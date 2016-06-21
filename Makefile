

.PHONY: build

test:
	sleep 1 && google-chrome http://localhost:4000 &
	jekyll serve -w --drafts

build:
	jekyll build

upload: clean build
	rsync -avzt --delete _site/ box.exekias.me:/home/user-data/www/default

clean:
	rm -rf _site
