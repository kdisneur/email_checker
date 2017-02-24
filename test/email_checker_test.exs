defmodule EmailCheckerTest do
  use EmailChecker.SMTPCase, async: false

  test "valid?: an invalid email format returns false" do
    assert false == EmailChecker.valid?("invalid-email")
  end

  test "valid?: a non-existing MX returns false" do
    assert false == EmailChecker.valid?("john.doe@invalid-mx-domain.tld")
  end

  test "valid?: a non-existing email address returns false" do
    with_mocks invalid_mock() do
      assert false == EmailChecker.valid?("non-existent-user@disneur.me")
    end
  end

  test "valid?: an existing email address returns true" do
    with_mocks valid_mock() do
      assert true == EmailChecker.valid?("kevin@disneur.me")
    end
  end
end
