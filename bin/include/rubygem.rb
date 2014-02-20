def rubygem(gem, req = gem)
  begin
    require req
  rescue LoadError => e
    puts %{Failed to load gem "#{gem}"}
    exit(1)
  end
end
