defmodule Plops.Mixfile do
  use Mix.Project

  def project do
    [app: :plops,
     version: "0.0.3",
     elixir: "~> 1.4.1",
     elixirc_paths: elixirc_paths(Mix.env),
     compilers: [:phoenix] ++ Mix.compilers,
     build_embedded: Mix.env == :prod,
     start_permanent: Mix.env == :prod,
     deps: deps()]
  end

  # Configuration for the OTP application
  #
  # Type `mix help compile.app` for more information
  def application do
    [mod: {Plops, []},
     applications: [:phoenix, :phoenix_html, :cowboy, :logger, :phoenix_ecto, :postgrex, :quantum, :earmark,
                    :ueberauth, :ueberauth_github, :httpoison]]
  end

  # Specifies which paths to compile per environment
  defp elixirc_paths(:test), do: ["lib", "web", "test/support"]
  defp elixirc_paths(_),     do: ["lib", "web"]

  # Specifies your project dependencies
  #
  # Type `mix help deps` for examples and options
  defp deps do
    [{:phoenix, "~> 1.2.1"},
     {:phoenix_ecto, "~> 3.2.1"},
     {:postgrex, "~> 0.13.0"},
     {:phoenix_html, "~> 2.9.3"},
     {:phoenix_live_reload, "~> 1.0.8", only: :dev},
     {:cowboy, "~> 1.1.2"},
     {:quantum, "~> 1.9.0"},
     {:earmark, "~> 1.1.1"},
     {:ueberauth, "~> 0.4.0"},
     {:ueberauth_github, "~> 0.4.1"},
     {:httpoison, "~> 0.11.0"}]
  end
end
