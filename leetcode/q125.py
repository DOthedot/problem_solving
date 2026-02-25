class Solution:
    def isPalindrome(self, s: str) -> bool:
        # cleaning the string 
        s = "".join(ch.lower() for ch in s if ch.isalnum())
        
        left_pointer = 0
        right_pointer = len(s)-1
        
        while left_pointer <= right_pointer :
            if s[left_pointer] != s[right_pointer] : 
                return False 
            else : 
                left_pointer += 1 
                right_pointer -= 1 
        
        # and if eveything goes correct 
        return True 
        
