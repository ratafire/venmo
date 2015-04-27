module Venmo
  module Pay
    def pay_by_email(email, amount, note, access_token, privacy)
      # -d email= \
      @send_hash= common(amount,note,access_token,privacy, { :email => email})
      core_pay
    end

    def pay_by_user_id(user_id, amount, note, access_token, privacy)
      # -d user_id= \
      @send_hash= common(amount,note,access_token,privacy, {:user_id => user_id})
      core_pay
    end

    def pay_by_phone_number(phone_number, amount, note, access_token, privacy)
      # -d phone= \
      @send_hash = common(amount,note,access_token,privacy, {:phone=> phone_number})
      core_pay
    end

    protected
    def common(new_amount, new_note, access_token, privacy, merge_in)
      {
       amount: new_amount,
       note: new_note,
       access_token: access_token,
       audience: privacy,
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
