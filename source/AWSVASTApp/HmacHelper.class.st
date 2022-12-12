Class {
	#name : 'HmacHelper',
	#superclass : 'Object',
	#instVars : [
		'function',
		'key'
	],
	#category : 'AWSVASTApp'
}

{ #category : 'api' }
HmacHelper >> digestMessage: aMessage [

	^OSSslMac hmac digest: aMessage key: self key using: self function
]

{ #category : 'accessing' }
HmacHelper >> function [
	^function
]

{ #category : 'accessing' }
HmacHelper >> function: anObject [
	function := anObject
]

{ #category : 'accessing' }
HmacHelper >> key [
	^key
]

{ #category : 'accessing' }
HmacHelper >> key: anObject [
	key := anObject
]
