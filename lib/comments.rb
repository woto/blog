module Comments
  def self.getComments(id)
    id = id.to_i
    id = id.to_s
    Post.find_by_sql('select c2.body, c2.id, count(*) as lvl from comments c1, comments c2 where c1.post_id = ' + id + ' and c2.lft between c1.lft and c1.rgt group by c2.id order by c2.lft')
  end
end
