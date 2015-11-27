import threading
import time
import random

class Producer(threading.Thread):
    '''Consumer inherits threading.Thread
    Parameter: Buffer, counter 
    '''
    
    def __init__(self, buffer, count):
        threading.Thread.__init__(self)
        self.buffer = buffer
        self.count = count
    
    def run(self):
        '''adds random integers between 1-100 to buffer
        prints the own Producer count and the produced number, sleeps a random time
        '''
        while(True):
            num = random.randint(1,100)
            self.buffer.push(num)
            print ("Producer",self.count,"produced", num)
            time.sleep(random.random())