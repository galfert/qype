$: << File.join(File.dirname(__FILE__), '..')

require 'rubygems'
require 'context'
require 'mocha'

require 'qype'


def mock_client(response_file)
  response = File.read(response_file)
  mock(:get => response)
end
