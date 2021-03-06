require('pg')


class Bounty

  attr_reader(:id)
  attr_accessor :name, :value, :favourite_weapon, :danger_level

  def initialize(options)
      @id = options['id'].to_i if options ['id']
      @name = options['name']
      @value = options['value'].to_i
      @favourite_weapon = options['favourite_weapon']
      @danger_level = options['danger_level']
    end


  def self.all
    db = PG.connect({dbname: 'space_cowboys', host: 'localhost'})
    sql = "SELECT * FROM bounties"
    db.prepare("all", sql)
    bounties = db.exec_prepared("all")
    p bounties.to_a()
    p bounties
    db.close()
    return bounties.map {|bounty_hash| Bounty.new(bounty)}
  end


    def save()
        db = PG.connect({dbname: 'space_cowboys', host: 'localhost'})
        sql =
        "INSERT INTO bounties
        (name, value, favourite_weapon, danger_level)

        VALUES
        ($1, $2, $3, $4)
        RETURNING id
        "
        #confused why you can return id here
        values = [@name, @value, @favourite_weapon, @danger_level]
        db.prepare("save", sql)

        @id = db.exec_prepared("save", values)[0]['id'].to_i
        db.close()
      end

def update()
      db = PG.connect({dbname: 'space_cowboys', host: 'localhost'})
      sql = "UPDATE bounties
       SET (
         name,
         value,
         favourite_weapon,
         danger_level
       ) = ( $1, $2, $3, $4)
       WHERE id = $5"
      values = [@name, @value, @favourite_weapon, @danger_level, @id]
      db.prepare("update", sql)
      db.exec_prepared("update", values)
      db.close()
  end

  def Bounty.delete_by_id(id)
    db = PG.connect({dbname: 'space_cowboys', host: 'localhost'})
    sql = "DELETE FROM bounties WHERE id = $1"
    values = [id]
    db.prepare("delete_by_id", sql)
    db.exec_prepared("delete_by_id", values)
    db.close()
  end

  def delete()
    db = PG.connect({dbname: 'space_cowboys', host: 'localhost'})
    sql = "DELETE FROM bounties WHERE id = $1"
    values = [@id]
    db.prepare("delete_one", sql)
    db.exec_prepared("delete_one", values)
    db.close()
  end

  def self.delete_all
    db = PG.connect({dbname: 'space_cowboys', host: 'localhost'})
    sql = "DELETE FROM bounties"
    db.prepare("delete_all", sql)
    db.exec_prepared("delete_all")
    db.close()
  end

  def self.find(id)
    db = PG.connect({dbname: 'space_cowboys', host: 'localhost'})
    sql = "SELECT * FROM bounties WHERE id = $1"
    values = [id]
    db.prepare("find", sql)
    results_array = db.exec_prepared("find", values)
    bounty_hash = results_array[0]
    db.close()
    bounty = Bounty.new(bounty_hash)
    return bounty

  end


end
