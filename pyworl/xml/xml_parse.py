# -*- coding: UTF-8 -*-
import os,sys
from  xml.etree import ElementTree as ET

class XmlParse(object):
    mFile="XmlParse" #类成员变量，由类调用，或者是对象调用
    def __init__(self,filepath):
        print  "xml parse class"
        mFile=filepath
        self.var=filepath #对象成员
    def getTree(self):
        print "root Path =%s" %(self.var)
        mPath=self.__getfile()
        # print mFile
    def __getfile(self):
        for root, subs,files in os.walk(self.var):
            for file in files:
                name = os.path.basename(file)
                if name =='AndroidManifest.xml':
                    return os.path.join(root,file)
    def parseXml(self):
        print  "xml pars"
    def modifiedXml(self):
        print 'modified xml file'
    def writeBackXml(self):
        print  'write back xml file'



if __name__=='__main__':
    print "call xml_parse.py"