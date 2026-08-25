#Função AMOSTRASPAREADAS para teste t de amostras pareadas

using DataFrames, CSV, Statistics, Distributions

X=CSV.read("amostraspareadas.csv", DataFrame) 
 
function AMOSTRASPAREADAS(x1,x2)
    n= length(x1)
    x1bar=mean(x1)
    x2bar=mean(x2)
    d=x1-x2
    xbard=sum(d)/n
    s²=sum((d.-xbard).^2)/(n-1)
    s=sqrt(s²)
    tcalculado = xbard/(s/sqrt(n))
    Alpha = 2*ccdf(TDist(n-1), abs(tcalculado))
    println("Média de x1: ", x1bar)
    println("Média de x2: ", x2bar)
    println("Média da diferença: ", xbard)
    println("Variância da diferença: ", s²)
    println("Desvio-padrão da difrença: ", s)
    println("tcalculado: ", tcalculado)
    println("Alpha: ", Alpha)
end
    
#AMOSTRASPAREADAS(x1,x2)    
AMOSTRASPAREADAS(X.x1,X.x2)

___________________________________________________
#Função ICPAREADO para intervalo de confiança para a diferença da média populacional

function ICPAREADO(x1,x2)
    alpha=0.05
    n= length(x1)
    x1bar=mean(x1)
    x2bar=mean(x2)
    d=x1-x2
    xbard=sum(d)/n
    s²=sum((d.-xbard).^2)/(n-1)
    s=sqrt(s²)
    sx=s/sqrt(n)
    tVal = quantile(TDist(n-1),1-alpha/2)
    ICInferior = xbard- tVal * sx
    ICSuperior = xbard+ tVal * sx
    Confiança=(1-alpha)*100
    println("Média da diferença: ", xbard)
    println("Limite de confiança inferior: ", ICInferior)
    println("Limite de confiança superior: ", ICSuperior)
    println("Confiança (%): ", Confiança)
end

#ICPAREADO(x1,x2)
ICPAREADO(X.x1,X.x2)