defmodule CodeCorps.StripePlanTest do
  use CodeCorps.ModelCase

  alias CodeCorps.StripePlan

  @valid_attrs %{
    id_from_stripe: "abc123"
  }

  @invalid_attrs %{}

  describe "create_changeset/2" do
    test "reports as valid when attributes are valid" do
      project_id = insert(:project).id

      changes = Map.merge(@valid_attrs, %{project_id: project_id})
      changeset = StripePlan.create_changeset(%StripePlan{}, changes)
      assert changeset.valid?
    end

    test "reports as invalid when attributes are invalid" do
      changeset = StripePlan.create_changeset(%StripePlan{}, @invalid_attrs)
      refute changeset.valid?

      assert changeset.errors[:id_from_stripe] == {"can't be blank", []}
      assert changeset.errors[:project_id] == {"can't be blank", []}
    end

    test "ensures associations link to records that exist" do
      attrs =  @valid_attrs |> Map.merge(%{project_id: -1})

      { result, changeset } =
        StripePlan.create_changeset(%StripePlan{}, attrs)
        |> Repo.insert

      assert result == :error
      refute changeset.valid?
      assert changeset.errors[:project] == {"does not exist", []}
    end
  end
end
