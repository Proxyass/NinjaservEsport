class TeamsController < ApplicationController

  def index
    @full_banner = 'ninjaserv-team.jpg'
    @teams = Team.all
  end

end
