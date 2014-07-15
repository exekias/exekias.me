

.PHONY: build

test:
	sleep 1 && google-chrome http://localhost:4000 &
	jekyll serve -w

build:
	jekyll build

upload: build
	rsync -avzt _site/ exekias.me:/srv/apache/exekias.me
