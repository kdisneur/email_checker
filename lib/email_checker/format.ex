defmodule EmailChecker.Format do
  def valid?(email) do
    Regex.match?(EmailChecker.Tools.email_regex, email)
  end
end
