require_relative 'scraper.rb'
require 'yaml'
require 'facets'

def expand (path, n)
  h = YAML.load_file(path)
  h.each do |key, value|
    unless value.length == 1
      synonyms = value.map{|w| get_synonyms(w, n)}
      frequent = synonyms.inject(&:+).frequency.select{|k, v| v >= 2}
      h[key] |= frequent.keys
    else
      h[key] |= get_synonyms(value.first, n)
    end
  end
end