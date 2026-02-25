# top k most frequent elements in O(klogn) 
class Solution:
    def topKFrequent(self, nums: List[int], k: int) -> List[int]:
        freq_map = {}
        for num in nums : 
            freq_map[num] = freq_map.get(num,0) + 1 
        
        final_list = sorted(freq_map.items() , key = lambda x : x[1] , reverse = True )

        return [ val[0] for val in final_list[0:k] ]

# solving using o(N)
class Solution:
    def topKFrequent(self, nums: List[int], k: int) -> List[int]:
        counter = [[]] * (len(nums)+1)
        fmap = {}
    
        for n in nums :
            fmap[n] = fmap.get(n,0) + 1
        for n , c in fmap.items():
            counter[c].append(n)
        
        res = []
        for i in range(len(counter)-1,0,-1):
            for n in counter[i]:
                res.append(n)
                if len(res) == k : 
                    return res

