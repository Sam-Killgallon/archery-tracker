class RoundsController < ApplicationController
  def index
    respond_to do |format|
      format.html
      format.json { render json: Round.includes(:round_distances).all }
    end
  end
end
