"
Famix Entity to represent a Bug
"
Class {
	#name : #FAMIXBugEntity,
	#superclass : #FAMIXEntity,
	#instVars : [
		'bugID',
		'openDate',
		'resolutionDate',
		'entities'
	],
	#category : 'Famix-Extensions-Bugs'
}

{ #category : #meta }
FAMIXBugEntity class >> annotation [
	<MSEClass: #BugEntity super: #FAMIXEntity>
	<package: #FAMIX>
	^self
]

{ #category : #accessing }
FAMIXBugEntity >> addEntity: anObject [
	entities add: anObject
]

{ #category : #accessing }
FAMIXBugEntity >> age [
	<MSEProperty: #age type: #Number> <derived>
	<MSEComment: 'Number of hours of this bug from opening to resolution'>
	^ (resolutionDate - openDate) asSeconds / 3600.
]

{ #category : #converting }
FAMIXBugEntity >> asString [
	
	^ self bugID 
]

{ #category : #accessing }
FAMIXBugEntity >> bugID [
	<MSEProperty: #bugID type: #String>
	<MSEComment: 'Unique ID of this bug in the issue tracker tool'>
	^ bugID
]

{ #category : #accessing }
FAMIXBugEntity >> bugID: anObject [
	name := anObject.
	bugID := anObject.
]

{ #category : #accessing }
FAMIXBugEntity >> entities [
	<MSEProperty: #entities type: #FAMIXContainerEntity opposite: #bugs> <multivalued>
	<MSEComment: 'All containerEntities that were modified for the correction of this bug'>
	^ entities
]

{ #category : #initialization }
FAMIXBugEntity >> initialize [

	super initialize.
	entities := FMMultiMultivalueLink on: self opposite: #bugs .

]

{ #category : #printing }
FAMIXBugEntity >> mooseNameOn: stream [ 
	
	self name ifNotNil: 
		[stream nextPutAll: 'bug:' , self bugID ]
]

{ #category : #accessing }
FAMIXBugEntity >> openDate [
	<MSEProperty: #openDate type: #String>
	<MSEComment: 'Date (year) this bug was opened'>
	^ openDate
]

{ #category : #accessing }
FAMIXBugEntity >> openDate: anObject [
	openDate := anObject
]

{ #category : #accessing }
FAMIXBugEntity >> resolutionDate [
	<MSEProperty: #resolutionDate type: #String>
	<MSEComment: 'Date (year) this bug was resolved'>
	^ resolutionDate
]

{ #category : #accessing }
FAMIXBugEntity >> resolutionDate: anObject [
	resolutionDate := anObject
]
