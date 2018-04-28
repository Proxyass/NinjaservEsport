class SponsorsController < ApplicationController
  def index
    @sponsors = Sponsor.where(visible: true)
  end
end
