defmodule CommunityWeb.NewsResolver do
  alias Community.News

  def all_links(_root, _args, _info) do
    {:ok, News.list_links}
  end

  def get_link(_root, %{id: id}, _info) do
    case News.get_link(id) do
      nil ->
        {:error, "Link ID #{id} not found"}

      link ->
        {:ok, link}
    end
  end

  def create_link(_root, args, _info) do
    case News.create_link(args) do
      {:ok, link} ->
        {:ok, link}

      {:error, _cs} ->
        {:error, "could not create link"}
    end
  end

  def update_link(_root, %{id: id} = args, _info) do
    params = Map.delete(args, :id)

    case News.get_link(id) do
      nil ->
        {:error, "Link ID #{args.id} not found"}

      link ->
        case News.update_link(link, params) do
          {:ok, link} ->
            {:ok, link}

          {:error, _cs} ->
            {:error, "Could not update link"}
        end
    end
  end

  def delete_link(_root, %{id: id}, _info) do
    case News.get_link(id) do
      nil ->
        {:error, "Link ID #{id} not found"}

      link ->
        case News.delete_link(link) do
          {:ok, link} ->
            {:ok, link}

          {:error, _cs} ->
            {:error, "Could not delete link"}
        end
    end
  end
end
