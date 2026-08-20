#Simetria de dados

using Distributions, PyPlot

#Assimetria positiva
d=Beta(2,8); 
x = rand(d, 10000);	
PyPlot.plt.hist(x,10,histtype = "step") 
ylabel("Frequência")
xlabel("x (u.m.)")
gcf()

#Assimetria negativa
d=Beta(8,2)
x = rand(d, 10000)
plt.hist(x, 10, facecolor="orange", histtype = "step")
gcf()

#Simétrica
d=Beta(5,5)
x = rand(d, 10000)
plt.hist(x, 10, facecolor="green", histtype = "step")
gcf()

savefig("ast.png", dpi=300)

__________________________________________________________________
#Simetria de dados

using Distributions, PyPlot

#Assimétrica positiva
d=Beta(2,8)
x = rand(d, 10000)
plt.hist(x, 10, facecolor="blue", alpha=0.75)
ylabel("Frequência")
xlabel("x (u.m.)")
mean(d)
mode(d)
median(d)

gcf()
savefig("asp.png", dpi=300)

#Assimétrica negativa
d=Beta(8,2)
x = rand(d, 10000)
plt.hist(x, 10, facecolor="orange", alpha=0.75)
ylabel("Frequência")
xlabel("x (u.m.)")
mean(d)
mode(d)
median(d)

gcf()
savefig("asn.png", dpi=300)

#Simétrica
d=Beta(5,5)
x = rand(d, 10000)
plt.hist(x, 10, facecolor="green", alpha=0.75)
ylabel("Frequência")
xlabel("x (u.m.)")
mean(d)
mode(d)
median(d)

gcf()
savefig("as.png", dpi=300)

__________________________________________________________________
#Distribuição das médias amostrais
using Distributions, PyPlot, Random

#Assimétrica positiva
d=Beta(2,8); 
x = rand(d, 10000);	
PyPlot.plt.hist(x,10,histtype = "step") 
ylabel("Frequência")
xlabel("x (u.m.)")

gcf()
savefig("map.png", dpi=300)
 
n, N = length(x), 10^6
Médias = [mean(rand(x, n)) for i in 1:N]
PyPlot.plt.hist(Médias,1000,histtype = "step") 
ylabel("Frequência")
xlabel("x (u.m.)")
legend("média da amostra")

gcf()
savefig("mapb.png", dpi=300)

#Simétrica
d=Beta(5,5); 
x = rand(d, 10000);	
PyPlot.plt.hist(x,10,histtype = "step") 
ylabel("Frequência")
xlabel("x (u.m.)")

gcf()
savefig("mas.png", dpi=300)
 
n, N = length(x), 10^6
Médias = [mean(rand(x, n)) for i in 1:N]
PyPlot.plt.hist(Médias,1000,histtype = "step") 
ylabel("Frequência")
xlabel("x (u.m.)")
legend("média da amostra")

gcf()
savefig("masb.png", dpi=300)

#Uniforme
d=Uniform(0,1); 
x = rand(d, 10000);	
PyPlot.plt.hist(x,10,histtype = "step") 
ylabel("Frequência")
xlabel("x (u.m.)")

gcf()
savefig("mu.png", dpi=300)
 
n, N = length(x), 10^6
Médias = [mean(rand(x, n)) for i in 1:N]
PyPlot.plt.hist(Médias,1000,histtype = "step") 
ylabel("Frequência")
xlabel("x (u.m.)")
legend("média da amostra")

gcf()
savefig("mub.png", dpi=300)


