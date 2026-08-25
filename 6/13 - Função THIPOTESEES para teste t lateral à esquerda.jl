#Função THIPOTESEES para teste t lateral à esquerda

using Distributions, Plots; pyplot()

function tHipoteseEs(n,tCalculado)
    xGrid = -5:0.01:5
    Alpha=0.05
    plot!(xGrid, pdf.(TDist(n),xGrid), c=:black, xlims=(-5, 5), ylims=(0,1), label="Distribuição de t α = 0.05")
    ValorCritico = quantile(TDist(n-1),1-Alpha)*-1
    plot!([ ValorCritico, ValorCritico],[0,1],c=:red, ls=:dash, label="Valor de t Crítico", xlabel="Valor de t", ylabel="Densidade")
    alphaH0=Alpha:0.0001:1
    H0 = quantile(TDist(n-1),alphaH0)
    DensidadeH0= pdf.(TDist(n),H0)
    plot!(H0, DensidadeH0,fill=(0, :green), label="H0 Verdadeira")
    alphaH1=0:0.0001:Alpha
    H1 = quantile(TDist(n-1),alphaH1)
    DensidadeH1= pdf.(TDist(n),H1)
    plot!(H1, DensidadeH1,fill=(0, :blue), label="H0 Falsa - direita")
    plot!([0, tCalculado],[0,0],c=:orange, lw=12, label="Valor de t Calculado")
    α = ccdf(TDist(n-1), abs(tCalculado))
    A=ValorCritico/2
    B=ValorCritico*1.15
    C=tCalculado*1.15
    annotate!([(A, 0.9, text("H0 Verdadeira")),(B, 0.9, text("H0 Falsa")),(C, 0.15, text("α =")), ((C+0.2), 0.1, α)])
end

#tHipoteseEs(n,tCalculado)
tHipoteseEs(10,-2.14)

savefig("tte.png")