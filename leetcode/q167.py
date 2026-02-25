# finding the target sum using two pointer, numbers list is ascending
class Solution:
    def twoSum(self, numbers: List[int], target: int) -> List[int]:
        left_pointer = 0 
        right_pointer = len(numbers) - 1 

        while left_pointer < right_pointer : 
            if target > numbers[left_pointer] + numbers[right_pointer] :
                left_pointer += 1 
            
            elif target < numbers[left_pointer] + numbers[right_pointer] :
                right_pointer -= 1
            
            else : 
                return [left_pointer+1 ,  right_pointer+1]
        
        # if found nothing 
        return [-1,-1]
        
