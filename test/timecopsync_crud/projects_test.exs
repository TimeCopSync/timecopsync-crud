defmodule TimecopsyncCrud.ProjectsTest do
  use TimecopsyncCrud.DataCase

  alias TimecopsyncCrud.Projects

  describe "timers" do
    alias TimecopsyncCrud.Projects.Timer

    import TimecopsyncCrud.ProjectsFixtures

    @invalid_attrs %{}

    test "list_timers/0 returns all timers" do
      timer = timer_fixture()
      assert Projects.list_timers() == [timer]
    end

    test "get_timer!/1 returns the timer with given id" do
      timer = timer_fixture()
      assert Projects.get_timer!(timer.id) == timer
    end

    test "create_timer/1 with valid data creates a timer" do
      valid_attrs = %{}

      assert {:ok, %Timer{} = timer} = Projects.create_timer(valid_attrs)
    end

    test "create_timer/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Projects.create_timer(@invalid_attrs)
    end

    test "update_timer/2 with valid data updates the timer" do
      timer = timer_fixture()
      update_attrs = %{}

      assert {:ok, %Timer{} = timer} = Projects.update_timer(timer, update_attrs)
    end

    test "update_timer/2 with invalid data returns error changeset" do
      timer = timer_fixture()
      assert {:error, %Ecto.Changeset{}} = Projects.update_timer(timer, @invalid_attrs)
      assert timer == Projects.get_timer!(timer.id)
    end

    test "delete_timer/1 deletes the timer" do
      timer = timer_fixture()
      assert {:ok, %Timer{}} = Projects.delete_timer(timer)
      assert_raise Ecto.NoResultsError, fn -> Projects.get_timer!(timer.id) end
    end

    test "change_timer/1 returns a timer changeset" do
      timer = timer_fixture()
      assert %Ecto.Changeset{} = Projects.change_timer(timer)
    end
  end
end
