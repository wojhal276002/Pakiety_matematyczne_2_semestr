c = rand([1, 0], rand(1:10), rand(1:10))
show(stdout, "text/plain", c)
print('\n')
jedynkowa = Tuple.(findall(x->x==1, c))
print(jedynkowa,'\n')
function Wyspy(jedynkowa)
    trasa = []
    wyspy = 0
    poczatki = []
    while jedynkowa != []
        if trasa == []
            poczatek_trasy = jedynkowa[1]
            push!(trasa, poczatek_trasy)
        else
            poczatek_trasy = last(trasa)
            if trasa[1] ∉ poczatki
                wyspy += 1
                push!(poczatki, trasa[1])
            end
        end
        if (poczatek_trasy[1],poczatek_trasy[2]-1) in jedynkowa
            deleteat!(jedynkowa, findall(x->x==poczatek_trasy, jedynkowa))
            poczatek_trasy = (poczatek_trasy[1],poczatek_trasy[2]-1)
            push!(trasa, poczatek_trasy)
        else
            if (poczatek_trasy[1]+1,poczatek_trasy[2]) in jedynkowa
                deleteat!(jedynkowa, findall(x->x==poczatek_trasy, jedynkowa))
                poczatek_trasy = (poczatek_trasy[1]+1,poczatek_trasy[2])
                push!(trasa, poczatek_trasy)
            else
                if (poczatek_trasy[1],poczatek_trasy[2]+1) in jedynkowa
                    deleteat!(jedynkowa, findall(x->x==poczatek_trasy, jedynkowa))
                    poczatek_trasy = (poczatek_trasy[1],poczatek_trasy[2]+1)
                    push!(trasa, poczatek_trasy)
                else
                    if (poczatek_trasy[1]-1,poczatek_trasy[2]) in jedynkowa
                        deleteat!(jedynkowa, findall(x->x==poczatek_trasy, jedynkowa))
                        poczatek_trasy = (poczatek_trasy[1]-1,poczatek_trasy[2])
                        push!(trasa, poczatek_trasy)
                    else
                        deleteat!(jedynkowa, findall(x->x==poczatek_trasy, jedynkowa))
                        deleteat!(trasa, findall(x->x==last(trasa), trasa))
                    end
                end
            end
        end
    end
    return wyspy
end

print("Liczba wysp:",Wyspy(jedynkowa))
