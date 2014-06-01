defmodule DynamoFirebase.Mixfile do
  use Mix.Project

  def project do
    [ app: :dynamo_firebase,
      version: "0.0.1",
      dynamos: [DynamoFirebase.Dynamo],
      compilers: [:elixir, :dynamo, :app],
      env: [prod: [compile_path: "ebin"]],
      compile_path: "tmp/#{Mix.env}/dynamo_firebase/ebin",
      deps: deps ]
  end

  # Configuration for the OTP application
  def application do
    [ applications: [:cowboy, :dynamo],
      mod: { DynamoFirebase, [] } ]
  end

  defp deps do
    [
      {:ibrowse, github: "cmullaparthi/ibrowse", ref: "866b0ff5aca229f1ef53653eabc8ed1720c13cd6", override: true},
      {:cowboy, github: "extend/cowboy" },
      {:dynamo, "0.1.0-dev", github: "elixir-lang/dynamo"},
      {:exfirebase, github: "parroty/exfirebase"},
      {:jsex, "~> 2.0"}
    ]
  end
end
