# two sum array - using HashMap

class Solution:
    def twoSum(self, nums: List[int], target: int) -> List[int]:
        diff_map = {}

        for index in range(len(nums)) : 
            if target - nums[index] in diff_map.keys(): 
                return [diff_map[target - nums[index]], index ]
            else : 
                diff_map[nums[index]] = index
        return [-1 , -1 ]

