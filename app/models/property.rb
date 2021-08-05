class Property < ApplicationRecord
    has_many :reviews, dependent: :destroy
    has_many :approaches, dependent: :destroy
    has_many_attached :images
    validate :image_type
def thumbnail input
    return self.images[input].variant(resize: '300X250>').processed
end

    private 
    def image_type
        if images.attached? == false
            errors.add(:images, "missing")
        end
        images.each do |image|
            if !image.content_type.in?(%('image/jpeg image/png'))
                errors.add(:images , "should be jpeg or png")
            end
        end
    end
end
