#!/usr/bin/env ruby
#
# this is an example that takes any note-on messages from a UniMIDI input
# and sends it to another UniMIDI output, transposed up an octave
#
#
$:.unshift File.join( File.dirname( __FILE__ ), '../lib')

require 'midi-eye'

include MIDIEye
include MIDIMessage 

@input = UniMIDI::Input.first.open
@output = UniMIDI::Output.first.open

transpose = Listener.new(@input)

transpose.on_message(:class => [NoteOn, NoteOff]) do |event|
   
  p "from #{event[:message].note} to #{(event[:message].note + 12)}"
  
  event[:message].note += 12
  @output.puts(event[:message].to_bytes)
  
end

p "use control-c to quit..."

transpose.run
