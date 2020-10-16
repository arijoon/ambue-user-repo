defmodule Ambune.FormsTest do
  use Ambune.DataCase

  alias Ambune.Forms

  describe "forms" do
    alias Ambune.Forms.Form

    @valid_attrs %{content: %{}, user_uuid: "some user_uuid"}
    @update_attrs %{content: %{name: "something"}, user_uuid: "some updated user_uuid"}
    @invalid_attrs %{content: nil, user_uuid: nil}

    def form_fixture(attrs \\ %{}) do
      {:ok, form} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Forms.create_form()

      form
    end

    test "get_form/1 returns the form with given user_uuid" do
      form = form_fixture()
      assert Forms.get_form(form.user_uuid).user_uuid == form.user_uuid
    end

    test "create_form/1 with valid data creates a form" do
      assert {:ok, %Form{} = form} = Forms.create_form(@valid_attrs)
      assert form.content == "{}"
      assert form.user_uuid == @valid_attrs.user_uuid
    end

    test "create_form/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Forms.create_form(@invalid_attrs)
    end

    test "update_form/2 with valid data updates the form" do
      form = form_fixture()
      assert {:ok, %Form{} = form} = Forms.update_form(form, @update_attrs)
      assert form.content == Jason.encode!(@update_attrs.content)
      assert form.user_uuid == @update_attrs.user_uuid
    end

    test "change_form/1 returns a form changeset" do
      form = form_fixture()
      assert %Ecto.Changeset{} = Forms.change_form(form, %{ content: %{ name: "something new"}})
    end
  end
end
