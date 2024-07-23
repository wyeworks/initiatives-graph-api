module RestJsonUtils
  def shallow_url_to_id(url)
    url.sub!(%r{.*/}, "")
  end
end
