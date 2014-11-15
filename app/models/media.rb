class Media

  private
  def self.add_media *medias
    medias.each do |media|
      self.class.send(:define_method, media) do 
        res = HTTParty.get(LINKS[media.to_s]).to_hash
        res['feed']['entry']
      end
    end
  end

  public
  add_media :series, :movies, :animes, :musics


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