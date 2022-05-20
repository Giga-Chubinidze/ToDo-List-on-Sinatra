require_relative './config/environment'
require 'sinatra/activerecord'


use Rack::MethodOverride
run ApplicationController
use UsersController
use TasksController
use ListsController