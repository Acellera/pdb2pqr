.PHONY: release

VERSION_FILE := pdb2pqr/_version.py

# Bump the version in _version.py, commit and push it, then create and push the
# matching tag. Committing the bump *before* tagging guarantees the tag and
# _version.py can never drift apart. The deploy workflow fires on the tag and
# publishes acellera-pdb2pqr to PyPI and the acellera conda channel.
#
#   make release version=3.7.1        # first release of an upstream version
#   make release version=3.7.1.post1  # Acellera-only re-release (PEP 440 .postN)
release:
ifndef version
	$(error usage: make release version=X.Y.Z[.postN])
endif
	python -c "import re, pathlib; p = pathlib.Path('$(VERSION_FILE)'); p.write_text(re.sub(r'__version__ = .*', '__version__ = \"$(version)\"', p.read_text()))"
	git add $(VERSION_FILE)
	git commit -m "Release $(version)"
	git push
	git tag -a "v$(version)" -m "Release $(version)"
	git push origin "v$(version)"
