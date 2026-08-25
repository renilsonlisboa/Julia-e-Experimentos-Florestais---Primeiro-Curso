#Função RESUMO_RLMC para regressão linear linearizável com correção

using Statistics, Distributions,LinearAlgebra

function Resumo_rlmC(x,y,α)
    X = [ones(size(x,1)) x]
    β =inv(X'X)*X'*y
    yhat = X*β
    n=n=size(x,1)
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
    FatorDeCorreção=QME/2
    yhatC = exp.(yhat.+(QME/2))
    yC=exp.(y)
    SSRC= sum((yhatC.- mean(yC)).^2)
    SSEC= sum((yhatC- yC).^2)
    SSTC = sum((yC.- mean(yC)).^2)
    MSEC=SSEC/GLE
    SYX=sqrt(MSEC)
    CV= SYX/mean(yC)*100
    R²=1-(SSEC/SSTC)
    R²aj=1-(MSEC/(SSTC/GLT))
    println("Coeficientes_estimados: ", β)
    println("QME: ", QME)
    println("SYX: ", SYX)
    println("CV (%): ", CV)
    println("R²: ", R²)
    println("R²aj: ", R²aj)
    println("FatorDeCorreção: ", FatorDeCorreção)
end

using DataFrames, CSV
X=CSV.read("descritiva.csv", DataFrame)

x=[log.(X.d) log.(X.h)]
y=log.(X.v) 

Resumo_rlmC(x,y,0.05)
