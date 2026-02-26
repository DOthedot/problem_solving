# Definition for a binary tree node.
# class TreeNode:
#     def __init__(self, val=0, left=None, right=None):
#         self.val = val
#         self.left = left
#         self.right = right
# solving the diameter of binary tree , using dfs recurssion o(n) time and O(h) space complexity 
class Solution:
    def diameterOfBinaryTree(self, root: Optional[TreeNode]) -> int:
        self.diameter = 0 

        def dfs(current):
            if current is None :
                return 0

            self.diameter = max(self.diameter ,dfs(current.left) + dfs(current.right) )

            return 1 + max(dfs(current.left),dfs(current.right))
        dfs(root)
        return self.diameter
        
