set minimum-version := "1.55.0"
set default-list
set shell := ["bash", "-eu", "-o", "pipefail", "-c"]
set positional-arguments

# Add a package page: just add NAME OWNER/REPO
[group('site')]
[script('bash')]
add name repo:
    set -euo pipefail
    page="public/$1.html"
    if [ -e "$page" ]; then
        echo "already exists: $page" >&2
        exit 1
    fi
    cat > "$page" <<EOF
    <html><head>
    <meta name="go-import" content="go.withmatt.com/$1 git https://github.com/$2">
    <meta name="go-source" content="go.withmatt.com/$1 https://github.com/$2 https://github.com/$2/tree/main/{/dir} https://github.com/$2/tree/main{/dir}/{file}#L{line}">
    <meta http-equiv="refresh" content="0; url=https://github.com/$2">
    </head></html>
    EOF

# Remove a package page
[group('site')]
remove name:
    rm public/{{ name }}.html

# Install node dependencies (cf CLI)
[group('deps')]
deps:
    npm install

# Serve the site locally
[group('dev')]
dev *args:
    npx cf dev "$@"

# Deploy to Cloudflare
[group('deploy')]
deploy:
    npx cf deploy
