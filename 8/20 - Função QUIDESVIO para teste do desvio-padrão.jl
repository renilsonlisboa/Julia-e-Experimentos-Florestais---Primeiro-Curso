#Função QUIDESVIO para teste do desvio-padrão

using DataFrames, Statistics, Distributions

function quidesvio(s,σ,n)
    Quiquadrado=((n-1)*s^2)/(σ^2)
    GL=n-1
    Alpha = ccdf(Chisq(GL), Quiquadrado)*2
    println("Qui-quadrado: ", Quiquadrado)
    println("Grau de liberdade: ", GL)
    println("Alpha: ", Alpha)
end

#quidesvio(s,σ,n)
quidesvio(0.3,0.2,100)