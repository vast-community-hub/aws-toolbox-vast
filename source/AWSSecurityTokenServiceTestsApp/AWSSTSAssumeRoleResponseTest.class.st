Class {
	#name : 'AWSSTSAssumeRoleResponseTest',
	#superclass : 'TestCase',
	#category : 'AWSSecurityTokenServiceTestsApp'
}

{ #category : 'tests' }
AWSSTSAssumeRoleResponseTest >> testFromXmlString [
	|response |
	
	response := AWSSTSAssumeRoleResponse fromXmlString: self xmlResponseString.
	self assert: response result credentials sessionToken equals: 'AQoDYXdzEE0a8ANXXXXXXXXNO1ewxE5TijQyp+IEXAMPLE'
]

{ #category : 'resources' }
AWSSTSAssumeRoleResponseTest >> xmlResponseString [
	^ '<AssumeRoleWithWebIdentityResponse xmlns="https://sts.amazonaws.com/doc/2011-06-15/">
  <AssumeRoleWithWebIdentityResult>
	<SubjectFromWebIdentityToken>amzn1.account.AF6RHO7KZU5XRVQJGXK6HB56KR2A</SubjectFromWebIdentityToken>
	<Audience>client.5498841531868486423.1548@apps.example.com</Audience>
	<AssumedRoleUser>
	  <Arn>arn:aws:sts::123456789012:assumed-role/FederatedWebIdentityRole/app1</Arn>
	  <AssumedRoleId>AROACLKWSDQRAOEXAMPLE:app1</AssumedRoleId>
	</AssumedRoleUser>
	<Credentials>
	  <SessionToken>AQoDYXdzEE0a8ANXXXXXXXXNO1ewxE5TijQyp+IEXAMPLE</SessionToken>
	  <SecretAccessKey>wJalrXUtnFEMI/K7MDENG/bPxRfiCYzEXAMPLEKEY</SecretAccessKey>
	  <Expiration>2014-10-24T23:00:23Z</Expiration>
	  <AccessKeyId>ASgeIAIOSFODNN7EXAMPLE</AccessKeyId>
	</Credentials>
	<SourceIdentity>SourceIdentityValue</SourceIdentity>
	<Provider>www.amazon.com</Provider>
  </AssumeRoleWithWebIdentityResult>
  <ResponseMetadata>
	<RequestId>ad4156e9-bce1-11e2-82e6-6b6efEXAMPLE</RequestId>
  </ResponseMetadata>
</AssumeRoleWithWebIdentityResponse>'
]
