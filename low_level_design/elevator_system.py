# low level desing of elevator system 

class direction(enum):
	up : 'up'
	down : 'down'
	idle : 'idle'

class elevator_state(enum):
	moving : 'moving'
	stopped : 'stopped'
	door_open : 'dooe_open'

class requests:
	def __init__(self, floor: int | None = None , direction: direction = None ):
		self.floor = floor
		self.direction = direction


class elevator:
	def __init__(self , eid: int , min_floor: int , max_floor: int):
		self.eid = eid
		self.min_floor = min_floor
		self.max_floor = max_floor
		self.current_floor = min_floor
		self.state = elevator_state.stopped
		self.direction = direction.idle
		self.requests: List[requests] = [] # definign a emply list here 
		self.lock() = Lock()

	def add_request(self , req: requests):

		with self.lock :
			self.requests.append(req)
			self.requests.sort(key=lambda r: abs(r.floor - self.current_floor))

	def _open_doors(self):
		self.state = elevator_state.door_open
		self.state = elevator_state.stopped


	def step(self):
		with self.lock():

			if not self.requests:
				self.state = elevator_state.stopped
				self.direction = direction.idle 
				return 

			target = self.requests[0].floor
			# if floor is above the current floor 
			if floor > self.current_floor : 
				self.direction = direction.up
				self.current_floor += 1 
				self.state = elevator_state.moving

			# if floor is below the current floor of elevator 
			elif floor < self.current_floor : 
				self.direction = direction.down
				self.current_floor -= 1 
				self.state = elevator_state.moving

			# now this means we have already reached at the target 
			else : 
				self._open_doors()
				self.requests.pop(0)
				
				if not self.requests:
					self.direction = direction.idle 
				return 

class elevator_controller : 
	def __init__(self , num_elevators: int , min_floor: int , max_floor: int):
		self.elevators: List[elevator] = [ elevator(eid = i, min_floor = min_floor, max_floor= max_floor) for i in range(num_elevators) ]
		self.lock = lock()

	def request_elevator(self , req: requests):
		with self.lock():
			chosen = min(self.elevators , key= lambda e: abs( e.current_floor - req.floor ) )
			chosen.add_request(req)

	def step_all(self):
		for e in self.elevators : 
			e.step()


	def process_requests( self , cmds: List(str) ):
		for cmd in cmds :
			parts = cmd.split()
			if parts[0] =='REQUEST' : 
				floor = int(parts[1])
				direction = direction[parts[2]]
				self.request_elevator(( requests(floor, direction) ))

		while any(e.requests for e in self.elevators):
			self.step_all()

	def get_elevator_floor(self, eid: int) -> int :
		return self.elevators[eid].current_floor

	def get_elevator_state(self, eid: int) -> elevator_state:
		return self.elevators[eid].state

	def get_elevator_direction(self,eid: int) -> direction:
		return self.elevators[eid].direction


