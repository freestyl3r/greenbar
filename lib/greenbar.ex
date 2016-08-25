defmodule Greenbar do

  alias Greenbar.Engine
  alias Piper.Common.Scope

  def eval(template, scope \\ %{}) do
    scope = Scope.from_map(scope)
    {:ok, engine} = Engine.default()
    case :greenbar_template_parser.scan_and_parse(template) do
      {:ok, parsed} ->
        case Greenbar.Exec.Interpret.run(parsed, engine, scope) do
          {:ok, outputs, _} ->
            IO.puts "#{String.trim_trailing(:erlang.iolist_to_binary(outputs))}"
            :ok
          error ->
            error
        end
      error ->
        error
    end
  end

end