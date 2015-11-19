defmodule EmailChecker.ToolsTest do
  use ExUnit.Case

  test "domain_name: returns the domain for a valid email" do
    assert "disneur.me" == EmailChecker.Tools.domain_name("kevin@disneur.me")
  end

  test "domain_name: returns nil for a non valid email" do
    assert nil == EmailChecker.Tools.domain_name("kevin.disneur.me")
  end
end
