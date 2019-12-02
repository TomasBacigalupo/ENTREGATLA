# A school method based Python3 program  
# to check if a number is prime 
  
# function check whether a number  
# is prime or not 
def isPrime(n): 
      
    # Corner case 
    if (n <= 1): 
        return False
  
    # Check from 2 to n-1 
    for i in range(2, n): 
        if (n % i == 0): 
            return False
  
    return True
  
# Driver Program  
if isPrime(23456789): 
    print ("true") 
else: 
    print ("false") 
      
# This code is contributed by Sachin Bisht 
