require 'rubygems'
require 'nokogiri'   
require 'open-uri'

def get_synonyms(word, n)
  url = URI.encode("http://nlp.pwr.wroc.pl/wordnet/msr/#{word}")
  page = Nokogiri::HTML(open(url))
  page.css('td.l').first(n).compact.map{|s| s.text}
end