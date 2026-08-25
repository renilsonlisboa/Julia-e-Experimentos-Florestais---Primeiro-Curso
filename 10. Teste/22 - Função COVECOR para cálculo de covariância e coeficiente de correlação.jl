#Função COVECOR para cálculo de covariância e coeficiente de correlação

using DataFrames, CSV, Statistics, Distributions

X=CSV.read("covariancia.csv", DataFrame)
 
function COVECOR(x,y)
    n= length(x)
    cov=(sum(x.*y)-((sum(x)*sum(y))/n))/(n-1)
    xbar=sum(x)/n
    s²x=sum((x.-xbar).^2)/(n-1)
    sx=sqrt(s²x)
    ybar=sum(y)/n
    s²y=sum((y.-ybar).^2)/(n-1)
    sy=sqrt(s²y)
    cor=cov/(sx*sy)
    println("Covariância: ", cov)
    println("Correlação: ", cor)
end

#COVECOR(x,y)
COVECOR(X.rfai,X.b)