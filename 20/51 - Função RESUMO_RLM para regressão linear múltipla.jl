#Função RESUMO_RLM para regressão linear múltipla

using Statistics, Distributions, LinearAlgebra

function Resumo_rlm(x,y,α)
    X = [ones(size(x,1)) x]
    β =inv(X'X)*X'*y
    yhat = X*β
    n=size(x,1)
    nβ=length(β)
    GLR= nβ-1
    GLT=n-1
    GLE= GLT- GLR 
    Σy = sum(y)
    SQR= β'*X'*y-(Σy^2)/n
    SQE= y'*y-β'*X'*y  
    SQT = y'*y-(Σy^2)/n
    QMR=SQR/GLR
    QME=SQE/GLE
    Fc=QMR/QME
    SYX=sqrt(QME)
    CV= SYX/mean(y)*100
    R²=1-(SQE/SQT)
    R²aj=1-(QME/(SQT/GLT))
    AlphaRegressao= ccdf(FDist(GLR, GLE),abs(Fc))
    AINV=inv(X'*X)
    Vβ= AINV*QME
    tβ=β./sqrt(Diagonal(Vβ))
    αβ= 2*ccdf.(TDist(GLE), abs.(tβ))
    println("Coeficientes_estimados: ", β)
    println("GLR: ", GLR)
    println("GLE: ", GLE)
    println("GLT: ", GLT)
    println("SQR: ", SQR)
    println("SQE: ", SQE)
    println("SQT: ", SQT)
    println("QMR: ", QMR)
    println("QME: ", QME)
    println("Fc: ", Fc)
    println("αF: ", AlphaRegressao)
    println("SYX: ", SYX)
    println("CV (%): ", CV)
    println("R²: ", R²)
    println("R²aj: ", R²aj)
    println("Vβ: ", Vβ)
    println("tβ: ", tβ)
    println("αβ: ", αβ)
end

using DataFrames, CSV
X=CSV.read("biomortas.csv", DataFrame)

#Resumo_rlm(x,y,α)
Resumo_rlm([X.DAP X.Altura],X.BF,0.05)