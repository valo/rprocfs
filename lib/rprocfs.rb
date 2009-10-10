$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), '..', 'ext', 'rprocfs'))
require 'native'

require 'rprocfs/stat'
require 'rprocfs/stat_m'

class RProcFS
  include Stat
  include StatM
  
  MEMORY_PAGESIZE = `getconf PAGESIZE`.to_i
end