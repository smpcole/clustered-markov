def RExp(numterms = Infinity, n = var('n')):
    E = QFrobMoment(2, 0, n) - 2 * QFrobMoment(0, 2, n) + n - 1
    if numterms < Infinity:
        E = E.taylor(n, Infinity, numterms)
    return E

def RVar(numterms = Infinity, n = var('n')):
    E = QFrobMoment(2, 0, n)
    F = QFrobMoment(0, 2, n)
    V = QFrobMoment(4, 0, n) + 4 * QFrobMoment(0, 4, n) - 4 * QFrobMoment(2, 2, n) - E^2 - 4 * F^2 + 4 * E * F
    if numterms < Infinity:
        V = V.taylor(n, Infinity, numterms)
    return V

def entrywise(p, k, M = 'A', n = var('n')):
    """Expectation of ||M||_p^{pk}, where || ||_p denotes the entrywise p-norm"""
    indices = ['i' + str(i) for i in range(k)]
    indices.extend(('j' + str(j) for j in range(k)))
    pairs = []
    for i in range(k):
        pairs.extend((('i' + str(i), 'j' + str(i)) for j in range(p)))

    return expSumProd(indices, pairs, M, n)

def QFrobMoment(QQTpwr, Qpwr, n = var('n')):
    return FrobMoment(QQTpwr, Qpwr, 'Q', n)

def FrobMoment(MMTpwr, Mpwr, M = 'Q', n = var('n')):
    indices = []
    pairs = []
    for i in range(MMTpwr / 2):
        for index in ('i', 'j', 'k', 'l'):
            indices.append(index + str(i))
        for rowindex in ('i', 'j'):
            for colindex in ('k', 'l'):
                pairs.append((rowindex + str(i), colindex + str(i)))
    for i in range(Mpwr / 2):
        pair = ('u' + str(i), 'v' + str(i))
        indices.extend(pair)
        pairs.extend((pair, pair))

    return expSumProd(indices, pairs, M, n)

def expSumProd(indices, pairs, M = 'A', n = var('n')):
    
    partitions = SetPartitions(indices)
    sumofterms = 0
    for P in partitions:
        sumofterms += computeTerm(P, pairs, M, n) * numTerms(P, n)

    return sumofterms

def computeTerm(partition, pairs, matrix = 'Q', n = var('n')):
    term = 1
    P = partition

    pairs = tuple(list(pair) for pair in pairs)
    
    partof = {}
    for part in P:
        for index in part:
            partof[index] = part

    for pair in pairs:
        rowpart = partof[pair[0]]
        colpart = partof[pair[1]]
        reprow = min(rowpart)
        repcol = min(colpart)
        pair[0] = reprow
        pair[1] = repcol

    pairs = tuple(tuple(pair) for pair in pairs)

    """Don't actually need this
    distpairs = {pair:0 for pair in pairs}
    for pair in pairs:
        distpairs[pair] += 1
    """

    # Partition the distinct pairs by row

    distpairsbyrow = {}
    for pair in pairs:
        row = pair[0]
        if row not in distpairsbyrow:
            distpairsbyrow[row] = {}
        if pair not in distpairsbyrow[row]:
            distpairsbyrow[row][pair] = 0
        distpairsbyrow[row][pair] += 1

    for row in distpairsbyrow:
        term *= rowTerm(distpairsbyrow[row], n, matrix)

    return term

def rowTerm(pairs, n = var('n'), matrix = 'Q'):
    beta = []
    
    row = None
    for pair in pairs:
        row = pair[0] # All pairs are in the same row
        break
    
    # If (row, row) is one of the pairs, ensure it corresponds to first entry of beta
    for pair in pairs:
        if pair[1] == row: # Row and column are same
            beta.insert(0, pairs[pair])
        else:
            beta.append(pairs[pair])

    factor = 0    
    if matrix == 'Q' and (row, row) in pairs:
        d = beta[0]
        rem = sum(beta) - d
        for i in range(d + 1):
            coeff = Subsets(d, i).cardinality() * (-1)^(rem + i)
            beta[0] = i
            factor += dirichMoment(beta, n) * coeff

    else:
        coeff = (-1)^sum(beta)
        factor = dirichMoment(beta, n)
        if matrix == 'Q':
            factor *= coeff

    return factor

def numTerms(partition, n = var('n')):
    prod = 1
    for i in range(len(partition)):
        prod *= (n - i)
    return prod

def dirichMoment(beta, n = var('n')):
    d = sum(beta)
    denom = 1
    for i in range(d):
        denom *= (n + i);
    num = 1
    for b in beta:
        num *= sage.all.factorial(b)
    return num / denom
