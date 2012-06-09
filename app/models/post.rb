class Post
  include Tire::Model::Search
  include Tire::Model::Callbacks
  include Tire::Model::Persistence

  validates_presence_of :title

  property :title,        :boost => 2, :type => :string
  property :body,         :type => :string
  property :created_at,   :type => 'date'
  property :tags,         :default => [], :analyzer => 'keyword', :type => :string
  
  before_save {self.created_at = Time.now}
  
  def __cast_value(name, value)
    value = super
    value = Time.parse(value) if value.is_a?(String) && value =~ /^\d{4}[\/\-]\d{2}[\/\-]\d{2}T\d{2}\:\d{2}\:\d{2}(Z|[-+]\d{2}?(:\d{2})?)$/
    value
  end
end