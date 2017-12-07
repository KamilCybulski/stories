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

    get "/", PostController, :index
    resources "/posts", PostController,
      only: [:new, :create, :edit, :update, :delete, :show]
    resources "/users", UserController, only: [:new, :create, :show]
    resources "/sessions", SessionController, only: [:new, :create, :delete]
  end

  # Other scopes may use custom stacks.
  # scope "/api", StoriesWeb do
  #   pipe_through :api
  # end
end
