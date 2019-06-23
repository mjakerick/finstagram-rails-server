class Pic
  if(ENV['DATABASE_URL'])
    uri = URI.parse(ENV['DATABASE_URL'])
    DB = PG.connect(uri.hostname, uri.port, nil, nil, uri.path[1..-1], uri.user, uri.password)
  else
    DB = PG.connect(host: "localhost", port: 5432, dbname: 'finstagram-rails-server_development')
  end

  def self.all
    results = DB.exec("SELECT * FROM pics;")
    return results.map do |result|
      if result["liked"] === 'f'
        {
          "id" => result["id"].to_i,
          "name" => result["name"],
          "picture" => result["picture"],
          "description" => result["description"],
          "liked" => false
        }
      else
        {
          "id" => result["id"].to_i,
          "name" => result["name"],
          "picture" => result["picture"],
          "description" => result["description"],
          "liked" => true
        }
      end
    end
  end

  def self.find(id)
    results = DB.exec("SELECT * FROM pics WHERE id=#{id};")
    if results.first["liked"] === 'f'
      return {
        "id" => results.first["id"].to_i,
        "name" => results.first["name"],
        "picture" => results.first["picture"],
        "description" => results.first["description"],
        "liked" => false
      }
    else
      {
        "id" => results.first["id"].to_i,
        "name" => results.first["name"],
        "picture" => results.first["picture"],
        "description" => results.first["description"],
        "liked" => true
      }
    end
  end

  def self.create(opts)
    results = DB.exec(
      <<-SQL
        INSERT INTO pics (name, picture, description)
        VALUES ('#{opts["name"]}', '#{opts["picture"]}', '#{opts["description"]}')
        RETURNING id, name, picture, description;
      SQL
    )
    return {
      "id" => results.first["id"].to_i,
      "name" => results.first["name"],
      "picture" => results.first["picture"],
      "description" => results.first["description"]
    }
  end

  def self.delete(id)
      results = DB.exec("DELETE FROM pics WHERE id=#{id};")
      return { "deleted" => true }
  end

  def self.update(id, opts)
    results = DB.exec(
      <<-SQL
        UPDATE pets
        SET name='#{opts["name"]}', picture='#{opts["picture"]}', description='#{opts["description"]}'
        WHERE id=#{id}
        RETURNING id, name, picture, description;
      SQL
    )
    return {
      "name" => results.first["name"],
      "picture" => results.first["picture"],
      "description" => results.first["description"]
    }
  end
end
