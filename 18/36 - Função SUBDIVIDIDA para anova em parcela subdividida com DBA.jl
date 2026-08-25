#Função SUBDIVIDIDA para anova em parcela subdividida com DBA

using DataFrames, CSV, Statistics, Distributions

X=CSV.read("PS2.csv", DataFrame)

function SUBDIVIDIDA(FatorA, FatorB, Bloco, Variavel)
    X=DataFrame()
    X.FatorA=FatorA
    X.FatorB=FatorB
    X.Bloco=Bloco
    X.Y=Variavel
    I= length(unique(X.FatorA))
    J= length(unique(X.FatorB))
    K= length(unique(X.Bloco))
    GLBlocos=K-1
    GLTrat=I*J-1
    GLErroA=(I-1)*(K-1)
    GLParcela=I*K-1
    GLTotal=I*J*K-1
    FC=((sum(X.Y))^2)/(I*J*K) 
    AB= combine(groupby(X, :Bloco)) do df
    (m = mean(df.Y), s² = var(df.Y), total= sum(df.Y), ss=sum((df.Y).^2))
    end
    SQBlocos=((sum(AB.total.^2))/(I*J))-FC
    AT= combine(groupby(X, [:FatorA,:FatorB])) do df
    (m = mean(df.Y), s² = var(df.Y), total= sum(df.Y), ss=sum((df.Y).^2))
    end
    SQTrat=((sum(AT.total.^2))/(K))-FC
    AP= combine(groupby(X, [:Bloco,:FatorA])) do df
    (m = mean(df.Y), s² = var(df.Y), total= sum(df.Y), ss=sum((df.Y).^2))
    end
    SQParcela=((sum(AP.total.^2))/(J))-FC
    AFA= combine(groupby(X, :FatorA)) do df
    (m = mean(df.Y), s² = var(df.Y), total= sum(df.Y), ss=sum((df.Y).^2))
    end
    SQFatorA=((sum(AFA.total.^2))/(J*K))-FC
    SQErroA=SQParcela-SQFatorA-SQBlocos 
    QMBlocos=SQBlocos/GLBlocos
    QMTrat=SQTrat/GLTrat
    QMErroA=SQErroA/GLErroA
    FBlocos=QMBlocos/QMErroA
    FTrat=QMTrat/QMErroA
    AlphaBlocos= ccdf(FDist(GLBlocos, GLErroA),abs(FBlocos))
    AlphaTrat= ccdf(FDist(GLTrat, GLErroA),abs(FTrat))
    GLFatorA=I-1
    GLFatorB=J-1
    GLFatorAFatorB=(I-1)*(J-1)
    GLErroB=I*(J-1)*(K-1)
    AFB= combine(groupby(X, :FatorB)) do df
    (m = mean(df.Y), s² = var(df.Y), total= sum(df.Y), ss=sum((df.Y).^2))
    end
    SQFatorB=((sum(AFB.total.^2))/(I*K))-FC
    SQTotal=(sum(X.Y.^2))-FC
    SQFatorAFatorB=SQTrat-SQFatorA-SQFatorB
    SQErroB=SQTotal-SQParcela-SQFatorB-SQFatorAFatorB
    QMFatorA=SQFatorA/GLFatorA
    QMFatorB=SQFatorB/GLFatorB
    QMFatorAFatorB=SQFatorAFatorB/GLFatorAFatorB
    QMErroB=SQErroB/GLErroB
    FFatorA=QMFatorA/QMErroA
    FFatorB=QMFatorB/QMErroB
    FFatorAFatorB=QMFatorAFatorB/QMErroB
    AlphaFatorAFatorB=ccdf(FDist(GLFatorAFatorB, GLErroB),abs(FFatorAFatorB))
    AlphaFatorA= ccdf(FDist(GLFatorA, GLErroA),abs(FFatorA))
    AlphaFatorB= ccdf(FDist(GLFatorB, GLErroB),abs(FFatorB))
    println("GLBlocos: ", GLBlocos)
    println("GLTrat: ", GLTrat)
    println("GLParcela: ", GLParcela)
    println("GLErroA: ", GLErroA)
    println("GLTotal: ", GLTotal)
    println("SQBlocos: ", SQBlocos)
    println("SQTrat: ", SQTrat)
    println("SQParcela: ", SQParcela)
    println("SQErroA: ", SQErroA)
    println("SQTotal: ", SQTotal)
    println("QMBlocos: ", QMBlocos)
    println("QMTrat: ", QMTrat)
    println("QMErroA: ", QMErroA)
    println("FBlocos: ", FBlocos)
    println("FTrat: ", FTrat)
    println("AlphaBlocos: ", AlphaBlocos)
    println("AlphaTrat: ", AlphaTrat)
    println("GLFatorA: ", GLFatorA)
    println("GLFatorB: ", GLFatorB)
    println("GLFatorAFatorB: ", GLFatorAFatorB)
    println("GLErroB: ", GLErroB)
    println("SQFatorA: ", SQFatorA)
    println("SQFatorB: ", SQFatorB)
    println("SQFatorAFatorB: ", SQFatorAFatorB)
    println("SQErroB: ", SQErroB)
    println("QMFatorA: ", QMFatorA)
    println("QMFatorB: ", QMFatorB)
    println("QMFatorAFatorB: ", QMFatorAFatorB)
    println("QMErroB ", QMErroB)
    println("FFatorAFatorB: ", FFatorAFatorB)
    println("FFatorA: ", FFatorA)
    println("FFatorB: ", FFatorB)
    println("AlphaFatorAFatorB: ", AlphaFatorAFatorB)
    println("AlphaFatorA: ", AlphaFatorA)
    println("AlphaFatorB: ", AlphaFatorB)
end

#SUBDIVIDIDA(FatorA, FatorB, Bloco, Variavel)
SUBDIVIDIDA(X.FatorA, X.FatorB, X.Bloco, X.dap)

________________________________________________________________________

#Teste de médias de Tukey
using DataFrames, Statistics, PyPlot, Distributions, StatsFuns

function TukeyFat(NumeroRepeticao,Tratamento,Medias,GLResiduo,QMResiduo,Alpha)
    I= length(Medias)
    J=NumeroRepeticao
    q=srdistinvccdf(I,GLResiduo,Alpha)
    DMS=q*sqrt(QMResiduo / 2 * (2 / J))
    A=Medias
    B=A'
    DIF = [A[l]-B[c] for l in 1:I, c in 1:I]
    DIFA=[if abs(DIF[i,c])>=DMS diferença="*" elseif abs(DIF[i,c])<DMS diferença="ns" end for i in 1:I, c in 1:I]
    Trat=levels(Tratamento)
    NomeTratamentos= Array(Tratamento)
    TabelaHipótese= DataFrame(DIFA, :auto)
    TabelaHipótese=rename(TabelaHipótese,[Symbol(name) for name in NomeTratamentos])
    Tratamentos=names(TabelaHipótese)
    TabelaSignificânciaDMS=insertcols!(TabelaHipótese, 1, :Tratamento => Tratamentos)
    TabelaDMS= DataFrame(DIF, :auto)
    TabelaDMS=rename(TabelaDMS,[Symbol(name) for name in NomeTratamentos])
    TabelaDMS=insertcols!(TabelaDMS, 1, :Tratamento => Tratamentos)
    println("DMS: ", DMS)
    println("Tabela DMS: ", TabelaDMS)
    println("Tabela de hipóteses DMS: ", TabelaSignificânciaDMS)
end

#TukeyFat(NumeroRepeticao,Medias,GLResiduo,QMResiduo,Alpha)

#Teste para as médias entre os níveis do FatorA
MédiasFatorA=combine(groupby(X, :FatorA), :dap => mean)

TukeyFat(6,MédiasFatorA.FatorA,MédiasFatorA.dap_mean,10,0.0319,0.05)


DMS=0.283
errorbar(MédiasFatorA.FatorA, MédiasFatorA.dap_mean,DMS,fmt="o")
xlabel("Tratamento")
ylabel("dap (cm)")

gcf()
savefig("gps.png", dpi=300)
