defmodule AmbuneWeb.UserLive.FormComponent do
  use AmbuneWeb, :live_component

  alias Ambune.Users
  alias Ambune.Forms
  import Logger

  @impl true
  def update(%{user: user, user_uuid: user_uuid, action: action} = assigns, socket) do

    form = Forms.get_form(user_uuid)
    changeset = user_change(action, user, form)

    {:ok,
     socket
     |> assign(assigns)
     |> assign(:form, form)
     |> assign(:changeset, changeset)}
  end


  @impl true
  def handle_event("save", %{"user" => user_params}, socket) do
    socket
    |> save_user(socket.assigns.action, user_params)
  end

  defp save_user(socket, :edit, user_params) do
    case Users.update_user(socket.assigns.user, user_params) do
      {:ok, user} ->
        {:noreply,
         socket
         |> put_flash(:info, "User updated successfully")
         |> assign(:changeset, Users.change_user(user))
        }

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, :changeset, changeset)}
    end
  end

  defp save_user(socket, :new, user_params) do
    case Users.create_user(user_params) do
      {:ok, _user} ->
        {:noreply,
         socket
         |> clear_form()
         |> put_flash(:info, "User created successfully")
         |> push_redirect(to: socket.assigns.return_to)}

      {:error, %Ecto.Changeset{} = changeset} ->
        update_form(socket, user_params)
        {:noreply, assign(socket, changeset: changeset)}
    end
  end

  defp clear_form(socket) do
    Forms.delete_form(socket.assigns.form)
    socket
  end

  defp update_form(socket, user_params) do
    Forms.update_form(socket.assigns.form, %{ content: user_params})
    socket
  end

  defp user_change(:new, user, form), do: Users.change_user(user, form.content)
  defp user_change(:edit, user, _form), do: Users.change_user(user)
end
