require 'rubygems'
require 'httparty'
require 'happymapper'

$:.unshift(File.join(File.dirname(__FILE__)))

require 'httparty_patch'
require 'happymapper_patch'
require 'qype/client'
require 'qype/models'
