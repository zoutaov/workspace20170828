#-*- coding:UTF-8 -*-
'''
author:Loopher
date:2017-08-24 11:26:57
分析指令，找到字符串指令位置，记录对应的方法名
'''
import  re
import sys,os
from common import  fileUtils
import  time
class Parser(object):
	isover=False
	className = "Parser"
	smaliClassName='' #记录每一个smali文件的类名
	isSmaliMethod =False #是否找到符合条件的方法
	isstart=False     #是否开始构建方法框架
	def __init__(self):
		print  self.className
		self.isSmaliClass=False #记录是否找到smali文件的类名
		self.mehtod             =[] #记录每一个方法体
		self.AllMethods         =[] #保存所有方法体
		self.constStringsMethods=[] #记录找到的字符串方法名称
		self.classListNames     =[] #记录每个类
		self.AllMethodsLen      =[] #记录所有方法的长度
		self.allFiles           = [] #保存所有的文件
		self.black_list         =[] #黑名单列表
		self.tmpblackfile       =''#临时黑名单文件 文件个命名是使用时间戳  20170825171823.txt方式
		self.fileTools =fileUtils.FileHelper()
	#查找到指令const-string
	def findConstString(self,path=None):
		# print  '查找const-string'
		if not path : #如果path是空
			path = self.filePath
			print 'Oops ! path is None  '
		#测试
		print  '===file == ',path
		lines =self.fileTools.openFile(path)
		#查找
		for line in lines:
			if not self.isSmaliClass:
				self.__recordSmaliClassName(line)
			self.__createMethodTemplete(line)
			if self.isover:
				self.isover =False #设置结束
				self.isstart =False #设置是否开始方法创建
				if self.__findMatchString(self.mehtod):
					self.__recordConstStingMethod(self.mehtod)  ##记录方法名
				self.AllMethods.append(self.mehtod) #保存每一个方法的列表
				self.mehtod=[] #清空上一个的
		self.storeMethodLength() #记录每一个函数的长度
		self.__sortMethodsLen() #排序方法长度
		self.pickBlackMethod()#选出黑名单
	def storeMethodLength(self):
		for item in self.AllMethods:
			self.AllMethodsLen.append((len(item)))
	#排序方法长度，筛选出最小两个值
	def __sortMethodsLen(self):
		self.AllMethodsLen.sort()

	# 记录方法名*************************
	'''
	(^\.class.*;$) 匹配规则
	.class public Lcom/my089/activity/account/zhaiquan/ZhaiquanTransferActivity; 匹配内容
	'''
	def __recordSmaliClassName(self, string):
		print  'recordSmaliClassName'
		metchObj = re.match(r'^\.class.*;$',string)
		clzz=None
		if metchObj:
			self.isSmaliClass =True
			tmp = string.split(' ')  # 根据空格分隔
			print '[*] split classString:', tmp
			self.smaliClassName = tmp[len(tmp) - 1].strip().replace(';', '')[1:]  # 字符串切割,去掉L
			print  '[*] className name:', self.smaliClassName
			self.classListNames.append(tmp[len(tmp) - 1].strip().replace(';', '')[1:])  # 记录当smali的类名

#****************************************************
	'''
    方法框架：
    .method xxx   #方法开始 \.method.*
      ...         #方法体
    .end method   #方法结束 ^\.end method*
    
	'''

	def __createMethodTemplete(self, line):
		#print 'method templete' #方法的框架，根据.method xxxx 开始 .end method 结束作为一个方法框架判断
		metchObj=re.match(r'^\.method.*',line)
		if metchObj:
			#print  'method start' #方法开始
			self.isstart=True
			self.mehtod.append(line)
		metchObj = re.match(r'^\.end method$',line)
		if metchObj:
			#print  'method end ' #方法结束
			self.mehtod.append(line)
			self.isover = True #方法框架读取完成
		if self.isstart: #开始添加方法
			if  line not in self.mehtod:
				self.mehtod.append(line)

	# **********************************************
	def showAll(self):
		print '*************' * 20
		print "all classNameList: ",self.classListNames[0]
		print '*************'*20
		print "all allMethodsList: ",self.AllMethods
		print '*************' * 20
		print "all allMethodsLen:",self.AllMethodsLen
		print '*************' * 20
		print "all const-stringMethodsList:",self.constStringsMethods
		print 'all const-stringMethodsListLen:',len(self.constStringsMethods)
		print '*************' * 20
		print "all black_method list:",self.black_list
		print 'all black_method list len:',len(self.black_list)
		print '*************' * 20
		print  'black method : '
		# for method in self.black_list:
		# 	print  method
		# 	self.fileTools.saveFile(sys.path[0] + os.sep + 'analysis'+os.sep+time.strftime('%Y%m%d%H%M%S',time.localtime())+'.txt', method)  # 临时文件，用于查看读取的方法是否完整

	def saveToTmpFile(self,savetime):
		for method in self.black_list:
			print  method
			self.fileTools.saveFile(sys.path[0] + os.sep + 'analysis'+os.sep+'tmp'+savetime+'.txt', method)  # 临时文件，用于查看读取的方法是否完整
	# **********************************************
	# match 方法，只会查找字符的起始位置，如果不匹配，那么就不执行了，search方法，查找一行字符左匹配
	'''
	功能
	(^const-string\W[v|p]\d\W.*) #匹配规则
	const-string vn/pn,""        #匹配内容
	参数：
	methods: 每一个方法列表 []
	'''
	def __findMatchString(self, methods): #传递每一个方法体，找到符合字符串判断，那么记录当前方法
		for string in methods:
			#匹配 const-string vn|pn,""   ^const-string\W[v|p]\d\W.*
			matchObj = re.match(r'^const-string\W[v|p]\d\W.*',string.strip())
			if matchObj:
				#print "***find const-string ***",string
				return True
		return False
	'''
   记录符合const-string vn/pn,""的方法名称  如下
   com/my089/activity/account/zhaiquan/ZhaiquanTransferActivity.smali/<init>()V
   methodStruct:每一个方法的列表对象
   blackList:是否添加到黑名单中
	'''
	def __recordConstStingMethod(self, methodStruct, blackList=False):
		#print '记录方法名称',function
		tmp = methodStruct[0].split(" ")
		funName = tmp[len(tmp) -1]
		print  'functionName:',funName
		const_string_methodName=self.classListNames[0]+".smali"+'/'+funName
		if const_string_methodName not in self.constStringsMethods:
			if blackList:
				self.black_list.append(const_string_methodName)
			else:
				self.constStringsMethods.append(const_string_methodName)
		#print 'constStringsMethods: ',self.constStringsMethods
		#print  'constStringsMethods len: ',len(self.constStringsMethods)
#********************************挑选出每个类的方法黑名单******************************
	def pickBlackMethod(self):
		print  'pick method '
		minlen = self.AllMethodsLen[0] #长度列表已经排序为升序，从小到大，只需要读取0,1上位置长度，即可作为最小和最大边界条件
		maxlen = self.AllMethodsLen[1]
		for method in self.AllMethods:
			if minlen <= len(method) <=maxlen:
				if not self.__findMatchString(method):
					# print  "需要添加到黑名单"
					self.__recordConstStingMethod(method,blackList=True)
