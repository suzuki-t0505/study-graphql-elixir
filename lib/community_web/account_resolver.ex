defmodule CommunityWeb.AccountResolver do
  alias Community.Accounts

  def current_account(_, _, %{context: %{current_account: current_account}}) do
    {:ok, Community.Accounts.get_account!(current_account.id)}
  end

  def current_account(_, _, %{context: %{}}) do
    {:error, "invalid authorization token"}
  end

  def get_account(_, %{id: id}, _) do
    {:ok, Community.Accounts.get_account!(id)}
  end

  def register_account(_, args, %{context: %{}}) do
    case Accounts.register_account(args) do
      {:ok, account} ->
        token = Accounts.generate_account_session_token(account) |> Base.encode32()
        {:ok, %{account: account, token: token}}
      {:error, _cs} ->
        {:error, "cloud not account"}
    end
  end

  def log_in_account(_, %{email: email, password: password}, %{context: %{}}) do
    case Accounts.get_account_by_email_and_password(email, password) do
      nil ->
        {:error, "no account"}

      account ->
        token = Accounts.generate_account_session_token(account) |> Base.encode32()
        {:ok, %{account: account, token: token}}
    end
  end

  def log_out_account(_, _, %{context: context}) do
    with %{token: token} <- context,
      Accounts.delete_account_session_token(token) do
        {:ok, %{info: "log out account"}}
      else
        _ -> {:error, "not token"}
    end
  end
end
