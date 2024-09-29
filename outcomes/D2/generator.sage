
class Generator(BaseGenerator):
    def data(self):
        xs=list(var("x y t w r p q u v"))
        fns=list(var("f g h F G H R S j"))
        fs=[]
        
        for i in [0..1]:

            x=choice(xs)
            fn=choice(fns)
            #polynomial
            ps = sample(list(range(1,7)),3)
            f = sum([randrange(1,10)*choice([-1,1])*x^p for p in ps]) + \
                randrange(1,10)*choice([-1,1])
            df = f.diff()
            pairs = [[f,df]]
                    
            # exponential
            f = randrange(1,5)*choice([-1,1])*e^x + \
                randrange(1,5)*choice([-1,1])*x^randrange(1,5)+randrange(1,5)*choice([-1,1])
            df = f.diff()
            pairs = pairs + [[f,df]]        

            #simple power
            f = randrange(1,5)*choice([-1,1])*x^randrange(1,9)
            df = f.diff()
            pairs = pairs + [[f,df]] 

            #fractional power
            coprimes = [3,4,5,7]
            a,b = sample(coprimes,2)
            f = x^(b/a)
            f_latex = LatexExpr(f"\\sqrt[{a}]{{{x}^{b}}}")
            df = f.diff()
            pairs = pairs + [[f_latex,df]] 

            #negative power
            c=randrange(1,5)*choice([-1,1])
            p=randrange(1,7)
            f = c*x^(-p)
            f_latex = LatexExpr(f"{latex(c*x)}^{{-{p}}}")
            df = LatexExpr(f"{latex(c*(-p)*x)}^{{{latex(1-p)}}}")
            pairs = pairs + [[f_latex,df]] 

            # #difference of fractional powers
            # a = randrange(3,5)
            # f = randrange(2,5)*x^((2*a-1)/a)-randrange(2,5)*x^((a-1)/a)
            # df = f.diff()
            # pairs = pairs + [[f,df]] 
                    
            shuffle(pairs)
            fl = latex(pairs[0][0])
            dfl =latex(pairs[0][1])
            fr = latex(pairs[1][0])
            dfr =latex(pairs[1][1])
            f = LatexExpr(f"\\left({fl}\\right)\\cdot\\left({fr}\\right)")
            df = LatexExpr(f"\\left({fl}\\right)\\cdot\\left({dfr}\\right)+\\left({dfl}\\right)\\cdot\\left({fr}\\right)")
            
            fs += [
                {
                    "f":f,
                    "fn":fn,
                    "x":x,
                    "df":df,
                }
            ]
            fl = latex(pairs[2][0])
            dfl =latex(pairs[2][1])
            fr = latex(pairs[3][0])
            dfr =latex(pairs[3][1])
            f = LatexExpr(f"\\frac{{{fl}}}{{{fr}}}")
            df = LatexExpr(f"\\frac{{\\left(({dfl}\\right)\\left(({fr}\\right)-\\left(({fl}\\right)\\left(({dfr}\\right)}}{{\\left({fr}\\right)^2}}")
            
            fs += [
                {
                    "f":f,
                    "fn":fn,
                    "x":x,
                    "df":df,
                }
            ]
        


        shuffle(fs)
        #fs=fs[:5]
        return {"fs":fs}
        
