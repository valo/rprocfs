require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe "StatM" do
  it "should parse the info from the stat files" do
    File.stub!(:read).and_return("918 396 329 36 0 74 0")
    
    RProcFS.size(123).should == 918 * RProcFS::MEMORY_PAGESIZE
    RProcFS.resident(123).should == 396 * RProcFS::MEMORY_PAGESIZE
    RProcFS.share(123).should == 329 * RProcFS::MEMORY_PAGESIZE
    RProcFS.text(123).should == 36 * RProcFS::MEMORY_PAGESIZE
    RProcFS.lib(123).should == 0
    RProcFS.data(123).should == 74 * RProcFS::MEMORY_PAGESIZE
    RProcFS.dt(123).should == 0
  end
end
