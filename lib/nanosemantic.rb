require "nanosemantic/version"
require 'time'
require 'net/http'
require 'net/https'
require 'json'
require 'rubygems'
require 'json_builder'

$LOAD_PATH.unshift(File.expand_path(File.dirname(__FILE__) + "/../lib"))
%w(interfaces request_json request_retval request_result).each{|lib| require lib}


module Nanosemantic
  # Your code goes here...
  include RequestRetval
  include RequestResult
  include RequestJson

  class ResultError < StandardError; end

  attr_reader :error, :errormsg, :last_request, :last_response, :interfaces

  def default_url
  	'http://biz.nanosemantics.ru/api/axe/nkd/json/'
  end

  def initialize(opt = {})
  	prepare_ulr
  	@uuid = Inf.new(opt[:uuid])
  	@clientid = Inf.new(opt[:clientid])
  end

  def request(iface, opt ={})
    raise ArgumentError, "should be hash" unless opt.kind_of?(Hash)
    opt[:uuid] = @uuid
    opt[:client] = @clientid
    res = http_request(iface, make_body(iface, opt))
    doc = JSON.parse(res)
    parse_retval(iface, doc)
    make_result(iface, doc)
  end  


  def http_request(iface, req_body)
    @last_request = @last_response = nil

    url = @interfaces[iface]

    http = Net::HTTP.new(url.host, url.port)  	
  	@last_response = result = http.post( url.path, req_body, , "Accept" => "application/json" )

    case result
      when Net::HTTPSuccess
        result.body
      else
        @error = result.code
        @errormsg = result.body if result.class.body_permitted?()
        raise RequestError, [@error, @errormsg].join(' ')
    end  	
  end

  def make_body(iface, opt)
  	iface_func = "json_#{iface}"
  	send(iface, opt)
  end

  def parse_retval(iface, doc)         
    method = "retval_#{iface}"
    if respond_to?(method)
      send(method, doc)
    else
      retval_global(doc)
    end
  end

  def make_result(iface, doc)        
    iface_result = "result_#{iface}"
    send(iface_result, doc)
  end

end