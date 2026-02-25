# we have to find out, the maximum length of longest subsequence 

from typing import List 

def longest_consecutive(array: List[int]) -> int:
    # checking for anmolies in the array 
    if len(array) <= 1 : 
        return array


    # sorting the array inplace 
    array.sort() 
  
    max_length = 0 
    count = 1 
    current_value = array[0] # to initialise the first value 

    #using the loop to calculate the maximum array 
    for value in array[1:] :
        if value != current_value + 1 : 
            current_value = value  
            count = 0 
        else:
            count += 1 
            current_value = value 
        max_length = max(max_length , count)

    return max_length  

print(longest_consecutive([0,3,7,2,5,8,4,6,0,1]))
