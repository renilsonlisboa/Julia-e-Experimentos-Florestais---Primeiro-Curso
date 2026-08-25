#Função THIPOTESEDI para teste t lateral à direita

using Distributions, Plots; pyplot()

function tHipoteseDi(n,tCalculado)
    xGrid = -5:0.01:5
    Alpha=0.05
    plot!(xGrid, pdf.(TDist(n),xGrid), c=:black, xlims=(-5, 5), ylims=(0,1), label="Distribuição de t α = 0.05")
    ValorCritico = quantile(TDist(n-1),1-Alpha)
    plot!([ ValorCritico, ValorCritico],[0,1],c=:red, ls=:dash, label="Valor de t Crítico", xlabel="Valor de t", ylabel="Densidade")
    alphaH0=0:0.0001:(1-Alpha)
    H0 = quantile(TDist(n-1),alphaH0)
    DensidadeH0= pdf.(TDist(n),H0)
    plot!(H0, DensidadeH0,fill=(0, :green), label="H0 Verdadeira")
    alphaH1=(1-Alpha):0.0001:1
    H1 = quantile(TDist(n-1),alphaH1)
    DensidadeH1= pdf.(TDist(n),H1)
    plot!(H1, DensidadeH1,fill=(0, :blue), label="H0 Falsa - direita")
    plot!([0, tCalculado],[0,0],c=:orange, lw=12, label="Valor de t Calculado")
end

#tHipoteseDi(n,tCalculado)
tHipoteseDi(10,2.14)

savefig("ttd.png")