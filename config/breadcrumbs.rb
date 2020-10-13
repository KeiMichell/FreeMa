crumb :root do
  link 'FreeMa', root_path
end

crumb :parent_category do |item|
  link item.category.parent.parent.name, root_path
  parent :root
end

crumb :child_category do |item|
  link item.category.parent.name, root_path
  parent :parent_category, item
end

crumb :grandchild_category do |item|
  link item.category.name, root_path
  parent :child_category, item
end

crumb :current_product do |item|
  link item.name
  parent :grandchild_category, item
end
