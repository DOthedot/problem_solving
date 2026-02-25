# 3 sum using 2 ponter in o(n^2) time complexity  
class Solution:
    def threeSum(self, nums: List[int]) -> List[List[int]]:
        result = set()
        sorted_nums = sorted(nums)

        for primary_index in range(0,len(sorted_nums)-2) : 
            left_pointer = primary_index + 1
            right_pointer = len(sorted_nums) - 1 
            
            while left_pointer < right_pointer : 
                total = sorted_nums[primary_index] + sorted_nums[left_pointer] + sorted_nums[right_pointer]

                if  total < 0  :
                    left_pointer += 1

                elif total > 0 :
                    right_pointer -= 1

                else :
                    result.add((sorted_nums[primary_index] , sorted_nums[left_pointer] , sorted_nums[right_pointer]))
                    left_pointer += 1 
                    right_pointer -= 1 
        return [list(t) for t in result]

                

        
