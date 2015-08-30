defmodule Slack do
  use HTTPoison.Base

  def send_test(user) do
    url = "https://#{user.slack_domain}.slack.com/services/hooks/slackbot"
    message = "Congratulations! You've correctly configured Plops!"
    params = %{ token: user.slackbot_token, channel: "@#{user.slack_username}" }
    post!(url, message, [], params: params)
  end


  # defp process_url(url) do
  #   "https://api.github.com/" <> url
  # end
  #
  # defp process_response_body(body) do
  #   body
  #   |> Poison.decode!
  # end
end
