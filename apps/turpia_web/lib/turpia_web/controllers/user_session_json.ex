defmodule TurpiaWeb.UserSessionJSON do
  def index(%{access_token: token, token_type: type}) do
    %{data: %{access_token: token, token_type: type}}
  end
end
