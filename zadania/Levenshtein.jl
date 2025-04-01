function levenshtein(rzad::String, kolumna::String)
    rzad = [i for i in rzad]
    kolumna = [i for i in kolumna]
    rozwiazanie = zeros(length(kolumna), length(rzad))
    rozwiazanie[1,:] = [k-1 for k in 1:length(rzad)]
    rozwiazanie[:,1] = [k-1 for k in 1:length(kolumna)]
    if rzad[2] != kolumna[2]
        rozwiazanie[2,2] = 2
    end
    for c in 2:length(kolumna)
        for r in 2:length(rzad)
            if kolumna[c] != rzad[r]
                rozwiazanie[c,r] = min(rozwiazanie[c-1,r],rozwiazanie[c,r-1])+1
            else 
                rozwiazanie[c,r] = rozwiazanie[c-1,r-1]
            end
        end
    end
    show(stdout, "text/plain", rozwiazanie)
    print('\n')
    print(" Odległość Levenstheina:",rozwiazanie[length(kolumna), length(rzad)])
end

levenshtein("#correct","#correct")
