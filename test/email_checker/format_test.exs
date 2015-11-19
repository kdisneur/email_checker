defmodule EmailChecker.FormatTest do
  use ExUnit.Case

  test "valid?: a valid email format returns true" do
    assert true == EmailChecker.Format.valid?("user@domain.com")
    assert true == EmailChecker.Format.valid?("user+addition@domain.com")
    assert true == EmailChecker.Format.valid?("user.name+addition@domain.com")
  end

  test "valid?: an invalid email format returns false" do
    assert false == EmailChecker.Format.valid?("user.domain.com")
    assert false == EmailChecker.Format.valid?("user name@domain.com")
  end
end
