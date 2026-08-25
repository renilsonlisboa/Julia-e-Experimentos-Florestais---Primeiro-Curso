#Função SK para teste de médias de Scott-Knott

using Statistics, Distributions, DataFrames

function SK(x,nt,I,J,QME,GLE,Alpha)
    K=I-1 #número de partições
    NomeTratT1=[nt[1:i] for i in 1:K]
    NomeTratT2=[nt[i+1:end] for i in 1:K]
    T1 = [x[1:i] for i in 1:K]
    T2=[x[i+1:end] for i in 1:K]
    t1=sum.(T1)
    t2=sum.(T2)
    k1=length.(T1)
    k2=length.(T2)
    B0i=(((t1.^2)./k1).+((t2.^2)./k2)).-(((t1.+t2).^2)./(k1.+k2))
    B0=maximum(B0i)
    Sub_Grupos=DataFrame(Tratamentos_Grupo1=NomeTratT1, Tratamentos_Grupo2=NomeTratT2,Médias_Grupo1=T1,Médias_Grupo2=T2,B0=B0i)
    Grupos_Testados=Sub_Grupos[in.(Sub_Grupos.B0, Ref(B0)), :]
    MG=mean(x)
    S20=(sum((x.-MG).^2)+(QME/J)*GLE)/(I+GLE)
    Lambda=(pi/(2*(pi-2)))*(B0/S20)
    QuiQuadCrit = quantile(Chisq(I/(pi-2)),1-Alpha)
    DIF=[if Lambda>QuiQuadCrit diferença="*" elseif Lambda<=QuiQuadCrit diferença="ns" end]
    Grupos_Testados=insertcols!(Grupos_Testados, 6, :Significância => DIF)
    println("Tabela de Sub_Grupos: ", Sub_Grupos)
    println("Tabela de Grupos_Testados: ", Grupos_Testados)
    println("Soma de Quadrado entre grupos - B0 : ", B0)
    println("Estimador de máxima verossimilhança: ", S20)
    println("Lambda: ", Lambda)
    println("Valor Crítico de Qui-Quadrado: ", QuiQuadCrit)
end

#Entrada do conjunto de dados experimentais e definição de informações para o teste

#X=Conjunto de dados
J=length(unique(X.Bloco))   #número de repetição, indicar a variável
QME=10.08                   #Quadrado médio do resíduo (ANOVA)
GLE=15                      #Grau de liberdade do resíduo (ANOVA)
Alpha=0.05

#Primeira avaliação - Comparação das médias de todos os tratamentos
print("Primeira avaliação")
Dados= combine(groupby(X, :Trat)) do df
    (m = mean(df.Y), s² = var(df.Y))
end
Dados=sort(Dados, :m, rev=true)
I=length(Dados.m)           #número de médias
nt=Dados.Trat               #Nome dos tratamentos
x=Dados.m                   #médias a serem comparadas

SK(x,nt,I,J,QME,GLE,Alpha)  #Aplicação da função

#Segunda avaliação - Comparação das médias dentro do Grupo 1 (Por exemplo, tratamentos C, D e A)
print("Segunda avaliação")
Dados= combine(groupby(X, :Trat)) do df
    (m = mean(df.Y), s² = var(df.Y))
end
Dados=sort(Dados[Dados.m .> 80, :], :m, rev=true)    #Definir quais médias devem ser comparadas. No caso, médias maiores que 80, por exemplo

# Se preferir denominar os tratamentos, Dados=sort(Dados[in.(Dados.Trat, Ref(["C", "D","A"])), :], :m, rev=true)    
I=length(Dados.m)                                       
nt=Dados.Trat                                           
x=Dados.m                                               

SK(x,nt,I,J,QME,GLE,Alpha)                              #Aplicação da função

#Terceira avaliação não seria necessária, pois teria-se uma média em cada grupo a ser comparado, por exemplo.
