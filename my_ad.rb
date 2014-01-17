require_relative 'time_converter'
class MyAd

  def self.find(name, hash)
    ldap = Net::LDAP.new
    ldap.host = "172.16.2.12"
    ldap.port = 389
    ldap.auth hash[:username], hash[:password]
    ldap.bind

    filter = Net::LDAP::Filter.eq('cn', "#{name}*")
    base = 'ou=Elever, ou=Sodertorn, ou=ITG, dc=learnet, dc=se'
    entry_list = []
    ldap.search(:base => base, :filter => filter) do |entry|
      entry_list << entry
    end
    return entry_list
  end


  def self.old_people

    config = YAML::load_file('config.yaml')
    ldap = Net::LDAP.new
    ldap.host = "172.16.2.12"
    ldap.port = 389
    ldap.auth config['username'], config['password']
    ldap.bind

    filter = Net::LDAP::Filter.eq('cn', "max*")
    base = 'ou=Elever, ou=Sodertorn, ou=ITG, dc=learnet, dc=se'

    entry_list = []

    ldap.search(:base => base, :filter => filter) do |entry|
      if entry[:lastlogontimestamp]
       last_login = TimeConverter.ad_timestamp_to_datetime(entry[:lastlogontimestamp])

       diff = Time.diff(Time.parse(last_login.strftime("%F")), Time.parse(Time.now.strftime("%F")), '%d')
       diff[:diff]
        if diff[:diff].to_i >= 90
          entry_list << entry
        end
      end
    end
    return entry_list
  end
end