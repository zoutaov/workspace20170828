import  sys
class Demo(object):
    def __init__(self):
        print "demo .class"

def tes(msg):
    print "demo"
    print "%s "%(msg)
if __name__=='__main__':
    print 'demo '
    print 'current file: ',  sys.argv[0]
