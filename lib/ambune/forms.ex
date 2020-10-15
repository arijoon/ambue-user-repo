defmodule Ambune.Forms do
  @moduledoc """
  The Forms context.
  """

  import Ecto.Query, warn: false
  alias Ambune.Repo

  alias Ambune.Forms.Form
  alias Ambune.Forms

  @doc """
  Gets a single form by user_uuid
  """
  def get_form(user_uuid) do
    form = case Repo.get_by(Form, user_uuid: user_uuid) do
      nil ->
        {:ok, form } = Forms.create_form(%{content: %{}, user_uuid: user_uuid})
        form
      form ->
        form
    end

    form
    |> Map.update!(:content, &Jason.decode!/1)
  end

  @doc """
  Creates a form.

  ## Examples

      iex> create_form(%{field: value})
      {:ok, %Form{}}

      iex> create_form(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_form(attrs \\ %{}) do
    %Form{}
    |> Form.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a form.

  ## Examples

      iex> update_form(form, %{field: new_value})
      {:ok, %Form{}}

      iex> update_form(form, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_form(%Form{} = form, attrs) do
    form
    |> Form.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a form.

  ## Examples

      iex> delete_form(form)
      {:ok, %Form{}}

      iex> delete_form(form)
      {:error, %Ecto.Changeset{}}

  """
  def delete_form(%Form{} = form) do
    Repo.delete(form)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking form changes.

  ## Examples

      iex> change_form(form)
      %Ecto.Changeset{data: %Form{}}

  """
  def change_form(%Form{} = form, attrs \\ %{}) do
    Form.changeset(form, attrs)
  end
end
