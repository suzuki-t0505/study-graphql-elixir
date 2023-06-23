defmodule CommunityWeb.Schema do
  use Absinthe.Schema

  import_types(Community.Objects)

  mutation do
    # link
    import_fields :link_mutations

    import_fields :account_mutations
  end

  query do
    # link
    import_fields :link_queries

    import_fields :account_queries
  end
end
