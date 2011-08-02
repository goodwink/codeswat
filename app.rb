require 'sinatra'
require 'octokit'

get '/user/:user' do |uname|
  Octokit.repos("goodwink").map do |r|
    l = Octokit.languages(r)
  end.flat_map do |x|
    x.map{|k, v| [k, v]}
  end.group_by do |l|
    l.first
  end.map do |language, counts|
    sum = counts.map{|c| c.last}.reduce(:+)
    "#{language}: #{sum}"
  end.to_s
end
