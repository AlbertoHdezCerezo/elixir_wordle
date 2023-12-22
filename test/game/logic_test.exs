defmodule Game.LogicTest do
  use ExUnit.Case

  describe "resolve" do
    setup do
      [
        session: Game.Session.new("sugar")
      ]
    end

    test "if game is in progress, and there are guess attempts left, track guess attempt" do
      session = Game.Session.new("sugar")

      session = Game.Logic.resolve(session, "zugar")
      assert session.guesses == [
        [
          %{char: "Z", state: :incorrect},
          %{char: "U", state: :correct},
          %{char: "G", state: :correct},
          %{char: "A", state: :correct},
          %{char: "R", state: :correct},
        ]
      ]

      session = Game.Logic.resolve(session, "sugar")
      assert session.guesses == [
        [
          %{char: "Z", state: :incorrect},
          %{char: "U", state: :correct},
          %{char: "G", state: :correct},
          %{char: "A", state: :correct},
          %{char: "R", state: :correct},
        ],
        [
          %{char: "S", state: :correct},
          %{char: "U", state: :correct},
          %{char: "G", state: :correct},
          %{char: "A", state: :correct},
          %{char: "R", state: :correct},
        ]
      ]
    end

    test "if game is in progress, and there are no guess attempts left, do not track guess attempt" do
      session = Game.Session.new("sugar")

      guess_words = 1..(session.guesses_limit + 1) |> Enum.map(fn index -> "sugar #{index}" end)
      session = Enum.reduce(guess_words, session, fn guess_word, acc_session -> Game.Logic.resolve(acc_session, guess_word) end)

      assert length(session.guesses) == session.guesses_limit
    end

    test "if game is in progress, and player guesses the word, game ends in victory" do
      session = Game.Session.new("sugar")

      session = Game.Logic.resolve(session, "sugar")

      assert session.state == :win
    end

    test "if game is in progress, there is one attemp left, and player does not guess the word, player loses" do
      session = Game.Session.new("sugar")

      guess_words = 1..session.guesses_limit |> Enum.map(fn index -> "sugar #{index}" end)
      session = Enum.reduce(guess_words, session, fn guess_word, acc_session -> Game.Logic.resolve(acc_session, guess_word) end)

      assert session.state == :lose
    end

    test "if game is in progress, there is more than one attempt left, and player does not guess the word, game continues" do
      session = Game.Session.new("sugar")

      guess_words = 1..(session.guesses_limit - 1) |> Enum.map(fn index -> "sugar #{index}" end)
      session = Enum.reduce(guess_words, session, fn guess_word, acc_session -> Game.Logic.resolve(acc_session, guess_word) end)

      assert session.state == :playing
    end

    test "if game is won, do not track guess attempt", fixtures do
      session = Game.Session.new("sugar")

      session = Game.Logic.resolve(session, "sugar")
      assert length(session.guesses) == 1
      assert session.state == :win

      session = Game.Logic.resolve(session, "sugar 2")
      assert length(session.guesses) == 2
    end

    test "if game is lost, do not track guess attempt" do
      session = Game.Session.new("sugar")

      guess_words = 1..session.guesses_limit |> Enum.map(fn index -> "sugar #{index}" end)
      session = Enum.reduce(guess_words, session, fn guess_word, acc_session -> Game.Logic.resolve(acc_session, guess_word) end)

      session = Game.Logic.resolve(session, "sugar 6")
      assert length(session.guesses) == 5
    end
  end
end
