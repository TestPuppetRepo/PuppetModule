require 'spec_helper'

describe 'ssh::server' do
	let (:facts) { {
		:osfamily	=> 'Debian'
	}}
		
	context "basic tests" do
		it { should contain_class('ssh::server') }
		it { should contain_package('openssh-server').with( :ensure => 'present' ) }
	    it { should contain_service('ssh').with(
                :ensure => true,
                :enable => true
            )}
        it { should contain_file('/etc/ssh/sshd_config').with(
                :owner  => 'root',
                :group  => 'root',
                :mode   => '0644'
           )}

        it { should contain_file('/etc/ssh/sshd_config').with_content(/\nSubsystem sftp \/usr\/lib\/openssh\/sftp-server\n/) }
    end


    context "different settings for permit_root_login" do
        context "with permit_root_login => yes" do
            let (:params) {{ :permit_root_login => 'yes' }}
            it { should contain_file('/etc/ssh/sshd_config').with_content(/\nPermitRootLogin yes\n/) }
        end
        context "with permit_root_login => no" do
            let (:params) {{ :permit_root_login => 'no' }}
            it { should contain_file('/etc/ssh/sshd_config').with_content(/\nPermitRootLogin no\n/) }
        end
        context "with permit_root_login => without-password" do
            let (:params) {{ :permit_root_login => 'without-password' }}
            it { should contain_file('/etc/ssh/sshd_config').with_content(/\nPermitRootLogin without-password\n/) }
        end  
        context "with permit_root_login => forced-commands-only" do
            let (:params) {{ :permit_root_login => 'forced-commands-only' }}
            it { should contain_file('/etc/ssh/sshd_config').with_content(/\nPermitRootLogin forced-commands-only\n/) }
        end  


    end

    context "RedHat-specific differences" do
        let (:facts) {{
            :osfamily   => 'RedHat'
        }}

        it { should contain_service('sshd').with(
                :ensure => true,
                :enable => true
            )}

        it { should contain_file('/etc/ssh/sshd_config').with_content(/\nSubsystem sftp \/usr\/libexec\/openssh\/sftp-server\n/) }
    end

	context "absence test" do
		let (:params) { { :ensure => 'absent' } }
		it { should contain_package('openssh-server').with( :ensure => 'absent' ) }
	end
end
