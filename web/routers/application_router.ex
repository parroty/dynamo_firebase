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
    conn = conn.assign(:weather, %Weather{})
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
    params = conn.params[:weather] |> parse_weather
    Map.merge(%Weather{}, params) |> Repo.Weather.create
    redirect conn, to: "/"
  end

  @doc "update"
  put "/:id" do
    params  = conn.params[:weather] |> parse_weather
    Map.merge(get_weather_by_id(conn), params) |> Repo.Weather.update
    redirect conn, to: "/"
  end

  @doc "destroy"
  delete "/:id" do
    get_weather_by_id(conn) |> Repo.Weather.delete
    redirect conn, to: "/"
  end

  defp get_weather_by_id(conn) do
    conn.params[:id] |> Repo.Weather.get
  end

  defp parse_weather(param) do
    %{
      city:    param[:city],
      temp_lo: param[:temp_lo] |> String.strip |> binary_to_integer,
      temp_hi: param[:temp_hi] |> String.strip |> binary_to_integer,
      prcp:    param[:prcp]    |> String.strip |> Float.parse |> elem 0
    }
  end
end
