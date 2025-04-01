function tworzenie_planszy(x)|
    ["n" for a in 1:x^2]
end
 
populacja_dove = 1
populacja_hawk = 1
populacja_mewa = 1
populacja_kruk = 1
populacja_alt = 1
populacja_eagle = 0
populacja_sep = 0
 
 
function losowanie(x)
    global plansza = tworzenie_planszy(x)
    mozliwosci = []
    szansa = []
    for b in 1:x^2
        push!(mozliwosci, b)
        push!(mozliwosci, b)
        push!(szansa, b)
    end
    for dove in 1:populacja_dove
        if mozliwosci != []
            dove1 = rand(mozliwosci,1)
            for (indeks, wartosc) in enumerate(mozliwosci)
                if wartosc == dove1[1]
                    deleteat!(mozliwosci, indeks)
                    break
                end
            end
            if plansza[dove1[1]] == "n"
                plansza[dove1[1]] = "D"
            else
                plansza[dove1[1]] *= "D"
            end
        else
            global populacja_dove -= 1
        end
    end
    for hawk in 1:populacja_hawk
        if mozliwosci != []
            hawk1 = rand(mozliwosci,1)
            for (indeks, wartosc) in enumerate(mozliwosci)
                if wartosc == hawk1[1]
                    deleteat!(mozliwosci, indeks)
                    break
                end
            end
            if plansza[hawk1[1]] == "n"
                plansza[hawk1[1]] = "H"
            else
                plansza[hawk1[1]] *= "H"
            end
        else
            global populacja_hawk -= 1
        end
    end
    for mewa in 1:populacja_mewa
        if mozliwosci != []
            mewa1 = rand(mozliwosci, 1)
            for (indeks, wartosc) in enumerate(mozliwosci)
                if wartosc == mewa1[1]
                    deleteat!(mozliwosci, indeks)
                    break
                end
            end
            if plansza[mewa1[1]] == "n"
                plansza[mewa1[1]] = "J"
                mewa2 = rand(szansa, 1)
                for (indeks1, wartosc1) in enumerate(mozliwosci)
                    if wartosc1 == mewa2[1]
                        deleteat!(mozliwosci, indeks1)
                        break
                    end
                end
                if plansza[mewa2[1]] == "n"
                    plansza[mewa2[1]] = "M"
                elseif length(plansza[mewa2[1]]) == 2              
                    global populacja_mewa -= 1
                else
                    if mewa2[1] == mewa1[1]
                        plansza[mewa2[1]] *= "2"
                    else
                        plansza[mewa2[1]] *= "M"
                    end
                end
            else
                plansza[mewa1[1]] *= "M"
            end
        else
            global populacja_mewa -= 1
        end
    end
    for kruk in 1:populacja_kruk
        if mozliwosci != []
            kruk1 = rand(mozliwosci, 1)
            for (indeks, wartosc) in enumerate(mozliwosci)
                if wartosc == kruk1[1]
                    deleteat!(mozliwosci, indeks)
                    break
                end
            end
            if plansza[kruk1[1]] == "n"
                plansza[kruk1[1]] = "K"
            else                      
                plansza[kruk1[1]] *= "K"
            end
        else
            global populacja_kruk -= 1
        end
    end
    for alt in 1:populacja_alt
        if mozliwosci != []
            alt1 = rand(mozliwosci, 1)
            for (indeks, wartosc) in enumerate(mozliwosci)
                if wartosc == alt1[1]
                    deleteat!(mozliwosci, indeks)
                    break
                end
            end
            if plansza[alt1[1]] == "n"
                plansza[alt1[1]] = "A"
            else                      
                plansza[alt1[1]] *= "A"
            end
        else
            global populacja_alt -= 1
        end
    end
    for eagle in 1:populacja_eagle
        if mozliwosci != []
            eagle1 = rand(mozliwosci, 1)
            for (indeks, wartosc) in enumerate(mozliwosci)
                if wartosc == eagle1[1]
                    deleteat!(mozliwosci, indeks)
                    break
                end
            end
            if plansza[eagle1[1]] == "n"
                plansza[eagle1[1]] = "E"
            else                     
                plansza[eagle1[1]] *= "E"
            end
        else
            global populacja_eagle -= 1
        end
    end
    for sep in 1:populacja_sep
        if mozliwosci != []
            sep1 = rand(szansa, 1)
            if sep1[1] ∈ mozliwosci
                for (indeks, wartosc) in enumerate(mozliwosci)
                    if wartosc == sep1[1]
                        deleteat!(mozliwosci, indeks)
                        break
                    end
                end
                if plansza[sep1[1]] == "n"
                    plansza[sep1[1]] = "S"
                else
                    plansza[sep1[1]] *= "S"
                end
            else
                if length(plansza[sep1[1]]) == 2
                    plansza[sep1[1]] *= "S"
                else
                    global populacja_sep -= 1
                end
            end
        else
            global populacja_sep -= 1
        end
    end 
end
 
function procesy(plansza)
    temp = rand(1:30)
    for i in plansza
        if i == "n"
            continue
        #dove
        elseif i == "D"
            p = rand(1:4)
            if p == 1
                global populacja_alt += 1
            else
                global populacja_dove += 1
            end
        elseif i == "DD"
            continue
        #hawk
        elseif i == "H"
            p = rand(1:4)
            if p == 1
                global populacja_alt += 1
            else
                global populacja_hawk += 1
            end
        elseif i == "HH"
            global populacja_hawk -= 2
        elseif i == "DH"
            p = rand(1:2)
            if p == 1
                global populacja_dove -= 1
                global populacja_hawk += 1
            else
                continue
            end
        #mewa
        elseif i == "J"
            p = rand(1:4)
            if p == 1
                global populacja_alt += 1
            else
                global populacja_mewa += 1
            end
        elseif i == "M"
            p = rand(1:4)
            if p == 1
                global populacja_alt += 1
            else
                global populacja_mewa += 1
            end
        elseif i == "MM"
            global populacja_mewa -= 2
        elseif i == "JM"
            continue
        elseif i == "J2"
            p = rand(1:2)
            if p == 1
                global populacja_mewa += 1
            else
                continue
            end
        elseif i == "DM" 
            p = rand(1:4)
            if p == 1
                global populacja_mewa += 1
                global populacja_dove -= 1
            else
                continue
            end
        elseif i == "HM"
            p = rand(1:4)
            if p == 1
                global populacja_mewa += 1
                global populacja_hawk -= 1
            else
                global populacja_hawk += 1
                global populacja_mewa -= 1
            end
        #kruk 
        elseif i == "K"
            if temp <= 10
                continue
            elseif 10 < temp <= 20
                global populacja_kruk += 1
            else
                p = rand(1:2)
                if p == 1
                    global populacja_kruk += 1 
                else
                    continue
                end
            end
        elseif i == "KK"
            if temp <= 10
                continue
            elseif 10 < temp <= 20
                global populacja_kruk -= 2
            else
                global populacja_kruk -= 1
            end
        elseif i == "DK"
            if 10 < temp <= 20
                global populacja_kruk += 1
                global populacja_dove -= 1
            else
                continue
            end
        elseif i == "HK"
            if 10 < temp <= 20
                p = rand(1:2)
                if p == 1
                    global populacja_kruk -= 1
                    global populacja_hawk += 1
                else
                    global populacja_kruk += 1
                    global populacja_hawk -= 1
                end
            else
                q = rand(1:3)
                if q == 1
                    global populacja_kruk += 1
                    global populacja_hawk -= 1
                else
                    global populacja_kruk -= 1
                    global populacja_hawk += 1
                end
            end
        elseif i == "MK"
            if temp <= 10
                p = rand(1:3)
                if p == 1
                    continue
                else
                    global populacja_kruk -= 1
                    global populacja_mewa += 1
                end
            elseif 10 < temp <= 20
                global populacja_mewa -= 1
                global populacja_kruk += 1
            else 
                q = rand(1:3)
                if q == 1
                    continue
                else
                    global populacja_mewa -= 1
                    global populacja_kruk += 1
                end
            end
        elseif i == "JK"
            if temp <= 10
                p = rand(1:5)
                if p <= 2
                    global populacja_mewa += 1
                    global populacja_kruk -= 1
                else
                    global populacja_kruk += 1
                end
            elseif 10 < temp <= 20
                global populacja_kruk += 1
            else 
                q = rand(1:4)
                if q == 1
                    global populacja_mewa += 1
                    global populacja_kruk -= 1
                else
                    global populacja_kruk += 1
                end
            end
        #altruist
        elseif i == "A"
            global populacja_alt += 1
        elseif i == "AA"
            continue
        elseif i == "DA"
            global populacja_dove += 1
            global populacja_alt -= 1
        elseif i == "HA"
            global populacja_hawk += 1
            global populacja_alt -= 1
        elseif i == "MA"
            global populacja_mewa += 1
            global populacja_alt -= 1
        elseif i == "JA"
            p = rand(1:2)
            if p == 1
                global populacja_mewa += 1
                global populacja_alt -= 1
            else
                continue
            end
        elseif i == "KA"
            global populacja_kruk += 1
            global populacja_alt -= 1
        #eagle
        elseif i == "E"
            p = rand(1:2)
            if p == 1
                global populacja_eagle -= 1
            else
                continue
            end
        elseif i == "EE"
            global populacja_eagle -= 2
        elseif i == "DE"
            global populacja_eagle += 1
            global populacja_dove -= 1
        elseif i == "HE"
            p = rand(1:3)
            if p == 1
                global populacja_eagle += 1
                global populacja_hawk -= 1
            else
                continue
            end
        elseif i == "ME"
            p = rand(1:2)
            if p == 1
                global populacja_eagle += 1
                global populacja_mewa -= 1
            else
                continue
            end
        elseif i == "JE"
            global populacja_eagle += 1
        elseif i == "KE"
            if temp <= 10
                global populacja_kruk -= 1
                global populacja_eagle += 1
            elseif 10 < temp <= 20
                p = rand(1:3)
                if p == 1
                    global populacja_kruk -= 1
                    global populacja_eagle += 1
                else
                    continue
                end
            else
                p = rand(1:2)
                if p == 1
                    global populacja_kruk -= 1 
                    global populacja_eagle += 1
                else
                    continue
                end
            end
        elseif i == "AE"
            global populacja_eagle += 1
            global populacja_alt -= 1
        #sep
        elseif i == "S"
            global populacja_sep -= 1
        elseif i == "SS"
            global populacja_sep -= 2
        elseif i == "SSS"
            global populacja_sep -= 1
        #podwojne zaleznosci
        elseif i == "DS"
            p = rand(1:4)
            if p == 1
                global populacja_sep += 1
                global populacja_dove -= 1
            else
                continue
            end
        elseif i == "HS"
            p = rand(1:4)
            if p == 1
                global populacja_sep += 1
                global populacja_hawk -= 1
            else
                global populacja_hawk += 1
                global populacja_sep -= 1
            end
        elseif i == "MS"
            global populacja_mewa -= 1
            global populacja_sep -= 1
        elseif i == "JS"
            global populacja_sep -= 1
        elseif i == "KS"
            if temp <= 10
                p = rand(1:3)
                if p == 1
                    continue
                else
                    global populacja_kruk -= 1
                    global populacja_sep += 1
                end
            elseif 10 < temp <= 20
                global populacja_sep -= 1
                global populacja_kruk += 1
            else 
                q = rand(1:3)
                if q == 1
                    continue
                else
                    global populacja_sep -= 1
                    global populacja_kruk += 1
                end
            end
        elseif i == "AS"
            global populacja_sep += 1
            global populacja_alt -= 1
        elseif i == "ES"
            p = rand(1:2)
            if p == 1
                global populacja_eagle += 1
                global populacja_sep -= 1
            else
                continue
            end
        #potrojne zaleznosci
        elseif i == "DDS"
            global populacja_sep -= 1
        elseif i == "DHS"
            p = rand(1:2)
            if p == 1
                global populacja_dove -= 1
                global populacja_hawk += 1
                global populacja_sep += 1
            else
                global populacja_sep -= 1
            end
        elseif i == "HHS"
            global populacja_hawk -= 2
            global populacja_sep += 1
        elseif i == "DMS"
            p = rand(1:4)
            if p == 1
                global populacja_mewa += 1
                global populacja_dove -= 1
                global populacja_sep += 1
            else
                global populacja_sep -= 1
            end
        elseif i == "HMS"
            p = rand(1:4)
            if p == 1
                global populacja_mewa += 1
                global populacja_hawk -= 1
                global populacja_sep += 1
            else
                global populacja_hawk += 1
                global populacja_mewa -= 1
                global populacja_sep += 1
            end
        elseif i == "MMS"
            global populacja_mewa -= 2
            global populacja_sep += 1
        elseif i == "J2S"
            p = rand(1:2)
            if p == 1
                global populacja_mewa += 1
                global populacja_sep -= 1
            else
                continue
            end
        elseif i == "JMS"
            continue
        elseif i == "DKS"
            if 10 < temp <= 20
                global populacja_kruk += 1
                global populacja_dove -= 1
                global populacja_sep += 1
            else
                global populacja_sep -= 1
            end
        elseif i == "HKS"
            if 10 < temp <= 20
                p = rand(1:4)
                if p == 1
                    global populacja_kruk -= 1
                    global populacja_hawk += 1
                    global populacja_sep += 1
                else
                    global populacja_kruk += 1
                    global populacja_hawk -= 1
                    global populacja_sep += 1
                end
            else
                q = rand(1:3)
                if q == 1
                    global populacja_kruk += 1
                    global populacja_hawk -= 1
                    global populacja_sep += 1
                else
                    global populacja_kruk -= 1
                    global populacja_hawk += 1
                    global populacja_sep += 1
                end
            end
        elseif i == "MKS"
            if temp <= 10
                p = rand(1:3)
                if p == 1
                    global populacja_sep -= 1
                else
                    global populacja_kruk -= 1
                    global populacja_mewa += 1
                    global populacja_sep += 1
                end
            elseif 10 < temp <= 20
                global populacja_mewa -= 1
                global populacja_kruk += 1
                global populacja_sep += 1
            else 
                q = rand(1:3)
                if q == 1
                    global populacja_sep -= 1
                else
                    global populacja_mewa -= 1
                    global populacja_kruk += 1
                    global populacja_sep += 1
                end
            end
        elseif i == "JKS"
            if temp <= 10
                p = rand(1:5)
                if p <= 2
                    global populacja_mewa += 1
                    global populacja_kruk -= 1
                    global populacja_sep += 1
                else
                    global populacja_kruk += 1
                end
            elseif 10 < temp <= 20
                global populacja_kruk += 1
            else 
                q = rand(1:4)
                if q == 1
                    global populacja_mewa += 1
                    global populacja_kruk -= 1
                    global populacja_sep += 1
                else
                    global populacja_kruk += 1
                end
            end
        elseif i == "KKS"
            if temp <= 10
                global populacja_sep -= 1
            elseif 10 < temp <= 20
                global populacja_kruk -= 2
                global populacja_sep += 1
            else
                global populacja_kruk -= 1
                global populacja_sep += 1
            end
        elseif i == "DAS"
            global populacja_dove += 1
            global populacja_alt -= 1
            global populacja_sep += 1
        elseif i == "HAS"
            global populacja_hawk += 1
            global populacja_alt -= 1
            global populacja_sep += 1
        elseif i == "MAS"
            global populacja_mewa += 1
            global populacja_alt -= 1
            global populacja_sep += 1
        elseif i == "JAS"
            global populacja_mewa += 1
            global populacja_alt -= 1
            global populacja_sep += 1
        elseif i == "KAS"
            global populacja_kruk += 1
            global populacja_alt -= 1
            global populacja_sep += 1
        elseif i == "AAS"
            global populacja_sep -= 1
        elseif i == "DES"
            global populacja_eagle += 1
            global populacja_dove -= 1
            global populacja_sep += 1
        elseif i == "HES"
            p = rand(1:3)
            if p == 1
                global populacja_eagle += 1
                global populacja_hawk -= 1
                global populacja_sep += 1
            else
                global populacja_sep -= 1
            end
        elseif i == "MES"
            p = rand(1:2)
            if p == 1
                global populacja_eagle += 1
                global populacja_mewa -= 1
                global populacja_sep += 1
            else
                global populacja_sep -= 1
            end
        elseif i == "JES"
            global populacja_eagle += 1
        elseif i == "AES"
            global populacja_eagle += 1
            global populacja_alt -= 1
            global populacja_sep += 1
        elseif i == "EES"
            global populacja_eagle -= 2
            global populacja_sep += 1
        elseif i == "DSS"
            global populacja_dove -= 1
        elseif i == "HSS"
            p = rand(1:2)
            if p == 1
                global populacja_hawk -= 1
            else
                global populacja_sep -= 1
            end
        elseif i == "MSS"
            global populacja_mewa -= 1
        elseif i == "JSS"
            global populacja_sep -= 1
        elseif i == "KSS"
            if 10 < temp <= 20
                p = rand(1:2)
                if p == 1
                    global populacja_kruk -= 1
                else
                    global populacja_sep -= 1
                end
            else
                global populacja_kruk -= 1
            end
        elseif i == "ASS"
            global populacja_alt -= 1
        elseif i == "ESS"
            global populacja_eagle -= 1
            global populacja_sep -= 1
        end
    end
    print(populacja_dove + populacja_hawk + populacja_mewa + populacja_kruk + populacja_alt + populacja_eagle + populacja_sep,"\n")
end
 
populacje_dove = []
populacje_hawk = []
populacje_mewa = []
populacje_kruk = []
populacje_alt = []
populacje_eagle = []
populacje_sep = []
 
for f in 1:100
    push!(populacje_dove, populacja_dove)
    push!(populacje_hawk, populacja_hawk)
    push!(populacje_mewa, populacja_mewa)
    push!(populacje_kruk, populacja_kruk)
    push!(populacje_alt, populacja_alt)
    push!(populacje_eagle, populacja_eagle)
    push!(populacje_sep, populacja_sep)
    losowanie(50)
    if f == 15
        global populacja_eagle = 10
        global populacja_sep = 10
    end
    procesy(plansza)
end
 
using Plots
 
@userplot StackedArea
 
@recipe function f(pc::StackedArea)
    x, y = pc.args
    n = length(x)
    y = cumsum(y, dims=2)
    seriestype := :shape
 
    for c=1:size(y,2)
        sx = vcat(x, reverse(x))
        sy = vcat(y[:,c], c==1 ? zeros(n) : reverse(y[:,c-1]))
        @series (sx, sy)
    end
end
a = populacje_dove
b = populacje_hawk
c = populacje_mewa
d = populacje_kruk
e = populacje_alt
f = populacje_eagle
g = populacje_sep
 
x = []
nazwy = ["dove", "hawk", "mewa", "kruk", "alt", "eagle", "sep"]
append!(x, i for i in 1:100)
plotly(
    ylimits=(0,5000),
)
stackedarea(x, [a b c d e f g], color = [:greens :orange :blue :yellow :cyan :red :purple], labels = reshape(nazwy,(1,7)), legend= :outertopleft)