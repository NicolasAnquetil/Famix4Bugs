printing
mooseNameOn: stream 
	
	self name ifNotNil: 
		[stream nextPutAll: 'bug:' , self bugID ]