#Função DUASVARIANCIAS para teste de duas variâncias

using DataFrames, CSV, Statistics, Distributions

X=CSV.read("amostrasindependentes.csv", DataFrame); 

function DUASVARIANCIAS(X1,X2)
    dfX1 = DataFrame([X1], :auto)
    X1=dropmissing(dfX1)
    X1= X1.x1
    dfX2 = DataFrame([X2], :auto)
    X2=dropmissing(dfX2)
    X2= X2.x1
    n1= length(X1) 
    xbar1=sum(X1)/n1
    s²1=sum((X1.-xbar1).^2)/(n1-1)
    s1=sqrt(s²1)
    gl1=n1-1
    n2= length(X2)
    xbar2=sum(X2)/n2
    s²2=sum((X2.-xbar2).^2)/(n2-1)
    s2=sqrt(s²2)
    gl2=n2-1
    df = DataFrame()
    df.GrupoOriginal =["x1", "x2"]
    df.Media=[ xbar1, xbar2]
    df.Variancia=[ s²1, s²2]
    df.GrauDeLiberdade=[ n1, n2]
    df
    AT=sort(df, :Variancia, rev=true)
    F= AT.Variancia[1,1]/AT.Variancia[2,1]
    α= ccdf(FDist(gl1, gl2),abs(F))
    df = DataFrame()
    df.GrupoOriginal =["x1", "x2"]
    df.Media=[AT.Media[1,1], AT.Media[2,1]]
    df.Variancia=[AT.Variancia[1,1], AT.Variancia[2,1]]
    df. GrauDeLiberdade =[AT.GrauDeLiberdade[1,1], AT.GrauDeLiberdade[2,1]]
    df.F=[F,-]
    df.α=[α,-]
    return df
end

#DUASVARIANCIAS(X1,X2)
DUASVARIANCIAS(X.x1,X.x2)
 