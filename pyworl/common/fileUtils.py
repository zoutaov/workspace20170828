#-*- coding:UTF-8 -*-
'''
author:Loopher
date: 2017-08-24 11:37:08
'''
import os

class FileHelper(object):
	def __init__(self):
		print  "file helper"
	def openFile(self,path):
		if not os.path.isfile(path):
			print  '%s is not file or dir'%path
			raise 'Oops !'
		with open(path,'r') as fd:
			return fd.readlines()
	def saveFile(self,path,text):
		tmpRoot =os.path.split(path)[0]+os.sep+'tmp'
		if not os.path.isdir(tmpRoot):
			os.mkdir(tmpRoot)
		file = tmpRoot+os.sep+os.path.split(path)[1]
		with open(file,'a+') as fd:
			fd.write(text)
	'''
	根据路径和文件前缀或者后缀遍历处所有文件
	path:需要遍历的目录
	preffix :文件前缀
	suffix  :文件后缀
	'''
	def scanFileByPreffixOrSuffix(self,path,preffix=None,suffix=None):
		print 'scan file path =%s ' %path
		if not os.path.isdir(path):
			print '%s is not dir '
			return None
		filelist=[]
		for root,subs,files in os.walk(path):
			for file in files:
				if preffix:
					if os.path.basename(file).startswith(preffix):
						filelist.append(os.path.join(root,file))
				if suffix:
					if os.path.basename(file).endswith(suffix):
						filelist.append(os.path.join(root,file))
		return filelist


