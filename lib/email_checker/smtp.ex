defmodule EmailChecker.SMTP do
  def valid?(email) do
    valid?(email, 2)
  end

  defp valid?(email, retries) when retries == 0 do
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

  def smtp_reply(email) do
    socket =
      email
      |> mx_address
      |> Socket.TCP.connect!(25, packet: :line)
    socket |> Socket.Stream.recv!

    socket |> Socket.Stream.send!("HELO\r\n")
    socket |> Socket.Stream.recv!

    socket |> Socket.Stream.send!("mail from:<fake@email.com>\r\n")
    socket |> Socket.Stream.recv!

    socket |> Socket.Stream.send!("rcpt to:<#{email}>\r\n")
    socket |> Socket.Stream.recv!
  end
end
