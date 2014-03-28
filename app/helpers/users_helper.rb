module UsersHelper

  def gravatar_for(user, options={})
    gravatar_id = Digest::MD5::hexdigest(user.email.downcase)
    gravatar_url = "https://secure.gravatar.com/avatar/#{gravatar_id}"
    options[:alt] = user.name
    options[:class] = "gravatar"
    options[:size] = options[:size].to_s unless options[:size].nil?
    image_tag(gravatar_url, options)
  end
end
