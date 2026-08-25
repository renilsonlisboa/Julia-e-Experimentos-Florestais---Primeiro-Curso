#Função DBA para anova em DBA

using DataFrames, CSV, Statistics, Distributions

X=CSV.read("dba2.csv", DataFrame)

function DBA(Tratamento,Bloco,Variavel)
    X=DataFrame()
    X.Trat=Tratamento
    X.Bloco=Bloco
    X.Y=Variavel
    X
    I=length(unique(X.Trat))
    J=length(unique(X.Bloco))
    GLTrat=I-1
    GLBlocos=J-1
    GLResiduo=(I-1)*(J-1)
    GLTotal=I*J-1
    FC=((sum(X.Y))^2)/(I*J)
    AB= combine(groupby(X, :Bloco)) do df
    (m = mean(df.Y), s² = var(df.Y), total= sum(df.Y), ss=sum((df.Y).^2))
    end
    SQBlocos=((sum(AB.total.^2))/I)-FC
    AA= combine(groupby(X, :Trat)) do df
    (m = mean(df.Y), s² = var(df.Y), total= sum(df.Y), ss=sum((df.Y).^2))
    end
    SQTrat=((sum(AA.total.^2))/J)-FC
    SQTotal=(sum(X.Y.^2))-FC
    SQResiduo=SQTotal-SQBlocos-SQTrat
    QMBlocos=SQBlocos/GLBlocos
    QMTrat=SQTrat/GLTrat
    QMResiduo=SQResiduo/GLResiduo
    FBlocos=QMBlocos/QMResiduo
    FTrat=QMTrat/QMResiduo
    AlphaBlocos= ccdf(FDist(GLBlocos, GLResiduo),abs(FBlocos))
    AlphaTrat= ccdf(FDist(GLTrat, GLResiduo),abs(FTrat))
    R²=SQTrat/SQTotal*100
    CV=sqrt(QMResiduo)/mean(X.Y)*100
    println("GLBlocos: ", GLBlocos)
    println("GLTrat: ", GLTrat)
    println("GLResíduo: ", GLResiduo)
    println("GLTotal: ", GLTotal)
    println("SQBlocos: ", SQBlocos)
    println("SQTrat: ", SQTrat)
    println("SQResíduo: ", SQResiduo)
    println("SQTotal: ", SQTotal)
    println("QMBlocos: ", QMBlocos)
    println("QMTrat: ", QMTrat)
    println("QMResíduo: ", QMResiduo)
    println("FBlocos: ", FBlocos)
    println("FTrat: ", FTrat)
    println("AlphaBlocos: ", AlphaBlocos)
    println("AlphaTrat: ", AlphaTrat)
    println("R²(%): ", R²)
    println("CV(%): ", CV)
end

#DBA(Tratamento,Bloco,Variavel)
DBA(X.Trat,X.Bloco,X.Volume)


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
    TabelaHipótese=rename(TabelaHipótese,[Symbol(name) for name in NomeTratamentos])
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
    ylabel("Volume (m³/ha)")
end

#Tukey(Tratamento,Repeticao,Variavel,GLResiduo,QMResiduo,Alpha)
Tukey(X.Trat,X.Bloco,X.Volume,15,10.575,0.05)

gcf()
savefig("gdba.png", dpi=300)