class Person

  attr_reader :name, :lastdatestamp, :school

  def self.from_list(list)
    list.map {|x| self.new(x)}
  end

  def initialize(hash)
    @name = hash[:cn].first
    @lastdatestamp = hash[:lastlogontimestamp]
    @school = hash[:physicaldeliveryofficename].first
    @memberof = hash[:memberof]
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

  #def lastlogondate(ad_datestamp)
  #  return TimeConverter.ad_timestamp_to_datetime(ad_datestamp)
  #end
  #
  #def days_since_last_logon(ad_datestamp)
  #  diff = Time.diff(Time.parse(self.lastlogondate(ad_datestamp).strftime("%F")), Time.parse(Time.now.strftime("%F")), '%d')
  #  return diff[:diff]
  #end

end