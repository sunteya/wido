# == Schema Information
#
# Table name: lists
#
#  id         :integer          not null, primary key
#  user_id    :integer
#  syscode    :string(255)
#  name       :string(255)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class List < ActiveRecord::Base
  belongs_to :user
  has_many :links
  has_many :articles
  
  validates :user_id, presence: true
  validates :name, presence: true

  scope :customable, ->() { where(syscode: nil) }
  
  def to_label
    self.name.present? ? self.name : self.syscode
  end

  def include?(object)
    object.list == self
  end

  def to_route(view)
    ListRoute.new(view, self)
  end

  class ListRoute
    attr_accessor :view, :collation

    def initialize(view, collation)
      self.view = view
      self.collation = collation
    end

    def root_path
      view.workspace_list_path(collation.id)
    end
    
    def link_path(link)
      view.workspace_list_link_path(collation.id, link)
    end

    def links_path
      view.workspace_list_links_path(collation.id)
    end

    def edit_link_path(link)
      view.edit_workspace_list_link_path(collation.id, link)
    end

    def articles_path
      view.workspace_list_articles_path(collation.id)
    end

    def article_path(article)
      view.workspace_list_article_path(collation.id, article)
    end

    def edit_article_path(article)
      view.edit_workspace_list_article_path(collation.id, article)
    end
  end

end
