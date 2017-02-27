defmodule EmailChecker.Check.MX do
  @moduledoc """
  Check if an emails server has a valid MX record.
  """

  @behaviour EmailChecker.Check

  @doc """
  Check if an emails server has a valid MX record.

  ## Parameters

    * `email` - `binary` - the email to check

  ## Example

      iex> EmailChecker.Check.MX.valid?("test@gmail.com")
      true

      iex> EmailChecker.Check.MX.valid?("test@invalid-domains-foobar.com")
      true

  """
  def valid?(email) do
    email
    |> EmailChecker.Tools.domain_name
    |> EmailChecker.Tools.lookup
    |> present?
  end

  defp present?(nil), do: false
  defp present?(string), do: String.length(string) > 0
end
