#Função DUNCAN para teste de médias de Duncan

using Statistics, DataFrames

function Duncan(Tratamento,Repeticao,Variavel,GLResiduo,QMResiduo,z)
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
    z=sort(z)
    DMS=z.*sqrt(QMResiduo/J)
    AT=sort(AT, :m, rev=true)
    A=AT.m
    B=A'
    DIF = [A[l]-B[c] for l in 1:I, c in 1:I]
    DMS=[0; sort(DMS)]
    DIFA=[if abs(DIF[i,c])>DMS[abs(i-c)+1] diferença="*" elseif abs(DIF[i,c])<=DMS[abs(i-c)+1] diferença="ns" end for i in 1:I, c in 1:I]
    Trat=levels(AT.Trat)
    NomeTratamentos= Array(AT.Trat)
    TabelaHipótese= DataFrame(DIFA, :auto)
    TabelaHipótese=rename(TabelaHipótese,[Symbol(name) for name in NomeTratamentos])
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
end

#Duncan(Tratamento,Repeticao,Variavel,GLResiduo,QMResiduo,z)

z=[3.22,3.15,3.06,2.91] #Valores tabelares de Duncan. Atualizar para novas comparações.