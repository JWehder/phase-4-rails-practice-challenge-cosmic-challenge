class Mission < ApplicationRecord
    belongs_to :planet
    belongs_to :scientist

    validates :scientist, presence: true, uniqueness: { scope: :name }
    validates :name, presence: true
    validates :planet_id, presence: true
end
