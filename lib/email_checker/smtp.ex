defmodule EmailChecker.SMTP do
  def valid?(email) do
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
    Regex.match?(~r/^250 /, socket |> Socket.Stream.recv!)
  end

  defp mx_address(email) do
    email
    |> EmailChecker.Tools.domain_name
    |> EmailChecker.MX.lookup
  end
end
