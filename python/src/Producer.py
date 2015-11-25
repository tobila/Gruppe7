import threading
import time
import random

class Producer(threading.Thread):
    
    def __init__(self, buffer, count):
        threading.Thread.__init__(self)
        self.buffer = buffer
        self.count = count
    
    def run(self):
        
        while(True):
            num = random.randint(1,100)
            self.buffer.put(num)
            print ("Producer",self.count,"produced", num)
            time.sleep(random.random())