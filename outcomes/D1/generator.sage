
class Generator(BaseGenerator):
    def data(self):
        xs=list(var("x y t w r p q u v"))
        fns=list(var("f g h F G H R S j"))
        fs=[]
        
        #polynomial
        x=choice(xs)
        fn=choice(fns)
        ps = sample(list(range(1,7)),3)
        f = sum([randrange(1,10)*choice([-1,1])*x^p for p in ps]) + \
            randrange(1,10)*choice([-1,1])
        fs += [
            {
                "f":f,
                "fn":fn,
                "x":x,
                "df":f.diff(),
            }
        ]


        #miniproduct
        # x=choice(xs)
        # fn=choice(fns)
        # ps = sample(list(range(1,7)),3)
        # sgn_= choice([-1,1])
        # first_power  = ps[0]*sgn_
        # first_factor = x^first_power
        # second_factor = sum([randrange(1,10)*choice([-1,1])*x^ps[i] for i in [1..2]])
        # #factors = [first_factor,second_factor]
        # #factors =shuffle(factors)    
        # first_factor_latex = latex(x)+ '^{'+latex(first_power)+'}'
        # flatex = first_factor_latex+'\\cdot ('+latex(second_factor)+')'
        # f = first_factor * second_factor
        # fs += [
        #     {
        #         "f":flatex,
        #         "fn":fn,
        #         "x":x,
        #         "df":f.diff(),
        #     }
        # ]

        # exponential
        x=choice(xs)
        fn=choice(fns)
        f = randrange(1,5)*choice([-1,1])*e^x + \
            randrange(1,5)*choice([-1,1])*x^randrange(1,5)+randrange(1,5)*choice([-1,1])
        fs += [
            {
                "f":f,
                "fn":fn,
                "x":x,
                "df":f.diff(),
            }
        ]
        
        #simple power
        # x=choice(xs)
        # fn=choice(fns)
        # f = randrange(1,5)*choice([-1,1])*x^randrange(1,9)
        # fs += [
        #     {
        #         "f":f,
        #         "fn":fn,
        #         "x":x,
        #         "df":f.diff(),
        #     }
        # ]

        #fractional power
        x=choice(xs)
        fn=choice(fns)
        coprimes = [3,4,5,7]
        a,b = sample(coprimes,2)
        f = x^(b/a)
        flatex = LatexExpr(f"\\sqrt[{a}]{{{x}^{b}}}")
        fs += [
            {
                "f":flatex,
                "fn":fn,
                "x":x,
                "df":f.diff(),
            }
        ]

#negative power
        x=choice(xs)
        fn=choice(fns)
        f = randrange(1,5)*choice([-1,1])*x^randrange(-7,-1)
        fs += [
            {
                "f":f,
                "fn":fn,
                "x":x,
                "df":f.diff(),
            }
        ]

#difference of fractional powers
        x=choice(xs)
        fn=choice(fns)
        a = randrange(3,5)
        f = randrange(2,5)*x^((2*a-1)/a)-randrange(2,5)*x^((a-1)/a)
        fs += [
            {
                "f":f,
                "fn":fn,
                "x":x,
                "df":f.diff(),
            }
        ]

        shuffle(fs)
        #fs=fs[:5]
        return {"fs":fs}
        
