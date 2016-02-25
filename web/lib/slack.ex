defmodule Slack do
  use HTTPoison.Base

  def send_test(user) do
    body = Poison.encode! %{ text: "Congratulations! You've correctly configured Plops!" }
    _send(user, body)
  end

  def send_notifications(user) do
    notifications = GitHub.notifications(user.access_token)
    unless Enum.empty?(notifications) do
      body = Poison.encode! %{ attachments: attachments(user, notifications) }
      _send(user, body)
      if user.mark_as_read, do: GitHub.mark_as_read(user.access_token)
    end
  end

  def send_to_enabled do
    for user <- Plops.User.enabled, do: Task.start(fn -> send_notifications(user) end)
  end

  defp _send(user, body) do
    params = %{ channel: "@#{user.slack_username}" }
    post!(user.slack_webhook_url, body, [], params: params)
  end

  defp attachments(user, notifications) do
    notifications
    |> Enum.map(fn(n) -> attachement(user, n) end)
  end

  defp attachement(user, notification) do
    subject = notification["subject"]
    html_url = GitHub.get_url(subject["url"], user.access_token)["html_url"]
    %{
      pretext: "*#{notification["repository"]["full_name"]}* #{subject["type"]}",
      title: "<#{html_url}|#{subject["title"]}>",
      text: Plops.UserView.latest_comment(notification, user),
      mrkdwn_in: ["text", "pretext"]
    }
  end
end
