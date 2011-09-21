class CommentCreatedJob < Struct.new(:comment_id, :host) 

  def perform
    comment = Comment.find(comment_id)
    comment.send_notifications(host)
    Badge.assign_with_levels("commentator", comment.author.authored_comments.count, comment.author, [3, 10, 30], host)
  end

end