import numpy as np
import math
np.random.seed(33)

base = 16
maxval = 1<<base
max8 = 1<<8
max16 = max8<<8
n = 20

a = np.random.randint(0, max8, n)
b = np.random.randint(0, max8, n)
c = np.random.randint(0, max16, n)
cin = np.random.randint(0, 2, n)
s = a*b+c

f = open('TRACEFILE.txt', 'w')
for i in range(n):
	f.write(''.join([format(a[i], '#010b')[2:], format(b[i], '#010b')[2:], format(c[i], '#018b')[2:], ' ', format(s[i], '#019b')[2:], ' ', '1'*17, '\n']))

f.close()