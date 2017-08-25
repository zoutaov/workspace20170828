# -*- coding: UTF-8 -*-
import  os,sys
class Logger(object):
    def __init__(self):
        print "logger"
    def show(self,msg):
        print '---'*100
        print '%s'%msg
        print '---'*100
    def writeLog(self,savepath,msg):
        path=sys.path[0]+os.sep+savepath+'log'+os.sep+"log.txt"
        if not os.path.isdir(path):
            os.mkdir(path)
        with open(path,'r+') as fp:
            fp.write('\n')
            fp.write(msg)
        fp.close()

def show(msg):
    logger = Logger()
    logger.show(msg)
def saveLog(save,text):
    logger = Logger()
    logger.writeLog(save,text);