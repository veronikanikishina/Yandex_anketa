import numpy as np
import matplotlib
import matplotlib.pyplot as plt
from mpl_toolkits.mplot3d import Axes3D
x0=-1;
x1=1;
y0=-1;
y1=1;# границы прямоугольника, содержащего область интегрирования
z0=-1;
z1=1;
n=10# число испытаний методом Монте-Карло
f=lambda x, y, z: x**2*y/(2-z)#подынтегральная функция
g= lambda x, y, z: 1-x**2-y**2-z**2#область интегрирования
x = np.random.uniform(x0, x1, n)
y = np.random.uniform(y0, y1, n)
z = np.random.uniform(z0, z1, n)
f_av = 0          # среднее значение f
L = 0      # число точек, попавших в область интегрирования (g>=0)
for i in range(n):
    for j in range(n):
        for k in range(n):
            if (g(x[i], y[j], z[k]) >=0) :
                L += 1
                f_av += f(x[i],y[j],z[k] )
f_av = f_av/float(L)
V = L/float(n**3)*(x1 - x0)*(y1 - y0)*(z1 - z0)
I=V*f_av
print("Объем области интегрирования V=",V)
print("Среднее значение функции f_average=",f_av)
print("Значение интеграла методом Монте-Карло I=",I)
X1=np.zeros(L)
Y1=np.zeros(L)
Z1=np.zeros(L)
X2=np.zeros(n**3-L)
Y2=np.zeros(n**3-L)
Z2=np.zeros(n**3-L)
r1=0
r2=0
for i in range(n):
    for j in range(n):
        for k in range(n):
            if (g(x[i], y[j], z[k]) >=0) :
                X1[r1]=x[i]
                Y1[r1]=y[j]
                Z1[r1]=z[k]
                r1=r1+1
            else :
                X2[r2]=x[i]
                Y2[r2]=y[j]
                Z2[r2]=z[k]
                r2=r2+1
fig1 = plt.figure()
ax=Axes3D(fig1)
ax.plot(X1, Y1, Z1,'o', color='green')
ax.plot(X2, Y2, Z2,'o', color='blue')
plt.show()

