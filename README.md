# Community

To start your Phoenix server:

  * Run `mix setup` to install and setup dependencies
  * Start Phoenix endpoint with `mix phx.server` or inside IEx with `iex -S mix phx.server`

Now you can visit [`localhost:4000`](http://localhost:4000) from your browser.

Ready to run in production? Please [check our deployment guides](https://hexdocs.pm/phoenix/deployment.html).

## Learn more

  * Official website: https://www.phoenixframework.org/
  * Guides: https://hexdocs.pm/phoenix/overview.html
  * Docs: https://hexdocs.pm/phoenix
  * Forum: https://elixirforum.com/c/phoenix-forum
  * Source: https://github.com/phoenixframework/phoenix

## curl

```bash
$ curl http://localhost:4000 -H 'Content-Type: application/json' -d '{"query":"{allLists{id url description}}"}'

$ curl http://localhost:4000 \
  -H 'Content-Type: application/json' \
  -d '{"query":"mutation{createLink(url:\"http://localhost:4000\" description:\"localhost\"){id url description}}"}'

$ curl http://localhost:4000 \
  -H 'Content-Type: application/json' \
  -d '{"query":"{link(id:\"1\"){id url description}}"}'

$ curl http://localhost:4000 \
  -H 'Content-Type: application/json' \
  -d '{"query":"mutation{updateLink(id:\"1\" url:\"http://localhost:3000\" description:\"node.js server\"){id url description}}"}'

$ curl http://localhost:4000 \
  -H 'Content-Type: application/json' \
  -d '{"query":"mutation{deleteLink(id:\"1\"){id url description}}"}'

alias
$ curl http://localhost:4000 \
  -H 'Content-Type: application/json' \
  -d '{"query":"{first:link(id:\"1\"){id url}second:link(id:\"2\"){id url}}"}'
```

## graphiql

[http://localhost:4000/graphiql](http://localhost:4000/graphiql)

```
{
  allLists{
    id
    url
    description
  }
}
```

```
mutation{
  createLink(
    url: "http://localhost:4000",
    description: "localhost"
  ){
    id
    url
    description
  }
}
```

```
{
  link(id: "1")
  {
    id
    url
    description
  }
}