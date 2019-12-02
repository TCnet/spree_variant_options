Deface::Override.new(
  virtual_path: "spree/admin/option_types/_option_value_fields",
  name:         "admin_option_value_image_fields",
  insert_after: "td.presentation",
  text: "
    <td class='image-preview'>
   
  </td>
  <td class='image'></td>
  "
)
