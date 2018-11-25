require 'sinatra'
require 'sinatra/reloader'
set :secret_number, rand(101)

@@guesses = 6


get '/' do
  message = ""

  guess = params["guess"]
  response = check_guess(guess.to_i)
  message = response[0]
  color = response[1]

  if params["cheat"] && params["cheat"] == "true"
    cheat = true
  else
    cheat = false
  end

  erb :index, :locals => {:number => settings.secret_number, :message => message,
                          :color => color, :guesses => @@guesses, :cheat => cheat}
end


def check_guess (guess)
  if guess > (settings.secret_number + 5)
    @@guesses -= 1
    response = ["Way too high!", '#ff6868']
  elsif guess > settings.secret_number
    @@guesses -= 1
    response = ["Too high!", '#f9cb93']
  elsif guess < (settings.secret_number - 5)
    @@guesses -= 1
    response = ["Way too low!", '#ff6868']
  elsif guess < settings.secret_number
    @@guesses -= 1
    response = ["Too low!", '#f9cb93']
  else
    set_new_number()
    response = ["You got it right!", '#aada72']
  end

  if @@guesses == 0
    set_new_number()
    response = ["You used up all your guesses! Picking a new number... Try again."]
  else
    response
  end
end

def set_new_number
  @@guesses = 5
  settings.secret_number = rand(101)
end
