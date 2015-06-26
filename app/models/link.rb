require 'openssl'
require 'base32'

class Link < ActiveRecord::Base
  belongs_to :user
  has_and_belongs_to_many :tags
  has_many :snapshots

  def jothash
    # d = hmac.new(HMAC_KEY, url, hashlib.md5).digest()
    hmac = OpenSSL::HMAC.new('Jotmuch', OpenSSL::Digest.new('md5'))
    hmac << url

    # padding is always '======', so drop it:
    # return base64.b32encode(d).lower()[:-6]
    Base32.encode(hmac.digest)[0..-7].downcase
  end

  def mhtml
    path = Path["~/.jotmuch/archives/#{jothash}.mhtml"]
    path.exists? ? path : nil
  end

  def latest_snapshot
    snapshots.order(:created_at).last
  end
end
