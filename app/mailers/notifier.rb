module QuoVadis
  class Notifier < ActionMailer::Base
    # Sends an email to <tt>user</tt> with a link to a page where they
    # can change their password.
    def change_password(user)
      @username = user.username
      @url = change_password_url user.token
      mail :to => user.email, :from => QuoVadis.from, :subject => QuoVadis.subject
    end
  end
end



class Notifier < ActionMailer::Base
  def interview_schedule_mail(interview)
    @user = User.find_by_id(interview.user_id)
    @candidate = Candidate.find_by_id(interview.candidate_id)
    @interview = interview
    attachments[@candidate.resume_file_name] = File.read(@candidate.resume.path)
    mail :to => @user.email, :from => "rapbhantest@gmail.com", :subject => "Interview Scheduled"
  end

  def interview_reschedule_mail(interview)
    @user = User.find_by_id(interview.user_id)
    @candidate = Candidate.find_by_id(interview.candidate_id)
    @interview = interview
    attachments[@candidate.resume_file_name] = File.read(@candidate.resume.path)
    mail :to => @user.email, :from => "rapbhantest@gmail.com", :subject => "Interview rescheduled"
  end

  def interview_cancel_mail(user_id,candidate_id,scheduled_at,schedule_time)
    @usr = User.find_by_id(user_id.to_s)
    @candidate_obj = Candidate.find_by_id(candidate_id)
    @scheduled_at = scheduled_at
    @schedule_time = schedule_time
    mail :to => @usr.email, :from => "rapbhantest@gmail.com", :subject => "Interview cancelled"
  end

  def interview_feedback_mail(comment)
    @user = User.find_by_id(comment.user_id)
    @candidate = Candidate.find_by_id(comment.candidate_id)
    @interview = Interview.find_by_id(comment.interview_id)
    @comment = comment
    mail :to => "priya.t@imaginea.com", :from => @user.email, :subject => "Interview Feedback"
  end
end