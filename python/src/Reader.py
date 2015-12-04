
import threading
class Reader(threading.Thread):
    '''
    Reader inherits Thread
    '''
    
    '''
    initialize path and list to write in
    '''
    def __init__(self, mailList,path):
        super(Reader,self).__init__()   
        threading.Thread.__init__(self)
        self.locPath=path
        self.localMailList=mailList
    '''
    open file with given path and put every line in the given list
    '''
    def run(self):
        try:                #exception-handling
            infile = open(self.locPath)
            for line in infile:         
                self.localMailList.append(line)    
            infile.close()
        except IOError:     #what happens when an IOError occurs
            print("Smth's wrong with the File")