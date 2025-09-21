class Context < ApplicationRecord
  has_many_attached :markdown
  has_one_attached :system_prompt

  before_save :generate_slug, if: -> { slug.blank? }


  private

  def generate_slug(slug_id = "")
    id = 5.times.map { [ *0..9 ].sample }.join

    if slug_id
      self.slug = title.parameterize.concat(slug_id)
    else
      self.slug = title.parameterize
    end

    self.class.find_by(slug: slug) ?
    generate_slug(id) : self.slug
  end
end
