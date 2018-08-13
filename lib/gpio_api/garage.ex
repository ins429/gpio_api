defmodule GpioApi.Garage do
  import Plug.Conn

  def toggle(conn = %Plug.Conn{params: %{"password" => password}}) do
    case validate_password(password) do
      :ok ->
        {:ok, pid} = Gpio.start_link(14, :output)
        read = Gpio.read(pid)

        case read do
          0 ->
            Gpio.write(pid, 1)

          1 ->
            Gpio.write(pid, 0)
        end

        Gpio.release(pid)

        send_resp(conn, 200, "ok")

      :error ->
        send_resp(conn, 400, "error")
    end
  end

  defp validate_password(password) when password == "", do: :ok
  defp validate_password(_password), do: :error
end
