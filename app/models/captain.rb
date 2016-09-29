class Captain < ActiveRecord::Base
  has_many :boats
  # has_many :boat_classifications, through: :boats
  # has_many :classifications, through: :boat_classifications
  def self.catamaran_operators
    # self.joins(:classifications).where("classifications.name = 'Catamaran'")
    self.joins(boats: :classifications).where("classifications.name is 'Catamaran'")
  end

  def self.sailors
    self.joins(boats: :classifications).where("classifications.name is 'Sailboat'").distinct
  end

  def self.motorboats
    self.joins(boats: :classifications).where("classifications.name is 'Motorboat'").distinct
  end


  def self.talented_seamen
    self.sailors.where(id: self.motorboats.pluck(:id))
  end

  def self.non_sailors
    self.where.not("id IN (?)", self.sailors.pluck(:id))
  end
end
