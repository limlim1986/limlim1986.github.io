# limlim1986.github.io

## Running Locally
To run this blog locally you should use visual studio code with dev containers. To get started with dev containers make sure to follow the official guide https://code.visualstudio.com/docs/remote/containers

Once you have dev containers set up and running you should run the following commands from a terminal connected to the container:

```sh
bundle install
bundle exec jekyll serve --livereload --draft
```

The site should start at http://localhost:4000 and any changes should be automatically reloaded on save.

## Writing Posts
When writing posts you can put them in the `_drafts` folder until the point you feel ready with the post.
You should then move it to the `_posts` folder

Post filenames should always follow the same format __YYYY-MM-DD-name-of-post.markdown__.

example: __2021-05-12-my-blog-post.markdown__