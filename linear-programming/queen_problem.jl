#-------------------------------------------------------------------------------
# Set covering problem
#-------------------------------------------------------------------------------

#-------------------------------------------------------------------------------
#  Load packages
#-------------------------------------------------------------------------------
using JuMP, HiGHS

#-------------------------------------------------------------------------------
# Additional functions
#-------------------------------------------------------------------------------

include("additional_functions.jl")

avdelare = repeat('-',60)

#-------------------------------------------------------------------------------
# Input data file
#-------------------------------------------------------------------------------

#-------------------------------------------------------------------------------
# n						
# m
#a[i,j]						
#-------------------------------------------------------------------------------


#-------------------------------------------------------------------------------
# The model saved as CHESS
#-------------------------------------------------------------------------------
QUEEN  = Model(HiGHS.Optimizer)
#-------------------------------------------------------------------------------


################# Student part #################################################

#-------------------------------------------------------------------------------
# Define variables
#-------------------------------------------------------------------------------


@variable(QUEEN, x[1:8, 1:8], Bin)
#BOARD = [(i, j) for i in 8, j in 8]


#-------------------------------------------------------------------------------


#-------------------------------------------------------------------------------
# Add objective function
#-------------------------------------------------------------------------------

@objective(QUEEN, Max, sum(x[i, j] for i in 1:8 for j in 1:8))



#-------------------------------------------------------------------------------


#-------------------------------------------------------------------------------
# Add constraints

@constraint(QUEEN, con5[i in 1:8], sum(x[i, j] for j in 1:8) <= 1)

@constraint(QUEEN, con6[j in 1:8], sum(x[i, j] for i in 1:8) <= 1)

#for k in 0:6
    @constraint(QUEEN, con1[k in 0:6],  sum(x[i+k, i] for i in 1:8-k ) <= 1)
    @constraint(QUEEN, con2[k in 0:6], sum(x[i+k, 9-i] for i in 1:8-k) <= 1)

#end
#@constraint(QUEEN, sum(x[i+k, i] for i in 1:8-k) <= 1)

#@constraint(QUEEN, [i in 1:8-k], sum(x[i+k, 9-i]) <= 1)



#for k in 1:6

    @constraint(QUEEN, con3[k in 1:6], sum(x[i, i+k] for  i in 1:8-k) <= 1)

    @constraint(QUEEN, con4[k in 1:6], sum(x[i, 9-k-i] for i in 1:8-k) <= 1)

#end


#-------------------------------------------------------------------------------


#-------------------------------------------------------------------------------


############### End student part ###############################################

#-------------------------------------------------------------------------------
# Display defined problem
#-------------------------------------------------------------------------------
#println(avdelare)
#println("Set covering problem")
#println(avdelare)
#print(COVER)
#println(avdelare)
#-------------------------------------------------------------------------------

#-------------------------------------------------------------------------------
#Solve the optimisation problem
#-------------------------------------------------------------------------------
println("\n\n\n>>> SOLVING CHESS PROBLEM <<<\n")
solution = optimize!(QUEEN)
print_chess(value.(x))
#chess_matrix = [value(x[1,1]) value(x[1,2]) value(x[1,3]) value(x[1,4]) value(x[1,5]) value(x[1,6]) value(x[1,7]) value(x[1,8]) ;
#                value(x[2,1]) value(x[2,2]) value(x[2,3]) value(x[2,4]) value(x[2,5]) value(x[2,6]) value(x[2,7]) value(x[2,8]) ;
 #               value(x[3,1]) value(x[3,2]) value(x[3,3]) value(x[3,4]) value(x[3,5]) value(x[3,6]) value(x[3,7]) value(x[3,8]) ;
  #              value(x[4,1]) value(x[4,2]) value(x[4,3]) value(x[4,4]) value(x[4,5]) value(x[4,6]) value(x[4,7]) value(x[4,8]) ;
   #             value(x[5,1]) value(x[5,2]) value(x[5,3]) value(x[5,4]) value(x[5,5]) value(x[5,6]) value(x[5,7]) value(x[5,8]) ;
    #            value(x[6,1]) value(x[6,2]) value(x[6,3]) value(x[6,4]) value(x[6,5]) value(x[6,6]) value(x[6,7]) value(x[6,8]) ;
     #           value(x[7,1]) value(x[7,2]) value(x[7,3]) value(x[7,4]) value(x[7,5]) value(x[7,6]) value(x[7,7]) value(x[7,8]) ;
      #          value(x[8,1]) value(x[8,2]) value(x[8,3]) value(x[8,4]) value(x[8,5]) value(x[8,6]) value(x[8,7]) value(x[8,8]) ]

println("\n\n\n>>> OPTIMAL SOLUTION <<<\n")
println(avdelare)
zStar = objective_value(QUEEN)
zStar = round(zStar,digits=2)
println( "Optimal objective value:\n $(zStar)")
println(avdelare)
#-------------------------------------------------------------------------------
println("Optimal Solution:")
println(avdelare)
#-------------------------------------------------------------------------------
print_integer(QUEEN) # This prints all the variables 


# If you want, you can write a small code to print only nonzero variables. 
#-------------------------------------------------------------------------------