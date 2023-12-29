defmodule TimecopsyncCrudWeb.TimerControllerTest do
  use TimecopsyncCrudWeb.ConnCase

  import TimecopsyncCrud.ProjectsFixtures

  alias TimecopsyncCrud.Projects.Timer

  @create_attrs %{

  }
  @update_attrs %{

  }
  @invalid_attrs %{}

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "index" do
    test "lists all timers", %{conn: conn} do
      conn = get(conn, ~p"/api/timers")
      assert json_response(conn, 200)["data"] == []
    end
  end

  describe "create timer" do
    test "renders timer when data is valid", %{conn: conn} do
      conn = post(conn, ~p"/api/timers", timer: @create_attrs)
      assert %{"id" => id} = json_response(conn, 201)["data"]

      conn = get(conn, ~p"/api/timers/#{id}")

      assert %{
               "id" => ^id
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, ~p"/api/timers", timer: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "update timer" do
    setup [:create_timer]

    test "renders timer when data is valid", %{conn: conn, timer: %Timer{id: id} = timer} do
      conn = put(conn, ~p"/api/timers/#{timer}", timer: @update_attrs)
      assert %{"id" => ^id} = json_response(conn, 200)["data"]

      conn = get(conn, ~p"/api/timers/#{id}")

      assert %{
               "id" => ^id
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn, timer: timer} do
      conn = put(conn, ~p"/api/timers/#{timer}", timer: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "delete timer" do
    setup [:create_timer]

    test "deletes chosen timer", %{conn: conn, timer: timer} do
      conn = delete(conn, ~p"/api/timers/#{timer}")
      assert response(conn, 204)

      assert_error_sent 404, fn ->
        get(conn, ~p"/api/timers/#{timer}")
      end
    end
  end

  defp create_timer(_) do
    timer = timer_fixture()
    %{timer: timer}
  end
end
