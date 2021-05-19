using Plots
using Makie
using Printf
using LaTeXStrings
gr(show = true)

# --------------------------------- PART A -------------------------------------
# Problem parameters
Xtotal = [0.2, 0.6, 1.0, 1.4, 1.8, 2.0]
k₊ = 1
k₋ = 1

# Initialize arrays for figures & axes
figs = Array{Makie.Figure,1}(undef, length(h))
ax = Array{Makie.Axis}(undef, length(h))

for i ∈ 1:length(h)
    # Phosphorylation and Dephosphorylation rates as function of X*
    Xstar = LinRange(0,Xtotal[i], 50)
    phos_rate = k₊ * (Xtotal[i] .- Xstar) .* Xstar
    de_rate = k₋ * Xstar

    # Create figure and axis object for plotting
    figs[i] = Figure(backgroundcolor = RGBf0(0.98, 0.98, 0.98),resolution = (800, 800))
    ax[i] = figs[i][1,1] = Axis(figs[i])

    # Plot rates on same axis
    lines!(ax[i],Xstar,phos_rate, color = (:green,0.9), linewidth = 2.5)
    lines!(ax[i],Xstar,de_rate, color = (:orange,0.9), linewidth = 2.5)

    ax[i].xlabel = "X* [units]"
    ax[i].ylabel = "Phosphorylation / Dephosphorylation Rate [units/s]"
    ax[i].title = @sprintf("Positive Feedback Activity, Xtotal = %.1f", Xtotal[i])

    # save figure to current directory
    display(figs[i])
    name = @sprintf("Problem3a_%d.png", i)
    save(name, figs[i])
end

# --------------------------------- PART C -------------------------------------
Xtot = LinRange(0,2,100)
Xstable = Array{Float64,1}(undef, length(Xtot))
for j ∈ 1:length(Xtot)
    if Xtot[j] <= k₋/k₊
        Xstable[j] = 0
    else
        Xstable[j] = Xtot[j] - k₋/k₊
    end
end

f7 = Figure(backgroundcolor = RGBf0(0.98, 0.98, 0.98),resolution = (800, 800))
ax7 = f7[1,1] = Axis(f7)

lines!(ax7,Xtot,Xstable, color = (:blue,0.9), linewidth = 2.5)

ax7.xlabel = "Xtotal [units]"
ax7.ylabel = "Stable Equilibrium X* [units]"
ax7.title = "Bifurcation Diagram:  Stable Phosphorylation Steady State"

# save figure to current directory
display(f7)
save("Problem3c.png", f7)