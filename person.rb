class Person

  attr_reader :name, :lastdatestamp, :school, :memberof, :klass

  def self.from_list(list)
    list.map {|x| self.new(x)}
  end

  def initialize(hash)
    @name = hash[:cn].first
    @lastdatestamp = hash[:lastlogontimestamp]
    @school = hash[:physicaldeliveryofficename].first
    @memberof = hash[:memberof]
    @klass = self.find_group(hash[:memberof])
  end

  #def to_s
  #    days_last_login = self.days_since_last_logon(@lastdatestamp)
  #    info = ""
  #    info += @name + "\n"
  #    info += @school + "\n"
  #    info += self.lastlogondate(@lastdatestamp).strftime("%F, %T") + "\n"
  #    info += days_last_login + "\n"
  #    @memberof.each do |value|
  #      info += value.split(",").first.gsub("CN=itg_sod_gy", "Den har klassen").gsub("_", " ") + "\n"
  #    end
  #  return info
  #end

  def lastlogondate(ad_datestamp)
    return TimeConverter.ad_timestamp_to_datetime(ad_datestamp)
  end

  def days_since_last_logon(ad_datestamp)
    diff = Time.diff(Time.parse(self.lastlogondate(ad_datestamp).strftime("%F")), Time.parse(Time.now.strftime("%F")), '%d')
    return diff[:diff]
  end

  def find_group(list_of_groups)
    p self.name
    list_of_groups.each do |group|
      p '-----------------------'
      puts group
      p '-----------------------'
      data = group.match(/CN=itg_sod_gy_((11|12|13)_(TEK_A|TEK_B|SAM|EL|MU))/i)
      if data
        return data[1]
      end
    end
    return false
  end
end
