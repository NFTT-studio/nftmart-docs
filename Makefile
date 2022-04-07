push:
	sudo rm -r docs
	env RUSTDOCFLAGS="--default-theme=rust" mdbook build
	git -C docs add .
	git -C docs branch -D gh-pages
	git -C docs checkout -b gh-pages
	git -C docs commit -m 'make'
	git -C docs push -fu origin gh-pages
