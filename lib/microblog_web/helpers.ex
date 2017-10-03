defmodule MicroblogWeb.Helpers do
  def is_admin?(nil), do: false
  def is_admin?(user) do
    user.is_admin?
  end

  def nav_active?(view, text) do
    if String.contains?(to_string(view), text) do
      "active"
    else
      ""
    end
  end
end
