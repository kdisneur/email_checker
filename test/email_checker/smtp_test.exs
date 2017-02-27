defmodule EmailChecker.SMTPTest do
  use EmailChecker.SMTPCase, async: false

  test "valid?: a valid SMTP record returns true" do
    with_mocks valid_mock() do
      assert true == EmailChecker.SMTP.valid?("kevin@disneur.me")
    end
  end

  test "valid?: an invalid SMTP record returns false" do
    with_mocks invalid_mock() do
      assert false == EmailChecker.SMTP.valid?("non-existing@disneur.me")
    end
  end
end
