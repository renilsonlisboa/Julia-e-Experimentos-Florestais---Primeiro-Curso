#Distribuição normal padrão e distribuição tabela

#Áreas da distribuição normal padrão
using Distributions, Plots; pyplot()

function NZ(zInferior,zSuperior)
    z = zInferior:0.01:zSuperior
    plot!(z, pdf.(Normal(), z), label="Normal", xlims=(zInferior, zSuperior), xlabel="z", ylabel="Densidade", dpi=300)
    AI=-1:0.0001:0
    AS=0:0.0001:1
    BI=-2:0.0001:-1
    BS=1:0.0001:2
    CI=-3:0.0001:-2
    CS=2:0.0001:3
    plot!(AI, pdf.(Normal(),AI), fill=(0, :green), label=" 1 s")
    plot!(AS, pdf.(Normal(),AS), fill=(0, :green), label=" 1 s")
    plot!(BI, pdf.(Normal(),BI), fill=(0, :blue), label=" 2 s")
    plot!(BS, pdf.(Normal(),BS), fill=(0, :blue), label=" 2 s")
    plot!(CI, pdf.(Normal(),CI), fill=(0, :red), label=" 3 s")
    plot!(CS, pdf.(Normal(),CS), fill=(0, :red), label=" 3 s")
end
    
    
NZ(-5,5)

#Salvar o gráfico
savefig("np.png")

__________________________________________________________________
#Probabilidades na distribuição normal padrão
ÁreaVerde=1-ccdf(Normal(),1)*2

ÁreaAzul=1-ccdf(Normal(),2)*2

ÁreaVermelha=1-ccdf(Normal(),3)*2

__________________________________________________________________
#Distribuição normal padrão e distribuição de t
using Distributions, PyPlot
x = -4:0.2:4
plot(x, pdf.(Normal(), x), "k", label="Normal")
plot(x, pdf.(TDist(2) ,x), "r.", label="t com gl = 2")
plot(x, pdf.(TDist(15), x), "b.", label="t com gl = 15")
plot(x, pdf.(TDist(50),x),"g.", label="t com gl = 50")
xlim(-4,4)
ylim(0,0.5)
xlabel("X")
ylabel("Densidade")

legend()
savefig("nt.png", dpi=300)
gcf()