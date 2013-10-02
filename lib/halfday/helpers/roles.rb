def role_available?(role)
  find_servers(:roles => role).count > 0
end
