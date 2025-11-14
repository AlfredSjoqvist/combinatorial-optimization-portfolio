# TAOP33 - LAB5
# Rikard Ågren & Alfred Sjöqvist
# rikag489 & alfsj019

import numpy as np
import time
import sys
import copy
import math

e = 1

prob = " ".join(sys.argv[1:]).split('.')[0]
prob = "floc3"
fil  = prob + '.npz'

npzfile = np.load(fil)
npzfile.files
m = npzfile['m']                        # Number of factories
n = npzfile['n']                        # Number of customers
s = npzfile['s'].astype(np.int64)       # Factory production
d = npzfile['d']                        # Customer demand vector
f = npzfile['f']                        # Factory cost vector
c = npzfile['c'].astype(np.float64)     # Factory-to-customer transfer cost matrix

t1 = time.time()
x  = np.zeros((m,n),dtype=np.int16)
y  = np.zeros((m),dtype=np.int16)

ss = copy.deepcopy(s)
dd = copy.deepcopy(d)
cc = copy.deepcopy(c)

# Convert the numpy array of factory costs to a a list for easier management
f_list = f.tolist()

# Boolean to break the loop at the right moment
done = False

# Multiply the e-factor to the factory cost vector
for i in range(0, len(f_list)):
    f_list[i] = e*f_list[i]

# Main loop
for i in range(1, m):

    # Create variables for finding the current potential cheapest factory build
    cheapest_factory_index = math.inf
    min_build_cost = math.inf

    # Find the index in the vectors pointing to the cheapest potential factory
    for i in range(0, len(f_list)):
        if (f_list[i] < min_build_cost):
            min_build_cost = f_list[i]
            cheapest_factory_index = i
    
    # Build the factory
    y[cheapest_factory_index] = 1

    # Keep looking for potential delivieries while there is still left of the factory's supply
    while s[cheapest_factory_index] > 0:
        
        # Create variables for finding the current potential cheapest delivery
        cheapest_customer_index = math.inf
        cheapest_customer_cost = math.inf

        # Find the index in the vectors pointing to the cheapest potential delivery
        for j in range(0, n):
            if (c[cheapest_factory_index, j] < cheapest_customer_cost):
                cheapest_customer_index = j
                cheapest_customer_cost = c[cheapest_factory_index, j]

        # Remove the demanded resources from the factory supply
        s[cheapest_factory_index] -= d[cheapest_customer_index]

        # Make sure that the supply- and demand vectors are updated correctly if the delivery depleted the last of the supply
        if (s[cheapest_factory_index] < 0):
            x[cheapest_factory_index, cheapest_customer_index] += d[cheapest_customer_index] + s[cheapest_factory_index]    # Update the x-matrix after the delivery  
            d[cheapest_customer_index] = - s[cheapest_factory_index]        # The customer still has some demand left in this case
            s[cheapest_factory_index] = 0       # The supply is now empty
        
        # If the delivery doesn't empty the supply:
        else:
            x[cheapest_factory_index, cheapest_customer_index] = d[cheapest_customer_index]         # Update the x-matrix after the delivery  
            d[cheapest_customer_index] = 0         # The customer demands nothing more
            if sum(d) == 0:      # If no customers demand anything more, the heuristic has reached it's goal
                done = True
                break
        
        # Set the cost of the delivery to infinity so it isn't chosen again in the next iteration
        c[cheapest_factory_index, cheapest_customer_index] = np.inf
    
    # Set the cost of the factory build to infinity so it isn't chosen again in the next iteration of the main loop
    f_list[cheapest_factory_index] = np.inf
    
    # When the heuristic is done, break the loop
    if done:
        break



elapsed = time.time() - t1
print('Tid: '+str('%.4f' % elapsed))

cost=sum(sum(np.multiply(cc,x))) + e*np.dot(f,y)
print('Problem:',prob,' Totalkostnad: '+str(cost))
print('y:',y)
print('Antal byggda fabriker:',sum(y),'(av',m,')')

