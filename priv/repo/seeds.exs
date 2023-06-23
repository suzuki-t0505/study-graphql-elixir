alias Community.News.Link
alias Community.Accounts.Account
alias Community.Repo


# link
links =
  [
    %Link{url: "http://graphql.org/", description: "The Best Query Language"},
    %Link{url: "http://dev.apollodata.com/", description: "Awesome GraphQL Client"}
  ]

Enum.each(links, &Repo.insert/1)

# accounts
~w(user01 user02 user03 user04 user05)
|> Enum.map(fn name ->
  %Account{
    email: name <> "@sample.com",
    hashed_password: Bcrypt.hash_pwd_salt(name <> "999"),
    confirmed_at: NaiveDateTime.utc_now() |> NaiveDateTime.truncate(:second)
  }
end)
|> Enum.each(&Repo.insert/1)
