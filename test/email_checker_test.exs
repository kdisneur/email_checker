defmodule EmailCheckerTest do
  use ExUnit.Case

  test "valid?: an invalid email format returns false" do
    assert false == EmailChecker.valid?("invalid-email")
  end

  test "valid?: a non-existing MX returns false" do
    assert false == EmailChecker.valid?("john.doe@invalid-mx-domain.tld")
  end

  test "valid?: a non-existing email address returns false" do
    assert false == EmailChecker.valid?("non-existent-user@disneur.me")
  end

  test "valid?: an existing email address returns true" do
    assert true == EmailChecker.valid?("kevin@disneur.me")
  end
end
