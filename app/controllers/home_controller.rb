class HomeController < ApplicationController

  def index
	  redirect_to current_user if user_signed_in?
	end

  def create_letter   # официальное письмо
    phone = '+7(342)291-03-00'
    if user_signed_in?
      if current_user.phone
        phone = '+7(342)291-03-' + current_user.phone[1,2] if current_user.phone[0] == '2'
      else
        phone = '+7(342)291-03-00'
      end
      username = current_user.firstname.chr + '.' if current_user.firstname
      username += current_user.middlename.chr  + '.' if current_user.middlename
      username += ' ' + current_user.lastname
    else
      username = 'Незарегистрированный пользователь'
    end
    report = ODFReport::Report.new("reports/letter.odt") do |r|
      r.add_field "REPORT_DATE", Date.today.strftime('%d.%m.%Y')
      r.add_field "PHONE", phone
      r.add_field "USER_NAME", username
    end
    send_data report.generate, type: 'application/msword',
                              disposition: 'inline',
                              filename: 'letter.odt'
  end

end
