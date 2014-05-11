require 'rake'

PERSONA_PATH = File.join(ENV['HOME'], '.persona')

desc "Initialize local persona environment"
task :init do
  unless Dir.exists? PERSONA_PATH
    Dir.mkdir(PERSONA_PATH)
    Dir.chdir(PERSONA_PATH) do
      `git init`
    end
  end
end
