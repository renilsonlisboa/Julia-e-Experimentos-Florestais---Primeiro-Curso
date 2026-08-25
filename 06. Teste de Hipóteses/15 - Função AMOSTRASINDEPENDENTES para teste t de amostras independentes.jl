#Função AMOSTRASINDEPENDENTES para teste t de amostras independentes
#Teste t para duas amostras independentes pequenas e com mesma variância

using DataFrames, CSV, Statistics, Distributions

X=CSV.read("amostrasindependentes.csv", DataFrame) 
 
function AMOSTRASINDEPENDENTES(X1,X2)
    dfX1 = DataFrame([X1], :auto)
    X1=dropmissing(dfX1)
    X1= X1.x1
    dfX2 = DataFrame([X2], :auto)
    X2=dropmissing(dfX2)
    X2= X2.x1
    n1= length(X1) 
    xbar1=sum(X1)/n1
    s²1=sum((X1.-xbar1).^2)/(n1-1)
    s1=sqrt(s²1)
    n2= length(X2)
    xbar2=sum(X2)/n2
    s²2=sum((X2.-xbar2).^2)/(n2-1)
    s2=sqrt(s²2)
    s²p=(s²1*(n1-1)+s²2*(n2-1))/(n1+n2-2)
    tcalculado = ( xbar1-xbar2) /  sqrt(s²p*(1/n1+1/n2))
    Alpha = 2*ccdf(TDist(n1+n2 -2), abs(tcalculado))
    println("Média de x1: ", xbar1)
    println("Variância de x1: ", s²1)
    println("Desvio-padrão de x1: ", s1)
    println("Média de x2: ", xbar2)
    println("Variância de x2: ", s²2)
    println("Desvio-padrão de x2: ", s2)
    println("Variância ponderada: ", s²p)
    println("tcalculado: ", tcalculado)
    println("Alpha: ", Alpha)
end

#AMOSTRASINDEPENDENTES(X1,X2)
AMOSTRASINDEPENDENTES(X.x1,X.x2)
