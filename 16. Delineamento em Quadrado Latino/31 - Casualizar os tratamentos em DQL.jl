#Casualizar os tratamentos em DQL

using DataFrames, CSV, Random
X=CSV.read("aleatdql.csv", DataFrame)

function AleatDQL(X)
    Linha(X) = X[shuffle(1:end), :]
    Linhas=Linha(X)
    Coluna(X) = X[:, shuffle(2:end)]
    Colunas=Coluna(X)
end

#AleatDQL(X)
AleatDQL(X)
