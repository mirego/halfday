def require_recipe(path)
  begin
    require path
  rescue LoadError
    "> Unable to load #{path}"
  end
end
