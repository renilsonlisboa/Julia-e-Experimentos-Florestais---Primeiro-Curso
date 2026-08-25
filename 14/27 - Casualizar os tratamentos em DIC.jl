#Casualizar os tratamentos em DIC

using DataFrames, CSV

I=3 #Número de tratamentos
J=3 #Número de repetições
#Obtenção de uma tabela com os tratamentos e repetições
XDIC = DataFrame(Tratamento=repeat(Symbol.('A':'C'), inner=J),Repeticao=repeat(1:J, outer=I))
#Salvar a tabela de dados
XDIC|> CSV.write("ALEATORIZAR.csv")

#Casualização dos tratamentos
using Random
AleatDIC(X) = X[shuffle(1:end), :]
AleatDIC(XDIC)


