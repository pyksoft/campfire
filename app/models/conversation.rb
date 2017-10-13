# == Schema Information
#
# Table name: conversations
#
#  id           :integer          not null, primary key
#  sender_id    :integer
#  recipient_id :integer
#  listing_id   :integer
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#

class Conversation < ActiveRecord::Base
    belongs_to :listing
    belongs_to :sender, :foreign_key => :sender_id, class_name: 'User'
    belongs_to :recipient, :foreign_key => :recipient_id, class_name: 'User'
    has_many :messages, dependent: :destroy

    
    validates_uniqueness_of :sender_id, :scope => [:recipient_id, :listing_id]

    # scope :between, -> (sender_id,recipient_id,listing_id) {
    #     where("(conversations.sender_id = ? AND conversations.recipient_id =? AND conversations.listing_id =?) OR (conversations.sender_id = ? AND conversations.recipient_id =? AND conversations.listing_id =?)", sender_id, recipient_id, listing_id, recipient_id, sender_id, listing_id)
    # }

    scope :between, -> (sender_id,recipient_id) {
        where("(conversations.sender_id = ? AND conversations.recipient_id =?) OR (conversations.sender_id = ? AND conversations.recipient_id =?)", sender_id, recipient_id, recipient_id, sender_id)
    }
end
