#Distribuição Normal

#Distribuição da altura das mudas de louro-pardo
using PyPlot
xGrid = 10:0.01:20
mu, s = 15, 2
f(x) = (1/(s*sqrt(2*pi))*exp(-0.5*(((x-mu).^2)/(s^2))))
plot(xGrid,f.(xGrid),"r",label="Distribuição Normal")
xlabel("Altura (cm)")
ylabel("Densidade")

#Salvar o gráfico
savefig("lp.png", dpi=300)
#Visualizar o gráfico
gcf()

__________________________________________________________________
#Guapuruvu cultivado em estufa
using PyPlot
xGrid = 30:0.01:55
mu, s = 42.5, 4
f(x) = (1/(s*sqrt(2*pi))*exp(-0.5*(((x-mu).^2)/(s^2))))
plot(xGrid,f.(xGrid),"r",label="Distribuição Estufa")
xlabel("Altura (cm)")
ylabel("Densidade")
gcf()

#Guapuruvu cultivado em ambiente natural
xGrid = 5:0.01:40
mu, s = 22.5, 8
f(x) = (1/(s*sqrt(2*pi))*exp(-0.5*(((x-mu).^2)/(s^2))))
plot(xGrid,f.(xGrid),"b",label="Distribuição Ambiente Natural")

legend()
savefig("gae.png", dpi=300)
gcf()

__________________________________________________________________
#Distribuição normal padronizada 
using PyPlot
xGrid = -4:0.01:4
f(x) =( 1 / (sqrt(2*pi)))*exp(-0.5*x.^2)
plot(xGrid,f.(xGrid),"b",label="Distribuição Normal Padronizada")
xlabel("z")
ylabel("Densidade")
savefig("np.png", dpi=300)
gcf()

__________________________________________________________________
#Padronização de valores
X=[ 7.33, 2.01, 2.23, 3.54, 6.48, 5.11, 5.00, 1.70, 5.78, 2.79, 4.89, 6.60, 4.05, 4.82, 9.08, 3.90, 8.45, 7.73, 5.30, 5.31];

using DataFrames, Statistics

function z(X)
    X = sort(X)
    Média=mean(X)
    DesvioPadrão=std(X)
    z=(X.-Média)./DesvioPadrão
    df = DataFrame()
    df.X =X
    df.z=z
    return df
end
 
Tabela=z(X)

#Estatísticas dos valores originais e transformados

Média_X=mean(Tabela.X)

Variância_X=var(Tabela.X)

Desvio_Padrão_X=std(Tabela.X)

Média_z=mean(Tabela.z)

Variância_z=var(Tabela.z)

Desvio_Padrão_z=std(Tabela.z)

__________________________________________________________________
#Densidade básica da madeira das espécies araucária e pau-ferro
XAraucaria=[ 0.34, 0.54, 0.39, 0.49, 0.39, 0.32, 0.67, 0.74, 0.46, 0.19, 0.51, 0.16, 0.55, 0.40, 0.26, 0.32, 0.14, 0.37, 0.66, 0.34, 0.33, 0.28, 0.52, 0.37, 0.52, 0.16, 0.34, 0.46, 0.48, 0.28, 0.43, 0.46, 0.45, 0.67, 0.64, 0.44, 0.29, 0.46, 0.40, 0.63]
PauFerro=[ 1.01, 1.02, 0.59, 1.17, 1.04, 0.71, 0.83, 1.14, 0.85, 1.18, 1.14, 0.84, 0.55, 0.80, 0.89, 0.95, 0.94, 0.57, 0.64, 0.46, 0.62, 0.92, 0.29, 0.75, 1.11, 0.79, 0.66, 1.21, 0.94, 1.05, 0.96, 0.44, 1.33, 0.72, 1.10, 0.49, 0.77, 0.91, 0.82, 0.83]