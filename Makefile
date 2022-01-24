ifndef version
$(error version variable is not set. Call with `make release version=XXX`)
endif

release:
	git checkout acellera_conda
	git fetch
	git pull
	git tag -a $(version) -m "$(version) release"
	git push --tags origin $(version)
