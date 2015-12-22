class BuildingsController < ApplicationController
  
  def index
   @buildings = Building.all
   #@buildings = Unirest.get("http://localhost:3000/buildings.json").body
  end

  def show
    @building = Building.find(params[:id])
    #@building = Unirest.get("http://localhost:3000/buildings/#{params[:id]}.json").body
  end

  def new
  end

  def create
    @building = Building.create(location: params[:location], height: params[:height])
    redirect_to "/buildings/#{@building.id}"
    #@building = Unirest.post("http://localhost:3000/buildings.json", headers: {"Accept" => "application/json"}, parameters: {location: params[:location], height: params[:height]}).body
    #redirect_to "/buildings/#{@building["id"]}"
  end

  def edit
    @building = Building.find(params[:id])
    #@building = Unirest.get("http://localhost:3000/buildings/#{params[:id]}.json").body
  end

  def update
    @building = Building.find(params[:id])
    @building.update(location: params[:location], height: params[:height])
    redirect_to "/buildings/#{@building.id}"
    #@building = Unirest.patch("http://localhost:3000/buildings#{params[:id]}.json", headers: {"Accept" => "application/json"}, parameters: {location: params[:location], height: params[:height]}).body
    #redirect_to "/buildings/#{@building["id"]}"
  end

  def destroy
    @building = Building.find(params[:id])
    @building.destroy
    #Unirest.delete("http://localhost:3000/buildings#{params[:id]}.json").body
    redirect_to "/buildings"
  end
end
