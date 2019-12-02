Spree::Product.class_eval do

  has_many :option_values, through: :variants

  def ordered_option_types
    option_types.order(:position)
  end

  #get every color option_type use variant  
  def select_img
    
    image_params = Hash.new do |h,k| h[k] =[] end
    

    variants.includes(option_values: :option_type).each do |variant|
      if variant.images.length>0
        
        variant.option_values.each do |option_value|
          ss={}
          if option_value.option_type.name.include?("Color")|| option_value.option_type.name.include?("color")
              image =  variant.images.first
              type_id= option_value.option_type.id.to_s
              
                ss[:image] =  image 
                ss[:value_id] =  option_value.id.to_s 
                image_params[type_id] << ss

          end

        end
      end
      
    end
    image_params
  end

  def variants_color_has_image
    s = Hash.new do |h,k| h[k] =[] end
    p.variants.includes(option_values: :option_type).each do |variant|
       variant.option_values.each do |option_value|
          if option_value.option_type.name.include?("Color")|| option_value.option_type.name.include?("color")
            s[:v] << variant if !s[:v].include?(variant)
          end
        end
    end
  end

  def variants_option_value_details
    variants.includes(option_values: :option_type).collect do |variant|
      details = get_initial_detail(variant)


      variant.option_values.each do |option_value|
        details[:option_types][option_value.option_type.id] = option_value.id
      end

      details
    end
  end

  private
    def get_initial_detail(variant)
      {
        in_stock: variant.can_supply?,
        variant_id: variant.id,
        variant_price: variant.price_in(Spree::Config[:currency]).money,
        option_types: {},
      }
    end

    def get_image(image,value_id)
      {
        image: image,
        value_id: variant,

      }
    end
end
