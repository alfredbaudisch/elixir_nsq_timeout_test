defmodule NsqPublisher.Router do
  use NsqPublisher.Web, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/api", NsqPublisher do
    pipe_through :api
    post "/messages", MessagesController, :create
    get "/publish", MessagesController, :publish
  end
end
