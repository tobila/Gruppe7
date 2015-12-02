'''
Created on 02.12.2015

@author: Patrick
'''
import threading
class Counter(threading.Thread):
   
    def __init__(self, liste):
        super(Counter,self).__init__()
        self.locListe=liste

    def run(self):
           
        zaehler=0  
        zaehler1=0
        #for line in liste:
        #    if '.edu' in line:
        #        zaehler+=1
        #print(zaehler)
        liste1=list()
        for line in self.locListe:
            liste1=line.split('.')
            zaehler1+=1
            if liste1[liste1.__len__()-1].__eq__('edu\n') or liste1[liste1.__len__()-1].__eq__('edu'):
                zaehler+=1
        print(zaehler1) 