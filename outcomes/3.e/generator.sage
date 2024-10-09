
class Generator(BaseGenerator):
    def data(self):
        xs=list(var("x y t w r p q u v theta"))
        fns=list(var("f g h F G H R S j"))
        
        shuffle(xs)
        shuffle(fns)

        functions = [sin(xs[0]),cos(xs[1]),tan(xs[2]),cot(xs[3]),sec(xs[4]),csc(xs[5])]
        derivatives = [sin(xs[0]),cos(xs[1]),tan(xs[2]),cot(xs[3]),sec(xs[4]),csc(xs[5])]
        fs=[]
        
        for i in [0..5]:
            fs += [
            {
                "f":functions[i],
                "fn":fns[i],
                "x":xs[i],
                "df":functions[i].diff(),
            }
            ]    

        shuffle(fs)

        for i in [0..1]:
            j=i+6
            functions = [sin(xs[j]),cos(xs[j]),tan(xs[j]),cot(xs[j]),sec(xs[j]),csc(xs[j])]
            shuffle(functions)
            f=randrange(1,10)*choice([-1,1])*functions[0] + randrange(1,10)*choice([-1,1])*functions[1]
            fs += [
            {
                "f":f,
                "fn":fns[j],
                "x":xs[j],
                "df":f.diff(),
            }
            ]
   
        return {"fs":fs}
        
