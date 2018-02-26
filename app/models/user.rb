class User < ApplicationRecord
	has_many :follower_relationship, class_name: 'Relationship', foreign_key: 'follower_id'
	has_many :followee_relationship, class_name: 'Relationship', foreign_key: 'followee_id'
	has_many :media
end
