#Função TUMAAMOSTRA para teste t da média de uma amostra

using DataFrames, CSV, Statistics, Distributions

X=CSV.read("umaamostra.csv", DataFrame) 
 
function TUMAAMOSTRA(xamostra,xpadrao)
    n= length(xamostra)
    xbar=sum(xamostra)/n
    s2=sum((xamostra.-xbar).^2)/(n-1)
    s=sqrt(s2)
    sx = s/sqrt(n)
    tcalculado = (xbar- xpadrao)/(s/sqrt(n))
    Alpha = 2*ccdf(TDist(n-1), abs(tcalculado))
    println("Média: ", xbar)
    println("Variância: ", s2)
    println("Desvio-padrão: ", s)
    println("Erro padrão: ", sx)
    println("tcalculado: ", tcalculado)
    println("Alpha: ", Alpha)
end

#TUMAAMOSTRA(xamostra,xpadrao)
TUMAAMOSTRA(X.h,200)