CarrierWave.configure do |config|
  config.fog_credentials = {
    :provider               => 'AWS',                        # required
    :aws_access_key_id      => ENV["AWS_ACCESS_KEY"],                        # required
    :aws_secret_access_key  => ENV["AWS_SECRET_KEY"],                        # required
    :region                 => 'us-west-2',                  # optional, defaults to 'us-east-1'
    :host                   => 'imagenesactas.s3-website-us-west-2.amazonaws.com',             # optional, defaults to nil
    :endpoint               => 'http://imagenesactas.s3-website-us-west-2.amazonaws.com' # optional, defaults to nil
  }
  config.fog_directory  = 'actas'                     # required
  config.fog_public     = false                                   # optional, defaults to true
  config.fog_attributes = {'Cache-Control'=>'max-age=315576000'}  # optional, defaults to {}
end