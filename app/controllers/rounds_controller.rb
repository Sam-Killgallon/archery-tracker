class RoundsController < ApplicationController
  def index
    respond_to do |format|
      format.html
      format.json { render json: Round.all }
    end
  end
end
