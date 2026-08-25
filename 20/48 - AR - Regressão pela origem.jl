#AR - Regressão pela origem

using DataFrames, CSV, PyPlot

X=CSV.read("af.csv", DataFrame)   

plot(X.Massa,X.AreaFoliar,"b.",label="dados")
xlabel("Massa seca de folhas(g)")
ylabel("Área foliar (cm²)")

gcf()
savefig("gar7.png", dpi=300)

#Ajuste da equação que passa pela origem.
function rlso(x,y)
    Σx = sum(x)
    Σxy = sum(x.*y)
    Σx² = sum(x.^2)
    β= Σxy/ Σx²
end

#rlso(x,y)
rlso(X.Massa,X.AreaFoliar)

#Soma dos desvios.
f(x) = 63.6461*x
SE=sum(X.AreaFoliar.-f.(X.Massa))

#Estatísticas do modelo que passa pela origem
using Statistics

function Resumo_rlso(x,y)
    Σx = sum(x)
    Σxy = sum(x.*y)
    Σx² = sum(x.^2)
    β= Σxy/ Σx²
    f(x)= β*x
    yhat=f.(x)
    n=length(x)
    GLT=n
    GLE= n-1
    GLR=GLT-GLE
    SQR=((Σxy)^2)/Σx²
    SQE= sum((yhat- y).^2)
    SQT = sum(y.^2)
    QMR=SQR/GLR
    QME=SQE/GLE
    Fc=QMR/QME
    SYX=sqrt(QME)
    CV= SYX/mean(y)*100
    Σy² = sum(y.^2)
    R²=(Σxy^2)/(Σx²*Σy²)
    println("QME: ", QME)
    println("Fc: ", Fc)
    println("SYX: ", SYX)
    println("CV (%): ", CV)
    println("R²: ", R²)
end

#Resumo_rlso(x,y)
Resumo_rlso(X.Massa,X.AreaFoliar)

#Testar a significância de βhat
using Distributions

Fc= 48771.62339989079
gl=length(X.Massa)-1
tc=sqrt(Fc)
αβ= 2*ccdf(TDist(gl), abs(tc))