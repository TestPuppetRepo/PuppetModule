require 'spec_helper'

describe 'ssh_keygen' do
	context "test for expected exceptions" do
		it "raises expected error with no arguments" do
			should run.with_params().and_raise_error(Puppet::ParseError, /argument must be a Hash/)
		end


	end
end
