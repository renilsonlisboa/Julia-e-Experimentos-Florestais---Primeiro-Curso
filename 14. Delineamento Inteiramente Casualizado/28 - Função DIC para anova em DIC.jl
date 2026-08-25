#Função DIC para anova em DIC

using DataFrames, CSV, Statistics, Distributions

X=CSV.read("dados.csv", DataFrame)

function DIC(Tratamento, Repeticao,Variavel)
    X=DataFrame()
    X.Trat=Tratamento
    X.Rep=Repeticao
    X.Y=Variavel
    X
    I=length(unique(X.Trat))
    J=length(unique(X.Rep))
    GLTrat=I-1
    GLResiduo=I*(J-1)
    GLTotal=I*J-1
    FC=((sum(X.Y))^2)/(I*J)
    AT= combine(groupby(X, :Trat)) do df
    (m = mean(df.Y), s² = var(df.Y), total= sum(df.Y), ss=sum((df.Y).^2))
    end
    SQTrat=((sum(AT.total.^2))/J)-FC
    SQTotal=(sum(X.Y.^2))-FC
    SQResiduo=SQTotal-SQTrat
    QMTrat=SQTrat/GLTrat
    QMResiduo=SQResiduo/GLResiduo
    FTrat=QMTrat/QMResiduo
    AlphaTrat= ccdf(FDist(GLTrat, GLResiduo),abs(FTrat))
    R²=SQTrat/SQTotal*100
    CV=sqrt(QMResiduo)/mean(X.Y)*100
    println("GLTrat: ", GLTrat)
    println("GLResíduo: ", GLResiduo)
    println("GLTotal: ", GLTotal)
    println("SQTrat: ", SQTrat)
    println("SQResíduo: ", SQResiduo)
    println("SQTotal: ", SQTotal)
    println("QMTrat: ", QMTrat)
    println("QMResíduo: ", QMResiduo)
    println("FTrat: ", FTrat)
    println("Alpha: ", AlphaTrat)
    println("R²(%): ", R²)
    println("CV(%): ", CV)
end

#DIC(Tratamento, Repeticao,Variavel)
DIC(X.Trat,X.Rep,X.Y)


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
    TabelaHipótese=rename!(TabelaHipótese,[Symbol(name) for name in NomeTratamentos])
    Tratamentos=names(TabelaHipótese)
    TabelaSignificânciaDMS=insertcols!(TabelaHipótese, 1, :Tratamento => Tratamentos)
    TabelaDMS= DataFrame(DIF, :auto)
    TabelaDMS=rename!(TabelaDMS,[Symbol(name) for name in NomeTratamentos])
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
Tukey(X.Trat,X.Rep,X.Y,25,0.0652,0.05)

gcf()
savefig("gdic.png", dpi=300)