require 'rake'

PERSONA_PATH = File.join(ENV['HOME'], '.persona')

task :default => :init

desc "Initialize local persona environment"
task :init do
  unless Dir.exists? PERSONA_PATH
    Dir.mkdir(PERSONA_PATH)
    Dir.chdir(PERSONA_PATH) do
      `git init`
    end
  end
end

desc "Create a new persona"
task :new => :init
task :new, :name do |task, args|
  Dir.chdir PERSONA_PATH do
    Dir.mkdir args[:name] unless Dir.exists? args[:name]
    `git add . ; git ci -m "Add persona: #{args[:name]}"`
  end
end
