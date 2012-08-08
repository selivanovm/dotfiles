#!/usr/bin/env ruby

require 'date'
require 'net/http'

$CLOUDAPP_USER = "pelletier.thomas@gmail.com"
$CLOUDAPP_PASS = "xjm41s3l"

# Generate a file name.
$FNAME = Time.now.to_s.gsub(':', '-').gsub(' ', '-').gsub('+','') + ".png"

# Function to send a notification using libnotify
def notify(message)
  %x{notify-send "[Cloudshot] #{message}"}
end

# Create the file.
%x{import #{$FNAME}}

# Ask for the S3 info.
response = %x{curl http://my.cl.ly/items/new --digest -u "#{$CLOUDAPP_USER}:#{$CLOUDAPP_PASS}" -G -H "Accept: application/json"}

# Check that we haven't reached the limit.
/\"uploads_remaining\":(?<uploads_count>\d+)/ =~ response

if uploads_count.to_i == 0
  notify("Daily limit hit!")
  Process.exit
end

# Let's construct the S3 request.
response.gsub! "${filename}", $FNAME
/\"url\":\"(?<url>.+?)\"/ =~ response
/\"params\":{(?<params_raw>.+?)}/ =~ response

curl_cmd = ['curl']

params_raw.split(',').each do |param_raw|
  /\"(?<key>.+?)\":\"(?<val>.+)\"/ =~ param_raw
  curl_cmd << "-F \"#{key}=#{val}\""
end

# Add the file.
curl_cmd << "-F \"file=@#{$FNAME}\""
curl_cmd << url
curl_cmd << '-v'
curl_cmd << '-X POST'
curl_cmd << '2> /tmp/drop && cat /tmp/drop'

response = %x{#{curl_cmd.join(' ')}}

/< Location: (?<follow>.+)/ =~ response


response = %x{curl "#{follow.chomp}" --digest -u "#{$CLOUDAPP_USER}:#{$CLOUDAPP_PASS}" -G -H "Accept: application/json" -v}

/"url":"(?<final_url>.+?)"/ =~ response

%x{echo -n "#{final_url}" | xsel -i -b}

notify("New URL copied to the clipboard")
