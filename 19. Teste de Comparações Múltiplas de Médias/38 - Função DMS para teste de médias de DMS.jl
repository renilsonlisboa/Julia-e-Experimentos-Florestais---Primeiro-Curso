#Função DMS para teste de médias de DMS

using Statistics, Distributions, StatsFuns

function DMS(Tratamento,Repeticao,Variavel,GLResiduo,QMResiduo,Alpha)
    X=DataFrame()
    X.Trat=Tratamento
    X.Rep=Repeticao
    X.Y=Variavel
    X
    I=length(unique(X.Trat))
    J=length(unique(X.Rep))
    AT= combine(groupby(X, :Trat)) do df
    (m = mean(df.Y), s² = var(df.Y))
    end
    t = quantile(TDist(GLResiduo),1-Alpha/2)
    DMS=t*sqrt(2*QMResiduo/J)
    AT=sort(AT, :m, rev=true)
    A=AT.m
    B=A'
    DIF = [A[l]-B[c] for l in 1:I, c in 1:I]
    DIFA=[if abs(DIF[i,c])>=DMS diferença="*" elseif abs(DIF[i,c])<DMS diferença="ns" end for i in 1:I, c in 1:I]
    DIFA= DataFrame(DIFA, :auto)
    Trat=levels(AT.Trat)
    NomeTratamentos= Array(AT.Trat)
    TabelaHipótese= DIFA
    TabelaHipótese=rename(TabelaHipótese,[Symbol(name) for name in NomeTratamentos])
    Tratamentos=names(TabelaHipótese)
    TabelaSignificânciaDMS=insertcols!(TabelaHipótese, 1, :Tratamento => Tratamentos)
    println("Tabela de média: ", AT)
    println("DMS: ", DMS)
    println("Tabela de Significância: ", DIFA)
end




______________________________________________________________________________________________________________________
using DataFrames, CSV

X=CSV.read("TratMad.csv", DataFrame)

#DMS(Tratamento,Repeticao,Variavel,GLResiduo,QMResiduo,Alpha)
DMS(X.Tratamento,X.Rep,X.PM,56,2.23,0.05)