class Breaker
  attr_reader :codes

  def initialize(code)
    @codes = code.to_s.each_char.to_a
  end

  def try(num)
    numbers = num.to_s.each_char.to_a
    matched = @codes.zip(numbers).map {|e| e[0] == e[1] ? nil : e }

    ('+' * matched.select(&:nil?).size).tap do |r|
      unless (unmatched = matched.reject(&:nil?)).empty?
        r << '-' * duplicated(*unmatched.transpose).size
      end
    end
  end

private

  def duplicated(codes, try_nums)
    try_nums.select do |e|
      (idx = codes.find_index e) && codes.delete_at(idx)
    end
  end
end
