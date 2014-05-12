# -*- coding: utf-8 -*-
lib = File.expand_path("../lib", __FILE__)
$:.unshift lib unless $:.include? lib

require 'persona/version'

Gem::Specification.new do |s|
  s.name = 'persona'
  s.version = Persona::Version
  s.authors = 'Tim Jarratt'
  s.email = 'tjarratt@gmail.com'
  s.homepage = 'https://github.com/tjarratt/persona'
  s.summary = 'Experimental honeypot'
  s.description = 'An experiment in attracting recruiters'
  s.license = 'MIT'

  ignores  = File.readlines('.gitignore').grep(/\S+/).map(&:chomp)
  dotfiles = %w[.gitignore]

  all_files_without_ignores = Dir['**/*'].reject { |f|
    File.directory?(f) || ignores.any? { |i| File.fnmatch(i, f) }
  }

  s.add_dependency 'yajl-ruby'

  s.files = (all_files_without_ignores + dotfiles).sort

  s.require_path = 'lib'
end
