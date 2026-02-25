
def first_missing_pos(array)-> int : 
    """
    funciton find the first positive value that's missing from the input array , time complexity = O(N) 
    """
    min_value_not_found = 1
    sorted_array = sorted(array)

    for value in sorted_array :

        if value > 0 and value > min_value_not_found and value != min_value_not_found :
            return min_value_not_found  
        
        if value > 0 and value == min_value_not_found : 
            min_value_not_found += 1  

    return min_value_not_found


print(first_missing_pos([0,2,2,1,1]))
