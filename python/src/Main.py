import sys
from Consumer import Consumer
from Producer import Producer
from OwnBuffer import OwnBuffer
from Reader import  Reader
from Counter import Counter


def prodCons():
    args = list(sys.argv)[1:]
    args = list(map(int, args))

    buffer = OwnBuffer(args[0])
    producer = []
    consumer = []
    for i in range(args[1]):
        producer.insert(i, Producer(buffer,i+1))
        producer[i].start()
    
        
    for i in range(args[2]):
        consumer.append(Consumer(buffer,i+1))
        consumer[i].start()
        
'''
creates 2 threads with 2 different pathes to read from different files and one thread to count mail-addresses ending with .edu
'''
def mails():
    mailList=list()    
    thread1= Reader(mailList,"mails1.txt");    
    thread1.start()                         
    thread2= Reader(mailList,"mails2.txt")     
    thread2.start()                         
    thread1.join()                          
    thread2.join()                          
        
    thread3=Counter(mailList)                  
    thread3.start()                         
    thread3.join()                          
'''
method to test the other classes
'''
if __name__ == '__main__':
    mails()                                 
    prodCons()
