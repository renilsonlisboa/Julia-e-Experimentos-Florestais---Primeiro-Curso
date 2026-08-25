#Regressão linear simples

using DataFrames, CSV, PyPlot

X=CSV.read("descritiva.csv", DataFrame) 

#Diagrama de dispersão entre altura e diâmetro
plot(X.d,X.h,"o",label="dados")
xlabel("Diâmetro à altura do peito (cm)")
ylabel("Altura (m)")

gcf()
savefig("gar1.png", dpi=300)


________________________________________________________________________
#Ajuste de um modelo de regressão linear simples
function rls(x,y)
    Σx = sum(x)
    Σy = sum(y)
    Σxy = sum(x.*y)
    Σx² = sum(x.^2)
    n = length(x)
    ybar=Σy/n
    xbar= Σx/n
    β1= (Σxy-(Σx*Σy)/n)/(Σx²- (Σx^2)/n)
    β0= ybar- β1* xbar
    Coeficientes=[ β0, β1]
end

#rls(x,y)
rls(X.d,X.h)

#gráfico da função yhat=7,4671+0,7287*x
using PyPlot
x = minimum(X.d):0.01: maximum(X.d)
f(x) =7.4671+0.7287*x
plot(x,f.(x),"b")
xlabel("Diâmetro à altura do peito (cm)")
ylabel("Altura (m)")

gcf()
savefig("gar2.png", dpi=300)

plot(X.d,X.h,"o",label="dados")
gcf()
savefig("gar3.png", dpi=300)


________________________________________________________________________
#Estimar a altura das árvores (ŷ) para um novo conjunto de valores de d.
d=[5.2,6.1,7.8,9.10,10,5,12.8,15.2,17.5,19.2]
ŷ=[]
for i in d
    yhat = 7.4671+0.7287*i
    append!(ŷ,yhat)
end
ŷ

#Outras maneiras de estimar os valores
f(x) =7.4671.+0.7287*x
f(d)
f(x)=7.4671+0.7287*x
f.(d)