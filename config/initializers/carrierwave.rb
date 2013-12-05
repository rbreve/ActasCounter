CarrierWave.configure do |config|
  config.fog_credentials = {
    :provider               => 'AWS',                        # required
    :aws_access_key_id      => 'AKIAJBP6OA6EIVX7FGEA',                        # required
    :aws_secret_access_key  => '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',                        # required
    :region                 => 'us-west-2',                  # optional, defaults to 'us-east-1'
    :host                   => 'imagenesactas.s3-website-us-west-2.amazonaws.com',             # optional, defaults to nil
    :endpoint               => 'http://imagenesactas.s3-website-us-west-2.amazonaws.com' # optional, defaults to nil
  }
  config.fog_directory  = 'actas'                     # required
  config.fog_public     = false                                   # optional, defaults to true
  config.fog_attributes = {'Cache-Control'=>'max-age=315576000'}  # optional, defaults to {}
end