def Ecd_accelerate_version(s, t):
    k = 1
    sk = pow(s, k)
    while sk <= t:
        k += 1
        sk = pow(s, k)
    sk -= s
    t -= sk
    while t > 0:
        if t > s:
            k -= 1
            sk = pow(s, k)
            while sk > t:
                k -= 1
                sk = pow(s, k)
            t -= sk
        else:
            s, t = t, s
    return s
