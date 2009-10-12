$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), '..', 'ext', 'rprocfs'))
require 'native'

require 'rprocfs/stat'
require 'rprocfs/stat_m'

class RProcFS
  include RProcFS::Stat
  include RProcFS::StatM
end