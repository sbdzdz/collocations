require 'rubygems'
require 'nokogiri'   
require 'open-uri'

def get_synonyms(word, n)
  synonyms = []
  url = URI.encode("http://nlp.pwr.wroc.pl/wordnet/msr/#{word}")
  page = Nokogiri::HTML(open(url))   
  page.css('td.l').first(n).each do |elem|
    synonyms.push(elem.text)
  end
end



f = File.open('words')
f.readlines.each do |line|
  puts get_synonyms(line, 5)
end
f.close