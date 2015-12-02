import sys
from Consumer import Consumer
from Producer import Producer
from OwnBuffer import OwnBuffer
from Reader import  Reader
from Counter import Counter

#args = list(sys.argv)[1:]
#args = list(map(int, args))

#buffer = OwnBuffer(args[0])
#producer = []
#consumer = []

#for i in range(args[1]):
#    producer.insert(i, Producer(buffer,i+1))
#    producer[i].start()

    
#for i in range(args[2]):
#    consumer.append(Consumer(buffer,i+1))
#    consumer[i].start()
liste=list()
thread1= Reader(liste,"mails1.txt");
thread1.start()
thread2= Reader(liste,"mails2.txt")
thread2.start()
thread1.join()
thread2.join()
    
thread3=Counter(liste)
thread3.start()
thread3.join()

