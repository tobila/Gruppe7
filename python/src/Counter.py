
import threading
class Counter(threading.Thread):
    '''
    Counter inherits Thread
    '''
    '''
    initialize local variable list to write in
    parameter: list to write in
    '''
    def __init__(self, mailList):
        super(Counter,self).__init__()
        self.localMailList=mailList
    '''
    split each list item and check if the ending is ".edu(\n)"
    '''
    def run(self):
           
        counter=0   
        counter1=0
        splitList=list()
        for line in self.localMailList:
            splitList=line.split('.')
            counter1+=1
            if splitList[splitList.__len__()-1].__eq__('edu\n') or splitList[splitList.__len__()-1].__eq__('edu'):
                counter+=1
        print(counter) 