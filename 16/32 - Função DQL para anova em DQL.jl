#Função DQL para anova em DQL

using DataFrames, CSV, Statistics, Distributions

X=CSV.read("dql2.csv", DataFrame)

function DQL(Tratamento,Linha,Coluna,Variavel)
    X=DataFrame()
    X.Trat=Tratamento
    X.Linha=Linha
    X.Coluna=Coluna
    X.Y=Variavel
    X
    I=length(unique(X.Linha))
    J= length(unique(X.Coluna))
    K= length(unique(X.Trat))
    GLLinhas=I-1
    GLColunas=J-1
    GLTrat=K-1
    GLResiduo=(K-1)*(K-2)
    GLTotal=K^2-1
    FC=((sum(X.Y))^2)/(K^2)
    AL= combine(groupby(X, :Linha)) do df
    (m = mean(df.Y), s² = var(df.Y), total= sum(df.Y), ss=sum((df.Y).^2))
    end
    SQLinhas=((sum(AL.total.^2))/K)-FC
    AC= combine(groupby(X, :Coluna)) do df
    (m = mean(df.Y), s² = var(df.Y), total= sum(df.Y), ss=sum((df.Y).^2))
    end
    SQColunas=((sum(AC.total.^2))/K)-FC
    AT= combine(groupby(X, :Trat)) do df
    (m = mean(df.Y), s² = var(df.Y), total= sum(df.Y), ss=sum((df.Y).^2))
    end
    SQTrat=((sum(AT.total.^2))/K)-FC 
    SQTotal=(sum(X.Y.^2))-FC
    SQResiduo=SQTotal-SQLinhas-SQColunas-SQTrat
    QMLinhas=SQLinhas/GLLinhas
    QMColunas=SQColunas/GLColunas
    QMTrat=SQTrat/GLTrat
    QMResiduo=SQResiduo/GLResiduo
    FLinhas=QMLinhas/QMResiduo
    FColunas=QMColunas/QMResiduo
    FTrat=QMTrat/QMResiduo
    AlphaLinhas= ccdf(FDist(GLLinhas, GLResiduo),abs(FLinhas))
    AlphaColunas= ccdf(FDist(GLColunas, GLResiduo),abs(FColunas))
    AlphaTrat= ccdf(FDist(GLTrat, GLResiduo),abs(FTrat))
    R²=SQTrat/SQTotal*100
    CV=sqrt(QMResiduo)/mean(X.Y)*100
    println("GLLinhas: ", GLLinhas)
    println("GLColunas: ", GLColunas)
    println("GLTrat: ", GLTrat)
    println("GLResíduo: ", GLResiduo)
    println("GLTotal: ", GLTotal)
    println("SQLinhas: ", SQLinhas)
    println("SQColunas: ", SQColunas)
    println("SQTrat: ", SQTrat)
    println("SQResíduo: ", SQResiduo)
    println("SQTotal: ", SQTotal)
    println("QMLinhas: ", QMLinhas)
    println("QMColunas: ", QMColunas)
    println("QMTrat: ", QMTrat)
    println("QMResíduo: ", QMResiduo)
    println("FLinhas: ", FLinhas)
    println("FColunas: ", FColunas)
    println("FTrat: ", FTrat)
    println("AlphaLinhas: ", AlphaLinhas)
    println("AlphaColunas: ", AlphaColunas)
    println("AlphaTrat: ", AlphaTrat)
    println("R²(%): ", R²)
    println("CV(%): ", CV)
end

#DQL(Tratamento,Linha,Coluna,Variavel)
DQL(X.Trat,X.Linha,X.Coluna,X.Y)


_________________________________________________________________________
#Teste de médias de Tukey

using DataFrames, Statistics, PyPlot, Distributions, StatsFuns

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
    NomeTratamentos= Array(AT.Trat)
    TabelaHipótese= DataFrame(DIFA, :auto)
    TabelaHipótese= rename(TabelaHipótese,[Symbol(name) for name in NomeTratamentos])
    Tratamentos=names(TabelaHipótese)
    TabelaSignificânciaDMS=insertcols!(TabelaHipótese, 1, :Tratamento => Tratamentos)
    TabelaDMS= DataFrame(DIF, :auto)
    TabelaDMS= rename(TabelaDMS,[Symbol(name) for name in NomeTratamentos])
    TabelaDMS=insertcols!(TabelaDMS, 1, :Tratamento => Tratamentos)
    TabelaMédia=DataFrame(Tratamento=AT.Trat,Média=AT.m,Variância=AT.s²)
    println("Tabela de média: ", TabelaMédia)
    println("Diferença Mínimca Significativa: ", DMS)
    println("Tabela DMS: ", TabelaDMS)
    println("Tabela de hipóteses DMS: ", TabelaSignificânciaDMS)
    errorbar(AT.Trat,AT.m,DMS,fmt="o")
    xlabel("Tratamento")
    ylabel("Altura (cm)")
end

#Tukey(Tratamento,Repeticao,Variavel,GLResiduo,QMResiduo,Alpha)
Tukey(X.Trat,X.Trat,X.Y,12,8.56,0.05)

gcf()
savefig("gdql.png", dpi=300)