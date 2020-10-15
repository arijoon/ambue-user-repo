defmodule Ambune.Forms.Form do
  use Ecto.Schema
  import Ecto.Changeset

  schema "forms" do
    field :content, :string
    field :user_uuid, :string

    timestamps()
  end

  @doc false
  def changeset(form, attrs) do
    form
    |> cast(transform_attrs(attrs), [:content, :user_uuid])
    |> validate_required([:content, :user_uuid])
  end

  def transform_attrs(attrs) do
    attrs
    |> Map.update!(:content, &Jason.encode!/1)
  end
end
