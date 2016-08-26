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

  def units_in_existence
    if self.remissions.blank?
      return profit = 'n/a'
    else
      id = self.id
      return Unit.where(store_id: id,sold: false).count
    end
  end

  def all_time_profit
    id = self.id
    return Unit.where(store_id: id, sold:true).sum(:profit).to_i
  end

  def last_remission_profit
    if self.remissions.blank?
      return profit = 'n/a'
    else
      sold_units = self.remissions.last.units
      profit = sold_units.nil? ? 0 : sold_units.where(sold: true).sum(:profit).to_i
      return "$#{profit}"
    end
  end
  private

    def upcase_rfc
      self.rfc = rfc.upcase
    end

    def downcase_mail
      self.email = email.downcase
    end
end
