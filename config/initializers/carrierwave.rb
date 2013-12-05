CarrierWave.configure do |config|
  config.fog_credentials = {
    :provider               => 'AWS',                        # required
    :aws_access_key_id      => ENV["AWS_ACCESS_KEY"],                        # required
    :aws_secret_access_key  => ENV["AWS_SECRET_KEY"],                        # required
    :region                 => 'us-west-2',                  # optional, defaults to 'us-east-1'
 
  }
  config.fog_directory  = 'imagenesactas'                     # required
  config.fog_public     = false                                    # optional, defaults to true
  config.fog_attributes = {'Cache-Control'=>'max-age=315576000'}  # optional, defaults to {}
end