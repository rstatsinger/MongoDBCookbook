# # encoding: utf-8

# Inspec test for recipe mongodb::default

# The Inspec reference, with examples and extensive documentation, can be
# found at http://inspec.io/docs/reference/resources/

# unless os.windows?
  # This is an example test, replace with your own test.
#   describe user('root'), :skip do
#     it { should exist }
#   end
# end

# This is an example test, replace it with your own test.
# describe port(80), :skip do
#   it { should_not be_listening }
# end

# our end goal - is mongo daemon running?

describe command('curl http://localhost:27017') do
  	its('stdout') { should match /MongoDB/ }
end

# users and groups

describe group('mongo') do
	it { should exist }
end

describe user('mongo') do
	it { should exist }
	its('groups') { should include 'mongo' }
	its('home') { should eq '/opt/mongodb' }
end



describe package('mongodb-org') do
	it { should be_installed }
end


describe file('/etc/yum.repos.d/mongodb-org-3.4.repo') do
	it { should exist }
end


# directories

describe directory('/opt/mongodb') do
	it { should exist }
	its('group') { should eq 'mongo' }
	it { should be_executable.by('group') }
	it { should be_readable.by('group') }
	it { should be_writable.by('group') }
end


# sshd config
 
# describe sshd_config do
# 	its('PasswordAuthentication') { should eq 'yes' }
# end
