class DataRetriever
    def self.get_names
        @@doc = Nokogiri::HTML(open("https://akabab.github.io/superhero-api/api/glossary.html"))

        @@doc.css("tr")[1..-1].each do |super_row|
            id = super_row.css("td")[1].text
            name = super_row.css("td")[2].text
            SuperHeroBio.new(id, name)
        end
    end

    def self.get_bios(obj)
        num = obj.id 
        bio = HTTParty.get("https://cdn.jsdelivr.net/gh/akabab/superhero-api@0.3.0/api/biography/#{num}.json")
        obj.full_name = bio['fullName']
        obj.alter_egos = bio['alterEgos']
        obj.birthplace = bio['placeOfBirth']
        obj.alignment = bio['alignment']
    end
end
