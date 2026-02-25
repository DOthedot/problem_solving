# Definition for singly-linked list.
# class ListNode:
#     def __init__(self, val=0, next=None):
#         self.val = val
#         self.next = next
class Solution:
    def merge_lists(self, l1, l2):
            dummy = ListNode()
            tail = dummy

            while l1 and l2 : 
                if l1.val < l2.val :
                    tail.next = l1
                    l1 = l1.next 
                else : 
                    tail.next = l2
                    l2 = l2.next 
                
                tail = tail.next 
                
            tail.next = l1 if l1 else l2 # to attach the remaining list 
            return dummy.next 
            
    def mergeKLists(self, lists: List[Optional[ListNode]]) -> Optional[ListNode]:
        # checking for the base condition 
        if not lists or len(lists) == 0:
            return None 
        
        # divide and conquer , while picking 2 lists at a time 
        while len(lists) > 1:
            merged_list = []

            for i in range(0,len(lists),2):
                l1 = lists[i]
                l2 = lists[i+1] if i + 1 < len(lists) else None

                merged_list.append(self.merge_lists(l1, l2))
            lists = merged_list
        
        return lists[0]
