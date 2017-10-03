defmodule MicroblogWeb.PageController do
  use MicroblogWeb, :controller

  def index(conn, _params) do
    redirect conn, to: post_path(conn, :index)
  end
end
