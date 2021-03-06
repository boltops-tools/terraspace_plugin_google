# Terraspace Google Cloud Plugin

Google Cloud support for [terraspace](https://terraspace.cloud/).

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'terraspace_plugin_google'
```

## Configure

Optionally configure the plugin. Here's an example `google.rb` for your terraspace project.

config/plugins/google.rb

```ruby
TerraspacePluginGoogle.configure do |config|
  config.auto_create = true # set to false to completely disable auto creation
  config.gcs.versioning = true
end
```

By default:

* GCS Buckets have [versioning](https://cloud.google.com/storage/docs/object-versioning) enabled.

The settings generally only apply if the gcs bucket does not yet exist yet and is created for the first time.

## Versioning

To confirm that the GCS bucket has versioning enabled:

    $ gsutil versioning get gs://my-bucket
    gs://my-bucket: Enabled
    $

Here's also how you list multiple versions of an object.

    $ gsutil ls gs://my-bucket
    gs://my-bucket/us-central1/
    $ echo hello1 > hello.txt
    $ gsutil cp hello.txt gs://my-bucket/hello.txt
    $ echo hello2 > hello.txt
    $ gsutil cp hello.txt gs://my-bucket/hello.txt
    $ gsutil ls gs://my-bucket/hello.txt
    gs://my-bucket/hello.txt
    $ gsutil ls -a gs://my-bucket/hello.txt
    gs://my-bucket/hello.txt#1590950916098856
    gs://my-bucket/hello.txt#1590950925738834
    $ gsutil cp gs://my-bucket/hello.txt#1590950916098856 hello1.txt

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/boltops-tools/terraspace_plugin_google.
