push:
	rm -r docs
	mdbook build
	git -C docs commit -am 'init'
	git -C docs push -f origin gh-pages
