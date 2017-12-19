.PHONY: help virtualbox aws vagrant_up  vagrant_clean
.SILENT:

VERSION = 7.4
DISTRO = centos

help:
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}'


virtualbox: vagrant_clean ## build virtualbox image
		rm $(DISTRO)-$(VERSION)-x64-virtualbox.box 2>/dev/null; true
		packer build -only=virtualbox-iso centos7.json

aws: ## build aws image
	  packer build -only=amazon-ebs centos7.json

vagrant_up: ## starts the vagrant box
		vagrant up

vagrant_clean: ## stops and removes vagrant box
		vagrant destroy -f 2>/dev/null; true
		vagrant box remove file://$(DISTRO)-$(VERSION)-x64-virtualbox.box 2>/dev/null; true
		vagrant box list
