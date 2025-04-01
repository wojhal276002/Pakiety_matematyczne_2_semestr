import Pkg; 
Pkg.add("Primes")

import Primes
lista1 = []
function Dzielnik(x)
    liczby = Primes.primes(x)
    while x != 1
        for pierwsze in eachindex(liczby)
            if isinteger(x /liczby[pierwsze]) == true
                append!(lista1, liczby[pierwsze])
                x = x / liczby[pierwsze]
            else
                continue
            end
        end
    end
    lista2 = sort(lista1)
    return lista2
end

print(Dzielnik(1001))
