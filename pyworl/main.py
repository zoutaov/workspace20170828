# -*- coding: UTF-8 -*-
import  sys ,os
# from test import demo
from  analysis import  analysis
import  time
from common import fileUtils
def show_os_time():
    fmt='%Y%m%d%H%M%S'
    print  time.strftime(fmt,time.localtime())


def recordTimeStamp(timestamp):
	with open(sys.path[0]+os.sep+'analysis'+os.sep+'timelog.txt','a+') as fd:
		fd.write('----'*10)
		fd.write('\n')
		fd.write('tmp.txt record time : '+timestamp)
		fd.write('\n')
if __name__=='__main__':
    # print  "main"
    # # m=Demo()
	print "current path ", sys.path[0]
	# show_os_time();
	# sys.exit(0)
    # parse.test()
	path = sys.path[0] + os.sep+'analysis'
	mstr ='com/my089/activity/account/zhaiquan/ZhaiquanTransferActivity.smali'
	timeStamp =time.strftime('%Y%m%d%H%M%S',time.localtime())
	recordTimeStamp(timeStamp)
	# parse.callPickBlackMethod()
	# mstr.find('')
	#*********************test**************************************
	allfiles = fileUtils.FileHelper().scanFileByPreffixOrSuffix(path,suffix='.smali')
	print allfiles
	for file in allfiles:
		tool = analysis.Parser()
		tool.findConstString(file)
		tool.saveToTmpFile(timeStamp)
		tool.showAll()
	#************************test end ****************************

    # tool  = parse.Parser().findConstString()
    # mParse=xmlPars.XmlParse(sys.path[0])
    # mParse.getTree()
    # print "mFile: " , mParse.mFile