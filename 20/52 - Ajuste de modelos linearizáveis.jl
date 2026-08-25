#AR - Ajuste de modelos linearizáveis

using DataFrames, CSV
X=CSV.read("Z:/Alexandre/Julia/Exemplos/descritiva.csv", DataFrame)

x=log.(X.d) 
y=log.(X.v) 

Resumo_rlm(x,y,0.05) #Conforme arquivo 51.

using PyPlot

f(x) =-8.05991+2.29350*x
x = minimum(X.d):0.01: maximum(X.d)
logx=log.(x)
yhat=exp.(f.(logx))
plot(x,yhat,"b.",label="Sem correção")
xlabel("Diâmetro à altura do peito (cm)")
ylabel("Volume (m³)")
plot(X.d,X.v,"g.",label="dados")

#Correção
f(x) =-8.05991+2.29350*x+(0.011639/2)
x = minimum(X.d):0.01: maximum(X.d)
logx=log.(x)
yhatC=exp.(f.(logx))
plot(x,yhatC,"r",label="Com correção")
legend(loc="upper left")

gcf()
savefig("Z:/Alexandre/Julia/Exemplos/gar10.png", dpi=300)


____________________________________________________________________________________
#Dados de biomassa nativas
using DataFrames, CSV
X=CSV.read("Z:/Alexandre/Julia/Exemplos/BioNat.csv", DataFrame)

x=log.(X.d) 
y=log.(X.BGalhos) 

Resumo_rlm(x,y,0.05)

using PyPlot
f(x) =-3.89732+2.64394*x
x = minimum(X.d):0.01: maximum(X.d)
logx=log.(x)
yhat=exp.(f.(logx))
plot(x,yhat,"b",label="Sem correção")
xlabel("Diâmetro à altura do peito (cm)")
ylabel("Biomassa dos galhos (kg)")
plot(X.d,X.BGalhos,"g.",label="dados")

#Correção
f(x) =-3.89732+2.64394*x+(0.3164853999352024/2)
x = minimum(X.d):0.01: maximum(X.d)
logx=log.(x)
yhatC=exp.(f.(logx))
plot(x,yhatC,"r",label="Com correção")
legend(loc="upper left")

gcf()
savefig("Z:/Alexandre/Julia/Exemplos/gar12.png", dpi=300)