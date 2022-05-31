# Create a Jekyll container from a ruby alpine image

# At a minimum, use Ruby 2.5 or later
FROM ruby:2.7-alpine3.16

# Add Jekyll dependencies to alpine
RUN apk update
RUN apk add --no-cache build-base gcc cmake git

# Update the ruby bundler and install Jekyll
RUN gem update bundler && gem install bundler jekyll