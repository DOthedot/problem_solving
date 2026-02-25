class Solution:
    def copyRandomList(self, head: 'Optional[Node]') -> 'Optional[Node]':
        old_nodes_map = {None: None}
        current = head 
        while current:
            copy = Node(current.val)
            old_nodes_map[current] = copy
            current = current.next  # Fixed: proper indentation

        current = head 
        while current: 
            copy = old_nodes_map[current]
            copy.next = old_nodes_map[current.next]
            copy.random = old_nodes_map[current.random]
            current = current.next

        return old_nodes_map[head]
