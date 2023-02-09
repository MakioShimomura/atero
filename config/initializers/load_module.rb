Dir.glob(File.join(Rails.root, 'lib', 'module', '*.rb')) do |file|
  load file
end