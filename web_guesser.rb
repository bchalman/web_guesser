require 'sinatra'
require 'sinatra/reloader'
set :secret_number, rand(101)

get '/' do
  message = ""

  guess = params["guess"]
  response = check_guess(guess.to_i)
  message = response[0]
  color = response[1]

  erb :index, :locals => {:number => settings.secret_number, :message => message, :color => color}
end


def check_guess (guess)
  if guess > (settings.secret_number + 5)
    ["Way too high!", '#ff6868']
  elsif guess > settings.secret_number
    ["Too high!", '#f9cb93']
  elsif guess < (settings.secret_number - 5)
    ["Way too low!", '#ff6868']
  elsif guess < settings.secret_number
    ["Too low!", '#f9cb93']
  else
    ["You got it right!", '#aada72']
  end
end
