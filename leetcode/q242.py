# is a valid anagram 

class Solution:
    def isAnagram(self, s: str, t: str) -> bool:
        if len(s) != len(t) : return False 

        map_s , map_t = {} , {}

        for index in range(len(s)):
            map_s[s[index]] = 1 + map_s.get(s[index],0)
            map_t[t[index]] = 1 + map_t.get(t[index],0)

        for val in map_s : 
            if map_s[val] != map_t.get(val, 0):
                return False
        
        return True 

        
