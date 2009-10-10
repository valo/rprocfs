require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe "Stat" do
  it "should parse the info from the stat files" do
    File.stub!(:read).and_return("2452 (imap-login) S 2411 2411 2411 0 -1 4202752 501 0 0 0 20 3 0 0 20 0 1 0 4462 3760128 396 4294967295 3086491648 3086638316 3215609600 3215609124 3086365732 0 0 4096 16386 3223266791 0 0 17 0 0 0 0 0 0")
    
    RProcFS.pid(123).should == 2452
    RProcFS.utime(123).should == 20.0 / RProcFS::CLOCKS_PER_SEC
    RProcFS.stime(123).should == 3.0 / RProcFS::CLOCKS_PER_SEC
    RProcFS.comm(123).should == "imap-login"
    RProcFS.state(123).should == "S"
    RProcFS.vsize(123).should == 3760128
  end
end
