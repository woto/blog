module Tags
  def self.getTagsCloud(scope = nil)
    scope = Post unless scope
    scope.tag_counts(:order => "count DESC", :limit => 30).sort_by{|tag| tag.name.downcase}
  end
end
