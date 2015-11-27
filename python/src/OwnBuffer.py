'''
Created on 05.11.2015

@author: dortepuchelt
'''


# last in first out 

class OwnBuffer():
    '''
    classdocs
    '''

    
    def __init__(self, capacity):
        self.capacity= capacity
        self.bufferList=list();

    
    def push(self, value) :
        if len(self.bufferList) < self.capacity:
            self.bufferList.append(value)
    
    def peek(self):
        value = self.bufferList[0]
        self.bufferList.remove(value)
        return value
        
        
    def isEmpty(self):
        if len(self.bufferList)==0:
            return True    
        else:
            return False
        
    def isFull(self):
        if len(self.bufferList) >= self.capacity:  
            return True
        else: 
            return False  
        
    def getBuffer(self):
        return self.bufferList    
        
if __name__ == '__main__':
    t=OwnBuffer(10)
    

    t.push(1)
    t.push(2)
    t.push(3)
    t.push(4)
    print (t.getBuffer())
    t.push(5)
    t.push(6)
    t.push(7)
    t.push(8)
    t.push(2)
    t.push(3)
    t.push(4)
    t.push(5)
    t.push(6)
    t.push(7)
    t.push(8)
    print (t.getBuffer())
    t.peek()
    print (t.getBuffer())

