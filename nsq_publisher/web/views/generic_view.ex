defmodule NsqPublisher.GenericView do
  @moduledoc false

  use NsqPublisher.Web, :view

  def render("generic.json", %{content: content}) do
    content
  end
end
