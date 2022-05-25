module ApiUtils
  def json
    JSON.parse(response.body)
  end
end
