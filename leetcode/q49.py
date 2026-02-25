# group anagrams and return in a list
class Solution:
    def groupAnagrams(self, strs: List[str]) -> List[List[str]]:
        ana_map = {}
        for word in strs : 
            if str(sorted(word)) in ana_map.keys():
                ana_map[str(sorted(word))].append(word)
            else : 
                ana_map[str(sorted(word))] = [word]
        
        result_array = []
        for val in ana_map.values():
            result_array.append(val)

        return result_array  
