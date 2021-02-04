require 'json'

meta_files = Dir.glob('./**/vehicles.meta')

json = JSON.parse File.read('example_vmenu_addons.json')

meta_files.each do |file|
    xml = File.read file
    
    game_name = xml[/(?<=<gameName>).*(?=<\/gameName>)/]
    model_name = xml[/(?<=<modelName>).*(?=<\/modelName>)/]

    if game_name.downcase != model_name.downcase
        xml.gsub!(/(?<=<gameName>).*(?=<\/gameName>)/, model_name)
        File.write(file, xml)
    end

    json['vehicles'] << model_name.downcase unless json['vehicles'].map(&:downcase).include? model_name.downcase

end

File.write('example_vmenu_addons.json', JSON.pretty_generate(json))