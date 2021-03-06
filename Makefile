
MPATH=/usr/local/opt/gnu-tar/libexec/gnubin:$(PATH)
IMAGE=dotnetderek/freeling41
BUILDTAG=v0
PUBLITAG=pub
DOCKERCFG=dependencies.docker freeling.docker locale.docker


Dockerfile-es: Dockerfile.m4 $(DOCKERCFG) python.docker pyfreeling.docker es-config.docker
	svn export --force -q https://github.com/TALP-UPC/FreeLing.git/tags/4.1/APIs/common APIs/common
	svn export --force -q https://github.com/TALP-UPC/FreeLing.git/tags/4.1/APIs/java APIs/java
	m4 Dockerfile.m4 > Dockerfile-es

build-es: Dockerfile-es
	docker build -t $(IMAGE)-ru:$(BUILDTAG) -f Dockerfile-es .
	touch build-es


clean:
	rm -f Dockerfile-es build-es squash-es


## because docker-squash must run as root it asks its password
squash-es: build-es
	$(eval IMAGEID = $(shell docker images -q $(IMAGE)-es:$(BUILDTAG))) \
	docker save $(IMAGEID) | \
	PATH=$(MPATH) sudo docker-squash -t $(IMAGE)-ru:$(PUBLITAG) |  \
	docker load
	touch squash-es

publish-es: squash-es
	docker push $(IMAGE)-es:$(PUBLITAG)
