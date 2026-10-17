#Função FHIPOTESE para teste F na ANOVA

using Distributions, Plots; pyplot()
QMTrat=15
QMRes=2
FTrat=QMTrat/QMRes
GLTrat=8
GLErro =25

function FHipotese(FTrat,GLTrat,GLErro)
    xGrid = 0:0.01:(FTrat*1.2)
    Alpha=0.05
    plot!(xGrid, pdf.(FDist(GLTrat, GLErro),xGrid),c=:black, xlims=(0, (FTrat*1.2)), ylims=(0,1), label="Distribuição de F α = 0.05",
    tickfontsize=26, guidefontsize=28, legendfontsize=18)
    ValorCritico = quantile(FDist(GLTrat, GLErro),(1-Alpha))
    plot!([ ValorCritico, ValorCritico],[0,1],c=:red, ls=:dash, label="Valor de F Crítico", xlabel="Valor de F", ylabel="Densidade")
    alphaH0=0:0.0001:(1-Alpha)
    H0 = quantile(FDist(GLTrat, GLErro),alphaH0)
    DensidadeH0=pdf.(FDist(GLTrat, GLErro),H0)
    plot!(H0, DensidadeH0,fill=(0, :green), label="H0 Verdadeira")
    alphaH1=(1-Alpha):0.0001:1
    H1 = quantile(FDist(GLTrat, GLErro),alphaH1)
    DensidadeH1=pdf.(FDist(GLTrat, GLErro),H1)
    plot!(H1, DensidadeH1,fill=(0, :blue), label="H0 Falsa")
    plot!([0, FTrat],[0,0],c=:orange, lw=12, label="Valor de F Calculado")
    α = round(ccdf(FDist(GLTrat, GLErro),abs(FTrat)), digits = 7)
    A=ValorCritico/2
    B=ValorCritico*1.1
    C=FTrat*1.1
    annotate!([(A, 0.9, text("H0 Verdadeira", 18)),((B+0.5), 0.9, text("H0 Falsa", 18)),((C-1.1), 0.15, text("α =", 18)), ((C-0.6), 0.15, text(α, 18))])
end

#FHipotese(FTrat,GLTrat,GLErro)
FHipotese(FTrat,GLTrat,GLErro)

savefig("Z:/Alexandre/Julia/Exemplos/gtf.png")