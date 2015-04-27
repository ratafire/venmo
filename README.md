venmo
=====

Venmo API Integration

====
Change Log:

0.4.0: Fix for calling to phone_number and not phone as arguments in curl.

Recent Fixes in 0.3.2

Curl now posts to endpoint with --data call.


====

#For privacy: private, public, friends are vaild options

Venmo.pay_by_email(email, amount, note, access_token, privacy)

Venmo.pay_by_user_id(user_id, amount, note, access_token, privacy)

Venmo.pay_by_phone_number(phone_number, amount, note, access_token, privacy)

I think these are working. Tests coming soon. 

After install update these values to reflect your Environment

Venmo.configure do |c|
  c.access_token= "My Super Secret API"
  c.privacy= "private"
  #private, public, friends are vaild options
  #see Venmo documentation
end
