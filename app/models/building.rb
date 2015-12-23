class Building

  attr_accessor :location, :height, :id

  def initialize(hash)
    @location = hash["location"]
    @height = hash["height"]
    @id = hash["id"]
  end

  def full_building
    "#{location} #{height}"
  end

  def self.all
    buildings = []
    building_hashes = Unirest.get("#{ENV['API_BASE_URL']}/buildings.json", headers: {"X-User-Email": "tc@gmail.com", "Authorization": "Token token=123"}).body
    #building_hashes = Unirest.get("http://localhost:3000/api/v1/buildings.json").body
    building_hashes.each do |building_hash|
      buildings << Building.new(building_hash)
    end
    return buildings
  end

  def self.find(id)
    building_hash = Unirest.get("#{ENV['API_BASE_URL']}/buildings/#{id}.json", headers: {"X-User-Email": "tc@gmail.com", "Authorization": "Token token=123"}).body
    #building_hash = Unirest.get("http://localhost:3000/api/v1/buildings/#{id}.json").body
    Building.new(building_hash)
  end

  def destroy
    Unirest.delete("#{ENV['API_BASE_URL']}/buildings/#{id}.json").body
    #Unirest.delete("http://localhost:3000/api/v1/buildings/#{id}.json").body
  end

  def self.create(attributes)
    building_hash = Unirest.post("#{ENV['API_BASE_URL']}/buildings.json", headers: {"Accept" => "application/json"}, parameters: attributes).body
    Building.new(building_hash)
  end

  def update(attributes)
    building_hash = Unirest.patch("#{ENV['API_BASE_URL']}/buildings/#{id}.json", headers: {"Accept" => "application/json"}, parameters: attributes).body
    Building.new(building_hash)
  end
end