
function Brakujacy_element_super1(wektor, start, koniec)
    if start > koniec
        return koniec+1
    end

    if start != wektor[start]
        return start
    end
    srodek = (start + koniec) ÷ 2
    if wektor[srodek] == srodek
        return Brakujacy_element_super1(wektor,srodek + 1,koniec)
    end
    return Brakujacy_element_super1(wektor,start,srodek)
end

arr3 = [1,2,3,4,5,6]
arr4 = [1,2,3,4,5,7]
println(Brakujacy_element_super1(arr3, 1, length(arr3)))
println(Brakujacy_element_super1(arr4, 1, length(arr4)))


function Brakujacy_element(wektor)
    lista = []
    for i in 1:length(wektor)
        if i != wektor[i]
            append!(lista, i)
        end
    end
    if lista == []
        return length(wektor)+1
    else
        return lista[1]
    end
end

arr1 = [1,2,3,4,5,6]
arr2 = [1,2,3,4,5,7]
#println(Brakujacy_element(arr1))
#println(Brakujacy_element(arr2))

