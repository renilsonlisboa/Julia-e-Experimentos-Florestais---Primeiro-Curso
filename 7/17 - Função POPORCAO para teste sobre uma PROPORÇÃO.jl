#Função POPORCAO para teste sobre uma PROPORÇÃO

phat=(1000-879)/1000
n=1000
p=0.01
q=1-p
n*p
n*q

using Distributions

function proporcao(n,x,p)
    Alpha=0.01
    phat=x/n
    q=1-p
    z=(phat-p)/sqrt((p*q)/n)
    zVal = quantile(Normal(),Alpha)
    Alpha =(ccdf(Normal(),abs(z)))
    println("zcalculado: ", z)
    println("z Crítico: ", zVal)
    println("Alpha: ", Alpha)
end

#proporcao(n,x,p)
proporcao(1000,(1000-879),0.1)