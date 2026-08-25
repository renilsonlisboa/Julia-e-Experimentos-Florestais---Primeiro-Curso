#Função RESUMO para estatística descritiva

using DataFrames, CSV, Statistics, Distributions

#Arquivo com os dados das variáveis dendrométricas
X=CSV.read("descritiva.csv", DataFrame)
 
function RESUMO(variavel)
    n= length(variavel)
    xbar=sum(variavel)/n
    md=median(variavel)
    mo=mode(variavel)
    max=maximum(variavel)
    min=minimum(variavel)
    at=maximum(variavel)-minimum(variavel)
    s2=sum((variavel.-xbar).^2)/(n-1)
    s=sqrt(s2)
    sx=s/sqrt(n)
    cv=s/xbar*100
    alpha = 0.05
    tVal = quantile(TDist(n-1),1-alpha/2)
    ICInferior = (xbar- tVal * sx)
    ICSuperior = (xbar+ tVal * sx)
    Confiança=(1-alpha)*100
    println("Média: ", xbar)
    println("Mediana: ", md)
    println("Moda: ", mo)
    println("Mínimo: ", min)
    println("Máximo: ", max)
    println("Amplitude: ", at)
    println("Variância: ", s2)
    println("Desvio padrão: ", s)
    println("Erro padrão da média: ", sx)
    println("Coeficiente de variação (%): ", cv)
    println("Limite de confiança inferior: ", ICInferior)
    println("Limite de confiança superior: ", ICSuperior)
    println("Confiança (%): ", Confiança)
end

RESUMO(X.d)
