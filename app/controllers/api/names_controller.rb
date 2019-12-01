module Api
  class NamesController < Api::ApplicationController
    def index
      names = Person.all

      render json: names
    end
  end
end
