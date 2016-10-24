defmodule NsqPublisher.Consumer do
  use GenServer
  require Logger

  def start_link do
    GenServer.start_link(__MODULE__, :ok, name: __MODULE__)
  end

  def init(:ok) do
    Logger.log(:debug, "Starting Consumer...")
    {:ok, consumer} = NSQ.Consumer.Supervisor.start_link("messages", "x-messages", %NSQ.Config{
      nsqlookupds: ["127.0.0.1:4161"],
      message_handler: fn(body, msg) ->
        IO.inspect "Message: #{msg.id}"
        IO.inspect body
        :ok
      end
    })
    {:ok, consumer}
  end

  def terminate(_, consumer) do
    Logger.log(:debug, "Terminating Consumer...")
    NSQ.Consumer.close(consumer)
    :ok
  end

end
