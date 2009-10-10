module StatM
  def self.included(base)
    base.extend ClassMethods
  end

  module ClassMethods
    STATM_FIELDS = [:size, :resident, :share, :text, :lib, :data, :dt]
    PAGES_TO_BYTES = lambda { |value| value.to_i * RProcFS::MEMORY_PAGESIZE }
    STATM_FIELDS_FORMAT = STATM_FIELDS.inject({}) { |hash, field| hash[field] = PAGES_TO_BYTES; hash }

    def parse(pid)
      stat = File.read("/proc/#{pid}/statm").chomp.split(" ")

      result = {}

      STATM_FIELDS.zip(stat) do |field, value|
        case STATM_FIELDS_FORMAT[field]
          when Symbol
            result[field] = value.send(STATM_FIELDS_FORMAT[field])
          when Proc
            result[field] = STATM_FIELDS_FORMAT[field].call(value)
        end
       end
       
       result
    end

    STATM_FIELDS.each do |field|
      define_method field do |pid|
        parse(pid)[field]
      end
    end
  end
end