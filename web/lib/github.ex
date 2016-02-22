defmodule GitHub do
  @moduledoc """
  An OAuth2 strategy for GitHub.
  """
  use OAuth2.Strategy
  alias OAuth2.Strategy.AuthCode

  # Public API
  def new do
    url = Application.get_env(:plops, Plops.Endpoint)[:url]
    github = Application.get_env(:plops, Plops.Endpoint)[:github]
    scheme = Application.get_env(:plops, Plops.Endpoint)[:url][:port] == 443 && "https" || "http"
    OAuth2.Client.new([
      strategy: __MODULE__,
      client_id: github[:id], client_secret: github[:secret],
      redirect_uri: "#{scheme}://#{url[:host]}:#{url[:port]}/authentication/callback",
      site: "https://api.github.com",
      authorize_url: "https://github.com/login/oauth/authorize",
      token_url: "https://github.com/login/oauth/access_token"
    ])
  end

  def authorize_url!(params \\ []) do
    OAuth2.Client.authorize_url!(new(), params)
  end

  def get_token!(params \\ [], headers \\ []) do
    OAuth2.Client.get_token!(new(), params)
  end

  # Strategy Callbacks
  def authorize_url(client, params) do
    AuthCode.authorize_url(client, params)
  end

  def get_token(client, params, headers) do
    client
    |> put_header("Accept", "application/json")
    |> AuthCode.get_token(params, headers)
  end
end
