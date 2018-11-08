# frozen_string_literal: true

case os[:family]

when 'redhat'

  describe yum.repo('rundeck') do
    it { should exist }
    it { should be_enabled }
  end

when 'debian'

  describe apt('https://dl.bintray.com/rundeck/rundeck-deb') do
    it { should exist }
    it { should be_enabled }
  end
end
