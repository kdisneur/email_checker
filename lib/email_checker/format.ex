defmodule EmailChecker.Format do
  def valid?(email) do
    email =~ EmailChecker.Tools.email_regex
  end
end
