#Função QUIAJUSTE para teste de qui-quadrado para ajuste

using DataFrames, CSV, Statistics, Distributions

X=CSV.read("quiajuste.csv", DataFrame) 
 
function QUIAJUSTE(fo,fe)
    Quiquadradocalculado = sum((fe-fo).^2 ./fe)
    Gl = (length(fo)-1)
    Alpha = ccdf(Chisq(Gl), Quiquadradocalculado)
    println("Qui-quadrado: ", Quiquadradocalculado)
    println("Grau de liberdade: ", Gl)
    println("Alpha: ", Alpha)
end

#QUIAJUSTE(fo,fe)
QUIAJUSTE(X.CincoAnos,X.Plantio)
