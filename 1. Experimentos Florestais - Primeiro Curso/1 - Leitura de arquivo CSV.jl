
#Leitura de um arquivo de dados em formato CSV

using DataFrames, CSV 
X=CSV.read("mudas.csv", DataFrame) 

#Ativação dos pacotes: using DataFrames, CSV 
# X variável onde serão armazenados os dados
#Para leitura de uma tabela de dados: readtable
#Local em que o arquivo está armazenado: Z:/Alexandre/Julia/Exemplos
#Nome do arquivo: mudas
#Formato do arquivo: .csv
#DataFrame: armazenamento dos dados em uma tabela.
