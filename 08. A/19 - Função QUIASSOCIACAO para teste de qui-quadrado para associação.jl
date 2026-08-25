#Função QUIASSOCIACAO para teste de qui-quadrado para associação

using DataFrames, CSV, Statistics, Distributions

X=CSV.read("quiassociacao.csv", DataFrame) 

function QUIASSOCIACAO(X)
    FO=X[:,2:end]
    L=size(FO,1)
    C=size(FO,2)
    TotalLinha = [sum(FO[i,:]) for i in 1:L]
    TotalColuna = [sum(FO[:,i]) for i in 1:C]
    n = sum(TotalColuna)
    PropLinha = TotalLinha/n
    PropColuna = TotalColuna/n
    FE = [PropColuna[c]*PropLinha[l]*n for l in 1:L, c in 1:C]
    Quiquadradocalculado = sum([(FO[l,c]-FE[l,c])^2 / FE[l,c] for l in 1:L, c in 1:C])
    Gl = (L-1)*(C-1)
    Alpha = ccdf(Chisq(Gl), Quiquadradocalculado)
    println("Frequência Esperada: ", FE)
    println("Qui-quadrado: ", Quiquadradocalculado)
    println("Grau de liberdade: ", Gl)
    println("Alpha: ", Alpha)
end

#QUIASSOCIACAO(X)
QUIASSOCIACAO(X)
    