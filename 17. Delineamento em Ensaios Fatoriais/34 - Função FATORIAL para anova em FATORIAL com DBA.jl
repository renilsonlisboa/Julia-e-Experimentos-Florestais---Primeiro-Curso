#Função FATORIAL para anova em fatorial com DBA

using DataFrames, CSV, Statistics, Distributions

X=CSV.read("fatorial2.csv", DataFrame)

function FATORIAL2F(FatorA,FatorB,Bloco,Variavel)
    X=DataFrame()
    X.FatorA=FatorA
    X.FatorB=FatorB
    X.Bloco=Bloco
    X.Y=Variavel
    X
    I= length(unique(X.FatorA))
    J= length(unique(X.FatorB))
    K= length(unique(X.Bloco))
    GLBlocos=K-1
    GLTrat=I*J-1
    GLTotal=I*J*K-1
    GLResiduo=(I*J-1)*(K-1)
    FC=((sum(X.Y))^2)/(I*J*K) 
    AB= combine(groupby(X, :Bloco)) do df
    (m = mean(df.Y), s² = var(df.Y), total= sum(df.Y), ss=sum((df.Y).^2))
    end
    SQBlocos=((sum(AB.total.^2))/(I*J))-FC
    AT= combine(groupby(X, [:FatorA, :FatorB])) do df
    (m = mean(df.Y), s² = var(df.Y), total= sum(df.Y), ss=sum((df.Y).^2))
    end
    SQTrat=((sum(AT.total.^2))/(K))-FC
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
    GLFatorA=I-1
    GLFatorB=J-1
    GLFatorAFatorB=(I-1)*(J-1)
    AFA= combine(groupby(X, :FatorA)) do df
    (m = mean(df.Y), s² = var(df.Y), total= sum(df.Y), ss=sum((df.Y).^2))
    end
    SQFatorA=((sum(AFA.total.^2))/(J*K))-FC
    AFB= combine(groupby(X, :FatorB)) do df
    (m = mean(df.Y), s² = var(df.Y), total= sum(df.Y), ss=sum((df.Y).^2))
    end
    SQFatorB=((sum(AFB.total.^2))/(I*K))-FC
    SQFatorAFatorB=SQTrat-SQFatorA-SQFatorB
    QMFatorA=SQFatorA/GLFatorA
    QMFatorB=SQFatorB/GLFatorB
    QMFatorAFatorB=SQFatorAFatorB/GLFatorAFatorB
    FFatorA=QMFatorA/QMResiduo
    FFatorB=QMFatorB/QMResiduo
    FFatorAFatorB=QMFatorAFatorB/QMResiduo
    AlphaFatorAFatorB=ccdf(FDist(GLFatorAFatorB, GLResiduo),abs(FFatorAFatorB))
    AlphaFatorA= ccdf(FDist(GLFatorA, GLResiduo),abs(FFatorA))
    AlphaFatorB= ccdf(FDist(GLFatorB, GLResiduo),abs(FFatorB))
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
    println("GLFatorA: ", GLFatorA)
    println("GLFatorB: ", GLFatorB)
    println("GLFatorAFatorB: ", GLFatorAFatorB)
    println("SQFatorA: ", SQFatorA)
    println("SQFatorB: ", SQFatorB)
    println("SQFatorAFatorB: ", SQFatorAFatorB)
    println("QMFatorA: ", QMFatorA)
    println("QMFatorB: ", QMFatorB)
    println("QMFatorAFatorB: ", QMFatorAFatorB)
    println("FFatorAFatorB: ", FFatorAFatorB)
    println("FFatorA: ", FFatorA)
    println("FFatorB: ", FFatorB)
    println("AlphaFatorAFatorB: ", AlphaFatorAFatorB)
    println("AlphaFatorA: ", AlphaFatorA)
    println("AlphaFatorB: ", AlphaFatorB)
end

#FATORIAL2F(FatorA,FatorB,Bloco,Variavel)
FATORIAL2F(X.FatorA,X.FatorB,X.Bloco,X.h)

_______________________________________________________________________
Dados=sort(combine(groupby(X, [:FatorB,:FatorA]), :h => mean))
nFA=length(levels(X.FatorA))
nFB=length(levels(X.FatorB))
#XA: Tabela de médias dos níveis do Fator A para os níveis de B.
Medias=[Dados[1:nFA,3] Dados[(nFA+1):end,3]]
Tabela= DataFrame(Medias, :auto)
TratFB=levels(Dados.FatorB)
Tabela= rename(Tabela,[Symbol(name) for name in TratFB])
TratFA=levels(Dados.FatorA)
XA=insertcols!(Tabela, 1, :FatorA => TratFA)

#XB: Tabela de médias dos níveis do Fator B para os níveis de A.
Medias=[Dados[1:nFA,3] Dados[(nFA+1):end,3]]'
Tabela= DataFrame(Medias, :auto)
Tabela=rename(Tabela,[Symbol(name) for name in TratFA])
XB=insertcols!(Tabela, 1, :FatorB => TratFB)
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

#Teste para as médias: diferença entre os níveis a1, a2 e a3 dentro do nível b1.
XA.b1
TukeyFat(5,XA.FatorA,XA.b1,20,0.081,0.05)

#Teste para as médias: diferença entre os níveis a1, a2 e a3 dentro do nível b2.
XA.b2
TukeyFat(5,XA.FatorA,XA.b2,20,0.081,0.05)

#Teste para as médias: diferença entre os níveis b1 e b2 dentro do nível a1.
XB.a1
TukeyFat(5,XB.FatorB,XB.a1,20,0.081,0.05)


#Teste para as médias: diferença entre os níveis b1 e b2 dentro do nível a2.
XB.a2
TukeyFat(5,XB.FatorB,XB.a2,20,0.081,0.05)

#Teste para as médias: diferença entre os níveis b1 e b2 dentro do nível a3.
XB.a3
TukeyFat(5,XB.FatorB,XB.a3,20,0.081,0.05)


#Construção de um gráfico
#Níveis a1, a2 e a3 dentro do nível b1.
DMS=0.46

errorbar(XA.FatorA,XA.b1,DMS,fmt="o",label="nível b1")
xlabel("Tratamento")
ylabel("Altura (cm)")
legend(loc="best")
gcf()

#Níveis a1, a2 e a3 dentro do nível b2
errorbar(XA.FatorA,XA.b2,DMS,fmt="o",label="nível b2")
legend(loc="best")
gcf() 

#Níveis b1 e b2 dentro do nível a1.
DMS: 0.38
errorbar(XB.FatorB,XB.a1,DMS,fmt="o",label="nível a1")
legend(loc="best")
gcf()

#Níveis b1 e b2 dentro do nível a2
errorbar(XB.FatorB,XB.a2,DMS,fmt="o",label="nível a2")
legend(loc="best")
gcf()

#Níveis b1 e b2 dentro do nível a3
errorbar(XB.FatorB,XB.a3,DMS,fmt="o",label="nível a3")
legend(loc="best")
gcf()

savefig("gfat.png", dpi=300)


________________________________________________________________________
#Médias dos efeitos principais
MédiasFatorA=combine(groupby(X, :FatorA), :h => mean)

MédiasFatorB=combine(groupby(X, :FatorB), :h => mean)
