module HappyMapper
  module ClassMethods
    def parse(xml, o={})
      options = {
        :single => false,
        :use_default_namespace => false,
      }.merge(o)
      
      namespace = "default_ns:" if options[:use_default_namespace]
      doc = xml.is_a?(LibXML::XML::Node) ? xml : xml.to_libxml_doc
      
      nodes = if namespace
        node = doc.respond_to?(:root) ? doc.root : doc
        node.register_default_namespace(namespace.chop)
        node.find("#{namespace}#{get_tag_name}")
      else
        doc.find("//#{get_tag_name}")
      end
      
      collection = create_collection(nodes, namespace)
      
      # per http://libxml.rubyforge.org/rdoc/classes/LibXML/XML/Document.html#M000354
      nodes = nil
      GC.start
      
      options[:single] ? collection.first : collection
    end
  end
end