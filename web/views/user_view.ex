defmodule Plops.UserView do
  use Plops.Web, :view

  def latest_comment(notification, user) do
    GitHub.Client.get_url(notification["subject"]["latest_comment_url"], user.access_token)["body"]
  end

  def latest_comment_html(notification, user) do
    latest_comment(notification, user) |> Earmark.to_html |> raw
  end
  
  def html_url(notification, user) do
    GitHub.Client.get_url(notification["subject"]["url"], user.access_token)["html_url"]
  end

  def configured?(user) do
    user.slack_webhook_url && user.slack_username
  end
end
