class Media

  private
  def self.add_media *medias
    medias.each do |media|
      self.class.send(:define_method, media) do 
        res = HTTParty.get(LINKS[media.to_s]).to_hash
        Media.filter_keys res
      end
    end
  end

  public
  add_media :series, :movies, :animes, :musics


  def self.filter_keys hash
    hash['feed'].select do |k,v|
      ['entry', 'updated', 'title'].include? k
    end
  end

  def self.limit_entries hash
    hash['entry'] = hash['entry'][0..59]
    hash
  end

    ##
  # @!method check_symbol_parameters(parameters)
  #   Check if the parameters are strings or symbols
  # @param parameters [Array] An array of the parameters
  private
  def check_symbol_parameters parameters
     parameters.each do |parameter|
      if !(parameter.kind_of?(Symbol) || parameter.kind_of?(String))
        raise "Erreur d'arguments"
      end
    end
  end
end