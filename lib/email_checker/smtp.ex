defmodule EmailChecker.SMTP do

  defp max_retries(), do: Application.get_env(:email_checker, :smtp_retries, 2)
  defp max_timeout(), do: Application.get_env(:email_checker, :timeout_milliseconds, :infinity)

  def valid?(email) do
    valid?(email, max_retries())
  end

  defp valid?(email, retries)
  defp valid?(_, 0) do
    false
  end
  defp valid?(email, retries) do
    try do
      case smtp_reply(email) do
        nil ->
          false
        response ->
          Regex.match?(~r/^250 /, response)
      end
    rescue
      Socket.Error ->
        valid?(email, retries - 1)
    end
  end

  defp mx_address(email) do
    email
    |> EmailChecker.Tools.domain_name
    |> EmailChecker.MX.lookup
  end

  defp timeout_opt() do
    case max_timeout do
      :infinity            -> :infinity
      t when is_integer(t) -> t |> div(max_retries) |> abs
    end
  end

  def smtp_reply(email) do
    opts = [packet: :line, timeout: timeout_opt]
    socket =
      email
      |> mx_address
      |> Socket.TCP.connect!(25, opts)
    socket |> Socket.Stream.recv!

    socket |> Socket.Stream.send!("HELO\r\n")
    socket |> Socket.Stream.recv!

    socket |> Socket.Stream.send!("mail from:<fake@email.com>\r\n")
    socket |> Socket.Stream.recv!

    socket |> Socket.Stream.send!("rcpt to:<#{email}>\r\n")
    socket |> Socket.Stream.recv!
  end
end
