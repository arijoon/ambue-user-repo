defmodule Ambune.FormsTest do
  use Ambune.DataCase

  alias Ambune.Forms

  describe "forms" do
    alias Ambune.Forms.Form

    @valid_attrs %{content: "some content", user_uuid: "some user_uuid"}
    @update_attrs %{content: "some updated content", user_uuid: "some updated user_uuid"}
    @invalid_attrs %{content: nil, user_uuid: nil}

    def form_fixture(attrs \\ %{}) do
      {:ok, form} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Forms.create_form()

      form
    end

    test "list_forms/0 returns all forms" do
      form = form_fixture()
      assert Forms.list_forms() == [form]
    end

    test "get_form!/1 returns the form with given id" do
      form = form_fixture()
      assert Forms.get_form!(form.id) == form
    end

    test "create_form/1 with valid data creates a form" do
      assert {:ok, %Form{} = form} = Forms.create_form(@valid_attrs)
      assert form.content == "some content"
      assert form.user_uuid == "some user_uuid"
    end

    test "create_form/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Forms.create_form(@invalid_attrs)
    end

    test "update_form/2 with valid data updates the form" do
      form = form_fixture()
      assert {:ok, %Form{} = form} = Forms.update_form(form, @update_attrs)
      assert form.content == "some updated content"
      assert form.user_uuid == "some updated user_uuid"
    end

    test "update_form/2 with invalid data returns error changeset" do
      form = form_fixture()
      assert {:error, %Ecto.Changeset{}} = Forms.update_form(form, @invalid_attrs)
      assert form == Forms.get_form!(form.id)
    end

    test "delete_form/1 deletes the form" do
      form = form_fixture()
      assert {:ok, %Form{}} = Forms.delete_form(form)
      assert_raise Ecto.NoResultsError, fn -> Forms.get_form!(form.id) end
    end

    test "change_form/1 returns a form changeset" do
      form = form_fixture()
      assert %Ecto.Changeset{} = Forms.change_form(form)
    end
  end
end
