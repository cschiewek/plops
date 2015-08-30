defmodule GitHub.Client do
  use HTTPoison.Base

  def notifications(token) do
    headers = %{ "Authorization" => "token #{token}" }
    get!("notifications", headers).body[:data]
  end

  defp process_url(url) do
    "https://api.github.com/" <> url
  end

  defp process_response_body(body) do
    body
    |> Poison.decode!
    |> Enum.map(fn({k, v}) -> {String.to_atom(k), v} end)
  end
end
