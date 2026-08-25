#Função DUNNET para teste de médias de Dunnet

using DataFrames, Statistics

function Dunnet(Tratamento,Repeticao,Variavel,GLResiduo,QMResiduo,Testemunha,d)
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
    AT=sort(AT, :m, rev=true)
    c=AT[in.(AT.Trat, Ref([Testemunha])), :]
    DMS=d*sqrt(2*QMResiduo/J)
    A=AT.m
    DIF = c.m.-A
    DIFA=[if abs(DIF[i])>=DMS diferença="*" elseif abs(DIF[i])<DMS diferença="ns" end for i in 1:I, c in 1:I]
        Trat=levels(AT.Trat)
    NomeTratamentos= Array(AT.Trat)
    TabelaHipótese= DataFrame(DIFA, :auto)
    TabelaHipótese=rename(TabelaHipótese,[Symbol(name) for name in NomeTratamentos])
    Tratamentos=names(TabelaHipótese)
    TabelaSignificânciaDMS=insertcols!(TabelaHipótese, 1, :Tratamento => Tratamentos)
    TabelaDMS= DataFrame(DIF', :auto)
    TabelaDMS=rename(TabelaDMS,[Symbol(name) for name in NomeTratamentos])
    TabelaMédia=DataFrame(Tratamento=AT.Trat,Média=AT.m,Variância=AT.s²)
    println("Tabela de média: ", TabelaMédia)
    println("Diferença Mínimca Significativa: ", DMS)
    println("Tabela DMS: ", TabelaDMS)
    println("Tabela de hipóteses DMS: ", TabelaSignificânciaDMS)
end

#Dunnet(Tratamento,Repeticao,Variavel,GLResiduo,QMResiduo,Testemunha,d)

d= 2.04                      #valor tabelar de Dunnet. Atulizar para novas comparações.
Testemunha= Teste

'