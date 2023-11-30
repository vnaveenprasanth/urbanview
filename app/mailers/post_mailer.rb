class PostMailer < ApplicationMailer
    def new_post_notification(user, post)
        @user = user
        @post = post
        mail(to: @user.email, subject: 'New Post Notification')
    end

    def going_notification(user, post,count)
        @user = user
        @post = post
        @count = count
        mail(to: @user.email, subject: 'Event Update: Going Notification')
    end
end
