from threading import Condition

class OwnBuffer():
    '''Create a FIFO Buffer with a given capacity'''
    
    '''Initialisation of given capacity, new bufferdList of type list
    and mutex (mutual exclusion) from threading.Condition
    '''
    def __init__(self, capacity):
        self.capacity= capacity
        self.bufferList=list();
        self.mutex = Condition()

    
    def push(self, value):
        '''Parameter: some value to add to OwnBuffer.
        Acquires the lock. If OwnBuffer is full, wait() is called:
        -> thread releases the lock and blocks until notify() is called from another thread (wakeup).
        Adding the value to OwnBuffer, notifies if other thread is blocking and releases the lock
        '''
        self.mutex.acquire()
        while(self.isFull()):
            self.mutex.wait()
        self.bufferList.append(value)
        self.mutex.notify()
        self.mutex.release()
        
    
    def peek(self):
        ''' Acquires the lock. If OwnBuffer is empty, wait() is called:
        -> thread releases the lock and blocks until notify() is called from another thread (wakeup).
        Removes the value from OwnBuffer, notifies if other thread is blocking and releases the lock
        returns the removed value
        '''
        self.mutex.acquire()
        while(self.isEmpty()):
            self.mutex.wait()
        value = self.bufferList[0]
        self.bufferList.remove(value)
        self.mutex.notify()
        self.mutex.release()
        return value
        
        
    def isEmpty(self):
        '''Checks if OwnBuffer is empty and returns true, otherwise false'''
        if len(self.bufferList)==0:
            return True    
        else:
            return False
        
    def isFull(self):
        '''Checks if OwnBuffer is full and returns true, otherwise false'''
        if len(self.bufferList) >= self.capacity:  
            return True
        else: 
            return False  
        
    def getBuffer(self):
        return self.bufferList    
        


