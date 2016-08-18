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

  class NanosemanticError < StandardError; end
  class ResultError < NanosemanticError; end
  class RequestError < NanosemanticError; end

  attr_reader :uuid, :clientid, :error, :errormsg, :last_request, :last_response, :api

  def default_url
  	'https://biz.nanosemantics.ru/api/bat/nkd/json/'

  end

  def initialize(opt = {})
  	prepare_ulr
  	@uuid = opt[:uuid]
  	@clientid = opt[:clientid]
  end

  def request(iface, opt ={})
    raise ArgumentError, "should be hash" unless opt.kind_of?(Hash)
    opt[:uuid] = @uuid
    opt[:clientid] = @clientid
    res = https_request(iface, make_body(iface, opt).to_json)
    doc = JSON.parse(res)
    parse_retval(iface, doc)
    make_result(iface, doc)
  end  


  def https_request(iface, req_body)

    @last_request = @last_response = nil
    url = @api[iface]

#    https = Net::HTTP.new(url.host, url.port, proxy_addr, proxy_port) 
    http = Net::HTTP.new(url.host, url.port) 
    
    https.use_ssl = true

    @last_request = req_body 
    puts req_body
    puts url.path
  	@last_response = result = https.post( url.path, req_body, "Accept" => "application/json" )

    case result
      when Net::HTTPSuccess
        result.body
      else
        @error = result.code
        raise RequestError, @error
    end  	
  end

  def make_body(iface, opt)
  	iface_func = "json_#{iface}"
  	send(iface_func, opt)
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
