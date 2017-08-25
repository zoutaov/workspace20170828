# -*- coding: UTF-8 -*-
import sys,os
import shutil  #删除有内容的子目录  
import xml.dom.minidom
import xml.etree.cElementTree as ET
#import ndkObfuscator as obfuscator
from  lxml import etree#修改AndroidManifest.xml文件使用库
import re
'''
这里需要传入一个java 
反编译apk包

'''
class Decoder(object):
	def __init__(self,*p):
		self.currPath =p[0]
		print self.currPath
		self.decoeDir =""
		self.smaliDir=""
		self.mklist=[]
		self.cpplist=[]
		self.header=[]
	def decode(self,jar,apk,outpPath):
		try:
			self.decoeDir=outpPath
			os.system(" java -jar %s  d %s  -o  %s " %(jar,apk,outpPath))
		except Exception as e:
			raise e
	def recordFiles(self):
		#这里是读取原始数据位置的方法调用处
		mpath=self.currPath+os.sep+"configJni"
		for root,subs,files in os.walk(mpath):
			for file in files:
				name=os.path.basename(file)
				if name.endswith(".mk"):
					self.mklist.append(os.path.join(root,file))
				if name.endswith(".cpp"):
					self.cpplist.append(os.path.join(root,file))
				if name.endswith(".h"):
					self.header.append(os.path.join(root,file))

	def getMklist(self):
		return self.mklist
	def getCpplist(self):
		return self.cpplist
	def getHeader(self):
		return self.header
	def decodeApkPath(self):
		for root,subs,files in os.walk(self.currPath):
			for sub in subs:
				if sub == self.decoeDir:
					return os.path.join(root,sub)
	def getSmaliDir(self):
		for root,subs,files in os.walk(self.currPath):
			for sub in subs:
				if sub == "smali":
					return os.path.join(root,sub)

'''
使用文件的方式保存记录
参数：
outDir:反编译后的输出路径

Recoder类：
1.记录 lib下的架构 lib/xxx  lib.txt
2.读取AndroidManifest.xml中的Application，并且添加纪录  fi.txt
3.读取黑白名单的内容，手工填写 .txt 
3.增加黑白名单 
4.记录jni路径
'''
archDict=["armeabi","armeabi-v7a","arm64-v8a ","mips","mips64","x86","x86_64"]
class Recoder(object):
	def __init__(self,outDir):
		# print "recoder init "
		self.workDir = outDir
		self.libArc=[]
		self.applicationnName="" #记录入口类 Application
		self.pkgName=""
		self.manifest={}
	#apk 解包后的lib目录下的架构文件
	def readApkLib(self):
		for root,subs,files in os.walk(self.workDir+os.sep+"lib"):
			for sub in subs:
				self.libArc.append(os.path.join(root,sub))
		return self.libArc
	def getManifestPath(self):
		try:
			logger("manifest_xml ",self.workDir)
			for root , subs , files in os.walk(self.workDir):
				for file in files:
					name=os.path.basename(file)
					logger("AndroidManifest.xml",name == "AndroidManifest.xml")
					# sys.exit(0)
					if name == "AndroidManifest.xml":
						logger("file",file)
						# sys.exit(0)
						return os.path.join(root,file)
								 
		except Exception as e:
			raise e
	def getPackageName(self):
		tree = self.getManifestXmlTree()
		if tree == None:
			logger( "cant' get packageName",type(tree))
			sys.exit()
		for pk in tree.iter(tag="manifest"):
			for key in pk.attrib.keys():
				if key == "package":
					return pk.attrib.get(key)
	def getApplication(self):
		tree = self.getManifestXmlTree()
		if tree == None:
			logger( "cant' get application",type(tree))
			sys.exit()
		android_name="{http://schemas.android.com/apk/res/android}name"
		android_value="android.intent.action.MAIN"
		for app in tree.iter(tag="application"):
			if android_name not in app.attrib.keys():
				break
			application=app.attrib[android_name]
			if application:
				return application
	def getMainActivity(self):
		tree = self.getManifestXmlTree()
		android_name="{http://schemas.android.com/apk/res/android}name"
		android_value="android.intent.action.MAIN"
		if tree == None:
			print "cant' get MainActivity"
			sys.exit()
		for imte in tree.iter(tag="activity"):
			print imte.tag,imte.attrib[android_name]
			for item in imte:
				print item.tag,item.attrib
				if item.tag =="intent-filter":
					for index in item:
						if index.tag =="action":
							mdic=index.attrib
							value =mdic[android_name]
							if value == android_value:					
								print "find MainActivity: ", imte.attrib[android_name]
								return imte.attrib[android_name]
	def getManifestXmlTree(self):
		manifest_xml=self.getManifestPath()
		logger("manifest_xml",manifest_xml)
		# sys.exit(1)
		if not os.path.exists(manifest_xml):
			print "AndroidManifest.xml is not exists !! "
			sys.exit()
		android_name="{http://schemas.android.com/apk/res/android}name"
		android_value="android.intent.action.MAIN"
		packageName="package"
		tree = ET.ElementTree(file=manifest_xml)
		return tree
		

	def getApkLibArchName(self):
		tmp=[]
		for lib in self.libArc:
			name=os.path.basename(lib)
			tmp.append(name)
		return tmp

	def commonUtilCopyFile(self,mlist,dstpath):
		#复制所有文件
		for item in mlist:
			name=os.path.basename(item)
			self.writeFile(item,dstpath+os.sep+name)
	def writeFile(self,srcpath,dstpath,date=None):
		try:
			name=os.path.basename(srcpath)
			fp1=open(srcpath,"r")
			lines=fp1.readlines()
			print "dstpath : ",dstpath
			fp2=open(dstpath,"w+")
			for line in lines :
				fp2.writelines(line)				
			fp1.close()
			fp2.close()
		except Exception as e:
			raise e
	
class SmaliToJni(object):
	def __init__(self):
		print "smaliToJni_jar "
		self.jniDir=""
	#执行的时候，需要添加白名单
	def exeSmaliToJni(self,jar,smaliDir,jni,currPath,enterClazz,debug):
		try:
			self.jniDir=jni
			cmd="java -jar  %s %s  %s  %s  %s  %s " %(jar,smaliDir,jni,currPath,enterClazz,debug)
			print cmd
			os.system(cmd)
			# sys.exit()
		except Exception as e:
			raise e
	def readKey(self,keyPath):
		try:
			tmp=[]
			fp= open(keyPath,"r+")
			lines = fp.readlines()
			for line in lines:
				tmp.append(line)
			fp.close()
			return tmp

		except Exception as e:
			raise e
	#先打开文件读取内容，在重新打开一次，写内容
	def modifyCheckSig(self,sign,utilPath):
		if sign == "":
			print "sign is None"
			return
		signTest="const char* appSign = " +"\"" +sign+"\""
		fp = open(utilPath+os.sep+"checksign.cpp","r")
		lines = fp.readlines()
		fp2=open(utilPath+os.sep+"checksign.cpp","w+") 
		for line in lines:
			fp2.writelines(line.replace(r'const char* appSign = "APP_SIGN"',signTest))
		fp2.close()
		fp.close()
		print "change sign ok ",sign
	def getEnterFilePath(self,smali,name):
		print "===== ",name

		for root,subs,files in os.walk(smali):
			for file in files:
				tmp = os.path.basename(file)
				if tmp == name: 
					return os.path.join(root,file)
	#列表内容改变
	def __insertCode(self,srcList,insertList ):

		end_tag = 'return-void'+'\n'
		tag=".method static constructor <clinit>()V"+'\n'
		secidea='const-string v0, "secidea"' +'\n'
		mlocals ='.locals'+'\n'
		function='invoke-static {v0}, Ljava/lang/System;->loadLibrary(Ljava/lang/String;)V' +'\n'
		prologue ='.prologue'+'\n' 
		#'\n',mlocals,
		addTextList = ['\n',mlocals,'\n',prologue,'\n',secidea,'\n',function,'\n',end_tag] #添加集合
		startIndex = 0 # 出现第一次位置
		endIndex   = 0 #最后找到的位置
		tmpIndex   = 0 #临时存储位置
		#logger('srclist',srcList)
		#logger('insert list',insertList)
		for tmpItem in srcList : #首先，找到的肯定是 <clinit>()V这里，那么记录当前位置，往下找到 数据位置，添加到insertlist中，
			# logger('src',tmpItem)
			if tmpItem in insertList:
				# logger('item',tmpItem) 
				startIndex = srcList.index(tmpItem) #最后偶一次肯定是在 .locals 1
				if tmpItem.startswith('.method static constructor <clinit>()V'):				
					tmpIndex = startIndex
					#logger('clinit index ',tmpIndex)
					#logger('clinit next item',srcList[tmpIndex + 1].strip())
					matchObj = re.match( r'.locals \d+$', srcList[tmpIndex + 1].strip())
					if matchObj:
						#logger('find',srcList[tmpIndex + 1].strip())
						# sys.exit(0)
						tmpIndex =startIndex + 1
						#logger('local index ',tmpIndex)
					# if srcList[tmpIndex + 1] .startswith(r'.locals \d+'):						
					# 	tmpIndex =startIndex + 1
					# 	print "tmpIndex locals",tmpIndex
					
					matchObj = re.match(r'\s+',srcList[tmpIndex + 1 ])
					if matchObj:
						#logger('plaintext before',tmpIndex)
						#logger('plaintext','nothing')
						# sys.exit(0)
						tmpIndex =startIndex + 2
					#logger('plaintext next',srcList[tmpIndex + 1 ].strip())
					#logger('plaintext index',tmpIndex)
					matchObj = re.match(r'.prologue+',srcList[tmpIndex + 1 ].strip())
					if matchObj:					
						tmpIndex += 1
						#print "tmpIndex prologue ",tmpIndex
					else:
						tmpIndex =tmpIndex-1

				# if tmpIndex != "\n" and srcList[tmpIndex +1 ].startswith(r'    return-void'):						
				# 	tmpIndex += 1
		#从当前的位置找到之后，从当前位置增加
		endIndex = tmpIndex #这里找到了是 return-void那么
		if endIndex == 0:
			#把insertList追加
			srcList.extend(insertList)
		else:
			#添加
			print "last index  obj ",srcList[endIndex],'index',endIndex
			matchObj = re.match( r'.locals \d+$', srcList[endIndex].strip())
			if matchObj:
				#print "remove locals"
				addTextList.remove(mlocals)
				addTextList.remove(end_tag)
			matchObj = re.match( r'.prologue+', srcList[endIndex].strip())
			if matchObj:
				#print ' remove locals & prologue'
				addTextList.remove(mlocals)
				addTextList.remove(prologue)
				addTextList.remove(end_tag)
			
			index = endIndex+1
			for mtext in addTextList:				
				srcList.insert(index,mtext )
				index += 1
		# logger("ret srcList",srcList) 
		# sys.exit(0)
		return srcList
	
	def __writeData(self,fp,dataList):
		for data in dataList:
			fp.writelines(data)

	def insertCode(self,enter,code):
		print "prepare add code in ",enter
		print "add code path " ,code
		# print  "enter ",enter ,"add code : ",code
		end_tag = 'return-void'
		tag=".method static constructor <clinit>()V"
		secidea='const-string v0, "secidea"'
		function='invoke-static {v0}, Ljava/lang/System;->loadLibrary(Ljava/lang/String;)V'
		entFile=open(enter,"r")
		lines = entFile.readlines()
		# print "orgin text"
		# print lines #列表1
		# print ''
		codeFile=open(code,"r")#
		text=codeFile.readlines() #列表2
		insertList =[]
		for item in text:
			# print item.strip()
			insertList.append(item.strip()+'\n')
		mAddTextList = self.__insertCode(lines,insertList)
		print 'back ',len(mAddTextList)
		# sys.exit()
		tmpFp=open(enter,"w+")
		self.__writeData(tmpFp,mAddTextList)
		entFile.close()
		codeFile.close()
		tmpFp.close()
		print "insert code ok "	
		#os.sys.exit(0)
'''
因为当前路径下包含了jni目录。直接调用ndk-build执行
注意:
ndk-build ：需要增加环境变量

'''
class Build(object):
	def __init__(self):
		print "build so"
		# self.mndk = obfuscator.NDK()
	def ndk_build(self):
		print "build so+++++++++++++++++++++ "
		os.system('ndk-build clean')
		os.system('ndk-build')		
	#复制,
	def copyLibTo(self,srcPath,dstPath):
		print "copy lib"
		srcFp= open(srcpath,"rb")
		dstfp=open(dstPath,"wb")
		datas=srcFp.readlines()
		for data in datas:
			dstfp.writelines(data)
		srcFp.close()
		dstfp.close()
		print "copy lib ok ",dstPath
#***********************************parse xml and change it*******************

'''
首先，需要根据tag来判断

'''
class XmlUtil(object):
	def __init__(self,filePath):
		self.path=filePath+os.sep+'AndroidManifest.xml'
		self.root=None
		print "change AndroidManifest.xml",self.path
	def __getRoot(self):
		if self.path =="" or not os.path.exists(self.path):
			print "please check %s is exists ?"
			sys.exit()
		tree=etree.parse(self.path)
		return tree.getroot()
		# self.root= root
	#tp是一个元组，mtag是需要查找的tag,例如 tag=application，就是查找当前的
	def addAttributes(self,tp,rootTag,mtag):
		self.root=self.__getRoot()
		if self.root ==None or tp ==None or mtag=="":
			print "can't get file rootElements ,root is None or tp is None ,tag is None,please check"
			sys.exit()
		mroot=self.root
		for node in mroot.xpath("//%s/%s"%(rootTag,mtag)):
			if tp not in node.items():
				node.set(tp[0],tp[1])
				break
		self.__addAttrib(mroot)
	def __addAttrib(self,mroot=None):
		if mroot == None:
			print "can't add attrib to AndroidManifest.xml,because rootElements is None "
			sys.exit()
		header='<?xml version="1.0" encoding="utf-8" standalone="no"?>'
		oldFile=self.path
		path=os.path.split(oldFile)[0]
		#name=oldFile[1]
		newFile=path+os.sep+"tmp_AndroidManifest.xml"
		print "[========]"
		print "new AndroidManifest.xml path ",newFile
		print "[========]"
		fp=open(newFile,"w")
		content=etree.tostring(mroot)
		fp.write(header+'\n')
		fp.write(content)
		fp.flush()
		fp.close()
		print "write content is ok"
		print "replace file "
		self.__replaceFile(oldFile,newFile)
	def __replaceFile(self,oldFile,newFile):
		try:
			old=open(oldFile,"w+")
			new=open(newFile,"r")
			old.writelines(new.readlines())	
			old.close()
			new.close()
			os.remove(newFile)
			# sys.exit()
			print 'print ok ... '		
		except Exception as e:
			 print 'replace AndroidManifest.xml exception',e
			 sys.exit()
#*****************************************************************************
'''
通用读取当前工作路径下制定后最文件名的方法，
能够返回指定后最文件名的路径
例如
prefix = ".apk" 
那么，就会返回一个 .apk后缀的文件路径，如果存在多个，
应该给定指定文件名字
'''
def getPath(currPath,prefix=None ,fileName=None):
	for root,subs,files in os.walk(currPath):
		for file in files:
			#制定后缀
			if prefix:
				if file.endswith(prefix):
					return os.path.join(root,file)
			#指定文件路径
			if fileName:
				if file == fileName:
					return os.path.join(root,file)		
def clear(currPath):
	# index =0
	tmplist=["outDir","jni","kpath","obj","libs"]
	for item in tmplist:
		path=currPath+os.sep+item
		print path
		if os.path.isdir(path) :
			print "clear %s "%(path)
			shutil.rmtree(path)		
				
def createDir(path,name):
	print "create....., ",path
	os.chdir(path)
	for root,subs, files in os.walk(path):
		for sub  in subs:
			if sub == name:
				print " delets ",name
				path = os.path.join(root,sub)
				shutil.rmtree(path)
			elif sub != name:
				print "name : ",name				
				os.mkdir(name)
				return os.path.join(root,name)

'''
准备阶段：
清楚缓存
准备工作目录
'''
currentPath="currentPath"
apktool="apktool.jar"
jni="jni"
smaliToJniJar="smalitojni.jar"
apk="apk"
addCodeTxt="addCode.txt"
kpath="kpath"
signJar="getsign.jar"
jniUtil="util"

modify_linux='modifyso_linux.linux'
#添加读取Application文件配置
configApp="application.txt"
#增加自定义的Application smali代码
myApplication="OrginalApplication.smali"

filterName="black_white_list.txt"
outfile ="libsecidea.so"
upxfile ="upx.out"
#'util': 'D:\\Android\\worRecord\\smaliToJni\\jni\\util',
def prepare(name):
	logger("prepare",name)
	dirname=[currentPath,apktool,apk,jni,smaliToJniJar,signJar,kpath,jniUtil,addCodeTxt,filterName,configApp,myApplication,modify_linux,upxfile]
	mlist=[]
	path = sys.path[0]
	clear(path) 
	mjni=create(path+os.sep+jni)
	keyPath=create(path+os.sep+kpath)
	mjniUtil=create(mjni+os.sep+jniUtil)	
	apktool_jar = getPath(path,apktool)
	addCode= getPath(path,addCodeTxt)
	smaliToJni_jar=getPath(path,smaliToJniJar)
	signature_jar=getPath(path,signJar)
	blcak_whilte=getPath(path,filterName)
	mconfigApp=getPath(path,configApp)#application.txt
	mapk=getPath(path,fileName=name)	#apkname
	mlist.append(path) #currePath
	mlist.append(apktool_jar)#apktool.jar
	mlist.append(mapk) #apk
	mlist.append(mjni) #jni
	mlist.append(smaliToJni_jar) # smalitojni.jar
	mlist.append(signature_jar)#signature_jar
	mlist.append(keyPath) #keyPath
	mlist.append(mjniUtil) #jni/util 
	mlist.append(addCode) #addCode.txt
	mlist.append(blcak_whilte)# black_white_list
	mlist.append(mconfigApp) #application.txt  追加
	mlist.append(getPath(path,myApplication))#myApplication
	mlist.append(getPath(path,modify_linux)) #modify_linux.linux
	mlist.append(getPath(path,upxfile)) #add upx.out 
	return dict(zip(dirname,mlist))

def getApkSign(getsigJar,apk,keyPath):
	try:
		logger( "get srcApkSign ..","")
		os.system("java -jar %s  %s %s " %(getsigJar,apk,keyPath))
	except Exception as e:
		raise e

def create(mpath):
	if os.path.isdir(mpath) :
		if os.path.getsize(mpath) >0:
			shutil.rmtree(mpath)
			os.mkdir(mpath)
			return mpath
		else:
			shutil.rmtree(mpath) 
			os.mkdir(mpath)
			return mpath
	else:
		os.mkdir(mpath)
		return mpath
#outDir
#libs 

#这里需要把生成的so复制到outDir中，首先记录的是生成lib的路径文件
#因为中生成的时候，就记录了abi，所以，这里直接copy
def getLibsFiles():
	# flterName=os.path.basename(flter)
	path=sys.path[0]+os.sep+"libs"
	flist=[]
	for root, subs,files in  os.walk(path):
		for file in files:
			flist.append(os.path.join(root,file))
	print "getLibsFiles befor :" , flist 
	return flist

def getLibsBySoProcessed(libName):
	# flterName=os.path.basename(flter)
	path=sys.path[0]+os.sep+"libs"
	flist=[]
	for root, subs,files in  os.walk(path):
		for file in files:
			if os.path.basename(file) == libName:
				flist.append(os.path.join(root,file))
	print "getLibsFiles after :" , flist 
	return flist
def copyLibTo(srcPath,dstPath):
	print "copy lib"
	print "srcpath :",srcPath," , ",dstPath
	#name =os.path.basename(srcPath)
	name="libsecidea.so"
	srcFp= open(srcPath,"rb")
	dstfp=open(dstPath +os.sep+name,"wb")
	datas=srcFp.readlines()
	for data in datas:
		dstfp.writelines(data)
	srcFp.close()
	dstfp.close()
def commonCopy(msrcList,mdstList):
	print "msrcList ",msrcList ,mdstList
	mlen=len(mdstList)-1
	if mlen <0:
		print "mlen < 0",mlen
		return
	index=0
	while index  <=mlen:
		copyLibTo(msrcList[index],mdstList[index])
		index +=1
	print "copy lib is ok "

#匹配复制
#D:\\Android\\worRecord\\smaliToJni\\libs\\armeabi\\libsecidea.so
#
def matchCopyLibs(jniLibs,managerDic):
	#debug 要指定架构 
	#apkLibArchName= debug_archivName
	apkLibArchName =managerDic.get("apkLibArchName")
	#测试使用
	#******
	logger( "apkLibArchName :",apkLibArchName)
	mlist=[]
	for item in jniLibs:
		tmp=os.path.split(item)
		name=os.path.basename(tmp[0])
		logger( "tmp :",tmp)
		logger(" archivName : ",name )
		if name in apkLibArchName:
			mlist.append(item)
	logger( "match lib :", mlist)
	logger("dstLibs :",managerDic.get("dstLibs"))
	if len(mlist) == 0:
		logger( "not found match libs ,please check it !","")
		sys.exit()
	  #mlt=managerDic.get("dstLibs")
	# mlt=[managerDic.get("decodApkPath")+os.sep+"lib"+os.sep+"armeabi"]
	# commonCopy(mlist,mlt)
	#
	commonCopy(mlist,managerDic.get("dstLibs"))

	#选择jniLis和outDirLibs下的做匹配

def buildApk(jar,outDir,newapk):
	try:
		logger( "build apk ..","")
		os.system("java -jar %s  b  %s  -o  %s" %(jar,outDir,newapk))
	except Exception as e:
		logger( "ndk-build exception ",e)
		sys.exit()
		

def copy(src,dst):
	for index in os.listdir(src):
		spath=os.path.join(src,index)
		dpath=os.path.join(dst,index)
		if os.path.isfile(spath):
			if not os.path.isdir(spath):
				logger( "makedirs","")
				os.makedirs(spath)
		if not os.path.exists(dpath) or (os.path.exists(dpath) and (os.path.getsize(dpath) != os.path.getsize(spath))):
			open(dpath, "wb").write(open(spath, "rb").read())
			logger( "copy ok ","")
		else:
			print "exists"

def createLibs(src,dst):
	tmp=[]
	for item in src:
		pp=os.path.split(item)
		path=dst+os.sep+"lib"+os.sep+os.path.basename(pp[0])
		os.makedirs(path)
		tmp.append(path)
	return tmp

def callDecodeApk(managerDic):
	logger( "current dir : ", managerDic.get(currentPath))
	apkDecode=Decoder(managerDic.get(currentPath))
	apkDecode.decode(managerDic.get(apktool),managerDic.get(apk),"outDir")
	decodApkPath=apkDecode.decodeApkPath()
	managerDic.setdefault("decodApkPath",decodApkPath)
	dict.update(managerDic)
	logger( "decodApkPath : " ,decodApkPath)
	smaliDir = apkDecode.getSmaliDir()
	managerDic.setdefault("smaliDir",smaliDir)
	dict.update(managerDic)
	logger( "smaliDir :",smaliDir)
	apkDecode.recordFiles()
	print "\n"
	mklist=apkDecode.getMklist() #读取mk文件
	managerDic.setdefault("mklist",mklist)
	dict.update(managerDic)
	# print "mklist :",mklist," len : ",len(mklist)
	cpplist=apkDecode.getCpplist() #读取apk/util/*.cpp文件
	managerDic.setdefault("cpplist",cpplist)
	dict.update(managerDic)
	# print "cpplist : ",cpplist ," len : ",len(cpplist)
	header=apkDecode.getHeader()
	managerDic.setdefault("header",header)
	dict.update(managerDic)
	return managerDic

#增加手动配置入口Application
def getApplicationFromConfig(managerDic):
	mSrc=managerDic.get(configApp)
	if not os.path.isfile(mSrc):
		logger( "check application.txt is exists ?  %s"%(mSrc),"")
		sys.exit()
	fp =open(mSrc,'r')
	text= fp.readlines()
	mstr=" ".join(text).split(':')[1] #取到包名的形式
	if mstr=="":
		logger( "please check application.txt is ok? " ,"")
		logger( "should be written as  'application:com.demo.app.MyApplication' ","")
		fp.close()
		sys.exit()
	fp.close()
	return mstr
#读取应用的包名作为写smali文件的路径
def getApkApplicationPath(smaliPath,name):
	logger(smaliPath,name)
	for root,subs,files in os.walk(smaliPath):
		for sub in subs:
			dirname=os.path.basename(sub)
			if dirname == name:
				logger("equal dirname",dirname)
				return os.path.join(root,sub)


#******************************************
#2017.4.21增加创建自己的包名的应用

def createDir(smaliPath,name):
	try:
		os.makedirs(smaliPath+os.sep+name)
	except Exception as e:
		logger( "create mypackage dir failed ", e)
		sys.exit(0)
def getPrefix(managerDic):
	for root,subs, files in os.walk(managerDic.get('smaliDir')):
		for sub in subs:
			if os.path.basename(sub) == 'com':
				return os.path.join(root,sub)
def creatMyApplicationDir(root,path):
	try:
		os.chdir(root)
		os.makedirs(path)
	except Exception as e:
		raise e
def createMyApplication(managerDic):
	logger("======createMyApplication===","*****createMyApplication*******")
	tmplist=[]
	com=getPrefix(managerDic)
	if com == None or com == '':
		com=managerDic.get('smaliDir')+os.sep+'com'
	itsec='com'+"/"+'itsec'+"/"+'application'  #outputfile
	mypath_application=com+os.sep+'itsec'+os.sep+'application'
	creatMyApplicationDir(com,mypath_application)
	if not os.path.isdir(mypath_application):
		logger("is not dir",mypath_application)
		sys.exit(0)
	logger('mypath_application',mypath_application)
	mainApplication=itsec.replace('/','.')+'.'+"MyApplication"
	tmp=mainApplication.split('.') 
	logger("mainApplication ",tmp)
	name=tmp[len(tmp)-1] # MyApplication
	logger("itsec mainApplication ",mainApplication)
	modifiedManifestXml(managerDic,mainApplication) #修改xml文件
	tmplist.append(mypath_application)
	tmplist.append(name)
	tmplist.append(mainApplication)
	return tmplist
#******************************************

#写smali代码
def writeApplicationSmali(managerDic,outputfile,name,enterClazz):
	if outputfile == None or outputfile == '':
		logger("can't write Application file ")
		sys.exit(0)
	inputfile=managerDic.get(myApplication)
	# name=tmp[len(tmp) -1] 
	# outputfile          |   name
	#com/itsec/application/MyApplication.smali
	entrSmali=outputfile+os.sep+'MyApplication'+'.smali'
	out=open(entrSmali,"w")
	instream=open(inputfile,"r")
	headerText='.class public '+'L'+enterClazz.replace('.','/')+';'+'\n'
	out.writelines(headerText)
	out.writelines(instream.readlines())
	out.close()
	instream.close()
	logger( "add my application is ok ","")

def addSmaliFileByPkgNm(menterClazz):
	filePath=managerDic.get("smaliDir")
	if filePath =="" or filePath == None:
		loger( "can't add enterclass file in %s ,because path is None ")
		sys.exit()
	#临时需要存储入口类的名称字符串
	# mEnterClzz=menterClazz
	logger("add smali application enterClazz ",menterClazz)
	tmp=menterClazz.split('.')
	#创建文件夹路径
	name=tmp[len(tmp) -2]
	logger("test===**= smaliDir ",managerDic.get("smaliDir"))
	logger("test===**= dirname",name)
	outputfile=getApkApplicationPath(managerDic.get("smaliDir"),name)
	#创建自己的文件目录存放application
	logger("add smali File 'outputfile：",outputfile)
	if outputfile == None or outputfile == '':
		retlist=createMyApplication(managerDic)
		outputfile=retlist[0]
		name=retlist[1]
		menterClazz=retlist[2]
	#**********************************
	writeApplicationSmali(managerDic,outputfile,name,menterClazz)
	# os.sys.exit(0)
	return menterClazz

#*************************************************
flag=True
def logger(tag,msg):
	if flag:
		print "[========]"
		print "%s : --> %s" %(tag,msg)
		print "[========]"

#***************************************************
def modifiedManifestXml(managerDic,enterClazz):
	if managerDic ==None or enterClazz =='' or enterClazz == None:
		logger("modifiedManifestXml failed ","enterClazz maybe is None")
		sys.exit(1)
	nmspase_value=enterClazz
	nmspace_tuple=(nmspase_key,nmspase_value)
	xmlutil=XmlUtil(managerDic.get("decodApkPath")) #路径不对，应该是入口类的报名
	xmlutil.addAttributes(nmspace_tuple,"manifest","application")
	xmlutil.addAttributes(nmspace_tuple,"manifest","application")

#这里更新了enterClazz is_addCode
def callMyApplication(managerDic):
	#***************修改AndroidManifest.xml**********************
	logger("create Application","callMyApplication")
	retlist=[]
	is_addCode=False
	retlist.append(is_addCode)
	# 
	enterClazz=managerDic.get("package")+".MyApplication"
	logger("packageName",enterClazz)
	# sys.exit(1)
	modifiedManifestXml(managerDic,enterClazz)
	#************************写入smali代码*********************************
	mEnterClzz=addSmaliFileByPkgNm(enterClazz)
	if mEnterClzz != enterClazz:
		enterClazz=mEnterClzz
	retlist.append(enterClazz)
	return retlist
	# sys.exit()
	#************************************************************

'''
增加功能：
1.修改AndroidManifest.xml,添加指定的入口Application

2.向报名下增加自定义的application

字典内容更新问题：
1.如果先设置了值，后续中，要更新，没有更新出来？

'''

is_addCode=True

def callHotFix(managerDic):
	hotfix=managerDic.get("isHotFix")
	#读取配置文件内容
	logger("get config Applicatio","hotfix enterClazz")
	return getApplicationFromConfig(managerDic)


def callCopyFile(managerDic):
	recoder =Recoder(managerDic.get("decodApkPath"))
	dstLibs=recoder.readApkLib() #返回解包后的lib的架构集合
	managerDic.setdefault("dstLibs",dstLibs)
	dict.update(managerDic)
	logger( "dstLibs  archiv :",dstLibs) #读取libs的架构
	packageName=recoder.getPackageName()
	logger( "packageName : ",packageName)
	managerDic.setdefault("package",packageName)
	dict.update(managerDic)
	#读取配置文件的形式(热更新)，不管manifest.xml的形式，如果这里没有读取到，那么，选择使用MainActivity来作为入口类
	enterClazz=recoder.getApplication() #读取到manifest.xml下的内容作为标签
	# #在这里添加自己的application
	#********************处理使用.xxx.xxApplication的情况
	#pkg =tinker.sample.android
	#.app.SampleApplication
	if enterClazz != None and enterClazz.startswith('.'):
		logger("startswith '.'",enterClazz)
		enterClazz=packageName+enterClazz
	#************************
	managerDic.setdefault("enterClazz",enterClazz)
	managerDic.setdefault("is_addCode",is_addCode)
	#增加读取功能，如果是tinke或者是bugly的框架，需要手动配置application****
	#***********热更新功能***********************
	hotfix=managerDic.get("isHotFix")

	if hotfix:#true 
	# 	#读取配置文件内容
		enterClazz=callHotFix(managerDic)

		managerDic["enterClazz"]=enterClazz
		logger("hotfix application ",managerDic.get("enterClazz"))

	#*************************
	if enterClazz == None or enterClazz =='':
		#没有application的情况
		logger("enterClazz is None ,and is not hotfix app,","get MyApplication")
	# 	#这里把enterClazz替换为自己的applition
		mlist=callMyApplication(managerDic)
		managerDic["is_addCode"]=mlist[0]
		managerDic["enterClazz"]=mlist[1]	
	logger( "enterClazz :" ,managerDic.get("enterClazz"))
	print "\n"
	dict.update(managerDic)
	# sys.exit()
	recoder.commonUtilCopyFile(managerDic.get("mklist"),managerDic.get(jni))
	recoder.commonUtilCopyFile(managerDic.get("cpplist"),managerDic.get(jniUtil))
	recoder.commonUtilCopyFile(managerDic.get("header"),managerDic.get(jniUtil))
	apkLibArchName=recoder.getApkLibArchName()
	managerDic.setdefault("apkLibArchName",apkLibArchName)
	dict.update(managerDic)	
	#list 转成 string 输出
	mstr=" ".join(apkLibArchName)
	print "\n"
	logger( "apkLibArchName  string : ",mstr) # mstr :  armeabi
	return managerDic
'''
Application.mk文件格式不能做修改：

必须保持如下规则：

# app_abi :=abi
APP_ABI :=all
APP_STL   := stlport_static
APP_SHORT_COMMANDS      := true

'''
def modifyApplicationMk(managerDic):
	logger( " change Application.mk ","")
	srcFile=managerDic.get(jni)+os.sep+"Application.mk"
	libArcNames=" ".join(managerDic.get("apkLibArchName"))
	if libArcNames =="":
		logger( "not found libArcNames ",libArcNames)
		logger('keep default config ',"all")
		libArcNames='all'
	#测试华润通1.3.1过签名加固
	#libArcNames='armeabi'
	#***********
	logger( "modify ApplicationMk : %s"%srcFile,libArcNames)
	if os.path.isfile(srcFile):
		if os.path.basename(srcFile) =="Application.mk":
			fp=open(srcFile,"r")
			text=fp.readlines()
			wr=open(srcFile,'w+')
			logger( " before text : ",text)
			text[1]="APP_ABI := "+libArcNames+'\n'
			logger( "update : ",text)
			for txt in text:
				wr.writelines(txt)
			wr.close()
			fp.close()
	else:
		logger( " %s not found ,please check it path !" %(srcFile),"")
		sys.exit()
	logger( " change application.mk ok ",libArcNames)
	# sys.exit(1)

#匹配原则，就是默认格式为：
'''
whitelist:


blacklist:
会在这两者之间做增加默认值的情况

'''
def setDefaulfList(managerDic):
	print "set blcak_whilte list "
	pkgName=managerDic.get("package").replace('.','/')
	srcfile=managerDic.get(filterName)
	enterClazz=managerDic.get("enterClazz").replace('.','/')+".smali\n"
	print "packageName",pkgName,"srcfile  :",srcfile

	#print srcfile
	if not os.path.isfile(srcfile):
		print "not found ",os.path.basename(srcfile)
		sys.exit()
	fp=open(srcfile,'r')
	text=fp.readlines()
	wr=open(srcfile,"w+")
	white=[]
	black=[]
	mm=[]
	for line in text :
		if line =="" or line == '\n' or len(line)==0 or line.startswith("#"):
			continue
		mm.append(line)
	#print "before :",mm
	if len(mm) ==2:
		print "[++++] len = 2"
		white.append(mm[0])
		white.append(pkgName+'\n')
		white.append(enterClazz)
		black.append(mm[1])
		#黑名单也是可以直接往这里添加
		#black.append(item)
		white.extend(black) #列表合并
		wr.writelines(white)

	elif len(mm) >2:
		print "[++++] len > 2"
		#logger('white black list',mm)
		for i in mm:
			print i 
			if i == enterClazz:
				print "***************************>>> "
				#mm.insert(1,enterClazz)
		#logger('applist ',mm)
		#logger('tag',enterClazz)
		if enterClazz not in  mm:
			logger('test','addd application')
			mm.insert(1,enterClazz)
		#logger('ffffffff',mm)
		#os.sys.exit(0)
		wr.writelines(mm)
		#logger('ffffffff','---------------')
	fp.close()
	wr.close()
	logger( "add config black_white_list","txt ok ")
	# os.sys.exit(0)

def getSign(managerDic):
	print type(managerDic)
	signPath=managerDic.get(kpath)+os.sep+"sign.txt"
	managerDic.setdefault("signPath",signPath)
	logger( "sign path : ",signPath)
	dict.update(managerDic)
	getApkSign(managerDic.get(signJar),managerDic.get(apk),managerDic.get("signPath"))
	return managerDic
def callSmaliToJni(managerDic):
	smJni=SmaliToJni()
	keySign=smJni.readKey(managerDic.get("signPath"))
	logger( "keySign : ",keySign[0])
	smJni.modifyCheckSig(keySign[0],managerDic.get(jniUtil))
	smJni.exeSmaliToJni(managerDic.get(smaliToJniJar),managerDic.get("smaliDir"),managerDic.get(jni),managerDic.get(currentPath),managerDic.get("enterClazz"),managerDic.get("debug"))
	tmp=managerDic.get("enterClazz").split(".")
	enterFileName=tmp[len(tmp)-1]#记录入口类
	managerDic.setdefault("enterFileName",enterFileName)
	dict.update(managerDic)
	logger( "enterFileName",enterFileName)
	flag=managerDic.get("is_addCode")
	logger("is_addCode",flag)
	#sys.exit(0)
	if flag:
		#增加判断是否需要写入插入代码dd
		logger("add code ==== flag: ",flag)
		#
		path = '.'.join(tmp[:len(tmp)-1])
		# logger('path',path)
		# logger('smalidir',managerDic.get("smaliDir"))
		# sys.exit(0)
		insertPath = managerDic.get("smaliDir")+os.sep+path.replace(".",os.sep)
		logger("path------",insertPath)
		enterPath=smJni.getEnterFilePath(insertPath,enterFileName+".smali")#入口类的路径
		logger("enterPath ",enterPath)
		# sys.exit(0)
		smJni.insertCode(enterPath,managerDic.get(addCodeTxt))
	#sys.exit(0)
	#smJni.modifyCheckSig(keySign[0],managerDic.get(jniUtil))
	#smJni.exeSmaliToJni(managerDic.get(smaliToJniJar),managerDic.get("smaliDir"),managerDic.get(jni),managerDic.get(currentPath),managerDic.get("enterClazz"),managerDic.get("debug"))
	return managerDic

def ndkBuild():
	try:
		ndkBuild=Build()
		ndkBuild.ndk_build()
	except Exception as e:
		raise e

debug_archiv = ""
debug_archivName = ""
#检测ndk-build 得到的libs目录是否得到正确的so文件
def checkIsSuccess(managerDic,ndkLibs):
	if ndkLibs == None or len(ndkLibs) <=0 :
		logger("ndk_build didn't finish ndkLibs len =",len(ndkLibs))
		managerDic.setdefault("isSuccess",False)
		dict.update(managerDic)
	else:
		logger("ndk-build is finished ndkLibs len = ",len(ndkLibs))
		managerDic.setdefault("isSuccess",True)
		dict.update(managerDic)

'''
2017-7-7 add process so 
'''
def soProcess(modify_so,libss):
	logger("sohelper","begin...")
	tmpName=[]
	tmpLibs=[]
	tmpBaseName=''
	initTag=True
	logger("modifier",modify_so)
	if(len(libss) ==0):
		logger('soProcess','libss len == 0')
		os.sys.exit(0)
	for file in libss:
		#tmpName.append(os.basename(file))
		#call cmd
		try:
			cmd = "%s  %s "%(modify_so,file)
			#logger("cmd",cmd)	
			os.system(cmd)
		except Exception as e:

			logger("soProcess",e)
			sys.exit(0)
	#add filebasename+"_new.so"to tmpLibs
	logger("sohelper","finish..")
	#sys.exit(0)

'''
call upx compress so file 

添加upx的压缩功能，这里outfile=libsecidea.so 
使用ndk-build的so文件，是libsecidea1.so
通过使用 ./upx libsecidea1.so libsecidea.so 就得到了upx的压缩文件，
使用 soProcess处理得到libsecidea_new.so文件，把libsecidea_new.so复制回到libsecidea.so文件

apk重打包即可

'''
def call_upx(upxfile,srcLibs):
	try:
		if(len(srcLibs)==0):
			logger("upx ","call upx failed ")
			os.sys.exit(1)

		for libfile in srcLibs:
			outPath = os.path.split(libfile)[0]
			upxCmd ='%s  -o  %s   %s '%(upxfile,outPath+os.sep+outfile,libfile)
			print upxCmd
			#os.sys.exit(0)
			os.system(upxCmd)
	except Exception as e:
		print e
		logger('upx execmd ','execption occured when exec upx cmd')
		os.sys.exit(1)
	logger('upx','call upx is ok')


def callCopyLibs(managerDic):
	srcLibs=getLibsFiles() #读取ndk-build 好的so 
	checkIsSuccess(managerDic,srcLibs)#检测ndk-build libs目录	
	if not managerDic.get('isSuccess'):	
		return
	#add soprocess function
	#********************2017-7-24---add upx compress libraries-----
	#call_upx(managerDic.get(upxfile),srcLibs)
	
	#*********************upx add end ****************************
	#srcLibs = getLibsBySoProcessed(outfile)
	#*****************2017-7-7************************
	#soProcess(managerDic.get(modify_linux),srcLibs)
	#
	#srcLibs =getLibsBySoProcessed('libsecidea1_new.so')
	#logger("after",srcLibs)
	#*****************************************************
	tdst=managerDic.get("dstLibs") # //debug  只要一个架构
	#tdst =[debug_archiv]
	mtmp=[]
	if len(tdst) ==0:
		print "[ no lib ]"
		mtmp=createLibs(srcLibs,managerDic.get("decodApkPath"))
		commonCopy(srcLibs,mtmp) #copyall
	else:
		print "[ find lib  ]"
		matchCopyLibs(srcLibs,managerDic)#匹配复制

managerDic={}

'''
currentPath="currentPath"
apktool="apktool.jar"
jni="jni"
smaliToJniJar="smalitojni.jar"
apk="apk"
addCodeTxt="addCode.txt"
kpath="kpath"
signJar="getsign.jar"
jniUtil="util"

'''

'''
未做的功能：
增加默认application 的情况
增加判断application是否存在，不存在，则增加java目录下的文件
OrginalApplication.smali到smali路径，同时根据应用报名，创建目录和修改manifest.xml
<application android:name="packageNmae.OrginalApplication"


新增功能：

1.增加修改Application的方法,根据解包后的架构做对应的增加，只会编译对应的架构
2.增加白名单判断，如果没有，默认到应用的包名 xx.xxx.xx作为白名单

测试使用规则：只需要匹配指定的架构即可
修改1：
modifyApplicationMk():
#测试华润通1.3.1过签名加固
	libArcNames='armeabi'
	#***********

修改2：
matchCopyLibs():
	#测试使用
	apkLibArchName=['armeabi']
	#******

'''

nmspase_key='{http://schemas.android.com/apk/res/android}name'
nmspase_value=""
# nmspace_tuple=(nmspase_key,nmspase_value)


'''
2014.4.20
增加一个针对热更新的情况状态值

'''

'''
读取config.xml文件

'''
isHotFix=False
configDic={}

'''
因为输入的字符类型是字符串，那么
在python中，除了‘’、""、0、()、[]、{}、None为False， 其他转换都为True
也就是说字符串如果不为空，则永远转换为True。
因此，做一个类型的转换判断即可
'''
def transformType(mflag):
	tmp=False
	if mflag == "True":
		tmp=True
	else:
		tmp=False
	return tmp
def readConfig():
	print "read config.xml"

'''
增加自定义异常类 
2017.5.10
'''
class MyException(Exception):
	def __init__(self):
		print "exception call"
	def throwsException(self,msg):
		raise Exception("somthing was wrong ",msg)

'''
修复包名在apk下不存在的情况：在清单文件中的<application android:name="com.demo.bug"/>
但是在apk中不存在，那么，在手动添加Application.smali的时候，要创建指定的文件夹目录
然后在写Application.smali

2017-7-6
增加有调试日志开关 ，根据传递参数为 'debug'== 'debug' ,才会开启调试日志

修復bug 在黑白名單中，
沒有檢查入口類添加情況，如果黑白名單沒有給，那麼會指定包名和入口類，如果給了黑白名單，但是沒有給定入口類，沒有檢查出來，現在修復

如果沒有添加入口類，那麼會添加，如果在黑黑白名單中給定了入口，那麼不會添加，

這裏的入口類指定的manifest.xml中的application

'''
smJarName="smaliToJni.py"
version="1.0.7"
if __name__ == '__main__':
	#********get args*******************
	print "smaliToJni.py current versoin %s" %(version)
	if len(sys.argv) != 5:
		print ' "smaliToJni.py current versoin %s" ' %(version)
		print  ' " please confirm third python libs of "lxml" already installed " '
		print "isHotFix value : True or False,"
		print  ' "usage: python  smaliToJni.py   apkpath  outApk  isHotFix debug " '	
		sys.exit(0)
	elif len(sys.argv) ==5 :
		
		apkpath= sys.argv[1]#apk名字
		outApk=sys.argv[2]
		hotfix=sys.argv[3]# 热更新状态标识
		debug = sys.argv[4] #
		mflag=transformType(hotfix)#类型转换
		print '--------',apkpath
	#*************prepare*************
	managerDic=prepare(apkpath)
	#sys.exit(0)
	print '***	'
	managerDic.setdefault("isHotFix",mflag)
	managerDic.setdefault("debug",debug)
	logger("flag",mflag)
	# sys.exit()
	dict.update(managerDic)
#********************decodeApk****************************#
	managerDic=callDecodeApk(managerDic)
	# print "len : ",len(managerDic)
#*******************copy file********************************#
	managerDic=callCopyFile(managerDic)
	# print "len : ",len(managerDic)
#*********************set default black white list***********#
	setDefaulfList(managerDic)
	#sys.exit(0)
#***********************getSign*****************************#
	managerDic=getSign(managerDic)
	# print "len : ",len(managerDic)
#**********************smaliTojar***************************#
	managerDic=callSmaliToJni(managerDic)
	# print "len : ",len(managerDic)
#*************************modified Application.mk**********#
	modifyApplicationMk(managerDic)
#****************************ndk-build*********************#
	ndkBuild()	
#*********************tmpso******************************#

#***********************copy libs ***********************#
	callCopyLibs(managerDic)

	isSuccess=managerDic.get('isSuccess')
	
#********************recomplied apk*************************#
	if isSuccess:
		#outApk
		buildApk(managerDic.get(apktool),managerDic.get('decodApkPath'),managerDic.get(currentPath)+os.sep+outApk)
		#buildApk(managerDic.get(apktool),managerDic.get('decodApkPath'),outApk)
	else:
		logger('will not build apk ','apk build failed ,because ndk-build is failed , can not  copy libs ')
		# sys.exit()
		#
		myexecption = MyException()
		myexecption.throwsException("because ndk-build is failed , can not  copy libs")




	
