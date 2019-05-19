module MathToolkit

export recvec
export pslq

function recvec(v; compute=BigInt, output=Int64)
  n = length(v)
  l = Array(Rational{compute}, n)
  l[:] = v[:]
  z = div(n, 2)
  q1 = Array(Rational{compute}, n)
  q2 = Array(Rational{compute}, n)
  q1[1] = 0
  q2[1] = 1
  sq1 = 1
  sq2 = 1
  q  = Array(Rational{compute}, n)
  m  = Array(Rational{compute}, n)
  b = 1
  while sq2 <= z
    # look for first non zero term in the series taylor(l)
    while l[b] == 0
      if (b += 1) > n
        c = 1
        g = num(q2[1])
        for k = 1:sq2
          c = lcm(c, den(q2[k]))
          g = gcd(g, num(q2[k]))
        end
        if q2[1] < 0
          c = -c
        end
        q = Array(output, sq2)
        q[:] = (c//g)*q2[1:sq2]
        return q
      end
    end
    # reciprocal of the series: x^(b-1) / taylor(l)
    m[1] = 1 / l[b]
    for k = (b+1):n
      c = zero(compute)
      for j = b:(k-1)
        c -= l[j+1]*m[k-j]
      end
      m[ k-b+1 ] = c / l[b]
    end
    l, m = m, l
    n -= b-1
    # compute (only) denominator of Pade approximant
    q[1:sq2] = l[1] * q2[1:sq2]
    q[sq2+1:b+sq1-1] = 0
    q[b:b+sq1-1] += q1[1:sq1]
    sq = max(sq2, b+sq1-1)
    while q[sq] == 0
      sq -= 1
    end
    q1, q2, q = q2, q, q1
    sq1, sq2 = sq2, sq
    # substract term of degree 0 before computing next reciprocal
    b = 2
  end
  return Array(output, 0)
end

function pslq(x, prec; maxiter=256)
  n = length(x)
  teps = prec * 16.0
  gam = 1.2
  s = Array(BigFloat, n)
  s[n] = abs(x[n])
  t = x[n]^2
  for i = (n-1):-1:1
    t += x[i]^2
    s[i] = sqrt(t)
  end
  t = s[1]
  y = x/t
  s = s/t

  h = [ zeros(BigFloat, n-1) for _ = 1:n ]
  for i = 1:n, j = 1:min(i,n-1)
    h[i][j] = (i==j) ? s[j+1]/s[j] : -y[i]*y[j]/(s[j]*s[j+1])
  end

  a = [ zeros(Integer, n) for _ = 1:n ]
  for i = 1:n
    a[i][i] = 1
  end
  b = deepcopy(a)

  for i = 2:n, j = (i-1):-1:1
    t = round(h[i][j]/h[j][j])
    y[j] += t*y[i]
    for k =1:j
      h[i][k] -= t*h[j][k]
    end
    t = convert(Integer,t)
    for k = 1:n
      a[i][k] -= t*a[j][k]
      b[j][k] += t*b[i][k]
    end
  end

  m = 0
  for itr =1:maxiter
    mval = -1
    g = gam
    for i = 1:(n-1)
      t = abs(g*h[i][i])
      if t > mval
        mval = t
        m = i
      end
      g *= gam
    end
    y[m], y[m+1] = y[m+1], y[m]
    h[m], h[m+1] = h[m+1], h[m]
    a[m], a[m+1] = a[m+1], a[m]
    b[m], b[m+1] = b[m+1], b[m]
    if m < n-1
      t0 = sqrt(h[m][m]^2 + h[m][m+1]^2)
      t1 = h[m][m]/t0
      t2 = h[m][m+1]/t0
      for i = m:n
        t3 = h[i][m]
        t4 = h[i][m+1]
        h[i][m] = t1*t3 + t2*t4
        h[i][m+1] = t1*t4 - t2*t3
      end
    end
    for i = (m+1):n, j=min(i-1,m+1):-1:1
      t = round(h[i][j] / h[j][j])
      y[j] += t*y[i]
      for k=1:j
        h[i][k] -= t*h[j][k]
      end
      t = convert(Integer,t)
      for k=1:n
        a[i][k] -= t*a[j][k]
        b[j][k] += t*b[i][k]
      end
    end

    mval = 0
    for j=1:(n-1)
      t = abs(h[j][j])
      if t > mval
        mval = t
      end
    end
    for i=1:n
      t = abs(y[i])
      if t < teps
        return b[m]
      end
    end
  end
  return zeros(Integer, n)
end

end # module
