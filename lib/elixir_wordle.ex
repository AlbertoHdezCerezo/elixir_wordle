defmodule ElixirWordle do
  @moduledoc """
   Play Wordle in your terminal - Implemented in Elixir

   This method starts the game loop:

   > mix run -e "ElixirWordle.main"
  """

  def play do
    start_game? = Prompt.choice(
      """
        Welcome to

        --- WORDLE ---

        Do you want to play a new game?
      """,
      [yes: "y", no: "n"]
    )

    with :yes <- start_game? do
      Prompt.display(
        """
          Time to play!
        """
      )
    else
      _ -> Prompt.display("See you next time!")
    end
  end
end
