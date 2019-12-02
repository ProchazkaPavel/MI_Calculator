import numpy as np
cimport numpy as np

np.import_array()


#@cython.boundscheck(False) # turn of bounds-checking for entire function
def MIcalc(np.ndarray[double, ndim=2, mode="c"] X not None,
           np.ndarray[double, ndim=2, mode="c"] Y not None):
    d = {}
    F = len(X)
    e = (1/F)**(1/(1 + Y.shape[1] + X.shape[1]))
    b = np.random.rand()*e
    H1 = lambda vec, e, b:np.asarray(np.floor((vec + b)/e))
    def H2(vec):
        res = np.zeros(len(vec), int)
        for i, x in enumerate(vec):
            key = tuple(x)
            act = d.get(key, np.random.randint(F))
            res[i] = act
            d[key] = act
        return res  
    A = np.c_[H2(H1(X, e, b)), H2(H1(Y, e, b))]
    Nx = np.histogram(A[:,0], np.arange(F+1))[0]
    Ny = np.histogram(A[:,1], np.arange(F+1))[0]
    omega_X = Nx / F
    omega_Y = Ny / F

    I = 0
    vv = {}
    for i, j in A:
        act = vv.get((i,j), 0)
        act += 1
        vv[(i,j)] = act

    for cnt, ((i, j), tmp) in enumerate(vv.items()):
        I += omega_X[i] * omega_Y[j] * np.log(tmp*F / (Nx[i]*Ny[j]))

    return I
