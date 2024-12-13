# 1
xor(1, 0) + xor(0, 0) + xor(0, 1) + xor(1, 1)

1 ⊻ 0 # również \xor + tab

wiel(x) = x^3 + 4x^2 + 7x + 2

wiel(2)

# prosta wektoryzacja obliczeń
wiel.([0, 0.5, 1.1, tan(0.3), 2 - im])

# tak można definiować funkcje, ale również tak
function wiel2(x)
    return x^3 + 4x^2 + 7x + 2
end

# albo tak - wykorzystuje tzw. funkcję anonimową - więcej na wykładzie
wiel3 = x -> x^3 + 4x^2 + 7x + 2

# uwaga - funkcje to zmienna, które są const - stałe, nie można zmieniać ich wartości, redefiniować
# takie coś nie przejdzie

g(x) = x
g(x) = x^2 # ERROR

# nawet takie unixy działają
🥰 = NaN

true | false # true or false = true

true & false # true and true = false

# 2

#= zdefiniujmy sobie funkcję dwuargumentową - wybieramy sobie z,
ale także liczbę początkowych wyrazów, które sumujemy =#
zeta(z, n) = sum((1 / i)^z for i in 1:n)

zeta(2, 10)
zeta(2, 100)

# 2b
func2(n) = prod(1 + 0.5^(2^i) for i in 0:n)

func2(10)
func2(50)

# 2c
sum((j for j in i:100) for i in 1:100)
sum(sum(k:100) for k in 1:100) # to niezła, aż sam się zdziwiłem, że takie coś napisałem :) - można z jedną zmienną

# powyższa sumka to tak, jak pokazałem po prostu suma kwadratów naturalów od 1 do 100
sum(i^2 for i in 1:100)

# całeczka - suma pól prostokątów 
sum(sin(x) * 0.01 for x in 0:0.01:pi) # u mnie to działa -> państwo, którzy mieli z tym problem muslie mieć źle zdefiniowane zmienne
# może coś zdefiniowane wcześniej spowodowało, że wszystko przestało stykać

# 3

A = [1 2;3 4]
B = [im 1+2im; 2- im 0]
v = [1 1]
g = [1//2; 3//4]
z = [2.0, 0.0]
c = -1


# iloczyn skalarny
using LinearAlgebra

dot(v, g)

# albo 

v * g # czyli zwykłe mnożenie wektorów - jeden leży, drugi stoi

v * A' * g

# wywołujemy funkcję cosh na każym elemencie macierzy A
cosh.(A)

# każdy element A podnosimy do kwadratu a następnie do każdego elementu dodajemy skalar c
A.^2 .+ c
