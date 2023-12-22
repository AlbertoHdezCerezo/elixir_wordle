defmodule Game.Logic do
  @moduledoc "Game logic, defines how guesses are processed to infer the state of the game"

  @doc "Updates game session with a new guess attempt"
  @spec resolve(Game.Session.t(), String.t()) :: Game.Session.t()
  def resolve(%Game.Session{state: [:win | :lose]} = session), do: session

  def resolve(%Game.Session{guesses: guesses, guesses_limit: guesses_limit, word: word_to_guess} = session, word)
    when length(guesses) >= guesses_limit, do: session

  def resolve(%Game.Session{guesses: guesses, guesses_limit: guesses_limit, word: word_to_guess} = session, word)
    when word_to_guess == word and length(guesses) < guesses_limit,
      do: %{session | guesses: [guesses] ++ guess(session, word), state: :won}

  def resolve(%Game.Session{guesses: guesses, guesses_limit: guesses_limit, word: word_to_guess} = session, word)
    when word_to_guess != word and length(guesses) == guesses_limit - 1,
      do: %{session | guesses: [guesses] ++ guess(session, word), state: :lose}

  def resolve(%Game.Session{guesses: guesses} = session, word),
    do: %{session | guesses: [guesses] ++ guess(session, word), state: :playing}

  @spec guess(Game.Session.t(), String.t()) :: Game.Session.guess()
  defp guess(%Game.Session{word: word_to_guess}, word) when word_to_guess == word,
    do: word |> String.graphemes() |> Enum.map(fn char -> %{char: char, state: :correct} end)

  defp guess(%Game.Session{}, word) do
    correct_chars = word |> String.graphemes()

    word
      |> String.graphemes()
      |> Enum.with_index()
      |> Enum.map(
        fn {char, index} ->
          state = case Enum.at(correct_chars, index) do
                    ^char -> :correct
                    _ -> :incorrect
                  end

          %{char: char, state: state}
        end
      )
  end
end
