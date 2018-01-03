require 'json'

class ApiController < ApplicationController
  def index
    json = JSON.parse request.body.read.html_safe
    results = RpcSql.execute(json)
    render json: results
  end
end
