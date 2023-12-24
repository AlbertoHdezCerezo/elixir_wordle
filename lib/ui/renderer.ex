defmodule UI.Renderer do
  @moduledoc false

  @doc "Renders Wordle guesses tiles in screen"
  @spec render(Game.Session.t()) :: any()
  def render(%Game.Session{guesses: guesses}) do
    guesses
      |> Enum.each(
        fn guess ->
          render(guess)
          # Print new line
          IO.puts("")
        end
      )
  end

  @spec render(Game.Session.guess()) :: any()
  def render(guess) when is_list(guess) do
    guess
      |> Enum.map(
          fn guess_letter ->
            color = case guess_letter.state do
                      :correct -> 2
                      :incorrect -> 1
                    end

            {guess_letter.char, color}
          end
        )
      |> Enum.each(
          fn {char, color} ->
            IO.write(ansi_colorize(char, color))
          end
        )
  end

  defp ansi_colorize(text, color) do
    IO.ANSI.color_background(color) <> text <> IO.ANSI.reset()
  end
end
