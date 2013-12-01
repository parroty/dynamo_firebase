defmodule ApplicationRouter do
  use Dynamo.Router
  filter Dynamo.Filters.MethodOverride

  prepare do
    conn = conn.fetch([:cookies, :params])
    conn.assign :layout, "main"
  end

  @doc "index"
  get "/" do
    conn = conn.assign(:items, Repo.Weather.all)
    render conn, "index.html"
  end

  @doc "new"
  get "/new" do
    conn = conn.assign(:weather, Weather.new)
    render conn, "new.html"
  end

  @doc "show"
  get "/:id" do
    conn = conn.assign(:weather, get_weather_by_id(conn))
    render conn, "show.html"
  end

  @doc "edit"
  get "/:id/edit" do
    conn = conn.assign(:weather, get_weather_by_id(conn))
    render conn, "edit.html"
  end

  @doc "create"
  post "/" do
    params = Dict.get(conn.params, :weather) |> parse_weather
    Weather.new(params) |> Repo.Weather.create
    redirect conn, to: "/"
  end

  @doc "update"
  put "/:id" do
    params  = Dict.get(conn.params, :weather) |> parse_weather
    get_weather_by_id(conn).update(params) |> Repo.Weather.update
    redirect conn, to: "/"
  end

  @doc "destroy"
  delete "/:id" do
    get_weather_by_id(conn) |> Repo.Weather.delete
    redirect conn, to: "/"
  end

  defp get_weather_by_id(conn) do
    Dict.get(conn.params, :id) |> Repo.Weather.get
  end

  defp parse_weather(param) do
    [
      city:    Dict.get(param, :city),
      temp_lo: Dict.get(param, :temp_lo) |> String.strip |> binary_to_integer,
      temp_hi: Dict.get(param, :temp_hi) |> String.strip |> binary_to_integer,
      prcp:    Dict.get(param, :prcp)    |> String.strip |> Float.parse |> elem 0
    ]
  end
end
