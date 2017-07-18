require 'spec_helper'
describe 'slurm' do

  on_supported_os.select { |_, f| f[:os]['family'] != 'Solaris' }.each do |os, f|
    context "on #{os}" do
      let(:facts) do
        f.merge(super())
      end
      it { is_expected.to compile.with_all_deps }
      describe "Testing dependencies between classes" do
        it { should contain_class('slurm::install') }
        it { should contain_class('slurm::config') }
        it { should contain_class('slurm::service') }
        it { is_expected.to contain_class('slurm::install').that_comes_before('Class[slurm::config]') }
      end
    end
  end
end
