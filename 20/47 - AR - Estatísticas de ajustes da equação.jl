#AR - Estatísticas de ajustes da equação

#Análise de variância de um modelo linear simples

using Statistics, Distributions

function Frl(x,y,yhat,nβ)
    n=length(x)
    GLR= nβ-1
    GLT=n-1
    GLE= GLT- GLR 
    SSR= sum((yhat.- mean(y)).^2)
    SSE= sum((yhat- y).^2)
    SST = sum((y.- mean(y)).^2)
    MSR=SSR/GLR
    MSE=SSE/GLE
    Fc=MSR/MSE
    AlphaRegressao= ccdf(FDist(GLR, GLE),abs(Fc))
    println("Fc: ", Fc)
    println("α: ", AlphaRegressao)
end

using DataFrames, CSV
X=CSV.read("descritiva.csv", DataFrame) 

f(x) =7.4671.+0.7287*x 	#equação ajustada
yhat=f(X.d)			    #obtenção dos valores estimados

#Frl(x,y,yhat,nβ)
Frl(X.d,X.h,yhat,2)


________________________________________________________________________
#Estatísticas do ajuste de uma equação de regressão linear simples

using Statistics, Distributions

function Resumo_rl(x,y,yhat,nβ)
    n=length(x)
    GLR= nβ-1
    GLT=n-1
    GLE= GLT- GLR 
    SQR= sum((yhat.- mean(y)).^2)
    SQE= sum((yhat- y).^2)
    SQT = sum((y.- mean(y)).^2)
    QMR=SQR/GLR
    QME=SQE/GLE
    Fc=QMR/QME
    SYX=sqrt(QME)
    CV= SYX/mean(y)*100
    R²=1-(SQE/SQT)
    R²aj=1-(QME/(SQT/GLT))
    println("Fc: ", Fc)
    println("SYX: ", SYX)
    println("CV (%): ", CV)
    println("R²: ", R²)
    println("R²aj: ", R²aj)
end

f(x) =7.4671.+0.7287*x 	#equação ajustada
yhat=f(X.d)			#obtenção dos valores estimados

#Resumo_rl(x,y,yhat,nβ)
Resumo_rl(X.d,X.h,yhat,2)


________________________________________________________________________
#Teste das hipóteses H_0: β_1=0 e H_0: β_0=0

using Statistics, Distributions
function t_rls(x,y,yhat,β0,β1)
    n=length(x)
    SSE= sum((yhat- y).^2)
    MSE=SSE/(n-2)
    SSx=sum((x.- mean(x)).^2)
    S1=sqrt(MSE/SSx)
    t1= β1/S1
    xbar= mean(x)
    S0=sqrt(MSE*((1/n)+(xbar^2)/SSx))
    t0= β0/S0
    αβ0= 2*ccdf(TDist(n-2), abs(t0))
    αβ1= 2*ccdf(TDist(n-2), abs(t1))
    println("t0: ", t0)
    println("αβ0: ", αβ0)
    println("t1: ", t1)
    println("αβ1: ", αβ1)
end

#t_rls(x,y,yhat,β0,β1)
t_rls(X.d,X.h,yhat, 7.4671, 0.7287)


________________________________________________________________________
#Intervalos de confiança para  β_1 e β_0

using Statistics, Distributions

function IC_rls(x,y,yhat,β0,β1,α)
    n=length(x)
    SQE= sum((yhat- y).^2)
    QME=SQE/(n-2)
    SSx=sum((x.- mean(x)).^2)
    S1=sqrt(QME/SSx)
    xbar= mean(x)
    S0=sqrt(QME*((1/n)+(xbar^2)/SSx))
    tα = quantile(TDist(n-2),1- α/2) 
    ICInferior_β0 = β0 - tα * S0
    ICSuperior_β0 = β0 + tα * S0
    ICInferior_β1 = β1 - tα * S1
    ICSuperior_β1 = β1 + tα * S1
    println("ICInferior_β0: ", ICInferior_β0)
    println("ICSuperior_β0: ", ICSuperior_β0)
    println("ICInferior_ β1: ", ICInferior_β1)
    println("ICSuperior_ β1: ", ICSuperior_β1)
end

#IC_rls(x,y,yhat,β0,β1,α)
IC_rls(X.d,X.h,yhat, 7.4671, 0.7287,0.05)


________________________________________________________________________
#Análise de Resíduos

using PyPlot
f(x) =7.4671.+0.7287*x
f(X.d);
ei=X.h-f(X.d)
scatter(X.h, ei, facecolor= "none", edgecolors="blue", s=20)
xlabel("Altura (m)")
ylabel("Resíduo (m)")
maximum(ei)
minimum(ei)
ylim(-5, 5)
xlim(minimum(X.h)-0.5, maximum(X.h)+0.5)
plot([0, maximum(X.h)+0.5],[0,0],c=:black)


gcf()
savefig("gar4.png", dpi=300)

scatter(X.d, ei, facecolor= "none", edgecolors="orange", s=20)
xlabel("Diâmetro à altura do peito (cm)")
ylabel("Resíduo (m)")
ylim(-5, 5)
xlim(minimum(X.d)-0.5, maximum(X.d)+0.5)
plot([0, maximum(X.d)+0.5],[0,0],c=:black)

gcf()
savefig("gar5.png", dpi=300)


________________________________________________________________________
#Intervalo de confiança para a média e intervalo de predição

X[in.(X.d, Ref([15.7])), :]

f(x) =7.4671.+0.7287*x
yhat=f(15.7)

using PyPlot, Distributions

function bandas_rls(x,y,β0,β1,α)
    X0= x
    f(x) = β0+ β1*x
    n=length(x)
    yhat= f.(x)
    SSE= sum((yhat- y).^2)
    MSE=SSE/(n-2)
    SSx=sum((x.- mean(x)).^2)
    xbar= mean(x)
    tα = quantile(TDist(n-2),1- α/2) 
    CIU(X0)= β0+ β1*X0+ tα*sqrt(MSE*((1/n)+(((X0- xbar)^2)/SSx)))
    CIL(X0)= β0+ β1*X0- tα*sqrt(MSE*((1/n)+(((X0- xbar)^2)/SSx)))
    CIPU(X0)= β0+ β1*X0+ tα*sqrt(MSE*(1+(1/n)+(((X0- xbar)^2)/SSx)))
    CIPL(X0)= β0+ β1*X0- tα*sqrt(MSE*(1+(1/n)+(((X0- xbar)^2)/SSx)))
    df=DataFrame(X = x, Y = y, ValorEstimado=yhat, CIL=CIL.(X0), CIU=CIU.(X0), CIPL=CIPL.(X0),CIPU=CIPU.(X0))
end

#bandas_rls(x,y,β0,β1,α)
bandas_rls(X.d,X.h,7.4671, 0.7287,0.05)

#Gráfico dos intervalos de confiança
using PyPlot, Distributions

function Gbandas_rls(x,y,β0,β1,α)
    X0= minimum(x):0.001: maximum(x)
    f(x) = β0+ β1*x
    plot(X0,f.(X0),"b", label="Regressão")
    xlabel("Diâmetro à altura do peito (cm)")
    ylabel("Altura (m)")
    plot(x,y,".k",label="dados")
    n=length(x)
    yhat= f.(x)
    SSE= sum((yhat- y).^2)
    MSE=SSE/(n-2)
    SSx=sum((x.- mean(x)).^2)
    xbar= mean(x)
    tα = quantile(TDist(n-2),1- α/2) 
    CIU(X0)= β0+ β1*X0+ tα*sqrt(MSE*((1/n)+(((X0- xbar)^2)/SSx)))
    CIL(X0)= β0+ β1*X0- tα*sqrt(MSE*((1/n)+(((X0- xbar)^2)/SSx)))
    CIPU(X0)= β0+ β1*X0+ tα*sqrt(MSE*(1+(1/n)+(((X0- xbar)^2)/SSx)))
    CIPL(X0)= β0+ β1*X0- tα*sqrt(MSE*(1+(1/n)+(((X0- xbar)^2)/SSx)))
    plot(X0, CIU.(X0) ,"r",label="Intervalo de confiança")
    plot(X0, CIL.(X0) ,"r")
    plot(X0, CIPU.(X0) ,"g",label="Intervalo de predição")
    plot(X0, CIPL.(X0) ,"g")
    legend(loc="upper left")
end

#Gbandas_rls(x,y,β0,β1,α)
Gbandas_rls(X.d,X.h,7.4671, 0.7287,0.05)

gcf()
savefig("gar6.png", dpi=300)