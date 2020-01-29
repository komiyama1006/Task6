class Book < ApplicationRecord

	#バリデーションは該当するモデルに設定する。エラーにする条件を設定できる。
	#presence trueは空欄の場合を意味する。
	validates :title, presence: true
	validates :body, {presence: true, length: {maximum: 200}}

	belongs_to :user
	# 下記は、コメント機能
	has_many :book_comments, dependent: :destroy
	# 下記は、コメント機能
	has_many :favorites, dependent: :destroy
	def favorited_by?(user)
		favorites.where(user_id: user.id).exists?
	end
end
