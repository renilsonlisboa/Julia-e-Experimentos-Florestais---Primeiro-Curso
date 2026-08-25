# AR - funções

#Gráfico da função f(x)=2*x.
A=[1, 2, 4];	#Domínio
f(x)=2*x 	#função
f(A)		#Imagem da função

using PyPlot
plot(A,f(A),"g")
xlabel("X (u.m.)")
ylabel("Y (u.m.)")

gcf()
savefig("gf.png", dpi=300)


#Gráfico da função Y=4+1,5*X
xGrid = 1:0.01:10
a, b = 4, 1.5
f(x) = a + b*x
plot(xGrid,f.(xGrid),"b",label="função linear")
xlabel("X (u.m.)")
ylabel("Y (u.m.)")
ylim(0,20)

gcf()
savefig("gf2.png", dpi=300)