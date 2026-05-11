defmodule AgendaCli.Store do

  @file_path "contacts.json"


  def load do
    case File.read(@file_path) do
      {:ok, content} ->
        Jason.decode!(content, keys: :atoms)
      {:error, _} ->
        []
    end
  end

  def save(contacts) do
    contacts
    |> Jason.encode!(pretty: true)
    |> then(&File.write!(@file_path, &1))
  end
end
