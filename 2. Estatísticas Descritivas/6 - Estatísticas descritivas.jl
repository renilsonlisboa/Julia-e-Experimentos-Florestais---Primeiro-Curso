#Estatísticas descritivas

x=[36.4, 44.9, 61.3, 20.0, 49.5, 70.2, 29.4, 33.1, 44.9, 25.4, 44.9]

using Statistics, Distributions

n= length(x)

Média=mean(x)

pm=(maximum(x)+minimum(x))/2

Mediana=median(x)

Moda=mode(x)

AT=maximum(x)-minimum(x)

s²=var(x)

s=std(x)

cv=s/Média*100

__________________________________________________________________
using Distributions, PyPlot

#Simulação 1
d=Normal(20,0)
x = rand(d, 10000);
PyPlot.plt.hist(x,10,histtype = "step")
ylabel("Frequência")
xlabel("x (u.m.)")
mean(x)
var(x)
std(x)
gcf()

#Simulação 2
d=Normal(20,4)
x = rand(d, 10000);
PyPlot.plt.hist(x,10,histtype = "step")
mean(x)
var(x)
std(x)
gcf()

#Simulação 3
d=Normal(20,8)
x = rand(d, 10000);
PyPlot.plt.hist(x,10,histtype = "step")
mean(x)
var(x)
std(x)
gcf()

savefig("ged.png", dpi=300)
__________________________________________________________________
#Erro padrão, para o conjunto de dados da linha 3
sx=s/sqrt(n)

__________________________________________________________________
using DataFrames, CSV, Distributions

#Arquivo com os valores de diâmetros à altura do peito da espécie acácia-negra 
X=CSV.read("Z:/Alexandre/Julia/Exemplos/descritiva.csv", DataFrame)
 
Media=mean(X.d)
Desviopadrao=std(X.d)
ErroPadrao=std(X.d)/sqrt(length(X.d))
n, N = 62, 1000000
Reamostragem = [mean(rand(X.d, n)) for i in 1:N]
MediaReamostragem=mean(Reamostragem)
DesvioPadraoReamostragem=std(Reamostragem)

__________________________________________________________________
#Intervalo de confiança para a média da amostra, para o conjunto de dados da linha 3
alpha = 0.05
tVal = quantile(TDist(n-1),1-alpha/2)
ICInferior = (Média- tVal * sx)
ICSuperior = (Média+ tVal * sx)

__________________________________________________________________
#Função IC para obtenção do intervalo de confiança graficamente 

using Distributions, Plots; pyplot()

function IC(x)
    Alpha=0.05
    n= length(x)
    xbar=sum(x)/n
    xbar=round(xbar)
    s²=sum((x.-xbar).^2)/(n-1)
    s=sqrt(s²)
    sx=s/sqrt(n)
    tVal = quantile(TDist(n-1),1-Alpha/2)
    ICInferior = (xbar- tVal * sx)
    ICInferior=round(ICInferior)
    ICSuperior = (xbar+ tVal * sx)
    ICSuperior=round(ICSuperior)
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
    plot!( XH1Inf, DensidadeH1Inf,fill=(0, :blue), xlims=((ICInferior*0.6), (ICSuperior*1.2)), ylims=(0,1), label="H0 Falsa",dpi=300)
    plot!( XH1Sup, DensidadeH1Sup,fill=(0, :blue), label="H0 Falsa")
    plot!( XH0Inf, DensidadeH0Inf,fill=(0, :green), label="H0 Verdadeira")
    plot!( XH0Sup, DensidadeH0Sup,fill=(0, :green), label="H0 Verdadeira")
    plot!([ ICInferior, ICInferior],[0,1],c=:red, ls=:dash, label="Limite de confiança inferior", xlabel="Valor", ylabel="Densidade")
    plot!([ ICSuperior, ICSuperior],[0,1],c=:red, ls=:dash, label="Limite de confiança superior")
    A=(ICInferior+ICSuperior)/2
    B=ICInferior*0.90
    C=ICSuperior*1.1
    D=(ICInferior+ICSuperior)/2
    E= ICSuperior*0.98
    F=ICInferior*0.95
    G= ICSuperior*1.10
    annotate!([(A, 0.9, text("H0 Verdadeira")),(B, 0.9, text("H0 Falsa")),(C, 0.9, text("H0 Falsa")),(D, 0.15, text("Média = ")), ((D+0.2), 0.1, xbar), (F, 0.15, text("LI = ")), ((F+0.2), 0.1, ICInferior), (E, 0.15, text("LS = ")), ((E+0.2), 0.1, ICSuperior), (G, 0.5, text("α = 0.05"))])
end

IC(x)

savefig("np.png")

__________________________________________________________________
#Intervalos de confiança para 100 amostras 
using DataFrames, Random, Distributions, PyPlot

d=Normal(20,8)
X = rand(d, 100000000);

function IC(X)
    mu=mean(X)
    n=1000
    N=100
    Amostra = [rand(X, n) for i in 1:N]
    Media=mean.(Amostra)
    Desvio=std.(Amostra)
    ErroPadrao=Desvio/sqrt(n)
    alpha = 0.05
    tVal = quantile(TDist(n-1),1-alpha/2)
    Delta= tVal*ErroPadrao
    LI=Media-Delta
    LS=Media+Delta
    df = DataFrame()
    df.NSimulacao = 1:N
    df.Media=Media
    df.Delta=Delta
    df.LI=LI
    df.LS=LS
    Dentro=df[(df.LI .< mu) .& (df.LS .>mu), :]
    ForaAcima=df[(df.LI .> mu) .& (df.LS .>mu), :]
    ForaAbaixo=df[(df.LI .< mu) .& (df.LS .<mu), :]
    errorbar(Dentro.NSimulacao,Dentro.Media,Dentro.Delta,fmt="o", c=:green, label="Valor da Amostra")
    errorbar(ForaAcima.NSimulacao,ForaAcima.Media,ForaAcima.Delta,fmt="o", c=:blue, label="Valor da Amostra")
    errorbar(ForaAbaixo.NSimulacao,ForaAbaixo.Media,ForaAbaixo.Delta,fmt="o", c=:red, label="Valor da Amostra")
    plot([0,N+1],[mu,mu], c=:black, label="Parâmetro")
    xlabel("Simulação")
    ylabel("Valor")
    legend(loc="best")
end

IC(X)

gcf()
savefig("ICC.png", dpi=300)