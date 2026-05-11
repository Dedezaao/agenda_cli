defmodule AgendaCli.Contacts do

  defp generate_id, do: :os.system_time(:millisecond)

  def add(contacts, attrs) do
    new_contact = %{
      id: generate_id(),
      name: attrs[:name],
      company: attrs[:company],
      phone: attrs[:phone],
      email: attrs[:email]
    }
    contacts ++ [new_contact]
  end

  def delete(contacts, id) do
    Enum.reject(contacts, fn c -> c.id == id end)
  end

  def edit(contacts, id, new_attrs) do
    Enum.map(contacts, fn c ->
      if c.id == id do
        Map.merge(c, new_attrs)
      else
        c
      end
    end)
  end

  def search(contacts, field, value) do
    search_value = String.downcase(value)

    Enum.filter(contacts, fn c ->
      current_field_value = Map.get(c, field) |> to_string() |> String.downcase()
      String.contains?(current_field_value, search_value)
    end)
  end
end
