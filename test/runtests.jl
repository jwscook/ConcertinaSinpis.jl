using ConcertinaSinpis
using Test, QuadGK

f(x) = exp(-x^2)
g(x) = sinpi(x)

@testset "Concertinas.jl" begin
  @show quadgk(ConcertinaSinpi(f, -100:100), 0.1, 0.9, rtol=1e-3)
  @show Δ = 1e-14
  @show quadgk(ConcertinaSinpi(x->exp(-(x-0.25)^2), -100:100), Δ, 1 - Δ, rtol=1e-6)
  for i in 1:100
    @test 2i ≈ quadgk(ConcertinaSinpi(sinpi, -i:i), Δ, 1 - Δ, rtol=1e-6)[1]
  end

  for i in [14], σ in 0:0.0001:1
    Δ = 0.1^i
    o = quadgk(ConcertinaSinpi(x->exp(-(x-σ)^2), -100:100), Δ, 1 - Δ, rtol=1e-8, atol=1e-8)[1]
    #@show o
  end
end
