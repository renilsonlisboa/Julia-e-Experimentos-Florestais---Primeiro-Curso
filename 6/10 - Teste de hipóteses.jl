#Teste de hipóteses
using Distributions

media=0.53
mu=0.49
s=0.012
n=100
sx=s/sqrt(n)
alpha = 0.05
tVal = quantile(TDist(n-1),1-alpha/2)
LimiteInferior = (mu- tVal * sx)
LimiteSuperior = (mu+ tVal * sx)

#Função HIPOTESE
using Distributions, Plots; pyplot()

function Hipotese(n,DesvioPadrao,media,mu)
    Alpha=0.05
    media=media
    n= n
    xbar=mu
    s=DesvioPadrao
    sx=s/sqrt(n)
    tVal = quantile(TDist(n-1),1-Alpha/2)
    z=(media-mu)/sx
    z=round(z)
    ICInferior = (xbar- tVal * sx)
    ICSuperior = (xbar+ tVal * sx)
    xGridInfH0=(Alpha/2):0.0001:0.5
    xGridSupH0=0.5:0.0001:(1-(Alpha/2))
    xGridInfH1=0:0.0001: (Alpha/2)
    xGridSupH1=(1-(Alpha/2)):0.0001:1
    H0Inf = quantile.(TDist(n-1),xGridInfH0)
    H0Sup= quantile.(TDist(n-1),xGridSupH0)
    H1Inf = quantile.(TDist(n-1),xGridInfH1)
    H1Sup= quantile.(TDist(n-1),xGridSupH1)
    DensidadeH0Inf= pdf.(TDist(n),H0Inf)
    DensidadeH0Sup= pdf.(TDist(n),H0Sup)
    DensidadeH1Inf= pdf.(TDist(n),H1Inf)
    DensidadeH1Sup= pdf.(TDist(n),H1Sup)
    XH1Inf = xbar.+(H1Inf.*sx)
    XH1Sup = xbar.+( H1Sup.*sx)
    XH0Inf = xbar.+(H0Inf.*sx)
    XH0Sup = xbar.+( H0Sup.*sx)
    plot!( XH1Inf, DensidadeH1Inf,fill=(0, :blue), label="H0 Falsa", dpi=300)
    plot!( XH1Sup, DensidadeH1Sup,fill=(0, :blue), label="H0 Falsa")
    plot!( XH0Inf, DensidadeH0Inf,fill=(0, :green), label="H0 Verdadeira")
    plot!( XH0Sup, DensidadeH0Sup,fill=(0, :green), label="H0 Verdadeira")
    plot!([ ICInferior, ICInferior],[0,1],c=:red, ls=:dash, label="Limite de confiança inferior", xlabel="Valor", ylabel="Densidade")
    plot!([ ICSuperior, ICSuperior],[0,1],c=:red, ls=:dash, label="Limite de confiança superior")
    A=(ICInferior+ICSuperior)/2
    B=ICInferior
    C=ICSuperior
    D=(ICInferior+ICSuperior)/2
    E= ICSuperior
    F=ICInferior
    annotate!([(A, 0.9, text("H0 Verdadeira")),(0.493, 0.9, text("H0 Falsa")),(0.487, 0.9, text("H0 Falsa")),(D, 0.15, text("Média = ")), (D, 0.1, xbar), (F, 0.15, text("LI = ")), (F, 0.1, ICInferior), (E, 0.15, text("LS = ")), (E, 0.1, ICSuperior), (0.493, 0.5, text("α = 0.05")),(0.493, 0.4, text("z amostra =")),(0.493, 0.35, z), (0.493, 0.3, text("Média da amostra = ")),(0.493, 0.25, media)])
end

#Hipotese(n,DesvioPadrao,media,mu)
Hipotese(100,0.012,0.53,0.49)

savefig("gth.png")