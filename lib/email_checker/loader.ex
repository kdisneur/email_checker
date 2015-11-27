defmodule EmailChecker.Loader do
  use Application

  def default_dns do
    Application.get_env(:email_checker, :default_dns, {8,8,8,8})
  end

  def start(_type, _args) do
    import Supervisor.Spec, warn: false

    # HACK: add default DNS when `inet_db` is not yet available
    # http://stackoverflow.com/questions/33811899/elixir-errors-using-inet-res-library?noredirect=1#comment55418047_33811899
    :ok = :inet_db.add_ns(default_dns())

    Supervisor.start_link([], strategy: :one_for_one, name: :email_checker)
  end
end
