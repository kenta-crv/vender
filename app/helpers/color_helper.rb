module ColorHelper
    def main_color
      @main_color ||= set_main_color
    end
  
    private
  
    def set_main_color
      case "#{controller_path}##{action_name}"
      when 'top#cocacola'
        '#F40002'
      when 'top#dydo'
        '#F7B106'
      when 'top#itoen'
        '#009E42' 
      when 'top#asahi'
        '#003591' 
      when 'top#kirin'
        '#E40114' 
      when 'top#otsuka'
        '#88B9E2' 
      when 'top#suntory'
        '#5bc2dc' 
      else
        '#0000FF'
      end
    end
  end