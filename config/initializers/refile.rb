require "refile/s3"

aws = {
  access_key_id: "AKIAIVCNM2WQTTC5H66A",
  secret_access_key: "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",
  region: "ap-southeast-1",
  bucket: "invoiced-heroku",
}
Refile.cache = Refile::S3.new(prefix: "cache", **aws)
Refile.store = Refile::S3.new(prefix: "store", **aws)