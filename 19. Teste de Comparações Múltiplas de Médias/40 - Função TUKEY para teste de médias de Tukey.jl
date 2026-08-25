#Função TUKEY para teste de médias de Tukey

using CSV, DataFrames, Statistics, PyPlot, Distributions, StatsFuns

function Tukey(Tratamento,Repeticao,Variavel,GLResiduo,QMResiduo,Alpha)
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
    q=srdistinvccdf(I,GLResiduo,Alpha)
    DMS=q*sqrt(QMResiduo / 2 * (2 / J))
    AT=sort(AT, :m, rev=true)
    A=AT.m
    B=A'
    DIF = [A[l]-B[c] for l in 1:I, c in 1:I]
    DIFA=[if abs(DIF[i,c])>=DMS diferença="*" elseif abs(DIF[i,c])<DMS diferença="ns" end for i in 1:I, c in 1:I]
    Trat=levels(AT.Trat)
    NomeTratamentos=Array(AT.Trat)
    TabelaHipótese= DataFrame(DIFA, :auto)
    TabelaHipótese= rename(TabelaHipótese,[Symbol(name) for name in NomeTratamentos])
    Tratamentos=names(TabelaHipótese)
    TabelaSignificânciaDMS=insertcols!(TabelaHipótese, 1, :Tratamento => Tratamentos)
    TabelaDMS= DataFrame(DIF, :auto)
    TabelaDMS=rename(TabelaDMS,[Symbol(name) for name in NomeTratamentos])
    TabelaDMS=insertcols!(TabelaDMS, 1, :Tratamento => Tratamentos)
    TabelaMédia=DataFrame(Tratamento=AT.Trat,Média=AT.m,Variância=AT.s²)
    println("Tabela de média: ", TabelaMédia)
    println("Diferença Mínimca Significativa: ", DMS)
    println("Tabela DMS: ", TabelaDMS)
    println("Tabela de hipóteses DMS: ", TabelaSignificânciaDMS)
    errorbar(AT.Trat,AT.m,DMS,fmt="o")
    xlabel("Tratamento")
    ylabel("Y")
end

#Tukey(Tratamento,Repeticao,Variavel,GLResiduo,QMResiduo,Alpha)

gcf()
savefig("gdic.png", dpi=300)