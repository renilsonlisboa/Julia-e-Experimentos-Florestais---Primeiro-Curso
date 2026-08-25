#Inventário florestal de acácia-negra

#Leitura do arquivo de dados "inventario" em formato CSV
using DataFrames, CSV, Statistics
X=CSV.read("Z:/Alexandre/Julia/Exemplos/inventario.csv", DataFrame)


describe(X)

#Quando os valores faltantes não devem ser computados para o cálculo da média
cap_médio=mean(skipmissing(X.X1))

#Eliminar os valores faltantes de uma determinada variável
cap=collect(skipmissing(X.X1))