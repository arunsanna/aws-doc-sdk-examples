require 'aws-sdk'

# Create a new SES resource and specify a region
# Replace us-west-2 with the AWS Region you're using for Amazon SES.
ses = Aws::SES::Client.new(region: 'us-west-2')

begin
  # Get send statistics so we don't ruin our reputation
  resp = ses.get_send_statistics({})

  dps = resp.send_data_points

  puts "Got #{dps.count} data point(s):"
  puts

  dps.each do |dp|
    puts "Timestamp:  #{dp.timestamp}" #=> Time
    puts "Attempts:   #{dp.delivery_attempts}" #=> Integer
    puts "Bounces:    #{dp.bounces}" #=> Integer
    puts "Complaints: #{dp.complaints}" #=> Integer
    puts "Rejects:    #{dp.rejects}"  #-> Integer
    puts
  end

# If something goes wrong, display an error message.
rescue Aws::SES::Errors::ServiceError => error
  puts "Error: #{error}"
end
