using Plots

# L.1, z.6

# a)

attacks = sum(rand(1:4, 1000, 3) .+ 1, dims=2)
goblin_deaths = attacks .>= 7
probability = sum(goblin_deaths) / 1000 |> display

# b) - nie podoba mi się

# c)
function simulateGame()
    mag = 12
    skeleton = 13
    while true
        mag -= (2 + rand(1:6))
        skeleton -= (3 + sum(rand(1:4, 3)))
        if mag <= 0
            return false
        elseif skeleton <= 0
            return true
        end
    end
end

@time sum(simulateGame() for i in 1:10^4) / 10^4

# L.2, z.1

function inverse(g, y, a, b, dx=1e-2)
    x = a
    while g(x) < y && x < b
        x += dx
    end
    x
end


f(x) = exp(-x) + exp(-2x) - 1 # zasób przedsiębiorstwa

# f(x) jest malejąca, inverse jest napisana dla funkcji rosnącej, zatem trzeba podać jako pierwszy argument funkcję -f(x)
# żeby uniknąć definiownia, np. g(x) = -f(x), używamy funkcji anonimowej: x -> -f(x)

inverse(x -> -f(x), 0, 0, 2) # kiedy trzeba uzupełnić zasób? Przyjmijmy, że dokładnie wtedy, kiedy się kończy

xs = LinRange(-1, 2, 1000);

# składnia Plots: plot(x, y, dodatkowe opcje wykresu)
# jeśli zrobimy plot! lub scatter! (dodamy wykrzynik), to dany wykres, ustawienie
# doda się do wcześniej utworzonego wykresu
plot(xs, f.(xs))
vline!([inverse(x -> -f(x), 0, -1, 2)])
plot!(legend=:none)

plot(1:10) # będzie już oddzielnym wykresem


# z.2

function malthus(N₀::Float64, r::Float64, horizon::Int64)::Vector{Float64}
    population = Vector{Float64}(undef, horizon)
    N = N₀
    for i in 1:horizon
        population[i] = N
        N = N * (1 + r)
    end
    return population
end

# malthusa można zapisać w sumie w jednej linijce:

malthus_short(N₀::Float64, r::Float64, horizon::Int64)::Vector{Float64} = N₀ * (1 + r) .^ collect(1:horizon)

function verhulst(N₀::Float64, r::Float64, L::Float64, horizon::Int64)::Vector{Float64}
    population = Vector{Float64}(undef, horizon)
    N = N₀
    for i in 1:horizon
        population[i] = N
        N = N + r * N * (1 - N / L) 
    end
    return population
end


function ricker(N₀::Float64, r::Float64, L::Float64, horizon::Int64)::Vector{Float64}
    population = Vector{Float64}(undef, horizon)
    N = N₀
    a = 1 / (1 + r)
    b = (1 - a) / L
    for i in 1:horizon
        population[i] = N
        N = N / (a + b * N)
    end
    return population
end

# można by zdeiniować jedną funkcję, która przyjmowała by jako argument funkcję opisującą jak zmienia się populacja -> N = f(N, r, L, ...) - coś w tym stylu
# można się zastanowić, jak to zrobić

scatter(1:50, malthus(0.5, 0.25, 50))
scatter(1:50, malthus(0.5, -0.25, 50))

scatter(1:50, verhulst(5.0, 0.25, 8.0, 50))
scatter(1:50, verhulst(5.0, 0.05, 3.0, 50))

scatter(1:50, ricker(5.0, 0.25, 8.0, 50))
scatter(1:50, ricker(5.0, 0.25, 3.0, 50))
