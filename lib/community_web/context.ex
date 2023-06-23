defmodule CommunityWeb.Context do
  @behaviour Plug

  import Plug.Conn
  alias Community.Accounts

  def init(opts), do: opts

  def call(conn, _) do
    context = build_context(conn)
    # %Plug.Connに%{context: context}を登録する
    Absinthe.Plug.put_options(conn, context: context)
  end

  defp build_context(conn) do
    # %Plug.Connのreq_headersから"authorization"の値を取り出す
    # リクエストを送る際はヘッダー(authorization)も一緒に送る必要がある
    # graphqlの標準ではbinaryを扱えないのでBase.encode32/1でstringに変換しているため、Base.decode32/1でbinaryに戻している
    with [token] <- get_req_header(conn, "authorization"),
      {:ok, token} <- Base.decode32(token),
      {:ok, current_account} <- authorize(token) do
        %{current_account: current_account, token: token}
    else
        _ -> %{}
    end
  end

  defp authorize(token) do
    case Accounts.get_account_by_session_token(token) do
      nil -> {:error, "invalid authorization token"}
      account -> {:ok, account}
    end
  end
end
