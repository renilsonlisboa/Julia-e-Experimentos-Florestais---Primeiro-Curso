#Resumo gráfico de dados

#Histograma
using DataFrames, CSV, Gadfly
X=CSV.read("descritiva.csv", DataFrame)
plot(X, x=:d, Geom.histogram(bincount=10), Guide.xlabel("Diâmetro (cm)"), Guide.ylabel("Frequência"), Guide.title("Histograma para diâmetro"))
Fig1 = SVG("g1.svg", 14cm, 8cm)

#Histograma de frequências acumuladas 
using DataFrames, CSV, PyPlot
X=CSV.read("descritiva.csv", DataFrame)
plt[:hist](X.d, 10, cumulative="true")
xlabel("d (cm)")
ylabel("Frequência")
savefig("g2s.svg")
savefig("gsp.png")
savefig("g2.png", dpi=300)
gcf()

#Box-plot
using DataFrames, CSV, StatsPlots
X=CSV.read("daplocais.csv", DataFrame)
@df X boxplot(:Local,:d, xlabel = "Local", ylabel = "d (cm)", legend =false, dpi=300)
savefig("g3.png")

#Linha
using DataFrames, CSV, Plots
X=CSV.read("temperatura.csv", DataFrame)
plot(X.Dia, X.T, xlabel = "Dia", ylabel = "Temperatura (°C)",legend =false, dpi=300)
savefig("g4.png")

using DataFrames, CSV, Plots
X=CSV.read("mortalidade.csv", DataFrame)
plot(X.Ano, [X.Pinheiro, X.Canelas],xlabel = "Ano", ylabel = "Mortalidade (%)",label=["Pinheiro-do-Paraná" "Canelas"],legend =true, dpi=300)
savefig("g5.png")

#Barras
using DataFrames, CSV, Plots
X=CSV.read("familias.csv", DataFrame)
bar(X.Familia,X.NE,xlabel = "Família Botânica", ylabel = "Número de espécies",legend =false, dpi=300)
savefig("g6.png")

#Dispersão
using DataFrames, CSV, Plots
X=CSV.read("descritiva.csv", DataFrame)
scatter(X.d, X.h,xlabel = "Diâmetro à altura do peito (cm)", ylabel = "Altura (m)",legend =false, dpi=300)
savefig("g7.png")

#Setores
using DataFrames, CSV, Plots
X=CSV.read("ingresso.csv", DataFrame)
pie(X.Grupo,X.Ingresso, dpi=300)
savefig("g8.png")

#Bivariados
using DataFrames, CSV, StatsPlots
X=CSV.read("descritiva.csv", DataFrame)
gr(size = (900, 900))
@df X cornerplot([:d :h :cc :v :ff], grid = false, dpi=500)
savefig("g9.png")