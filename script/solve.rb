#!/usr/bin/env ruby

$:<< File.join(File.dirname(__FILE__), '..', 'lib')
require 'no_change_please'

begin
  problem = NoChangePlease.load_problem(ARGV.shift)
rescue
  abort "Syntax: ruby #{__FILE__} <filename>"
end

if problem.solution.empty?
  puts "Unable to find a combination of menu items to equal #{problem.target_price} exactly"
else
  puts "The following combination of items equals #{problem.target_price} exactly:"
  problem.solution.each do |item|
    puts item
  end
end
