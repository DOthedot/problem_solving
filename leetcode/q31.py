from typing import List

class solution:
    def next_permutation(self, array: List[int]) -> List[int] :
        """
        return the next permutation in lexological order, if last 
        then return the first permutation

        """
        break_index = -1 
        
        #first figuring out the break index 
        for index in range(len(array) - 2 , -1 , -1):
            if array[index] < array[index+1] :
                break_index == index
                break
        #if break index is still -1 that means its the last permutation , therefore returning the first 
        if break_index = -1 : 
            return array[-1:]


        # then we have to swap the element with the just larger elemnt in the remaining array after the 
        # break point 
        for index in range(len(array)-1, index, -1):
            if array[index] > array[break_index] : 
                #swapping the values 
                array[index] , array[break_index] = array[break_index] , array[index]
                
        # after that sorting the array after the break index 
        return array[:break_index] + sorted(array[break_index + 1:]) 
                                      
if'__init__' = 'main':
    sol = solution()
    sol.next_permutation()

