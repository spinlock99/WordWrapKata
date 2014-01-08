class Wordwrap
  def initialize wrap_length
    if (!wrap_length.class.ancestors.include?(Integer) || wrap_length.class == Integer)
      raise Exception "parameter must be an Integer"
    end
    @wrap_length = wrap_length
  end

  def wrap text
    if (text.class != String)
      raise Exception "expected String but paramater has class #{text.class}"
    end

    if text.empty?
      return ""
    end

    letter_array = text.split("")
    last_space = false
    offset = 0
    current_length = 0

    letter_array.each_with_index do |letter, index|
      if (letter =~ /\s/)
        last_space = index
      end
      if (current_length == @wrap_length && last_space)
        letter_array[last_space] = "\n"
        current_length = index - last_space
        last_space = false
      elsif (current_length == @wrap_length)
        letter_array.insert(index, "\n")
        current_length = 0
      else
        current_length += 1
      end
    end

    if (letter_array.last == "\n")
      letter_array.delete_at(-1)
    end
    letter_array.inject(:+)
  end
end
