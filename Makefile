

.PHONY: build

test:
	sleep 1 && google-chrome http://localhost:4000 &
	jekyll serve -w --drafts

build:
	jekyll build

upload: clean build
	rsync -avzt _site/ exekias.me:/srv/apache/exekias.me

clean:
	rm -rf _site
