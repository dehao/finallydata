#import numpy as np
#import pandas as pd
#import matplotlib.pyplot as plt

#df = pd.read_csv('theta.csv')
#print df
#df.plot(kind='bar')

import matplotlib.pyplot as plt
import numpy as np
import pandas as pd
from io import StringIO


df = pd.read_csv('C1finaltheta.csv', delimiter=',')
print df
fig = plt.figure() # Create matplotlib figure

ax = fig.add_subplot(111) # Create matplotlib axes
#ax2 = ax.twinx() # Create another axes that shares the same x-axis as ax.

#width = 0.4
#colors = {1: 'r', 2: 'g'}
df.plot(kind='barh', stacked=True, ax=ax, color=['black', 'black', 'g', 'r', 'g', 'b', 'r'])

#df.left.plot(kind='bar', color='red', ax=ax)
#df.right.plot(kind='bar', color='blue', ax=ax2)




ax.set_ylabel('Agency')

plt.show()
