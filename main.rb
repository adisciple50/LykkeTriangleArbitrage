require_relative 'lykke_public_client'

public_client = LykkeRestApi::PublicClient.new

public_client.get_all_assets.each do |asset_struct|
  puts asset_struct.name
end



