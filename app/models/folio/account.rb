# frozen_string_literal: true

class Folio::Account < Folio::ApplicationRecord
  ROLES = %w( superuser manager ).freeze

  devise :database_authenticatable,
         :recoverable,
         :rememberable,
         :trackable,
         :validatable,
         :invitable

  validates :role, inclusion: ROLES
  validates :first_name, :last_name, presence: true

  # Scopes
  default_scope { order(created_at: :desc) }

  pg_search_scope :by_query,
                  against: %i[first_name last_name email],
                  ignoring: :accents,
                  using: {
                    tsearch: { prefix: true }
                  }


  scope :by_is_active, -> (b) {
    unless b.nil?
      where(is_active: b)
    else
      where(is_active: true)
    end
  }

  def superuser?
    role == 'superuser'
  end

  def manager?
    role == 'manager'
  end

  def full_name
    if first_name || last_name
      "#{first_name} #{last_name}"
    else
      email
    end
  end

  def remember_me
    super.nil? ? '1' : super
  end

  alias :to_label :full_name
  alias :title :full_name

  def active_for_authentication?
    # remember to call the super
    # then put our own check to determine "active" state using
    # our own "is_active" column
    super && self.is_active?
  end

  def self.clears_page_cache_on_save?
    false
  end
end

# == Schema Information
#
# Table name: folio_accounts
#
#  id                     :bigint(8)        not null, primary key
#  email                  :string           default(""), not null
#  encrypted_password     :string           default(""), not null
#  reset_password_token   :string
#  reset_password_sent_at :datetime
#  remember_created_at    :datetime
#  sign_in_count          :integer          default(0), not null
#  current_sign_in_at     :datetime
#  last_sign_in_at        :datetime
#  current_sign_in_ip     :string
#  last_sign_in_ip        :string
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#  first_name             :string
#  last_name              :string
#  role                   :string
#  is_active              :boolean          default(TRUE)
#  invitation_token       :string
#  invitation_created_at  :datetime
#  invitation_sent_at     :datetime
#  invitation_accepted_at :datetime
#  invitation_limit       :integer
#  invited_by_type        :string
#  invited_by_id          :bigint(8)
#  invitations_count      :integer          default(0)
#
# Indexes
#
#  index_folio_accounts_on_email                              (email) UNIQUE
#  index_folio_accounts_on_invitation_token                   (invitation_token) UNIQUE
#  index_folio_accounts_on_invitations_count                  (invitations_count)
#  index_folio_accounts_on_invited_by_id                      (invited_by_id)
#  index_folio_accounts_on_invited_by_type_and_invited_by_id  (invited_by_type,invited_by_id)
#  index_folio_accounts_on_reset_password_token               (reset_password_token) UNIQUE
#
