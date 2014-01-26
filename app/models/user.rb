class User < ActiveRecord::Base

  extend FriendlyId
  friendly_id :name, use: :slugged
  # def should_generate_new_friendly_id?
  #   new_record?#генерить новый УРЛ только, когда запись новая. Если мы изменяем существующую, УРЛ останется прежним
  # end

  attr_accessible :name, :email, :password, :password_confirmation,:slug

  has_many :microposts, dependent: :destroy
  has_many :relationships, foreign_key: "follower_id", dependent: :destroy
  has_many :followed_users, through: :relationships, source: :followed
  
  has_many :reverse_relationships, foreign_key: "followed_id",class_name: "Relationship",dependent: :destroy
  has_many :followers, through: :reverse_relationships, source: :follower
  has_secure_password

  before_save { |user| user.email = email.downcase }
  before_save :create_remember_token

  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :name,  presence: true, length: { maximum: 50 }

  validates :email, presence: true, format: { with: VALID_EMAIL_REGEX }, uniqueness: {case_sensitive: false}
  validates :password, presence: true, length: { minimum: 6 }
  validates :password_confirmation, presence: true

  def feed
    # Это предварительное решение. См. полную реализацию в "Following users".
    Micropost.where("user_id = ?", id)
  end

  def following?(other_user)
    #вначале можно писать self, либо не писать. Тут это всё равно
    relationships.find_by_followed_id(other_user.id)
  end

  def follow!(other_user)
    relationships.create!(followed_id: other_user.id)
  end

  def unfollow!(other_user)
    relationships.find_by_followed_id(other_user.id).destroy
  end

  def feed
    Micropost.from_users_followed_by(self)
  end
  
  private

  def create_remember_token
    self.remember_token = SecureRandom.urlsafe_base64
  end


end
