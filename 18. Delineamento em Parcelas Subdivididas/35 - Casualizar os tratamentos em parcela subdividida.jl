#Casualizar os tratamentos em parcela subdividida

using Random, DataFrames, CSV
X=CSV.read("aleatPS.csv", DataFrame)

function PS(X)
    B=X.FatorA
    Linha=B[shuffle(1:end), :]
    I=length(unique(X.FatorA))
    A= Matrix(X[:,2:end])
    Coluna=A
    for i=1:I
    Coluna[i,:]=A[i,shuffle(1:end)]
    end
    Coluna
    Desenho=[Linha Coluna]
    Desenho= DataFrame(Desenho, :auto)
end

PS(X)

NBlocos=4 #Número de blocos
desenho = for i=1: NBlocos
    println(PS(X))
end
