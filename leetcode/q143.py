# Definition for singly-linked list.
# class ListNode(object):
#     def __init__(self, val=0, next=None):
#         self.val = val
#         self.next = next
class Solution(object):
    def reorderList(self, head):
        """
        :type head: Optional[ListNode]
        :rtype: None Do not return anything, modify head in-place instead.
        """
        # checking the base condition 
        if not head or not head.next : 
            return 

        slow , fast = head , head.next 

        # to get second_half of the linkedlist 
        while fast and fast.next :
            slow = slow.next 
            fast = fast.next.next  
        
        second_half = slow.next 
        prev = slow.next = None 

        # reversing the second half 
        while second_half : 
            next_node = second_half.next
            second_half.next = prev
            prev = second_half
            second_half = next_node  

        # merging both the list
        # as at the end prev is set to the second half of the string  
        first_half , second_half = head , prev 

        while second_half : 
            next_node_of_first_half , next_node_of_second_half = first_half.next , second_half.next
            first_half.next = second_half
            second_half.next = next_node_of_first_half 

            # and now we are shifting the pointers 
            first_half , second_half  = next_node_of_first_half , next_node_of_second_half


