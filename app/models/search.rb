class Search < ApplicationRecord
  belongs_to :user

  validates :subject, presence: true, uniqueness: { scope: [:author, :sort_order] }

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
    params[:sort_order] = sort_order if sort_order
    params
  end

  def url
    [
      base_domain_with_version,
      '/books?',
      search_params.to_query
    ].join
  end

  def base_domain_with_version
    [
      Rails.application.config.base_domain,
      Rails.application.config.api_version
    ].join('/')
  end
end
