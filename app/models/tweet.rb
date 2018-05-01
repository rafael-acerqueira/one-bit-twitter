class Tweet < ApplicationRecord
  belongs_to :user
  acts_as_votable
  belongs_to :tweet_original, class_name: 'Tweet', required: false
  has_many :retweets, class_name: 'Tweet', foreign_key: 'tweet_original_id'
  validates_presence_of :body, :user_id

  mount_base64_uploader :photo, PhotoUploader

  searchkick word_start: [:body]

  def search_data
    { body: body }
  end

  def should_index?
    !tweet_original.present?
  end
end
