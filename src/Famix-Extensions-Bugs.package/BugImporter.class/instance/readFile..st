run
readFile: aFileName

	| stream buffer |
	
	[stream := FileStream readOnlyFileNamed: aFileName.

		buffer := String new: stream size.
		[stream atEnd] whileFalse: [
			self parseBugLine: stream nextLine.
		]
	] ensure: [stream close].
	buffer.