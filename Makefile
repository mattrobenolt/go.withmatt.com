pkgs = \
	autopprof \
	connect-brotli \
	connect-etcd \
	connect-python \
	httpheaders \
	purpleair \
	randid \
	size

pages = $(addsuffix .html,$(pkgs))

all: archive.zip

$(pages): data.yaml _page.html
	jinja2 --strict -D pkg=$(basename $@) _page.html data.yaml -o $@

clean:
	rm -vf archive.zip
	rm -vf $(pages)

archive.zip: _headers index.html 404.html $(pages)
	zip $@ $^

.PHONY: all clean
