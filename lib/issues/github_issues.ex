defmodule Issues.GithubIssues do
  @user_agent [{"User-agent", "Exlxir"}]

  def fetch(user, project) do
    issues_url(user, project)
    |> HTTPoison.get(@user_agent)
    |> handle_response
  end

  def issues_url(user, project) do
    "https://api.github.com/repos/#{user}/#{project}/issues"
  end
  def handle_response({:ok, %{status_code: 200, body: body}}), do: {:ok, :jsx.decode(body)}
  def handle_response({:ok, %{status_code: ___, body: body}}), do: {:error, :jsx.decode(body)}
  def handle_response({:error, %{reason: reason}}), do: {:error, reason}
end
