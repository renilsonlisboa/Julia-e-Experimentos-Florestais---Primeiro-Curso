#AR - Comparação de modelos

using DataFrames, CSV, PyPlot
X=CSV.read("descritiva.csv", DataFrame)

#Modelo V=B0+B1*(d²h)
f(x) =0.00732284+3.63139e-5*x
x=(X.d.^2).*X.h
yhat=f.(x)
ei=X.v.-yhat
scatter(X.d, ei, facecolor= "none", edgecolors="blue", s=20)
xlabel("Diâmetro à altura do peito (cm)")
ylabel("Resíduo (m³)")
title("Modelo V=B0+B1*(d²h)")
ylim(-0.035, 0.035)
xlim(minimum(X.d)-0.5, maximum(X.d)+0.5)
plot([0, maximum(X.d)+0.5],[0,0],c=:black)
gcf()
savefig("gar13.png", dpi=300)

#Modelo ln(v)=B0+B1*ln(d)+B2*ln(h)
f(x1,x2) =exp((-9.55579+1.87725*x1+0.903083*x2+0.0018508996914900855))
x1=log.(X.d)
x2=log.(X.h)
yhat=f.(x1,x2)
ei=X.v.-yhat
scatter(X.d, ei, facecolor= "none", edgecolors="blue", s=20)
xlabel("Diâmetro à altura do peito (cm)")
ylabel("Resíduo (m³)")
ylim(-0.035, 0.035)
xlim(minimum(X.d)-0.5, maximum(X.d)+0.5)
title("Modelo ln(v)=B0+B1*ln(d)+B2*ln(h)")
plot([0, maximum(X.d)+0.5],[0,0],c=:black)

gcf()
savefig("gar14.png", dpi=300)