#AR - Regressão linear simples por matrizes

using DataFrames, CSV

X=CSV.read("biomortas.csv", DataFrame) 

function mrls(x,y)
    X = [ones(size(x,1)) x]
    β =inv(X'X)*X'*y
end

#mrls(x,y)
mrls(X.DAP,X.H)    