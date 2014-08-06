require 'nice-ffi'

module Morfeusz
  extend NiceFFI::Library
  load_library 'libmorfeusz'
  attach_function :analyse, :morfeusz_analyse, [:string], :pointer
  
  class Edge < NiceFFI::Struct
    layout  :j, :int, 
            :i, :int,
            :orth, :string,
            :base, :string,
            :tags, :string
  end

  def Morfeusz.get_forms(word)
    ptr = analyse(word)
    forms = (0..5).map{|i| Edge.new(ptr+Edge.size*i)}.take_while{|edge| edge.i != -1}
  end
end