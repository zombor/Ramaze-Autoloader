class Tutorial < Ramaze::Controller
  map '/'
  engine :mustache

  def index
    "Hello, world!"
  end
end