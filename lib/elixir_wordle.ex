defmodule ElixirWordle do
  @moduledoc """
   Play Wordle in your terminal - Implemented in Elixir

   This method starts the game loop:

   > mix run -e "ElixirWordle.play"
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

    if start_game? == :yes do
      session = Game.Session.new(Game.WordsLibrary.word)
      game_loop(session)
      Prompt.display("Game is over!")
    else
      Prompt.display("See you next time!")
    end
  end

  defp game_loop(session) do
    guess_word = Prompt.text("Guess attempt #{length(session.guesses) + 1}")
    session = Game.Logic.resolve(session, guess_word)

    case session.state do
      :win -> Prompt.display("[WIN] You guessed the right word!")
      :lose -> Prompt.display("[LOSE] You ran out of guess attempts, game is over")
      _ ->
        Prompt.display("Wrong guess! You have #{session.guesses_limit - length(session.guesses)} attempts left ...")
        session = game_loop(session)
    end

    session
  end
end
