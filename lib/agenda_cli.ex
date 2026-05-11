defmodule AgendaCli do
  alias AgendaCli.{Contacts, Store}

  def main(_args) do
    IO.puts("""
    📖 Agenda de Contatos CLI
    -------------------------
    Comandos:
    add --name "Nome" --phone "85..."
    edit <id> --email "novo@email.com"
    del <id>
    list
    search --name "Ana"
    exit
    """)

    contacts = Store.load()
    loop(contacts)
  end

  defp loop(contacts) do
    input = IO.gets("agenda> ") |> String.trim()

    case parse(input) do
      {:add, attrs} ->
        updated = Contacts.add(contacts, attrs)
        Store.save(updated)
        IO.puts("✅ Contato adicionado.")
        loop(updated)

      {:edit, id, attrs} ->
        updated = Contacts.edit(contacts, id, attrs)
        Store.save(updated)
        IO.puts("✅ Contato ##{id} atualizado.")
        loop(updated)

      {:del, id} ->
        updated = Contacts.delete(contacts, id)
        Store.save(updated)
        IO.puts("❌ Contato ##{id} removido.")
        loop(updated)

      :list ->
        IO.puts("\n--- Lista de Contatos ---")
        list_contacts(contacts)
        loop(contacts)

      {:search, field, value} ->
        results = Contacts.search(contacts, field, value)
        IO.puts("\n--- Resultados da Busca ---")
        list_contacts(results)
        loop(contacts)

      :exit -> IO.puts("Até logo!")
      :unknown ->
        IO.puts("⚠️ Comando inválido ou formato incorreto.")
        loop(contacts)
    end
  end

  # --- Lógica de Parsing (Pattern Matching) ---

  defp parse("exit"), do: :exit
  defp parse("list"), do: :list

  defp parse("add " <> rest) do
    attrs = parse_flags(rest)
    if attrs != [], do: {:add, attrs}, else: :unknown
  end

  defp parse("edit " <> rest) do
    [id_str | flags_str] = String.split(rest, " ", parts: 2)
    id = String.to_integer(id_str)
    attrs = parse_flags(Enum.join(flags_str, " "))
    {:edit, id, attrs}
  rescue
    _ -> :unknown
  end

  defp parse("del " <> id), do: {:del, String.to_integer(String.trim(id))}

  defp parse("search " <> rest) do
    case parse_flags(rest) do
      [{field, value}] -> {:search, field, value}
      _ -> :unknown
    end
  end

  defp parse(_), do: :unknown

  # Transforma "--name Valor" em [name: "Valor"]
  defp parse_flags(str) do
    Regex.scan(~r/--(name|phone|email|company)\s+([^--]+)/, str)
    |> Enum.map(fn [_, flag, val] -> {String.to_existing_atom(flag), String.trim(val)} end)
  end

  defp list_contacts([]), do: IO.puts(" (vazio)")
  defp list_contacts(list) do
    Enum.each(list, fn c ->
      IO.puts(" [##{c.id}] #{c.name} | #{c.phone} | #{c.email} (#{c.company})")
    end)
  end
end
