def main
    puts 'I am working!'
    puts "My arguments are: #{ARGV}"
    p ARGV # See them like Ruby sees them.
  end
  
  # Keep it in the bottom of the file
  if __FILE__ == $0
      main
  end
  