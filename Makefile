.PHONY: all
all: helm-lint

CT_IMG ?= quay.io/helmpack/chart-testing:v3.5.0 
.PHONY: helm-lint
helm-lint: ### Lint Helm charts.
	docker run --rm --workdir /repo -v $(shell pwd):/repo $(CT_IMG) ct lint --config .github/config/ct.yml 
