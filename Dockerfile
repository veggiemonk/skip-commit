FROM debian:stable-slim

LABEL "name"="skip-commit"
LABEL "maintainer"="Julien Bisconti <julien.bisconti@hotmail.com>"
LABEL "version"="1"

LABEL "com.github.actions.name"="Skip based on commit message"
LABEL "com.github.actions.description"="Common filters to stop workflows"
LABEL "com.github.actions.icon"="filter"
LABEL "com.github.actions.color"="gray-dark"

COPY LICENSE README.md /

RUN apt-get update && apt-get install --no-install-recommends -y \
      git && \
    apt-get clean -y && rm -rf /var/lib/apt/lists/*

COPY entrypoint.sh /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]
