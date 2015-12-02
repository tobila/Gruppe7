'''
Created on 02.12.2015

@author: Patrick
'''
import threading
class Reader(threading.Thread):
   
   
   
    def __init__(self, liste,path):
        super(Reader,self).__init__()
        self.locPath=path
        self.locListe=liste

    def run(self):
        infile = open(self.locPath)
        for line in infile:
            self.locListe.append(line)
         
       
        #print self.liste
        #self.getMailList()   
        infile.close()