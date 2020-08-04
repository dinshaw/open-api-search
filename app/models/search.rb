class Search < ApplicationRecord
  belongs_to :user

  validates :subject, presence: true, uniqueness: { scope: [:author, :sort_order] }

  def url
    [
      Rails.application.config.open_library_uri,
      '/books?',
      search_params.to_query
    ].join
  end

  def as_json(_ops = {})
    {
      author: author,
      id: id,
      sort_order: sort_order,
      subject: subject,
      url: url
    }
  end

  private

  def search_params
    params = { subject: subject }
    params[:author] = author if author
    params
  end
end
