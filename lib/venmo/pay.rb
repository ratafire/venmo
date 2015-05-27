module Venmo
  module Pay
    def pay_by_email(email, amount, note, recipient_access_token)
      # -d email= \
      @send_hash= common(amount,note,recipient_access_token, { :email => email})
      core_pay
    end

    def pay_by_user_id(user_id, amount, note,recipient_access_token)
      # -d user_id= \
      @send_hash= common(amount,note,recipient_access_token, {:user_id => user_id})
      core_pay
    end

    def pay_by_phone_number(phone_number, amount, note,recipient_access_token)
      # -d phone= \
      @send_hash = common(amount,note,recipient_access_token, {:phone=> phone_number})
      core_pay
    end

    protected
    def common(new_amount, new_note,recipient_access_token, merge_in)
      {
       amount: new_amount,
       note: new_note,
       access_token: recipient_access_token,
       audience: (Venmo.privacy || "private")
      }.merge(merge_in)
    end


    def core_pay
      h = @send_hash.collect{|k,v| "#{k.to_s}=#{v.respond_to?(:gsub) ? CGI::escape(v) : v}"}.join('&')
      if Rails.env.production?
        to_send = "curl https://api.venmo.com/v1/payments --data \"#{h}\""
      else
        to_send = "curl https://sandbox-api.venmo.com/v1/payments --data \"#{h}\""
      end
      `#{to_send}`
    end
  end
end
