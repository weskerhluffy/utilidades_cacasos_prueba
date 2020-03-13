#!/Library/Frameworks/Python.framework/Versions/3.4/bin/python3
# XXX: http://stackoverflow.com/questions/30890434/how-to-generate-random-pairs-of-numbers-in-python-including-pairs-with-one-entr
from random import randint

def gencoordinates(m, n, ords=True):
    x = randint(m, n)
    if(ords):
        y = randint(x, n)
    else:
        y = randint(m, n)

    while True:
        yield (x, y)
        x = randint(m, n)
        if(ords):
            y = randint(x, n)
        else:
            y = randint(m, n)

if __name__ == "__main__":
    generados=0
    cacas=[]
    g=gencoordinates(int(1E6)-int(1E5),int(1E6),False)
    while (generados<1000):
        cacas.append(next(g))
        generados+=1
    for (x,y) in cacas:
        print("%u %u"%(x,y))
