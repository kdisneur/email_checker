defmodule EmailChecker.SMTPTest do
  use ExUnit.Case

  test "valid?: a valid SMTP record returns true" do
    assert true == EmailChecker.SMTP.valid?("kevin@disneur.me")
  end

  test "valid?: an invalid SMTP record returns false" do
    assert false == EmailChecker.SMTP.valid?("non-existing@disneur.me")
  end
end
