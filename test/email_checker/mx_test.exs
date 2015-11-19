defmodule EmailChecker.MXTest do
  use ExUnit.Case

  test "valid?: a valid MX record returns true" do
    assert true == EmailChecker.MX.valid?("kevin@disneur.me")
    assert true == EmailChecker.MX.valid?("non-existing-user@disneur.me")
  end

  test "valid?: an invalid MX record returns false" do
    assert false == EmailChecker.MX.valid?("john@invalid-mx-domain.tld")
  end

  test "lookup?: a non existing domain returns nil" do
    assert nil == EmailChecker.MX.lookup("invalid-mx-domain.tld")
  end

  test "lookup?: an existing domain returns the lowest priority record" do
    assert String.contains?(EmailChecker.MX.lookup("disneur.me"), "google.com")
  end
end
