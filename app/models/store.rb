class Store < ActiveRecord::Base
  has_many :units
  has_many :remissions, dependent: :destroy

  before_save :downcase_mail, :upcase_rfc

  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i
  VALID_RFC_REGEX = /\A[A-ZÑ&]{3,4}[0-9]{2}[0-1][0-9][0-3][0-9]([A-Z0-9]{3})?\z/i

  validates :name,  presence: true,
                    uniqueness: true,
                    length: { maximum: 50 }
  validates :email, allow_blank: true,
                    length: { maximum: 255 },
                    format: { with: VALID_EMAIL_REGEX }
  validates :rfc,   allow_blank: true,
                    format: { with: VALID_RFC_REGEX }

  private

    def upcase_rfc
      self.rfc = rfc.upcase
    end

    def downcase_mail
      self.email = email.downcase
    end
end
