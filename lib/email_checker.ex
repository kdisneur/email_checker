defmodule EmailChecker do
  @validations [
    &EmailChecker.Format.valid?/1,
    &EmailChecker.MX.valid?/1,
    &EmailChecker.SMTP.valid?/1,
  ]

  def valid?(email) do
    expected_length =
      validations() |> length

    case validations() |> Stream.take_while(&( &1.(email) )) |> Enum.to_list do
      list when length(list) == expected_length ->
        true
      _ ->
        false
    end
  end

  defp validations do
    @validations
  end
end
