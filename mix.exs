defmodule EmailChecker.Mixfile do
  use Mix.Project

  def project do
    [app: :email_checker,
     version: "0.0.3",
     elixir: "~> 1.0",
     build_embedded: Mix.env == :prod,
     start_permanent: Mix.env == :prod,
     description: description(),
     package: package(),
     deps: deps()]
  end

  # Configuration for the OTP application
  #
  # Type `mix help compile.app` for more information
  def application do
    [
      mod: {EmailChecker.Loader, []},
      applications: [:logger, :socket]
    ]
  end

  # Dependencies can be Hex packages:
  #
  #   {:mydep, "~> 0.3.0"}
  #
  # Or git/path repositories:
  #
  #   {:mydep, git: "https://github.com/elixir-lang/mydep.git", tag: "0.1.0"}
  #
  # Type `mix help deps` for more examples and options
  defp deps do
    [
      {:socket, "~> 0.3.1"},
    ]
  end

  defp description do
    """
    Simple library checking the validity of an email. Checks are performed in the following order:

    - REGEX: validate the emails has a good looking format

    - MX: validate the domain sever contains MX records

    - SMTP: validate the SMTP behind the MX records knows this email address (no email sent)
    """
  end

  defp package do
    [
      files: ["lib", "mix.exs", "README*", "LICENSE*"],
      maintainers: ["Kevin Disneur"],
      licenses: ["MIT"],
      links: %{
        "GitHub" => "https://github.com/kdisneur/email_checker"
      }
    ]
  end
end
