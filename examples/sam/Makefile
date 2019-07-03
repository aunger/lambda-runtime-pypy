package:
	sam package \
		--template-file template.yml \
		--output-template-file packaged.yml \
		--s3-bucket pypy-examples-us-east-1 \
		--region us-east-1

deploy: package
	aws cloudformation deploy \
		--template-file packaged.yml \
		--stack-name pypy-example-sam \
		--capabilities CAPABILITY_IAM \
		--region us-east-1
