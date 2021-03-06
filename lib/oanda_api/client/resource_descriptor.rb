module OandaAPI
  module Client
    # @private
    # Metadata about a resource request.
    #
    # @!attribute [r] collection_name
    #   @return [Symbol] method name that returns a collection of the resource
    #     from the API response.
    #
    # @!attribute [r] path
    #   @return [String] path of the resource URI.
    #
    # @!attribute [r] resource_klass
    #   @return [Symbol] class of the resource.
    class ResourceDescriptor
      attr_reader :collection_name, :path, :resource_klass

      # Mapper for not "typical" resources.
      #   Key is a resource from the API path.
      #   Value is a hash that can contain "resource_name" from the code and/or
      #   "is_collection" (if true: will force treating response as a collection of resources,
      #   if false: will force treating response as a single resource).
      RESOURCES_MAPPER = {
          alltransactions: { resource_name: "transaction_history", is_collection: false }
      }

      # Analyzes the resource request and determines the type of resource
      # expected from the API.
      #
      # @param [String] path a path to a resource.
      #
      # @param [Symbol] method an http verb (see {OandaAPI::Client.map_method_to_http_verb}).
      def initialize(path, method)
        @path = path
        path.match(/\/(?<resource_name>[a-z]*)\/?(?<resource_id>\w*?)$/) do |names|
          initialize_from_resource_name(names[:resource_name], method, names[:resource_id])
        end
      end

      # True if the request returns a collection.
      # @return [Boolean]
      def is_collection?
        @is_collection
      end

      private

      # The resource type
      # @param [String] resource_name
      # @return [void]
      def resource_klass=(resource_name)
        klass_symbol = OandaAPI::Utils.classify(resource_name).to_sym
        fail ArgumentError, "Invalid resource" unless OandaAPI::Resource.constants.include?(klass_symbol)
        @resource_klass = OandaAPI::Resource.const_get klass_symbol
      end

      # Will set instance attributes based on resource_name, method and resource_id.
      #
      # @param [String] resource_name name of the resource (from the path).
      # @param [Symbol] method an http verb (see {OandaAPI::Client.map_method_to_http_verb}).
      # @param [Symbol] resource_id id of the resource.
      # @return [void]
      def initialize_from_resource_name(resource_name, method, resource_id)
        mapped_resource = RESOURCES_MAPPER.fetch(resource_name.to_sym,
                                                 { resource_name: Utils.singularize(resource_name) })
        self.resource_klass = mapped_resource.fetch :resource_name
        @is_collection      = mapped_resource.fetch :is_collection, method == :get && resource_id.empty?
        @collection_name    = Utils.pluralize(mapped_resource.fetch(:resource_name)).to_sym if is_collection?
      end
    end
  end
end
