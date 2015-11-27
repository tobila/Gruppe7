'''
Created on 05.11.2015

@author: dortepuchelt
'''


# last in first out 

class OwnBuffer(object):
    '''
    classdocs
    '''

    
    def __init__(self, capacity):
        self.capacity= capacity
        self.bufferList=list();

    
    def __push__(self, value) :
        if len(self.bufferList) > self.capacity:
            return
        self.bufferList.append(value)
    
    def __peek__(self):
        s= len(self.bufferList)
        val= self.bufferList[s-1]
        self.bufferList.pop()
        return val
        
        
    def __isEmpty__(self):
        if len(self.bufferList)==0:
            return True    
        else:
            return False
        
    def __isFull__(self):
        if len(self.bufferList) >= self.capacity:  
            return True
        else: 
            return False  
        
    def __getBuffer__(self):
        return self.bufferList    
        
if __name__ == '__main__':
    t=OwnBuffer(10)
    #print len(t.__getBuffer__)
    
    #print t.__isEmpty__()
    t.__push__(1)
    t.__push__(2)
    t.__push__(3)
    t.__push__(4)
    print (t.__getBuffer__())
    t.__push__(5)
    t.__push__(6)
    t.__push__(7)
    t.__push__(8)
    t.__push__(2)
    t.__push__(3)
    t.__push__(4)
    t.__push__(5)
    t.__push__(6)
    t.__push__(7)
    t.__push__(8)
    print (t.__getBuffer__())
    t.__peek__()
    print (t.__getBuffer__())

    #t.__getBuffer__
    #print t.__isFull__()
    #print t.buffer