#Função SR para cálculo da matriz de variância-covariância e matriz de coeficiente de correlação

using DataFrames, CSV, Statistics, Distributions, LinearAlgebra

X=CSV.read("energia.csv", DataFrame)
 
function SR(X)
    n=size(X,1)
    p=size(X,2)
    A = [[X[:,i].-mean(X[:,i])]' for i in 1:p]
    S=A*A'/(n-1)
    s²=Diagonal(S)
    s=sqrt(s²)
    INVS=inv(s)
    R=INVS*S*INVS
    println("S: ", S)
    println("R: ", R)
end

#SR(X)
SR(X)

using StatsPlots
gr(size = (1200, 1200))
@df X cornerplot([:cap :h :b :c :pcs], grid = false, dpi=900)

savefig("gr.png")