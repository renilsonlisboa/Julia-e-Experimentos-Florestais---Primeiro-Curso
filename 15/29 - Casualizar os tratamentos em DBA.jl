#Casualizar os tratamentos em DBA

using DataFrames, CSV

I=3 #Número de tratamentos
J=3 #Número de blocos
#Obtenção de uma tabela com os tratamentos e repetições
XDBA = DataFrame(Tratamento=repeat(Symbol.('A':'C'), inner=J),Bloco=repeat(1:J, outer=I))
#Salvar a tabela de dados
XDBA|> CSV.write("ALEATDBA.csv")

#Casualização dos tratamentos
using DataFrames, StatsBase

function AleatDBA(Tratamento,Bloco)
    df = DataFrame()
    df.Trat = Tratamento
    df.Bloco=Bloco
    df
    n = size(df, 1)
    ord = sample(1:n, n, replace = false)
    A=df[ord,:]
    X=sort(A, :Bloco)
end

#AleatDBA(Tratamento,Bloco)
AleatDBA(XDBA.Tratamento,XDBA.Bloco)
    

_____________________________________________________
using Random
NTratamentos=5 #Número de tratamentos
NBlocos=4 #Número de blocos
Tratamentos=collect(1: NTratamentos)
function adba(x)
    Desenho=shuffle(x)
end 
desenho = for i=1: NBlocos
    println(Tratamentos)
end

Tratamentos=Symbol.('A':'E')