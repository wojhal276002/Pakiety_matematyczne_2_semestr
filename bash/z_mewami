function tworzenie_planszy(x)|
    ["n" for a in 1:x^2]
end
 
plansza = tworzenie_planszy(100)
populacja_dove = 15
populacja_hawk = 15
populacja_mewa = 200
 
function losowanie(populacja_dove, populacja_hawk, populacja_mewa, x)
    global plansza = tworzenie_planszy(x)
    mozliwosci = []
    szansa = []
    for b in 1:x^2
        push!(mozliwosci, b)
        push!(mozliwosci, b)
        push!(szansa, b)
    end
    for c in 1:populacja_dove
        los1 = rand(mozliwosci,1)
        for (indeks, wartosc) in enumerate(mozliwosci)
            if wartosc == los1[1]
                deleteat!(mozliwosci, indeks)
                break
            end
        end
        if plansza[los1[1]] == "n"
            plansza[los1[1]] = "D"
        else
            plansza[los1[1]] *= "D"
        end
    end
    for d in 1:populacja_hawk
        los2 = rand(mozliwosci,1)
        for (indeks, wartosc) in enumerate(mozliwosci)
            if wartosc == los2[1]
                deleteat!(mozliwosci, indeks)
                break
            end
        end
        if plansza[los2[1]] == "n"
            plansza[los2[1]] = "H"
        else
            plansza[los2[1]] *= "H"
        end
    end
    for e in 1:populacja_mewa
        k = rand(szansa, 1)
        for (indeks, wartosc) in enumerate(mozliwosci)
            if wartosc == k[1]
                deleteat!(mozliwosci, indeks)
                break
            end
        end
        if plansza[k[1]] == "n"
            plansza[k[1]] = "M"
            while true
                los = rand(szansa, 1)
                for (indeks1, wartosc1) in enumerate(mozliwosci)
                    if wartosc1 == los[1]
                        deleteat!(mozliwosci, indeks1)
                        break
                    end
                end
                if plansza[los[1]] == "n"
                    plansza[los[1]] = "M"
                else                      
                    plansza[los[1]] *= "M"
                    break
                end
            end
        else
            plansza[k[1]] *= "M"
        end
    end
end
 
function procesy(plansza)
    for i in plansza
        if i == "n"
            continue
        elseif i == "D"
            global populacja_dove += 1
        elseif i == "DD"
            continue
        elseif i == "HH"
            global populacja_hawk -= 2
        elseif i == "MM"
            p = rand(1:2)
            if p == 1
                populacja_mewa -= 2
            else
                continue
            end
        elseif i == "H"
            global populacja_hawk += 1
        elseif i == "DH"
            p = rand(1:2)
            if p == 1
                global populacja_dove -= 1
                global populacja_hawk += 1
            else
                continue
            end
        elseif i == "M"
            global populacja_mewa += 1
        elseif i == "DM"
            p = rand(1:2)
            if p == 1
                global populacja_mewa -= 1
                global populacja_dove -= 1
            else
                global populacja_dove += 1
            end
        elseif i == "HM"
            p = rand(1:2)
            if p == 1
                global populacja_mewa -= 1
                global populacja_hawk -= 1
            else
                global populacja_hawk += 1
            end
        end
    end
end
 
populacje_dove = []
populacje_hawk = []
populacje_mewa = []
 
for f in 1:100
    push!(populacje_dove, populacja_dove)
    push!(populacje_hawk, populacja_hawk)
    push!(populacje_mewa, populacja_mewa)
    losowanie(populacja_dove, populacja_hawk, populacja_mewa, 100)
    procesy(plansza)
end
print(populacje_mewa)
using Plots

@userplot StackedArea

@recipe function f(pc::StackedArea)
    x, y = pc.args
    n = length(x)
    y = cumsum(y, dims=2)
    seriestype := :shape

    # create a filled polygon for each item
    for c=1:size(y,2)
        sx = vcat(x, reverse(x))
        sy = vcat(y[:,c], c==1 ? zeros(n) : reverse(y[:,c-1]))
        @series (sx, sy)
    end
end
a = populacje_dove
b = populacje_hawk
c = populacje_mewa
sNames = ["zielone","pomarańczowe", "niebieskie"]
x = []
append!(x, i for i in 1:100)
plotly(
    ylimits=(0,50000),
)
stackedarea(x, [a b c], labels=reshape(sNames, (1,3)), color = [:greens :orange :blue], legend= :topleft)


