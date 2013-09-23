defmodule Repo.Weather do
  alias ExFirebase.Dict

  @location "dynamo_firebase"

  def all do
    Dict.Records.get(@location, Weather)
  end

  def get(id) do
    Dict.Records.get(@location, id, Weather)
  end

  def update(weather) do
    Dict.Records.patch(@location, weather)
  end

  def create(weather) do
    Dict.Records.post(@location, weather, Weather)
  end

  def delete(weather) do
    Dict.Records.delete(@location, weather)
  end
end

defrecord Weather, id: "", city: "", temp_lo: 0, temp_hi: 0, prcp: 0
