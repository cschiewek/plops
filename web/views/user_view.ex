defmodule Plops.UserView do
  use Plops.Web, :view

  def latest_comment(notification, user) do
    GitHub.Client.get_url(notification["subject"]["latest_comment_url"], user.access_token)["body"]
  end
end
