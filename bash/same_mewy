function tworzenie_planszy(x)|
    ["n" for a in 1:x^2]
end
 
plansza = tworzenie_planszy(10)
populacja_mewa = 1
 
function losowanie(populacja_mewa, x)
    global plansza = tworzenie_planszy(x)
    mozliwosci = []
    szansa = []
    for b in 1:x^2
        push!(mozliwosci, b)
        push!(szansa, b)
    end
    for w in 1:populacja_mewa
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
                        global populacja_mewa -= 1
                        break
                    end
            end
        else
            global populacja_mewa -= 1
        end
    end
end

function procesy(plansza)
    for i in plansza
        if i == "M"
            global populacja_mewa += 1
        end
    end
end

populacje_mewa = []
populacje_hawk = []

for f in 1:50
    push!(populacje_mewa, populacja_mewa)
    losowanie(populacja_mewa, 10)
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
append!(populacje_hawk, 0 for i in 1:50)
print(populacje_hawk, populacje_mewa)
a = populacje_hawk
b = populacje_mewa
sNames = ["zielone","pomarańczowe"]
x = []
append!(x, i for i in 1:50)
plotly(
    ylimits=(0,500),
)
stackedarea(x, [a b], labels=reshape(sNames, (1,2)), color = [:greens :orange], legend= :topleft)