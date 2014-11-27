require "bundler/gem_tasks"

task :default => :spec

desc "Prueba las pruebas"
task :spec do
   sh "rspec -I. -Ilib -Ispec spec/examen_spec.rb"
end

desc "Formato HTML Test"
task :thtml do
   sh "bundle exec ruby lib/question/simple_choice.rb > web.html"
end
