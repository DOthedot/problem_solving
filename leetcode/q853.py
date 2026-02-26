# total number of car fleet , time complexity o(N) and space complexity O(1)

class Solution:
    def carFleet(self, target: int, position: List[int], speed: List[int]) -> int:
        pairs = sorted(zip(position, speed), reverse=True)  # sort by position descending
        result_set = []

        for pos, spd in pairs:
            total_hrs = (target - pos) / spd
            if len(result_set) >= 1 and total_hrs <= result_set[-1]:
                continue  # this car catches up to fleet ahead, skip it
            result_set.append(total_hrs)


        return len(result_set)
