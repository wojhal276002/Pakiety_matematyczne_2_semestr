elementy = ['a', 'a', 'c', 'a', '1']
function Elementarz(string)
    lista=[]
    for e in string
        if e ∉ lista
            append!(lista, e)
        end
    end
    return lista
end
function Liczydlo(string)
    lista = Elementarz(string)
    lista1=[]
    for f in lista
        g = count(i->(i==f), elementy)
        push!(lista1, (f, g))
    end
    return lista1
end
print(Liczydlo(elementy))
