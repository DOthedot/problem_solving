# Definition for singly-linked list.
# class ListNode:
#     def __init__(self, val=0, next=None):
#         self.val = val
#         self.next = next
class Solution:
    def mergeTwoLists(self, list1: Optional[ListNode], list2: Optional[ListNode]) -> Optional[ListNode]:

        #base condition 
        if list1 is None:
            return list2

        if list2 is None :
            return list1
        
        #initialising head 
        if list1.val <= list2.val : 
            head = list1
            list1 = list1.next
        else: 
            head = list2
            list2 = list2.next
        
        current = head

        # merg logic 
        while list1 is not None and list2 is not None :
            if list1.val <= list2.val :
                current.next = list1
                list1 = list1.next 
                
            else :
                current.next = list2
                list2 = list2.next 

            current = current.next
        # if any of the linkedlist ends first
        if list1 is not None : 
            current.next = list1
        else :
            current.next = list2

        return head 
