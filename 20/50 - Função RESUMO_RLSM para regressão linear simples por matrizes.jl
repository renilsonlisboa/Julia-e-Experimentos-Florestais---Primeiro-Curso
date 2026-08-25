#Função RESUMO_RLSM para regressão linear simples por matrizes

using Statistics, Distributions, PyPlot

function Resumo_rlsm(x,y,α)
    X = [ones(size(x,1)) x]
    β =inv(X'X)*X'*y
    yhat = X*β
    n=length(x)
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
    Sβ0=sqrt(AINV[1,1]*QME)
    Sβ1=sqrt(AINV[2,2]* QME)
    t0 = β[1,1]/Sβ0
    t1 = β[2,1]/Sβ1
    αβ0= 2*ccdf(TDist(GLE), abs(t0))
    αβ1= 2*ccdf(TDist(GLE), abs(t1))
    tα = quantile(TDist(n-2),1- α/2) 
    ICInferior_β0 = β[1,1] - tα * Sβ0
    ICSuperior_β0 = β[1,1] + tα * Sβ0
    ICInferior_β1 = β[2,1] - tα * Sβ1
    ICSuperior_β1 = β[2,1] + tα * Sβ1
    x0= minimum(x):0.001: maximum(x)
    nx0=length(x0)
    X0 = [ones(size(x0,1)) x0]
    yhatX0 = X0*β
    tα = quantile(TDist(n-2),1- α/2) 
    Vβ= AINV*QME
    Syhat_X0= sqrt.([X0[i,:]'*Vβ*X0[i,:] for i in 1: nx0])
    CIL= yhatX0.-( tα.* Syhat_X0)
    CIU= yhatX0.+( tα.* Syhat_X0)
    Syhatno= sqrt.([(1+X0[i,:]'*AINV*X0[i,:])*QME for i in 1: nx0])
    CIPL= yhatX0.-( tα.* Syhatno)
    CIPU= yhatX0.+( tα.* Syhatno)
    subplot(121)
    plot(x0, yhatX0,"b", label="Regressão")
    xlabel("Diâmetro à altura do peito (cm)")
    ylabel("Altura (m)")
    plot(x,y,".k",label="dados")
    plot(x0, CIL,"r",label="Intervalo de confiança")
    plot(x0, CIU,"r")
    plot(x0, CIPU,"g",label="Intervalo de predição")
    plot(x0, CIPL,"g")
    legend(loc="upper left")
    subplot(122)
    ei= y.-yhat
    scatter(x, ei, facecolor= "none", edgecolors="blue", s=20)
    xlabel("Diâmetro à altura do peito (cm)")
    ylabel("Resíduo (m)")
    ylim(-maximum(abs.(ei))-0.5, maximum(abs.(ei))+0.5)
    xlim(minimum(x)-0.5, maximum(x)+0.5)
    plot([0, maximum(x)+0.5],[0,0],c=:black)
    legend(loc="upper left")
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
    println("Erro-padrão_β0: ", Sβ0)
    println("Erro-padrão_ β1: ", Sβ1)
    println("t0: ", t0)
    println("αβ0: ", αβ0)
    println("t1: ", t1)
    println("αβ1: ", αβ1)
    println("ICInferior_β0: ", ICInferior_β0)
    println("ICSuperior_β0: ", ICSuperior_β0)
    println("ICInferior_ β1: ", ICInferior_β1)
    println("ICSuperior_ β1: ", ICSuperior_β1)
end

using DataFrames, CSV
X=CSV.read("descritiva.csv", DataFrame)

#Resumo_rlsm(x,y,α)
Resumo_rlsm(X.d,X.h,0.05)

gcf()
savefig("gar8.png", dpi=300)