import numpy as np 
import matplotlib 
import matplotlib.pyplot as plt 
from Data import x, y 
fig, ax = plt.subplots(1) 
# ny is 10
plt.scatter(x, y) 
plt.xlabel('V') 
plt.ylabel('current') 
plt.savefig('.pdf') 

