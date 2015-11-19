defmodule EmailChecker.Tools do
  @email_regex ~r/^(?<user>[^\s]+)@(?<domain>[^\s]+\.[^\s]+)$/

  def domain_name(email) do
    case Regex.named_captures(email_regex, email) do
      %{ "domain" => domain } ->
        domain
      _ ->
        nil
    end
  end

  def email_regex do
    @email_regex
  end
end
