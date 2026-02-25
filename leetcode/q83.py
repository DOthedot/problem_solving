# Definition for singly-linked list.
# class ListNode:
#     def __init__(self, val=0, next=None):
#         self.val = val
#         self.next = next
class Solution:
    def deleteDuplicates(self, head: Optional[ListNode]) -> Optional[ListNode]:
        
        # we are parsing the list in o(N) time complexity , and then storing values to map 
        val_map = set()
         
        initial_node = ListNode(0) 
        current = initial_node

        while head is not None : 
            
            if head.val not in val_map : 
                val_map.add(head.val)
                current.next = head
                current = current.next
            
            head = head.next

        current.next = None 
        
        return  initial_node.next
                
