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
    rpc.sql_join
    rpc.sql_left_outer_join
    rpc.sql_full_outer_join
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

  def sql_join
    #ActiveRecord::Sanitization.sanitize_sql_array([
    #  "and ? on ? ? ?", params[1], params[2], params[3]])
    return if @json['join'].size == 0
    @json['join'].each do |params|
      if(params[0] == 'and')
        @sql << "and #{params[1]} #{params[2]} #{params[3]}"
      else
        @sql << "join #{params[0]} on #{params[1]} #{params[2]} #{params[3]}"
      end
    end
  end

  def sql_left_outer_join
    return if @json['leftOuterJoin'].size == 0
    @json['leftOuterJoin'].each do |params|
      if(params[0] == 'and')
        @sql << "and #{params[1]} #{params[2]} #{params[3]}"
      else
        @sql << "left outer join #{params[0]} on #{params[1]} #{params[2]} #{params[3]}"
      end
    end
  end

  def sql_full_outer_join
    return if @json['fullOuterJoin'].size == 0
    @json['fullOuterJoin'].each do |params|
      if(params[0] == 'and')
        @sql << "and #{params[1]} #{params[2]} #{params[3]}"
      else
        @sql << "left outer join #{params[0]} on #{params[1]} #{params[2]} #{params[3]}"
      end
    end
  end

  def sql_where
    return if @json['where'].size == 0
    @json['where'].each do |params|
      if(params[0] == 'and')
        @sql << "and #{params[1]} #{params[2]} #{params[3]}"
      else
        @sql << "where #{params[0]} #{params[1]} #{params[2]}"
      end
    end
  end

  def sql_group_by
    return if @json['groupBy'] == ""
    @sql << "group by #{@json['groupBy']}"
  end

  def sql_order
    return if @json['orderBy'].size == 0
    @sql << "order by #{@json['orderBy'][0]} #{@json['orderBy'][1]}"
  end
end
