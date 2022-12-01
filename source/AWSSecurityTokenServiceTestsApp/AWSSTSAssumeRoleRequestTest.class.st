Class {
	#name : 'AWSSTSAssumeRoleRequestTest',
	#superclass : 'TestCase',
	#category : 'AWSSecurityTokenServiceTestsApp'
}

{ #category : 'tests' }
AWSSTSAssumeRoleRequestTest >> testAsHttpRequest [

	| httpRequest |
	httpRequest := AWSSTSAssumeRoleRequest new
		               webIdentityToken: 'JWTToken';
		               roleArn: 'anAWSRoleArn';
		               roleSessionName: 'pharoSmalltalk';
		               policyArns: (OrderedCollection new
				                add: 'Hello';
				                add: 'Hello2';
				                yourself);
		               asHttpRequest: 'http://aws.test.url' asUrl.

	self
		assert: httpRequest url asString
		equals:
		'http://aws.test.url/?Action=AssumeRoleWithWebIdentity&Version=2011-06-15&RoleSessionName=pharoSmalltalk&RoleArn=anAWSRoleArn&WebIdentityToken=JWTToken&PolicyArns.member.1.arn=Hello&PolicyArns.member.2.arn=Hello2'
]
