require './config/environment'
require_relative "./app/controllers/users_controller"
require_relative "./app/controllers/grocery_list_controller"

if ActiveRecord::Migrator.needs_migration?
  raise 'Migrations are pending. Run `rake db:migrate` to resolve the issue.'
end

use Rack::MethodOverride

use UsersController
use GrocerListController
run ApplicationController
