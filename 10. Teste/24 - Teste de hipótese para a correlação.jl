#Teste de hipótese para a correlação

#Intervalo de confiança para correlação 
using DataFrames, CSV, Statistics, Distributions, LinearAlgebra

X=CSV.read("energia.csv", DataFrame)

n=10
r=0.97
Z=0.5*log((1+r)/(1-r))
σZ=1/sqrt(n-3)
ICInferiorZ=Z-1.96*σZ
ICSuperiorZ=Z+1.96*σZ
r_ICInferior=((exp(2*ICInferiorZ))-1)/((exp(2*ICInferiorZ))+1)
r_ICSuperior=((exp(2*ICSuperiorZ))-1)/((exp(2*ICSuperiorZ))+1)

_____________________________________________________________________
#Teste t para a correlação 
using Distributions
tr=r/sqrt((1-r^2)/(n-2))
Alpha=0.05
tVal = quantile(TDist(n-2),1-Alpha/2)
Alpha = 2*ccdf(TDist(n-2), abs(tr))

_____________________________________________________________________
#Teste para dois coeficientes de correlação
n1=23
r1=0.77
n2=53
r2=0.92
Z1=0.5*log((1+r1)/(1-r1))
Z2=0.5*log((1+r2)/(1-r2))
σZ1Z2=1/sqrt((n1-3)+(n2-3))
Zc=(Z1-Z2)/σZ1Z2

_____________________________________________________________________
#Teste para várias correlações
using Distributions
n1=57
n2=61
n3=50
r1=0.94
r2=0.91
r3=0.88
Z1=0.5*log((1+r1)/(1-r1))
Z2=0.5*log((1+r2)/(1-r2))
Z3=0.5*log((1+r3)/(1-r3))
Zw=((n1-3)*Z1+(n2-3)*Z2+(n3-3)*Z3)/((n1-3)+(n2-3)+(n3-3))
QuiQc=(((n1-3)*(Z1-Zw)^2)+(n2-3)*(Z2-Zw)^2)+((n3-3)*(Z3-Zw)^2)
QuiQuadCrit = quantile(Chisq(3-1),0.95)
rw=((exp(2*Zw))-1)/((exp(2*Zw))+1)

_____________________________________________________________________
#Intervalo de confiança para várias correlações
Zw
σZw=1/sqrt((n1-3)+(n2-3)+(n3-3))
ICInferiorZw=Zw-1.96*σZw
ICSuperiorZw=Zw+1.96*σZw
rw_ICInferior=((exp(2*ICInferiorZw))-1)/((exp(2*ICInferiorZw))+1)
rw_ICSuperior=((exp(2*ICSuperiorZw))-1)/((exp(2*ICSuperiorZw))+1)
