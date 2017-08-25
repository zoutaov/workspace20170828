#-*- coding:UTF-8 -*-
'''
author:Loopher
date:

根据提供的方法列表，筛选出黑名单

根据提供的minlen和maxlen，分别挑选出每个类的方法黑名单，
'''
class Selector(object):
	def __init__(self,allMethods,minlen,maxlen):
		print 'Selector'
		self.minLen=minlen #方法体长度最小值
		self.maxLen = maxlen #方法体长度最大值
		self.AllMethodsList=[] #获取所有的方法体列表
	def pickBlackMethod(self):
		print 'pick black method '