defmodule EmailChecker.Check.Format do
  @moduledoc """
  Check if a binary is formatted like an email.
  """

  @behaviour EmailChecker.Check

  @doc """
  Check a given emails format

  ## Parameters

    * `email` - `binary` - the email to check

  ## Example

      iex> EmailChecker.Check.Format.valid?("test@test.ch")
      true

      iex> EmailChecker.Check.Format.valid?("something")
      false

  """
  def valid?(email) do
    email =~ EmailChecker.Tools.email_regex
  end
end
