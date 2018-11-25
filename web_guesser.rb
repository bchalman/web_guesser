require 'sinatra'
require 'sinatra/reloader'
set :secret_number, rand(101)

get '/' do
  message = ""

  guess = params["guess"]
  message = check_guess(guess.to_i)

  erb :index, :locals => {:number => settings.secret_number, :message => message}
end


def check_guess (guess)
  if guess > (settings.secret_number + 5)
    "Way too high!"
  elsif guess > settings.secret_number
    "Too high!"
  elsif guess < (settings.secret_number - 5)
    "Way too low!"
  elsif guess < settings.secret_number
    "Too low!"
  else
    "You got it right!"
  end
end
