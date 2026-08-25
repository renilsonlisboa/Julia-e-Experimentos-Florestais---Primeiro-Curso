#Função COEF_RLMP para regressão linear ponderada

using Statistics, Distributions,LinearAlgebra

function Coef_rlmP(x,y,α)
    X = [ones(size(x,1)) x]
    β =inv(X'X)*X'*y
    yhat = X*β
    ei=y.-yhat
    lnei²=log.(ei.^2)
    lnx=log.(x)
    XR=[ones(size(x,1)) lnx]
    βR =inv(XR'XR)*XR'*lnei²
    βRd=Diagonal(βR[2:end])
    Wi=x.^βRd
    W=Diagonal(Wi)
    βP=inv(X'.*inv(W)*X)*X'.*inv(W)*y
end


using DataFrames, CSV,  PyPlot
X=CSV.read("descritiva.csv", DataFrame)

x=(X.d.^2).*X.h
y=X.v

Coef_rlmP(x,y,0.05)


#Modelo com ponderação V=B0+B1*(d²h)
f(x) =0.0073+3.6314e-5*x
x=(X.d.^2).*X.h
yhat=f.(x)
ei=X.v.-yhat
Wi=x.^-0.9355
eiP=ei.*Wi
scatter(X.d, eiP, facecolor= "none", edgecolors="blue", s=20)
xlabel("Diâmetro à altura do peito (cm)")
ylabel("Resíduo Ponderado")
title("Modelo V=B0+B1*(d²h)")
xlim(minimum(X.d)-0.5, maximum(X.d)+0.5)
ylim(-0.0001,0.0001)
plot([0, maximum(X.d)+0.5],[0,0],c=:black)
gcf()
savefig("gar16.png", dpi=300)