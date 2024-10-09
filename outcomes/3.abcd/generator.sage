
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
        
        #root
        x=choice(xs)
        fn=choice(fns)
        a = randrange(2,6)
        c = randrange(2,5)*choice([-1,1])
        f = c*x^(1/a)
        anew = (1-a)/a
        if a==2:
            flatex = LatexExpr(f"{c}\\cdot \\sqrt{{{x}}}")
            dflatex = LatexExpr(f"\\frac{{{c}}}{{2\\sqrt{{{x}}}}}")
        else:   
            flatex = LatexExpr(f"{c}\\cdot \\sqrt[{a}]{{{x}}}")
            dflatex = LatexExpr(f"({c})\\left(\\frac{{1}}{{{a}}}\\right) {x}^{{{anew}}}")
        fs += [
            {
                "f":flatex,
                "fn":fn,
                "x":x,
                "df":dflatex,
            }
        ]
        
        #reciprocal root
        x=choice(xs)
        fn=choice(fns)
        a = randrange(2,6)
        c = randrange(2,5)*choice([-1,1])
        f = c*x^(1/a)
        if a==2:
            flatex = LatexExpr(f"\\frac{{{c}}}{{\\sqrt{{{x}}}}}")
        else:   
            flatex = LatexExpr(f"\\frac{{{c}}}{{\\sqrt[{a}]{{{x}}}}}")
        dflatex = LatexExpr(latex((-c/a)*x)+f"^{{-{a+1}/{a}}}")
        fs += [
            {
                "f":flatex,
                "fn":fn,
                "x":x,
                "df":dflatex,
            }
        ]

        #fractional power
        x=choice(xs)
        fn=choice(fns)
        coprimes = [2,3,5,7]
        a,b = sample(coprimes,2)
        c = randrange(2,5)*choice([-1,1])
        f = c*x^(b/a)
        anew = (b-a)/a
        if a==2:
            flatex = LatexExpr(f"{c}\\cdot \\sqrt{{{x}^{{{b}}}}}")
        else:   
            flatex = LatexExpr(f"{c}\\cdot \\sqrt[{a}]{{{x}^{b}}}")
        dflatex = LatexExpr(f"(\\frac{{{b*c}}}{{{a}}}) {x}^{{{b-a}/{a}}}")
        fs += [
            {
                "f":flatex,
                "fn":fn,
                "x":x,
                "df":dflatex,
            }
        ]
    
        # #negative fractional power
        # x=choice(xs)
        # fn=choice(fns)
        # coprimes = [3,4,5,7]
        # a,b = sample(coprimes,2)
        # c = randrange(2,5)*choice([-1,1])
        # f = c*x^(-b/a)
        # flatex = LatexExpr(f"\\frac{{{c}}}{{\\sqrt[{a}]{{{x}^{b}}}}}")
        # fs += [
        #     {
        #         "f":flatex,
        #         "fn":fn,
        #         "x":x,
        #         "df":f.diff(),
        #     }
        # ]

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
        # x=choice(xs)
        # fn=choice(fns)
        # a = randrange(3,5)
        # f = randrange(2,5)*x^((2*a-1)/a)-randrange(2,5)*x^((a-1)/a)
        # fs += [
        #     {
        #         "f":f,
        #         "fn":fn,
        #         "x":x,
        #         "df":f.diff(),
        #     }
        # ]

        shuffle(fs)
        #fs=fs[:5]
        return {"fs":fs}
        
