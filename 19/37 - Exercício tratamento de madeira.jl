#Exercício tratamento de madeira

using DataFrames, CSV

X=CSV.read("TratMad.csv", DataFrame)

#ANOVA
using DataFrames, Statistics, Distributions

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
DIC(X.Tratamento,X.Rep,X.PM)
