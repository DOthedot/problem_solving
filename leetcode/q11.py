# find max water - using two pointer and o(N) time complexity 
class Solution:
    def maxArea(self, height: List[int]) -> int:
        left_pointer = 0
        right_pointer = len(height) - 1 

        max_amount = 0

        while left_pointer < right_pointer : 
            amount = min(height[left_pointer] , height[right_pointer]) * (right_pointer - left_pointer)
            max_amount = max(max_amount , amount )

            if height[left_pointer] < height[right_pointer] : 
                left_pointer += 1 
            else : 
                right_pointer -= 1 
        
        return max_amount 
            
        
