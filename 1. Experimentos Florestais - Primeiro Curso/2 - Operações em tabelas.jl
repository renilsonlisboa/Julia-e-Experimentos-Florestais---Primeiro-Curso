#Operações em tabelas

#Leitura do arquivo de dados "mudas" em formato CSV
using DataFrames, CSV 

X=CSV.read("Z:/Alexandre/Julia/Exemplos/mudas.csv", DataFrame)

#Nomes das colunas na tabela
names(X)

#Número de linhas e colunas na tabela de dados
nrow(X), ncol(X)

#Imprimir as primeiras 7 linhas da tabela de dados
first(X, 7)

#Imprimir as últimas 7 últimas linhas
last(X, 7)

#Informações resumidas sobre a tabela de dados
describe(X)

#Obter uma determinada coluna, por exemplo, a coluna clone
X.Clone

#Obter um subconjunto da tabela de dados, de modo a obter as 7 primeiras linhas e as 4 primeiras colunas
X[1:7, 1:4]

#Criar uma nova tabela de dados classificada pela variável d
sort(X, :d)

#Retornar uma nova tabela de dados com apenas linhas que atendam a condição de valores maiores que 4 para a variável d
filter(row -> row.d > 4, X)

#Retornar uma nova tabela de dados com apenas linhas que atendam a condição de valores maiores que 3.5 para a variável d e valores maiores do que 25 e menores que 26 para a variável h
X[(X.d .> 3.5) .& (25 .< X.h .< 26), :]

#Retornar um subconjunto específico de valores, como Formiga para a variável Praga
X[in.(X.Praga, Ref(["Formiga"])), :]

#Obter um subconjunto específico de valores, como 2, para a variável f
X[in.(X.f, Ref([2])), :]

#Calcular a soma da variável h por Clone e armazenar o resultado na coluna x
combine(groupby(X, :Clone), :h=> sum => :x)

#Ordenar os valores de uma variável
sort!(X.Patologia)

#Converter as colunas de 1 a 7 em uma matriz
Matrix(X[:, 1:7])

#Obtenção de estatísticas
using Statistics

#Ordenar os valores com base nas variáveis Clone e Rusticidade
sort!(X, [:Clone, :Rusticidade])
 
#Obtenção da média da variável d por Clone
combine(X, :Clone, :d => mean)

#Obtenção da média e da variância da variável d por Clone
combine(groupby(X, :Clone)) do df
   (m = mean(df.d), s² = var(df.d))
end

#Obtenção do número de valores para cada categoria da variável Patologia
combine(groupby(X, :Patologia), :Patologia => length => :N)

#Obtenção da altura (h) média por categoria da variável Patologia
combine(groupby(X, :Patologia), :Patologia => length, :h => mean)

#Identificar as categorias da variável Praga
levels(X.Praga)

#Obtenção ddos níveis para a variável Nutrição
levels(X[:,9])

#Substituir a categoria fosforo por Fosforo 
Nutrição=replace!(X[:,9], "fosforo" => "Fosforo")

levels(Nutrição)