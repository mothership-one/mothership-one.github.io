FROM starefossen/ruby-node:2-4

ENV GITHUB_GEM_VERSION 91

RUN mkdir -p /usr/src/app
WORKDIR /usr/src/app

RUN gem install --no-document \
  github-pages:${GITHUB_GEM_VERSION} \
  jekyll-github-metadata

RUN gem install html-proofer jekyll-paginate

EXPOSE 4000
CMD jekyll serve -d /_site --watch --force_polling -H 0.0.0.0 -P 4000
