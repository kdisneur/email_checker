defmodule EmailChecker do

  defp validations do
    strategies = Application.get_env(:email_checker, :validations, [Format,MX,SMTP])
    for v <- strategies, do: &Module.concat(EmailChecker,v).valid?/1
  end

  def valid?(email) do
    expected_length =
      validations() |> length

    case validations() |> Stream.take_while(&( &1.(email) )) |> Enum.to_list do
      list when length(list) == expected_length -> true
      _ ->                                         false
    end
  end

end
