module Sepa
  module PaymentsInitiation
    module Pain00800104
    end

    module Pain00800202
    end
  end
end

Dir["lib/sepa/payments_initiation/*.rb"].each do |f|
  require f.gsub("lib/", "")
end

Dir["lib/sepa/payments_initiation/pain00800104/**/*.rb"].each do |f|
  require f.gsub("lib/", "")
end

Dir["lib/sepa/payments_initiation/pain00800202/**/*.rb"].each do |f|
  require f.gsub("lib/", "")
end
