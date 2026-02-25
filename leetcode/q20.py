class Solution:
    def isValid(self, s: str) -> bool:
        stack = []
        match_set = {
          ')'  : '(',
          '}' : '{',
           ']' : '['
        }
        for char in s:
            if char in match_set :
                if stack and stack[-1] == match_set[char]:
                    stack.pop()
                else : 
                    return False
            else:
                stack.append(char)
        
        return True if not stack else False 
