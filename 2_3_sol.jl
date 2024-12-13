# Lista 2

using Plots
using Statistics
using LinearAlgebra

## Zadanie 3 - bifurkacja

function logistic_map(N₀::Float64, n::Int64, n₀::Int64)::Array{Float64}
    λs = LinRange(2.5, 4, n)
    points = Array{Float64}(undef, n, 40)
    
    for (index, λ) in enumerate(λs)
        x = N₀
        for i in 1:n₀
            x = λ * x * (1 - x)
        end
        for i in 1:40
            x = λ * x * (1 - x)
            points[index, i] = x
        end
    end
    return points
end

logistic_map(0.5, 20, 50) # przykładowe wywołanie

n = 800; n₀ = 50
scatter(LinRange(2.5, 4, n), 
        logistic_map(0.5, n, n₀),
        legend=nothing, 
        markersize=0.5,
        markercolor=:grey,
        markerstrokewidth=0.0
)

## Zadanie 4 - Kasyno

function game(money)
    s = 1
    while money > 0
        if rand(Bool)
            money += s
            break
        end
        money -= s
        s *= 2
    end
    return money
end

mean(game(50) for _ in 1:2*10^5) # mean jest funkcją z modułu Statistics

## Zadanie 5

function epidemic_simulation(N₀::Int64, p::Float64, q::Float64, S::Int64)::Vector{Int64}
    Ns = Vector{Int64}(undef, S)
    Ns[1] = N₀
    current_infectious = N₀
    for i in 2:S
        new_infectious = 0
        for ill in 1:current_infectious
            if rand() < p
                new_infectious += 0
            elseif rand() < q
                new_infectious += 2
            else
                new_infectious += 1
            end
        end
        current_infectious = new_infectious
        Ns[i] = current_infectious
    end
    Ns        
end

# przykładowe trajektorie
plot(legend=:none)
for i in 1:20
    plot!(epidemic_simulation(10,  0.22, 0.32, 50))
end
plot!()


mean_ = mean(epidemic_simulation(10, 0.12, 0.378, 50) for i in 1:500)
scatter(mean_)

# Lista 3

using LatTeXStrings # do wyświetlania wzorów w tytułach, labelach wykresów

## Pochodna 1D + spadek gradientu

pochodna1D(f, x, dx=1e-2) = (f(x + dx) - f(x)) / dx
xs = LinRange(-2, 2, 1000)
f(x) = x^2

plot(xs, f.(xs), label=L"f(x) = x^2") # tutaj L oznacza, że korzystamy z LatexStrings
plot!(xs, pochodna1D.(f, xs), label="pochodna \$f(x) = x^2\$") # ale można też użyć \$

x0 = 10
xs = LinRange(-10, 10, 1000)
ε = 1e-2
anim = @animate for i in 1:250
    global x0
    plot(xs, f.(xs))
    x0 = x0 - ε * pochodna1D(f, x0)
    scatter!([x0], [f(x0)])
    plot!(leg=:none)
end

gif(anim, "gradient_descent.gif", fps=25)

## Zadanie 1 - w sumie prześlę później, bo coś mi zniknęło

## Zadanie 2

weather_matrix(α₁, β₁) = [1 - α₁ α₁; β₁ 1 - β₁]
P₁ = weather_matrix(0.8, 0.4)

function markov_animation(matrix::Array{Float64}, n::Int64)
    mat = matrix
    anim = @animate for k in 1:n
        heatmap(mat,
        aspect_ratio=1,
        framestyle=:none,
        yflip=true,
        clim=(0, 1))
        mat *= mat
    end
    return anim
end

gif(markov_animation(P₁, 30), "markov_1.gif", fps=5)

P₂ = weather_matrix(0.4, 0.5)
gif(markov_animation(P₂, 30), "markov_2.gif", fps=0.5)


function JC66(ν::Float64, n::Int64)
    mat = diagm(0 => [0.25 + 0.75 * exp(-4 * ν / 3) for i in 1:4]) # diagm jest z modułu LinearAlgebra
    mat[mat .== 0.0] .= 0.25 - 0.25 * exp(-4 * ν / 3)
    anim = @animate for k in 1:n
        heatmap(
            mat,
            framestyle=:none,
            aspect_ratio=1,
            yflip=true,
            clim=(0,1)            
        )
        mat *= mat
    end
    return anim
end

gif(JC66(0.5, 8), "mutation_1.gif", fps=1)


## Zadanie 3 - specjalnie omijam, wrócimy może do tego za jakiś czas

## Zadanie 4 - Gra w życie Conwaya

function one_step!(A::BitArray)
    n, m = size(A)
    B = copy(A)
    for i in 1:n, j in 1:m
        c = sum(A[mod1(i + k, n), mod1(j + l, m)] for k in -1:1, l in -1:1) - A[i, j]
        if A[i, j] == 1 
            if !(c == 2 || c == 3)
                B[i, j] = 0
            end
        else 
            if c == 3
                B[i, j] = 1
            end
        end
    end
    A .= B
end    

# blinker
Blinker = BitArray(zeros(5, 5))
Blinker[2:4, 3] .= true

blinker_anim = @animate for i in 1:40
    heatmap(
        one_step!(Blinker),
        seriescolor=palette([:white, :black]),
        colorbar=:none,
        yflip=true,
        framestyle=nothing,
        aspect_ratio=1,
        xticks=nothing,
        yticks=nothing
    )
    vline!(0.5:5.5, c=:black)
    hline!(0.5:5.5, c=:black)
    plot!(
        legend=nothing,
        xlim=(0.5, 5.5),
        ylim=(0.5, 5.5)
    )
end
gif(blinker_anim, "blinker.gif", fps=2)

## glider

Glider = BitArray(zeros(12, 12))
Glider[3, 3:5] .= true
Glider[4, 3] = true
Glider[5, 4] = true
Glider

# można by napisać jedną funkcję do tworzenia animacji, która przyjmowałaby wymiary macierzy
# nie byłoby potrzeby pisania tak dużo powtarzalnego kodu, ale to proszę spróbować samemu/samej
glider_anim = @animate for i in 1:40
    heatmap(
        one_step!(Glider),
        seriescolor=palette([:white, :black]),
        colorbar=:none,
        yflip=true,
        framestyle=nothing,
        aspect_ratio=1,
        xticks=nothing,
        yticks=nothing
    )
    vline!(0.5:12.5, c=:black)
    hline!(0.5:12.5, c=:black)
    plot!(
        legend=nothing,
        xlim=(0.5, 12.5),
        ylim=(0.5, 12.5)
    )
end
gif(glider_anim, "glider.gif", fps=2)

## Sierpiński jest w internecie, ale i tak później doślę z tymi pochodnymi

## Równanie ciepła
function heat_transfer1(init, N::Int64, Δt::Float64, Δx::Float64, c::Float64)
    n = length(init)
    temps = Array{Float64}(undef, N, n)
    temps[1, :] .= init
    for i in 2:N
        temps[i, 1] = temps[i-1, 2] # w następnym kroku temperatura na brzegu to temperatura sąsiedniego punktu
        temps[i, end] = temps[i-1, end-1]
        for j in 2:n-1
            temp[i, j] = temp[i-1, j] + c * Δt / Δx^2 * (temp[i-1, j-1] - 2 * temp[i-1, j] + temp[i-1, j+1])
        end
        @. temps[i, 2:n-1] = temps[i-1, 2:n-1] + c * Δt / Δx^2 * (temps[i-1, 1:n-2] - 2 * temps[i-1, 2:n-1] + temps[i-1, 3:end])
    end
    return temps
end

function heat_transfer2(init, N::Int64, Δt, Δx, c::Float64)
    n = length(init)
    temps = Array{Float64}(undef, N, n)
    temps[1, :] .= init
    temps[:, 1] .= init[1] # stałe brzegi
    temps[:, end] .= init[end]
    for i in 2:N
        @. temps[i, 2:n-1] = temps[i-1, 2:n-1] + c * Δt / Δx^2 * (temps[i-1, 1:n-2] - 2 * temps[i-1, 2:n-1] + temps[i-1, 3:end])
    end
    return temps
end

# temperatura początkowa - jakiś sinus
temp_init = sin.(250*pi * 1:1000);
plot(temp_init)

h1 = heat_transfer1(temp_init, 10^4, 1.0, 1.0, 0.04);
anim1 = @animate for i in 1:10:10^4
    plot(h1[i, :])
end
gif(anim1, "heat_transfer_1.gif", fps=10)

# temperatura początkowa - dwa garby
temp_2 = zeros(300)
temp_2[50:70] .= 70
temp_2[110:160] .= 90;

plot(temp_2)

h = heat_transfer2(temp_2, 10^5, 1.0, 1.0, .02);
anim = @animate for i in 1:100:10^5
    plot(h[i, :])
end
gif(anim, "heat_transfer.gif", fps=25)

## Dodatek - metoda Eulera do rozwiązywania równań różniczkowych

function euler(f, x₀, y₀, xₑ, N)
    h = (xₑ - x₀) / N
    xs = x₀ .+ collect(0:N-1) * h
    ys = Array{Float64}(undef, N)
    ys[1] = y₀
    for i in 2:N
        ys[i] = ys[i-1] + h * f(ys[i-1], xs[i-1])
    end
    return xs, ys
end        

x₀ = 0; y₀ = 10
hi(x, y) = y^2 - x^2
xs, ys = euler(hi, x₀, y₀, 5, 10^3);

plot(xs, ys)
