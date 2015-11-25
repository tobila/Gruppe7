import threading
import time
import random

class Consumer(threading.Thread):
    
    def __init__(self, buffer, count):
        threading.Thread.__init__(self)
        self.buffer = buffer
        self.count = count
    
    def run(self):
        while(True):
            num = self.buffer.get()
            print ("Consumer",self.count,"consumed", num)
            self.buffer.task_done()
            time.sleep(random.random())