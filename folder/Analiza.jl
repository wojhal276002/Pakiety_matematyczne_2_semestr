function Analiza(plik)
    file = open(plik, "r")
    string = read(file, String)
    string2=[x for x ∈ lowercase(string)]
    znaki = ['!','"','#','$','%','&',''','(',')','*','+',',','-','.','/',':',';','<','=','>',
    '?','@','[',']','^','_','`','{','|','}','~']
    for characters in string2
        if characters ∈ znaki
            deleteat!(string2, findall(x->x==characters,string2))
        end
    end
    string2 = join(string2, "")
    z_analizowany = join(split(string2)," ")
    return z_analizowany
end

Analiza("/Users/wojtek/Desktop//julia/aba.txt")
