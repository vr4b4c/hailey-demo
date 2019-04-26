```
[vrabac - concept]$ mix phx.new hailey-demo --module Hailey --app hailey
* creating hailey-demo/config/config.exs
* creating hailey-demo/config/dev.exs
* creating hailey-demo/config/prod.exs
* creating hailey-demo/config/prod.secret.exs
* creating hailey-demo/config/test.exs
* creating hailey-demo/lib/hailey/application.ex
* creating hailey-demo/lib/hailey.ex
* creating hailey-demo/lib/hailey_web/channels/user_socket.ex
* creating hailey-demo/lib/hailey_web/views/error_helpers.ex
* creating hailey-demo/lib/hailey_web/views/error_view.ex
* creating hailey-demo/lib/hailey_web/endpoint.ex
* creating hailey-demo/lib/hailey_web/router.ex
* creating hailey-demo/lib/hailey_web.ex
* creating hailey-demo/mix.exs
* creating hailey-demo/README.md
* creating hailey-demo/.formatter.exs
* creating hailey-demo/.gitignore
* creating hailey-demo/test/support/channel_case.ex
* creating hailey-demo/test/support/conn_case.ex
* creating hailey-demo/test/test_helper.exs
* creating hailey-demo/test/hailey_web/views/error_view_test.exs
* creating hailey-demo/lib/hailey_web/gettext.ex
* creating hailey-demo/priv/gettext/en/LC_MESSAGES/errors.po
* creating hailey-demo/priv/gettext/errors.pot
* creating hailey-demo/lib/hailey/repo.ex
* creating hailey-demo/priv/repo/migrations/.formatter.exs
* creating hailey-demo/priv/repo/seeds.exs
* creating hailey-demo/test/support/data_case.ex
* creating hailey-demo/lib/hailey_web/controllers/page_controller.ex
* creating hailey-demo/lib/hailey_web/templates/layout/app.html.eex
* creating hailey-demo/lib/hailey_web/templates/page/index.html.eex
* creating hailey-demo/lib/hailey_web/views/layout_view.ex
* creating hailey-demo/lib/hailey_web/views/page_view.ex
* creating hailey-demo/test/hailey_web/controllers/page_controller_test.exs
* creating hailey-demo/test/hailey_web/views/layout_view_test.exs
* creating hailey-demo/test/hailey_web/views/page_view_test.exs
* creating hailey-demo/assets/webpack.config.js
* creating hailey-demo/assets/.babelrc
* creating hailey-demo/assets/css/app.css
* creating hailey-demo/assets/css/phoenix.css
* creating hailey-demo/assets/js/app.js
* creating hailey-demo/assets/js/socket.js
* creating hailey-demo/assets/package.json
* creating hailey-demo/assets/static/robots.txt
* creating hailey-demo/assets/static/images/phoenix.png
* creating hailey-demo/assets/static/favicon.ico

Fetch and install dependencies? [Yn] Y 
* running mix deps.get
* running cd assets && npm install && node node_modules/webpack/bin/webpack.js --mode development
* running mix deps.compile
    
We are almost there! The following steps are missing:

    $ cd hailey-demo
    $ cd assets && npm install && node node_modules/webpack/bin/webpack.js --mode development

Then configure your database in config/dev.exs and run:

    $ mix ecto.create

Start your Phoenix app with:

    $ mix phx.server

You can also run your app inside IEx (Interactive Elixir) as:

    $ iex -S mix phx.server
```
