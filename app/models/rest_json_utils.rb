module RestJsonUtils
  def shallow_url_to_id(url)
    url.sub!(%r{.*/}, "")
  end

  def url_to_wyeworker(url)
    Wyeworker.find(shallow_url_to_id(url))
  end

  def wyeworker_to_url(wyeworker)
    "#{wyeworker.is_a?(Manager) ? 'managers' : 'developers'}/#{wyeworker.id}"
  end

  def initiative_to_url(initiative)
    "initiatives/#{initiative.id}"
  end

  def url_to_initiative(url)
    Initiative.find(shallow_url_to_id(url))
  end
end
