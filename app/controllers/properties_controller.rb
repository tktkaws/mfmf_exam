class PropertiesController < ApplicationController
  before_action :set_property, only: [:show, :edit, :update, :destroy]

  def index
    @properties = Property.all
  end

  def new
    @property = Property.new
    @property.stations.build
  end

  def show
  end

  def edit
  end

  def update
    if @property.update(property_params)
      redirect_to properties_path, success: "編集しました！"
    else
      render :edit
    end
  end

  def create
    @property = Property.new(property_params)
    @property.stations.build
    if params[:back]
      render :new
    else
      if @property.save
        redirect_to properties_path, success: "新規投稿しました！"
      else
        render :new
      end
    end
  end

  def destroy
    @property.destroy
    redirect_to properties_path, danger:"削除しました！"
  end

  def confirm
    @property = Property.new(property_params)
    @property.stations.build
    render :new if @property.invalid?
  end

  private

  def property_params
    params.require(:property).permit(:name, :rent, :address, :age, :note, stations_attributes: [:route, :name, :time_needed])
  end
  def set_property
    @property = Property.find(params[:id])
  end

end