defmodule GpioApi.Garage do
  import Plug.Conn
  alias ElixirALE.GPIO

  def toggle(conn = %Plug.Conn{params: %{"password" => password}}) do
    case validate_password(password) do
      :ok ->
        {:ok, pid} = GPIO.start_link(14, :output)
        read = GPIO.read(pid)

        case read do
          0 ->
            GPIO.write(pid, 1)
            :timer.sleep(500)
            GPIO.write(pid, 0)
            :timer.sleep(500)

          1 ->
            GPIO.write(pid, 0)
            :timer.sleep(500)

          true ->
            GPIO.write(pid, 0)
            :timer.sleep(500)
        end

        GPIO.write(pid, 1)
        GPIO.release(pid)

        send_resp(conn, 200, "ok")

      :error ->
        send_resp(conn, 400, "error")
    end
  end

  defp validate_password(password) when password == "", do: :ok
  defp validate_password(_password), do: :error
end
