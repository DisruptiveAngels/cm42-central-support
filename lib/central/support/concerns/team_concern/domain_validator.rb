module Central
  module Support
    module TeamConcern
      module DomainValidator
        DOMAIN_SEPARATORS_REGEX = /[,;\|\n]/

        def allowed_domain?(email)
          whitelist = ( registration_domain_whitelist || "" ).split(DOMAIN_SEPARATORS_REGEX).map(&:strip)
          blacklist = ( registration_domain_blacklist || "" ).split(DOMAIN_SEPARATORS_REGEX).map(&:strip)
          has_whitelist = true
          has_whitelist = whitelist.any? { |domain| email.include?(domain) } unless whitelist.empty?
          has_blacklist = false
          has_blacklist = blacklist.any? { |domain| email.include?(domain) } unless blacklist.empty?
          has_whitelist && !has_blacklist
        end
      end
    end
  end
end
