APP_VERSION:="0.0.1-SNAPSHOT"
SPRING_BOOT_VERSION:="1.5.9.RELEASE"
SPRING_CLOUD_FUNCTION_VERSION:="1.0.0.BUILD-SNAPSHOT"
JAVA_APP_NAME:="com.redhat.developers.greeter.GreeterApplication"
FUNCTION_NAME:="greeter"

build:
	./mvnw clean install

.PHONY: docker
docker:
	docker build --rm \
	--build-arg APP_VERSION=$(APP_VERSION) \
	--build-arg SPRING_BOOT_VERSION=$(SPRING_BOOT_VERSION) \
	--build-arg SPRING_CLOUD_FUNCTION_VERSION=$(SPRING_CLOUD_FUNCTION_VERSION) \
	--build-arg JAVA_APP_NAME=$(JAVA_APP_NAME) \
	--build-arg FUNCTION_NAME=$(FUNCTION_NAME) \
	--tag kameshsampath/ow-scf-greeter .

.PHONY: docker-clean-all

clean: 
	-docker rmi kameshsampath/ow-scf-greeter ;\
	./mvnw clean

.PHONY: fn-create-greeter
fn-create-greeter:
	wsk -i action create greeter --docker kameshsampath/ow-scf-greeter

.PHONY: fn-update-greeter
fn-update-greeter:
	wsk -i action create greeter --docker kameshsampath/ow-scf-greeter


.PHONY: test
test:
	wsk -i action invoke greeter -p payload spring --result