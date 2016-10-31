defmodule CodeCorps.Plug.AnalyticsIdentify do
  @moduledoc """
  Plug used to identify the current user on Segment.com using `CodeCorps.Analytics.Segment`.
  """

  def init(opts), do: opts

  def call(conn, _opts), do: conn |> identify

  def identify(%{assigns: %{current_user: user}} = conn) do
    CodeCorps.Analytics.Segment.identify(user)
    conn
  end
  def identify(conn), do: conn
end
