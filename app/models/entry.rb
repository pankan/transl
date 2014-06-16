class Entry < ActiveRecord::Base
	  def language_name (code)
    LANGUAGELIST.each do
      |l_code|
      if l_code[1] == code
        return l_code[0]
      end
    end
  end
end
