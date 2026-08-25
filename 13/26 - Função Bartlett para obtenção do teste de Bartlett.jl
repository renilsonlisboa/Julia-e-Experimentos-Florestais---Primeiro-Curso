#Função Bartlett para obtenção do teste de Bartlett

using DataFrames, CSV, Statistics, Distributions

X=CSV.read("dic1.csv", DataFrame)

function Bartlett(Tratamento,Repeticao,Variavel,Alpha)
    X=DataFrame()
    X.Trat=Tratamento
    X.Rep=Repeticao
    X.Y=Variavel
    X
    I=length(unique(X.Trat))
    J=length(unique(X.Rep))
    AT= combine(groupby(X, :Trat)) do df
    (m = mean(df.Y),ni=length(df.Y),gl=length(df.Y)-1, s² = var(df.Y))
    end
    GLs²=sum(AT.gl.*(log10.(AT.s²)))
    logs²bar=log10(mean(AT.s²))
    C=1+(1/(3*(I-1)))*((sum(AT.gl.^-1))-(1/sum(AT.gl)))
    X²c=(1/C)*2.3026*((logs²bar*sum(AT.gl))-GLs²)
    X²Crit = quantile(Chisq(I-1),1-Alpha)
    Alpha = ccdf(Chisq(I-1), X²c)
    a=DataFrame(Tratamento=AT.Trat, Média=AT.m, Variância=AT.s²)
    println("Tabela de média e variância: ", a)
    println("X²c: ", X²c)
    println("Alpha: ", Alpha)
    println("X² crítico: ", X²Crit)
end

#Bartlett(Tratamento,Repeticao,Variavel,Alpha)
Bartlett(X.Trat,X.Rep,X.h,0.05)