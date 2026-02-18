class Solution:
    def dailyTemperatures(self, temperatures: List[int]) -> List[int]:
        stack = [(0,temperatures[0])]
        result = [0]*len(temperatures)
        
        # testing for valid temp strings 
        if len(temperatures) <= 0  :
            return result 

        for index , current_value in enumerate(temperatures[1:],1) : 
            while len(stack) != 0 :
                if stack[-1][1] < current_value :
                    result_index = stack.pop()[0]
                    result[result_index] = index - result_index 
                else : 
                    break 

            stack.append((index,current_value))

        return result 

