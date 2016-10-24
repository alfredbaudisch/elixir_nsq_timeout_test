defmodule NsqPublisher.MessagesController do
  use NsqPublisher.Web, :controller

  def create(conn, %{"message" => message}) do
    NsqPublisher.Publisher.publish(message)

    conn
    |> put_status(:ok)
    |> render(NsqPublisher.GenericView, "generic.json", %{content: message})
  end

  def publish(conn, _) do
    NsqPublisher.Publisher.publish("message")

    json(conn, "ok")
  end
end
