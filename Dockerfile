FROM ruby:2.3 as base

ADD docs-book/Gemfile* /tmp/
WORKDIR /tmp
RUN bundle install

from base as app

RUN mkdir -p /workspace/docs-book
RUN mkdir /workspace/docs-content 
RUN mkdir /workspace/docs-layout

COPY ./docs-book /workspace/docs-book
COPY ./docs-content /workspace/docs-content
COPY ./docs-layout /workspace/docs-layout
RUN ls -l /workspace

WORKDIR /workspace/docs-book

EXPOSE 4567

ENTRYPOINT ["bundle", "exec", "bookbinder"]


#docker run -it -p 4567:4567 -p 35729:35729 --workdir "/workspace/${PWD##*/}" -v $(pwd)/..:/workspace  ${image_tag} "$@"

