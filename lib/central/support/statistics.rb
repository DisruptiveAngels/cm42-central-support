module Central
  module Support
    module Statistics
      def self.mean(enumerable)
        values = to_float(enumerable)
        sum(values) / total(values)
      end

      # assumes that enumerable is the entire population
      # sample_size is < than enumerable.size than the variance will use N - 1 to adjust for sample
      def self.variance(enumerable, sample_size = enumerable.size)
        slice = slice_non_zero(enumerable, sample_size)
        total = total(slice) < total(enumerable) ? total(slice) - 1 : sample_size
        mean  = mean(slice)
        sum(slice.map { |sample| (mean - sample) ** 2 }) / total
      end

      def self.standard_deviation(enumerable, sample_size = enumerable.size)
        return 0 if enumerable.empty?
        values = to_float(enumerable)

        Math.sqrt(variance(values, sample_size))
      end

      def self.volatility(enumerable, sample_size = enumerable.size)
        slice = slice_non_zero(enumerable, sample_size)
        return 0 if slice.empty?

        standard_deviation(enumerable, sample_size) / mean(slice)
      end

      def self.to_float(enumerable)
        enumerable.map(&:to_f)
      end

      def self.sum(enumerable)
        enumerable.reduce(:+) || 0
      end

      def self.total(enumerable)
        enumerable.size.to_f
      end

      def self.slice_non_zero(enumerable, sample_size = 3)
        enumerable.map { |element| element == 0 ? nil : element }.compact.reverse.take(sample_size)
      end
    end
  end
end
