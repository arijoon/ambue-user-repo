defmodule Ambune.Users.User do
  use Ecto.Schema
  import Ecto.Changeset

  schema "users" do
    field :email, :string
    field :name, :string

    timestamps()
  end

  @doc false
  def changeset(user, attrs) do
    user
    |> cast(attrs, [:email, :name])
    |> validate_required([:email, :name])
    |> validate_email()
  end

  def validate_email(changeset) do
    changeset
    |> update_change(:email, &String.downcase/1)
    |> unique_constraint(:email, message: "Email already registered")
    |> validate_format(:email, ~r/\S+@\S+\.\S+/, message: "Invalid email format")
  end
end
