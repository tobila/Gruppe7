import sys
from Consumer import Consumer
from Producer import Producer
from OwnBuffer import OwnBuffer

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


