#Função BANDAS-RLSNO para intervalo de confiança e predição para um novo valor

using Statistics, Distributions

function Bandas_rlsno(x,y,α,x0)
    X = [ones(size(x,1)) x]
    β =inv(X'X)*X'*y
    yhat = X*β
    n=size(x,1)
    nβ=length(β)
    GLR= nβ-1
    GLT=n-1
    GLE= GLT- GLR
    SQE= y'*y-β'*X'*y
    QME=SQE/GLE
    AINV=inv(X'*X)
    nx0= size(x0,1)
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
    df=DataFrame(ValorEstimado=yhatX0, CIL=CIL, CIU=CIU, CIPL=CIPL, CIPU=CIPU)
end

using DataFrames, CSV
X=CSV.read("descritiva.csv", DataFrame)

#Bandas_rlsno(x,y,α,x0)
Bandas_rlsno([(X.d.^2) X.h],X.v,0.05,[18 15])