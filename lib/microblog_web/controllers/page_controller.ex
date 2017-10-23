defmodule MicroblogWeb.PageController do
  use MicroblogWeb, :controller

  def index(conn, _params) do
    if conn.assigns[:current_user] do
      redirect conn, to: post_path(conn, :index)
    else
      redirect conn, to: user_path(conn, :new)
    end
  end
end
