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
    building_hashes = Unirest.get("http://localhost:3000/buildings/api/v1").body
    building_hashes.each do |building_hash|
      buildings << Building.new(building_hash)
    end
    return buildings
  end

  def self.find(id)
    building_hash = Unirest.get("http://localhost:3000/buildings/#{id}.json").body
    Building.new(building_hash)
  end

  def destroy
    Unirest.delete("http://localhost:3000/buildings/#{id}.json").body
  end

  def self.create(attributes)
    building_hash = Unirest.post("http://localhost:3000/buildings.json", headers: {"Accept" => "application/json"}, parameters: attributes).body
    Building.new(building_hash)
  end

  def update(attributes)
    building_hash = Unirest.patch("http://localhost:3000/buildings#{id}.json", headers: {"Accept" => "application/json"}, parameters: attributes).body
    Building.new(building_hash)
  end
end