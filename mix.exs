defmodule Plops.Mixfile do
  use Mix.Project

  def project do
    [app: :plops,
     version: "0.0.1",
     elixir: "~> 1.0",
     elixirc_paths: elixirc_paths(Mix.env),
     compilers: [:phoenix] ++ Mix.compilers,
     build_embedded: Mix.env == :prod,
     start_permanent: Mix.env == :prod,
     deps: deps]
  end

  # Configuration for the OTP application
  #
  # Type `mix help compile.app` for more information
  def application do
    [mod: {Plops, []},
     applications: [:phoenix, :phoenix_html, :cowboy, :logger,
                    :phoenix_ecto, :postgrex, :oauth2, :quantum]]
  end

  # Specifies which paths to compile per environment
  defp elixirc_paths(:test), do: ["lib", "web", "test/support"]
  defp elixirc_paths(_),     do: ["lib", "web"]

  # Specifies your project dependencies
  #
  # Type `mix help deps` for examples and options
  defp deps do
    [{:phoenix, "~> 1.0.3"},
     {:phoenix_ecto, "~> 1.2.0"},
     {:postgrex, "~> 0.9.1"},
     {:phoenix_html, "~> 2.2.0"},
     {:phoenix_live_reload, "~> 1.0.1", only: :dev},
     {:cowboy, "~> 1.0.3"},
     {:oauth2, "~> 0.3.0"},
     {:quantum, "~> 1.5.0"},
     {:exrm, "~> 0.19.6"}]
  end
end
