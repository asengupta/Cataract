require 'digest/sha2'
include Digest

def sha_hash(key)
	Integer("0x" + (SHA2.new << key).to_s[-3..-1])/8192.0
end

