using ConcertinaSinpis
using Test, QuadGK

f(x) = exp(-x^2)
g(x) = sinpi(x)

@testset "Concertinas.jl" begin
  #@show quadgk(ConcertinaSinpi(f, -100:100), 0.1, 0.9, rtol=1e-3)
  Δ = 1e-14
  #@show quadgk(ConcertinaSinpi(x->exp(-(x-0.25)^2), -100:100), Δ, 1 - Δ, rtol=1e-6)
  @testset "sin(x)/sin(x), Δ = $Δ" begin
    for i in 1:100
      @test 2i ≈ quadgk(ConcertinaSinpi(sinpi, (-i, i)), Δ, 1 - Δ, rtol=1e-6)[1]
    end
  end

  #for i in [14], σ in 0:0.0001:1
  #  Δ = 0.1^i
  #  o = quadgk(ConcertinaSinpi(x->exp(-(x-σ)^2), -100:100), Δ, 1 - Δ, rtol=1e-8, atol=1e-8)[1]
  #  #@show o
  #end

  for i in -4:-1:-9
    Δ = 10.0^i
    expected = (log(tan((1 - Δ) * π / 2)) - log(tan(Δ * π / 2))) / 2π
    result = quadgk(ConcertinaSinpi(identity, (0, 1)), Δ, 1 - Δ, rtol=1e-6)[1]
    @testset "1 / sin(x), Δ = $Δ" begin
      @test expected ≈ result
    end

    @testset "cos(x)^2 / sin(x), Δ = $Δ" begin
      fcos²_sin(x) = (cos(x) + log(sin(x/2)) - log(cos(x/2))) / π 
      expected = fcos²_sin((1 - Δ) * π) - fcos²_sin(Δ * π)
      result = quadgk(ConcertinaSinpi(x->cospi(x)^2, (0, 1)), Δ, 1 - Δ, rtol=1e-6)[1]
      @test expected ≈ result
    end
  end
end
