import threading
import time
import random

class Consumer(threading.Thread):
    '''Consumer inherits threading.Thread
    Parameter: Buffer, counter 
    '''
    
    def __init__(self, buffer, count):
        threading.Thread.__init__(self)
        self.buffer = buffer
        self.count = count
    
    def run(self):
        '''get a number from the buffer
        prints the Consumer count and the consumed number, sleeps a random time
        '''
        while(True):
            num = self.buffer.pop()
            print ("Consumer",self.count,"consumed", num)
            time.sleep(random.random())