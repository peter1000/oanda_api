# The module that contains everything OandaAPI-related:
require 'httparty'
require 'persistent_httparty'
require 'http/exceptions'
require 'time'

require_relative 'oanda_api/configuration'
require_relative 'oanda_api/client/client'
require_relative 'oanda_api/client/namespace_proxy'
require_relative 'oanda_api/client/resource_descriptor'
require_relative 'oanda_api/client/token_client'
require_relative 'oanda_api/client/username_client'
require_relative 'oanda_api/streaming/client'
require_relative 'oanda_api/streaming/json_parser'
require_relative 'oanda_api/streaming/request'
require_relative 'oanda_api/errors'
require_relative 'oanda_api/resource_base'
require_relative 'oanda_api/resource_collection'
require_relative 'oanda_api/resource/account'
require_relative 'oanda_api/resource/instrument'
require_relative 'oanda_api/resource/candle'
require_relative 'oanda_api/resource/heartbeat'
require_relative 'oanda_api/resource/order'
require_relative 'oanda_api/resource/position'
require_relative 'oanda_api/resource/price'
require_relative 'oanda_api/resource/trade'
require_relative 'oanda_api/resource/transaction'
require_relative 'oanda_api/resource/transaction_history'
require_relative 'oanda_api/utils/utils'
require_relative 'oanda_api/version'
