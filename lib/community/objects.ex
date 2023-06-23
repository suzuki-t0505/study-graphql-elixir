defmodule Community.Objects do
  use Absinthe.Schema.Notation
  use Community.Objects.Link
  use Community.Objects.Account
end
