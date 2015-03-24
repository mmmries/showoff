defmodule Showoff.Mixfile do
  use Mix.Project

  def project do
    [app: :showoff,
     version: "0.0.1",
     elixir: "~> 1.0",
     elixirc_paths: ["lib", "web"],
     compilers: [:phoenix] ++ Mix.compilers,
     deps: deps]
  end

  # Configuration for the OTP application
  #
  # Type `mix help compile.app` for more information
  def application do
    [mod: {Showoff, []},
     applications: [:phoenix, :cowboy, :logger]]
  end

  # Specifies your project dependencies
  #
  # Type `mix help deps` for examples and options
  defp deps do
    [
      {:phoenix, "~> 0.10.0"},
      {:cowboy, "~> 1.0"},
      {:chunky_svg, "~> 0.0.1"},
    ]
  end
end
