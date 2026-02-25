class Solution:
    def hasCycle(self, head: Optional[ListNode]) -> bool:
        if head is None:
            return False
        
        visited = set()
        
        while head is not None:
            if id(head) in visited:
                return True
            visited.add(id(head))
            head = head.next
        
        return False
