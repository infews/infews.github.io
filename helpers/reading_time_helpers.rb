module ReadingTimeHelpers
  def reading_time_for(input)
    words_per_minute = 180

    words = input.split.size
    minutes = (words / words_per_minute).floor
    if minutes > 0
      "about a #{minutes} minute read"
    else
       "under 1 minute to read"
    end
  end
end

