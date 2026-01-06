class HashMap
  attr_accessor :load_factor, :capacity
  def initialize(load_factor = 0.75, capacity = 16)
    @load_factor = load_factor
    @capacity = capacity
    @buckets = Array.new(@capacity) {Array.new}
  end


  def hash(key)
    hash_code = 0
    prime_number = 31
        
    key.each_char { |char| hash_code = prime_number * hash_code + char.ord }
        
    hash_code
  end

  def set(key, value)
    hash = hash(key)
    index = hash % @capacity
    
    @buckets[index].each do |bucket|
      if(bucket[0] == key)
        bucket[1] = value
        return
      end
    end
    @buckets[index] << [key, value]

    if(length.to_f / @capacity > @load_factor)
      @capacity *= 2
      new_buckets = Array.new(@capacity) {Array.new}
      entries.each do |key, value|
        new_index = hash(key) % @capacity
        new_buckets[new_index] << [key, value]
      end
      @buckets = new_buckets
    end
  end

  def get(key)
    hash = hash(key)
    index = hash % @capacity
    @buckets[index].each do |bucket|
      if(bucket[0] == key)
        return bucket[1]
      else
        return nil
      end
    end
  end

  def has?(key)
    hash = hash(key)
    index = hash % @capacity
    @buckets[index].each do |bucket|
      if(bucket[0] == key)
        return true
      end
    end
    return false
  end

  def remove(key)
    hash = hash(key)
    index = hash % @capacity
    @buckets[index].each do |bucket|
      if(bucket[0] == key)
        deleted_value = bucket[1]
        @buckets[index].delete(bucket)        
        return deleted_value
      end
    end
    return nil
  end

  def length
    count = 0
    @buckets.each do |bucket|
      count += bucket.length
    end
    return count
  end

  def clear
    @buckets = Array.new(@capacity) {Array.new}
  end

  def keys
    keys = []
    @buckets.each do |bucket|
      bucket.each do |pair|
        keys << pair[0]
      end
    end
    return keys
  end

  def values
    values = []
    @buckets.each do |bucket|
      bucket.each do |pair|
        values << pair[1]
      end
    end
    return values
  end
  
  def entries
    pairs = []
    @buckets.each do |bucket|
      bucket.each do |pair|
        pairs << pair
      end
    end
    return pairs
  end

end