def QQTFrob4thMoment():
    indices = ('i','i1', 'j', 'j1', 'k', 'k1', 'l', 'l1')
    pairs = (['i', 'k'], ['j', 'k'], ['i', 'l'], ['j', 'l'], ['i1', 'k1'], ['j1', 'k1'], ['i1', 'l1'], ['j1', 'l1'])
    return QFrobMoment(indices, pairs)

def QFrobMoment(indices, pairs):
    partitions = SetPartitions(indices)
    sumofterms = 0
    for P in partitions:
        sumofterms += computeTerm(P, pairs) * numTerms(P)

    return sumofterms

def computeTerm(partition, pairs):
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
        term *= rowTerm(distpairsbyrow[row])

    return term

def rowTerm(pairs):
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
    if (row, row) in pairs:
        d = beta[0]
        rem = sum(beta) - d
        for i in range(d + 1):
            coeff = Subsets(d, i).cardinality() * (-1)^(rem + i)
            beta[0] = i
            factor += dirichMoment(beta) * coeff

    else:
        coeff = (-1)^sum(beta)
        factor = dirichMoment(beta) * coeff

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
