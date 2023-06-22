alias Community.News.Link
alias Community.Repo



links =
  [
    %Link{url: "http://graphql.org/", description: "The Best Query Language"},
    %Link{url: "http://dev.apollodata.com/", description: "Awesome GraphQL Client"}
  ]

Enum.each(links, fn link -> Repo.insert!(link) end)
