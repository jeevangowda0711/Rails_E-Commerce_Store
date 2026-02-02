# app/controllers/store/base_controller.rb
class Store::BaseController <ApplicationController
  admin_access_only
  layout "settings"
end
