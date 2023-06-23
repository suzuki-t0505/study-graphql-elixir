defmodule CommunityWeb.Schema do
  use Absinthe.Schema

  import_types(Community.Objects)

  mutation do
    # link
    import_fields :link_mutations
  end

  query do
    # link
    import_fields :link_queries
  end
end
