module ConcertinaSinpis

struct ConcertinaSinpi{F}
  numerator::F
  xs::UnitRange{Int}
  function ConcertinaSinpi(num, xs)
    @assert issorted(xs)
    @assert length(xs) > 0
    return new{typeof(num)}(num, xs)
  end
end
Base.:*(c::ConcertinaSinpi, x) = c.numerator(x) * (x / sinpi(x)) 

function (c::ConcertinaSinpi)(t)
  @assert 0 < t < 1
  n = c.numerator(t)
  output = zero(n)
  sgn = sign(sinpi((c.xs[1] + c.xs[2]) / 2))
  for i in 2:length(c.xs)
    term = c.numerator(t + c.xs[i-1])
    output += sgn * term
    sgn *= -1
  end
  return output / sinpi(t)
end

export ConcertinaSinpi
 
end # module ConcertinaSinpis
