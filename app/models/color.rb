class Color < ActiveRecord::Base
  has_many :units

  before_validation :form_real_color

  validates :real_color, presence: true,
                         uniqueness: true
  validates :hue,        presence: true,
                         format: { with: /\A[0-9ns]?\z/ }
  validates :tone,       presence: true,
                         format: { with: /\A[0-9]?\z/ }
  validates :darkness,   presence: true,
                         format: { with: /\A[0-9]?\z/ }

  def form_real_color
    h = self.hue
    t = self.tone
    d = self.darkness
    self.real_color = h+t+d
  end
end