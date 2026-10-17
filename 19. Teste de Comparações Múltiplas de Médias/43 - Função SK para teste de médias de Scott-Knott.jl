#Função SK para teste de médias de Scott-Knott

using Statistics, Distributions, DataFrames, CSV

function sk(Dados::DataFrame, J, QME, GLE, Alpha; verbose::Bool=true)
    Dados = sort(Dados, :m, rev=true)
    grupo = Dict{String,Int}()
    proximo_grupo = Ref(1)

    function particionar!(sub::DataFrame)
        p = nrow(sub)

        # caso base: um único tratamento não pode mais ser dividido
        if p == 1
            grupo[sub.Trat[1]] = proximo_grupo[]
            proximo_grupo[] += 1
            return
        end

        x  = sub.m
        nt = sub.Trat

        B0i = Vector{Float64}(undef, p - 1)
        for i in 1:(p - 1)
            t1, t2 = sum(x[1:i]), sum(x[i+1:end])
            k1, k2 = i, p - i
            B0i[i] = (t1^2) / k1 + (t2^2) / k2 - ((t1 + t2)^2) / (k1 + k2)
        end
        k_best = argmax(B0i)
        B0     = B0i[k_best]

        MG  = mean(x)
        S20 = (sum((x .- MG) .^ 2) + (QME / J) * GLE) / (p + GLE)
        Lambda = (pi / (2 * (pi - 2))) * (B0 / S20)
        nu   = p / (pi - 2)
        crit = quantile(Chisq(nu), 1 - Alpha)
        sig  = Lambda > crit

        if verbose
            println("---- Partição de $p tratamentos: ", nt)
            println("  Melhor corte: ", nt[1:k_best], " | ", nt[k_best+1:end])
            println("  B0 = ", round(B0, digits=4),
                    "  S20 = ", round(S20, digits=4),
                    "  Lambda = ", round(Lambda, digits=4),
                    "  Qui² crítico = ", round(crit, digits=4),
                    "  => ", sig ? "significativo (*)" : "não significativo (ns)")
        end

        if sig
            particionar!(sub[1:k_best, :])
            particionar!(sub[k_best+1:end, :])
        else
            # sem diferença: todo o subconjunto forma um único grupo
            for t in nt
                grupo[t] = proximo_grupo[]
            end
            proximo_grupo[] += 1
        end
    end

    particionar!(Dados)

    Dados.GrupoNum = [grupo[t] for t in Dados.Trat]
    letras = collect('a':'z')
    Dados.Grupo = [string(letras[g]) for g in Dados.GrupoNum]
    select!(Dados, Not(:GrupoNum))

    return Dados
end

QME   = 10.08
GLE   = 15       
Alpha = 0.05
J     = length(X.Bloco)       

Dados = combine(groupby(X, :Trat)) do df
    (m = mean(df.Y),)
end

sk(Dados, J, QME, GLE, Alpha)
