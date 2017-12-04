defmodule StoriesWeb.Router do
  use StoriesWeb, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
    plug Stories.Plugs.SetUser
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", StoriesWeb do
    pipe_through :browser # Use the default browser stack

    get "/", PageController, :index
  end

  scope "/users", StoriesWeb do
    pipe_through :browser

    resources "/", UserController
  end

  # Other scopes may use custom stacks.
  # scope "/api", StoriesWeb do
  #   pipe_through :api
  # end
end
