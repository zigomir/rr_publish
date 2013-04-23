require 'spec_helper'

describe RRPublish do

  before(:each) do
    $config = SPEC + '/fixtures/config.yml'
    Dir[SPEC + '/fixtures/destination/*.txt'].each do |path|
      FileUtils.rm_rf(path)
    end
  end

  it 'should backup all profiles' do
    RRPublish::Sync.new($config).run
    File.exists?(SPEC + '/fixtures/destination/1.txt').should == true
    File.exists?(SPEC + '/fixtures/destination/2.txt').should == true
    File.exists?(SPEC + '/fixtures/destination/3.txt').should == true
    File.read(SPEC + '/fixtures/destination/1.txt').should == '1'
    File.read(SPEC + '/fixtures/destination/2.txt').should == '2'
    File.read(SPEC + '/fixtures/destination/3.txt').should == '3'
  end

  it 'should backup profile_1' do
    RRPublish::Sync.new($config, 'profile_1').run
    File.exists?(SPEC + '/fixtures/destination/1.txt').should == false
    File.exists?(SPEC + '/fixtures/destination/2.txt').should == true
    File.exists?(SPEC + '/fixtures/destination/3.txt').should == true
    File.read(SPEC + '/fixtures/destination/2.txt').should == '2'
    File.read(SPEC + '/fixtures/destination/3.txt').should == '3'
  end

  it 'should backup profile_2' do
    RRPublish::Sync.new($config, 'profile_2').run
    File.exists?(SPEC + '/fixtures/destination/1.txt').should == true
    File.exists?(SPEC + '/fixtures/destination/2.txt').should == false
    File.exists?(SPEC + '/fixtures/destination/3.txt').should == true
    File.read(SPEC + '/fixtures/destination/1.txt').should == '1'
    File.read(SPEC + '/fixtures/destination/3.txt').should == '3'
  end

  it 'should backup profile_3' do
    RRPublish::Sync.new($config, 'profile_3').run
    File.exists?(SPEC + '/fixtures/destination/1.txt').should == false
    File.exists?(SPEC + '/fixtures/destination/2.txt').should == true
    File.exists?(SPEC + '/fixtures/destination/3.txt').should == true
    File.read(SPEC + '/fixtures/destination/2.txt').should == '2'
    File.read(SPEC + '/fixtures/destination/3.txt').should == '3'
  end

  it 'should backup profile_6' do
    RRPublish::Sync.new($config, 'profile_6').run
    File.exists?(SPEC + '/fixtures/destination/1.txt').should == false
    File.exists?(SPEC + '/fixtures/destination/2.txt').should == true
    File.exists?(SPEC + '/fixtures/destination/3.txt').should == true
    File.read(SPEC + '/fixtures/destination/2.txt').should == '2'
    File.read(SPEC + '/fixtures/destination/3.txt').should == '3'
  end

end
