class RpcSql
  attr_accessor :sql, :json

  def initialize(json)
    @sql = []
    @json = json
  end

  def self.execute(json)
    rpc = RpcSql.new(json)
    rpc.sql_select
    rpc.sql_from
    rpc.sql_joins
    rpc.sql_where
    rpc.sql_group_by
    rpc.sql_order

    begin
      results = rpc.execute_sql
      return rpc.format_response results
    rescue => e
      return rpc.format_response e
    end
  end

  def format_response(results)
    if results.is_a? Exception
      return { error: results.to_s }
    end

    results.each do |h|
      h.delete_if {|key, value| key.is_a? Integer }
    end

    return { data: results }
  end

  def execute_sql
    sql = @sql.join(' ')
    return ActiveRecord::Base.connection.execute(sql)
  end

  def sql_select
    return @sql << "select *" if @json['select'].size == 0
    @sql << "select #{@json['select'].join(', ')}"
  end

  def sql_from
    @sql << "from #{@json['from']}"
  end

  def sql_joins
    return if @json['joins'].size === 0
    @sql << @json['joins'].join("\n")
  end

  def sql_where
    return if @json['where'].size === 0
    @sql << "where " + @json['where'].join("\n")
  end

  def sql_group_by
    return if @json['groupBy'].size === 0
    @sql << "group by " + @json['groupBy'].join("\n")
  end

  def sql_order
    return if @json['orderBy'].size === 0
    @sql << "order by " + @json['orderBy'].join("\n")
  end
end
