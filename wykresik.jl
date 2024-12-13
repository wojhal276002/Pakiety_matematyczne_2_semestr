using Plots

@userplot StackedArea

# a simple "recipe" for Plots.jl to get stacked area plots
# usage: stackedarea(xvector, datamatrix, plotsoptions)
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
a = [10, 18, 33, 53, 75, 85, 92, 95, 97, 89]
b = [1, 2, 3, 5, 6, 11, 18, 29, 43, 64, 99, 142, 219, 328, 499, 733, 1029, 1464, 2010, 2645, 3430, 4219, 5069, 5873, 6338, 6783, 7082, 7428, 7504, 7614, 7721, 7628, 7663, 7818, 7680, 7770, 7893, 7901, 7987, 7831, 7829, 7861, 7812, 7971, 7972, 7957, 8001, 7907, 7910, 7921, 7945, 7864, 7959, 7950, 7954, 7929, 7915, 8006, 7988, 7923, 7796, 7950, 7889, 7942, 8000, 8027, 8004, 8132, 8133, 8163, 7975, 7937, 7983, 8032, 8026, 7994, 8074, 8237, 8144, 8098, 7976, 7967, 8028, 7968, 7995, 8092, 8097, 7987, 8094, 8116, 8126, 8105, 7984, 7935, 7942, 8012, 7971, 7905, 7923, 7837]
sNames = ["zielone","pomarańczowe"]
x = []
append!(x, i for i in 1:100)
plotly(
    ylimits=(0,25000),
)
stackedarea(x, [a b], labels=reshape(sNames, (1,2)), color = [:"#00FF00" :orange], legend= :topleft)

