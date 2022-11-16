class WeatherController < ApplicationController
  before_action :set_weather, only: [:show, :update, :destroy]

  rescue_from Exception do |e|
    render json: {error: e.message}, status: :internal_server_error
  end

  rescue_from ActiveRecord::RecordNotFound do |e|
    render json: {error: e.message}, status: :not_found
  end

  rescue_from ActiveRecord::RecordInvalid do |e|
    render json: {error: e.message}, status: :unprocessable_entity
  end

  def index
    if !params[:city].nil? && params[:city].present?
      if params[:city].include?(',')
        cities = params[:city].split(',')
        cities = cities.each do |city|
          city.downcase!
        end
        @weathers = Weather.where(city: cities)
      else
        @weathers = Weather.where("lower(city) = ?", params[:city].downcase)
      end
    elsif !params[:date].nil? && params[:date].present?
      @weathers = Weather.where(date: params[:date])
    elsif !params[:sort].nil? && params[:sort].present?
      if params[:sort] == "date"
        @weathers = Weather.order(:date)
      elsif params[:sort] == "-date"
        @weathers = Weather.order(date: :desc)
      end
    else
      @weathers = Weather.all
    end
    render :index
  end

  def show
    if @weather.nil?
      render json: { error: 'Not Found' }, status: :not_found
    else
      render :show, status: :ok
    end
  end

  def create
    @weather = Weather.create!(weather_params)
    render :create, status: :created
  end

  def update
    @weather.update!(weather_params)
    render :show, status: :ok
  end

  def destroy
    @weather.destroy

    render :show, status: :ok
  end

  private

  def weather_params
    params.require(:weather).permit(:date, :lat, :lon, :city, :state, temperatures: [])
  end

  def set_weather
    @weather = Weather.find(params[:id])
  end

end
