Spree::OptionValue.class_eval do
  
  with_options dependent: :destroy do
    if Spree.version.to_f >= 3.6
     has_one :image, as: :viewable, dependent: :destroy, class_name: 'Spree::OptionValueImage'
    end
  end


     
  

  
end
