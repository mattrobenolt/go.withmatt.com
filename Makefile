pkgs = \
	autopprof \
	connect-brotli \
	connect-etcd \
	connect-python \
	httpheaders \
	purpleair \
	randid \
	size \
	fasttime \
	metrics \
	metrics-speedups \
	murl

misc = _headers index.html 404.html

pages = $(addprefix out/,$(addsuffix .html,$(pkgs)))
static = $(addprefix out/,$(misc))

project-name = go-withmatt-com

wrangler = bunx wrangler@4.10.0 \
             --project-name=$(project-name) \
             --commit-dirty=true

all: $(pages) $(static)

$(pages): data.yaml _page.html
	@mkdir -p out
	jinja2 --strict -D pkg=$(basename $(notdir $@)) _page.html data.yaml -o $@

$(static): $(notdir $(static))
	@mkdir -p out
	cp $(notdir $@) $@

deploy: all
	$(wrangler) pages deploy out/

clean:
	rm -rvf out

.PHONY: all clean deploy
