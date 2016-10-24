defmodule NsqPublisher.Publisher do
  use GenServer
  require Logger

  def start_link do
    GenServer.start_link(__MODULE__, :ok, name: __MODULE__)
  end

  def publish(payload) do
    GenServer.cast(__MODULE__, {:publish, payload})
  end

  def init(:ok) do
    Logger.log(:debug, "Starting publisher...")

    {:ok, producer} = NSQ.Producer.Supervisor.start_link("messages", %NSQ.Config{
      nsqds: ["127.0.0.1:4150"]
    })
    {:ok, producer}
  end

  def handle_cast({:publish, payload}, producer) do
    NSQ.Producer.pub(producer, payload)
    {:noreply, producer}
  end

  def terminate(_, producer) do
    Logger.log(:debug, "Terminating publisher...")
    :ok
  end
end
