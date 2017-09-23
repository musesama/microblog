defmodule MicroblogWeb.PageController do
  use MicroblogWeb, :controller

  def index(conn, _params) do
    render conn, "index.html"
  end
end
