class Admin::BaseAdminController < ApplicationController
  before_action :must_be_admin
end
