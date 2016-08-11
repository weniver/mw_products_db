class Color < ActiveRecord::Base
  include ColorsHelper
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

  def color_in_words
    hue = self.hue
    tone = self.tone
    dark = self.darkness
    h_word = hue_word(hue)
    t_word = tone_word(tone)
    d_word = darkness_word(tone)
    return color_words = [h_word, t_word, d_word].join(" ")
  end

  def hue_for_description
    hue = self.hue
    return hue_word(hue)
  end
end
