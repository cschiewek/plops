defmodule GitHub.Client do
  use HTTPoison.Base

  def notifications(token) do
    headers = %{ "Authorization" => "token #{token}" }
    get!("notifications", headers).body
  end

  def get_url(url, token) do
    headers = %{ "Authorization" => "token #{token}" }
    url = String.replace(url, "https://api.github.com/", "")
    get!(url, headers).body
  end

  def mark_as_read(token) do
    headers = %{ "Authorization" => "token #{token}" }
    put!("notifications", "{}", headers)
  end

  defp process_url(url) do
    "https://api.github.com/" <> url
  end

  defp process_response_body(body) do
    unless body == "" do
      body
      |> Poison.decode!
    end
  end
end
