def dirich_moment(beta, n):
    d = sum(beta)
    denom = 1
    for i in range(d):
        denom *= (n + i);
    num = 1
    for b in beta:
        num *= sage.all.factorial(b)
    return num / denom
