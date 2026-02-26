# Definition for a binary tree node.
# class TreeNode:
#     def __init__(self, val=0, left=None, right=None):
#         self.val = val
#         self.left = left
#         self.right = right
# find if a binary tree is balances or not ? time complexity = 0(N) 
class Solution:
    def isBalanced(self, root: Optional[TreeNode]) -> bool:
        self.status = True 

        def dfs(current):
            if current is None :
                return 0
            left_tree = dfs(current.left) 
            right_tree = dfs(current.right)

            self.status = self.status and (abs(left_tree - right_tree) <=1 )

            return 1 + max(left_tree , right_tree)
        
        dfs(root)
        
        return self.status
        
