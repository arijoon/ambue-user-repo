defmodule AmbuneWeb.UserLive.Index do
  use AmbuneWeb, :live_view

  alias Ambune.Users
  alias Ambune.Users.User

  @impl true
  def mount(_params, %{"user_uuid" => user_uuid}, socket) do
    {:ok, socket
      |> assign(:users, list_users())
      |> assign(:user_uuid, user_uuid)}
  end

  @impl true
  def handle_params(params, _url, socket) do
    {:noreply, apply_action(socket, socket.assigns.live_action, params)}
  end

  defp apply_action(socket, :edit, %{"id" => id}) do
    socket
    |> assign(:page_title, "Edit User")
    |> assign(:user, Users.get_user!(id))
  end

  defp apply_action(socket, :new, _params) do
    socket
    |> assign(:page_title, "New User")
    |> assign(:user, %User{})
  end

  defp apply_action(socket, :index, _params) do
    socket
    |> assign(:page_title, "Listing Users")
    |> assign(:user, nil)
  end

  @impl true
  def handle_event("delete", %{"id" => id}, socket) do
    user = Users.get_user!(id)
    {:ok, _} = Users.delete_user(user)

    {:noreply, assign(socket, :users, list_users())}
  end

  defp list_users do
    Users.list_users()
  end
end
