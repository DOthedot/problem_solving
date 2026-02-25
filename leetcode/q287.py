class Solution:
    def findDuplicate(self, nums: List[int]) -> int:
        slow , fast = 0 , 0 
        # now creating a interserction 
        while True :
            slow = nums[slow]
            fast = nums[nums[fast]]
            if slow == fast : 
                break 

        slow2 = 0 

        # iteration so that they meet again at the cycle start 
        while True :
            slow = nums[slow]
            slow2 = numns[slow2]
            if slow == slow2 : 
                break 

        return slow 
