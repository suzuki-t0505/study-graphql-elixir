defmodule CommunityWeb.Schema do
  use Absinthe.Schema

  import_types(Community.Objects)

  alias CommunityWeb.AccountResolver

  # naive_datetimeが無いため文字列に変換するtypeを追加する
  scalar :naive_datetime do
    description "NaiveDatetime for 2022-03-01 00:00:00"
    parse &{:ok, NaiveDateTime.from_iso8601(&1)}
    serialize &Calendar.strftime(&1, "%c")
  end

  object :account do
    field :id, non_null(:id)
    field :email, non_null(:string)
    field :hashed_password, non_null(:string)
    field :confirmed_at, :naive_datetime
  end

  object :account_token do
    field :id, non_null(:id)
    field :token, non_null(:string)
    field :context, :string
    field :sent_to, :string
    field :account, :account
  end

  object :auto_play_load do
    field :account, :account
    field :token, :string
  end

  object :log_out_info do
    field :info, :string
  end

  mutation do
    # link
    import_fields :link_mutations

    @desc "register"
    field :register, :auto_play_load do
      arg :email, non_null(:string)
      arg :password, non_null(:string)
      resolve(&AccountResolver.register_account/3)
    end

    @desc "log_in"
    field :log_in, :auto_play_load do
      arg :email, non_null(:string)
      arg :password, non_null(:string)
      resolve(&AccountResolver.log_in_account/3)
    end

    @desc "log_out"
    field :log_out, :log_out_info do
      resolve(&AccountResolver.log_out_account/3)
    end
  end

  query do
    # link
    import_fields :link_queries

    field :account, :account do
      arg :id, non_null(:id)
      resolve(&AccountResolver.get_account/3)
    end

    @desc "Get a account"
    field :current_account, :account do
      resolve(&AccountResolver.current_account/3)
    end
  end
end
