module ConcertinaSinpis

struct ConcertinaSinpi{F}
  numerator::F
  az::Tuple{Int, Int} # the left and right hand integral bounds in normalised units
  function ConcertinaSinpi(num, az)
    @assert issorted(az)
    return new{typeof(num)}(num, az)
  end
end
Base.:*(c::ConcertinaSinpi, x) = c.numerator(x) * (x / sinpi(x)) 

"""
    (c::ConcertinaSinpi)(t)

Evaluate and sum the ConcertinaSinpi function at location `t` in [0, 1]
where t is mapped to [0, 1] + az[1]:az[2], taking into account the sign
of the denominator, sinpi(t + ax[1]:azp[2]), before finally dividing by
|sinpi(t)|.

...
# Arguments
- `c::ConcertinaSinpi(t`: 
...

# Example
```julia
```
"""
function (c::ConcertinaSinpi)(t)
  @assert 0 < t < 1
  n = c.numerator(t)
  breaks = c.az[1]:c.az[2]
  output = zero(n)
  sgn = iseven(breaks[1]) ? 1 : - 1
  for i in 2:length(breaks)
    term = c.numerator(t + breaks[i-1])
    output += sgn * term
    sgn *= -1
  end
  return output / sinpi(t)
end

export ConcertinaSinpi
 
end # module ConcertinaSinpis
