#Casualizar os tratamentos em Fatorial

using DataFrames

#Combinação dos níveis do Fator A com os níveis do Fator B

NFA=3 #Número de níveis do Fator A
NFB=2 #Número de níveis do Fator B
df = DataFrame(FatorA=repeat(1:NFA, inner=NFB),FatorB=repeat(1:NFB, outer=NFA),Tratamento=1:(NFA*NFB))

#casualização dos tratamentos
using Random
function AleatFat(X)
    Desenho=X[shuffle(1:end), :]
end

#Casualização dos tratamentos em DBA.
NBlocos=3#Númeroo de blocos
desenho= for i=1: NBlocos
    println(AleatFat(df))
end

#Casualização dos tratamentos em DIC.
NRep=3 #Número de repetições
X=repeat(df, inner = NRep)
AleatFat(X)
