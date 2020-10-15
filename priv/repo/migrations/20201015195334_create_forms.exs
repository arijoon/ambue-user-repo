defmodule Ambune.Repo.Migrations.CreateForms do
  use Ecto.Migration

  def change do
    create table(:forms) do
      add :content, :string
      add :user_uuid, :string

      timestamps()
    end

    create unique_index(:forms, :user_uuid)

  end
end
