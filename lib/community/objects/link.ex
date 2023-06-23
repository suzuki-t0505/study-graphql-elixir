defmodule Community.Objects.Link do
  alias CommunityWeb.NewsResolver
  
  defmacro __using__(_) do
    quote do
      object :link do
        field :id, non_null(:id)
        field :url, non_null(:string)
        field :description, non_null(:string)
      end

      object :link_queries do
        @desc "Get all links"
        field :all_links, list_of(non_null(:link)) do
          resolve(&NewsResolver.all_links/3)
        end

        @desc "Get a link"
        field :link, :link do
          arg :id, non_null(:id)
          resolve(&NewsResolver.get_link/3)
        end
      end

      object :link_mutations do
        @desc "Create a new link"
        field :create_link, :link do
          arg :url, non_null(:string)
          arg :description, non_null(:string)

          resolve(&NewsResolver.create_link/3)
        end

        @desc "Update a link"
        field :update_link, :link do
          arg :id, non_null(:id)
          arg :url, :string
          arg :description, :string

          resolve(&NewsResolver.update_link/3)
        end

        @desc "Delete a link"
        field :delete_link, :link do
          arg :id, non_null(:id)

          resolve(&NewsResolver.delete_link/3)
        end
      end
    end
  end
end
