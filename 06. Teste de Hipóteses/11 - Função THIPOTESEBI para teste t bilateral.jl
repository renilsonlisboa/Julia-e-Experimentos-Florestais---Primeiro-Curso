#Função THIPOTESEBI para teste t bilateral
	
using Distributions, Plots; pyplot()

function tHipoteseBi(n,tCalculado)
    xGrid = -5:0.01:5
    Alpha=0.05
    plot!(xGrid, pdf.(TDist(n),xGrid), c=:black, xlims=(-5, 5), ylims=(0,1), label="Distribuição de t α = 0.05")
    ValorCriticoS = quantile(TDist(n-1),1-Alpha/2)
    ValorCriticoI =(quantile(TDist(n-1),1-Alpha/2))*-1
    plot!([ ValorCriticoS, ValorCriticoS],[0,1],c=:red, ls=:dash, label="Valor de t Crítico Superior", xlabel="Valor de t", ylabel="Densidade")
    plot!([ ValorCriticoI, ValorCriticoI],[0,1],c=:red, ls=:dash, label="Valor de t Crítico Inferior")
    alphaH0=(Alpha/2):0.0001:(1-(Alpha/2))
    H0 = quantile(TDist(n-1),alphaH0)
    DensidadeH0= pdf.(TDist(n),H0)
    plot!(H0, DensidadeH0,fill=(0, :green), label="H0 Verdadeira")
    alphaH1I=0:0.0001:(Alpha/2)
    alphaH1S=(1-(Alpha/2)):0.0001:1
    H1I = quantile(TDist(n-1),alphaH1I)
    H1S = quantile(TDist(n-1),alphaH1S)
    DensidadeH1I= pdf.(TDist(n),H1I)
    DensidadeH1S= pdf.(TDist(n),H1S)
    plot!(H1I, DensidadeH1I,fill=(0, :blue), label="H0 Falsa - esquerda")
    plot!(H1S, DensidadeH1S,fill=(0, :blue), label="H0 Falsa - direita")
    plot!([0, tCalculado],[0,0],c=:orange, lw=12, label="Valor de t Calculado")
    α = 2*ccdf(TDist(n-1), abs(tCalculado))
    A=(ValorCriticoI+ValorCriticoS)/2
    B=ValorCriticoS*1.15
    C=ValorCriticoI*1.15
    D=tCalculado*1.15
    annotate!([(A, 0.9, text("H0 Verdadeira")),(B, 0.9, text("H0 Falsa")),(C, 0.9, text("H0 Falsa")),(D, 0.15, text("α =")), ((D+0.2), 0.1, α)])
end

#tHipoteseBi(n,tCalculado)
tHipoteseBi(25,1.8)

savefig("ttb.png")