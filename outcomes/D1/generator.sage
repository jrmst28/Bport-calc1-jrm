
class Generator(BaseGenerator):
    def data(self):
        xs=list(var("x y t w r p q u v"))
        shuffle(xs)
        fns=list(var("f g h F G H R S j"))
        shuffle(fns)
        
        #polynomial
        ps = sample(list(range(1,7)),3)
        f = sum([randrange(1,10)*choice([-1,1])*xs[0]^p for p in ps]) + \
            randrange(1,10)*choice([-1,1])
        fs = [
            {
                "f":f,
                "fn":fns[0],
                "x":xs[0],
                "df":f.diff(),
            }
        ]
        
        #miniproduct
        shuffle(xs)
        shuffle(fns)
        ps = sample(list(range(1,7)),3)
        left_factor = xs[0]^ps[0]
        right_factor = sum([randrange(1,10)*choice([-1,1])*xs[0]^p for p in [1..2]])
        flatex = LatexExpr(f"{left_factor}\\left({right_factor}\\right)")
        f = left_factor * right_factor
        fs += [
            {
                "f":flatex,
                "fn":fns[0],
                "x":xs[0],
                "df":f.diff(),
            }
        ]

        # #trig + transcendental
        # trig = choice([cos,sin])
        # transc = choice([log,exp])
        # f = randrange(1,5)*choice([-1,1])*trig(xs[1]) + \
        #     randrange(1,5)*choice([-1,1])*transc(xs[1])
        # fs += [
        #     {
        #         "f":f,
        #         "fn":fns[1],
        #         "x":xs[1],
        #         "df":f.diff(),
        #     }
        # ]
        
        #fractional/negative powers
        coprimes = [3,4,5,7]
        a,b = sample(coprimes,2)
        radical = xs[2]^(b/a)
        radical_latex = LatexExpr(f"\\sqrt[{a}]{{{xs[2]}^{b}}}")
        frac = randrange(1,10)/xs[2]^randrange(2,6)
        frac_latex = latex(frac)
        f = radical+frac
        flatex = radical_latex + " + " + frac_latex
        fs += [
            {
                "f":flatex,
                "fn":fns[2],
                "x":xs[2],
                "df":f.diff(),
            }
        ]

        shuffle(fs)
        return {"fs":fs}
        
