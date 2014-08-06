require 'nice-ffi'
require 'ffi'

module Morfeusz
  extend NiceFFI::Library
  
  class Edge < NiceFFI::Struct
    layout  :j, :int, 
            :i, :int,
            :orth, :string,
            :base, :string,
            :tags, :string
  end

  def Morfeusz.analyse(word)
    load_library './libmorfeusz.so'
    attach_function :analyse, :morfeusz_analyse, [:string], :pointer
    ptr = analyse(word)
    edges = (0..5).map{|i| Morfeusz::Edge.new(ptr+Morfeusz::Edge.size*i)}.take_while{|edge| edge.i != -1}
  end
end