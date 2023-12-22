defmodule Game.Session do
  @moduledoc "Defines struct to track game progress (n° guess attempts, word to guess, etc)"

  @doc """
    Models the game session

    ## Fields

    - `guesses`: Each player guess attempt, containing the word introduced and score information.
    - `guesses_limit`: Limit of guess attempts per game.
    - `state`: Tracks game completion
    - `word`: Word to guess.
  """
  defstruct guesses: [], guesses_limit: 5, state: :playing, word: nil

  @type guess() :: list(%{char: String.t(), state: :correct | :incorrect})

  @type t() :: %__MODULE__{
    guesses: list(guess()),
    guesses_limit: integer(),
    state: :playing | :win | :lose,
    word: String.t()
  }

  @doc "Creates a new game session"
  @spec new(String.t()) :: t()
  def new(word_to_guess), do: %__MODULE__{word: word_to_guess}
end
