#Função BONFERONI para teste de médias de Bonferoni

using DataFrames, Statistics, PyPlot, Distributions

function Bonferoni(Tratamento,Repeticao,Variavel,GLResiduo,QMResiduo,Alpha)
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
    NMC=2 #comparação de médias duas a duas
    m=(I*(I-1))/NMC
    alphaC=Alpha/m
    t=quantile(TDist(GLResiduo),1-alphaC/2)
    DMS=t*sqrt(2*(QMResiduo/J))
    AT=sort(AT, :m, rev=true)
    A=AT.m
    B=A'
    DIF = [A[l]-B[c] for l in 1:I, c in 1:I]
    DIFA=[if abs(DIF[i,c])>=DMS diferença="*" elseif abs(DIF[i,c])<DMS diferença="ns" end for i in 1:I, c in 1:I]
    Trat=levels(AT.Trat)
    NomeTratamentos= Array(AT.Trat)
    TabelaHipótese= DataFrame(DIFA, :auto)
    TabelaHipótese= rename(TabelaHipótese,[Symbol(name) for name in NomeTratamentos])
    Tratamentos=names(TabelaHipótese)
    TabelaSignificânciaDMS=insertcols!(TabelaHipótese, 1, :Tratamento => Tratamentos)
    TabelaDMS= DataFrame(DIF, :auto)
    TabelaDMS=rename(TabelaDMS,[Symbol(name) for name in NomeTratamentos])
    TabelaDMS=insertcols!(TabelaDMS, 1, :Tratamento => Tratamentos)
    TabelaMédia=DataFrame(Tratamento=AT.Trat,Média=AT.m,Variância=AT.s²)
    println("Tabela de média: ", TabelaMédia)
    println("Diferença Mínima Significativa: ", DMS)
    println("Tabela DMS: ", TabelaDMS)
    println("Tabela de hipóteses DMS: ", TabelaSignificânciaDMS)
    errorbar(AT.Trat,AT.m,DMS,fmt="o")
    xlabel("Tratamento")
    ylabel("Y")
end

#Bonferoni(Tratamento,Repeticao,Variavel,GLResiduo,QMResiduo,Alpha)