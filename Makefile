all:
	docker build . -t lyrics-builder -t cwongloising/lyrics-builder
	docker push cwongloising/lyrics-builder