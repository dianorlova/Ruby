def str_to_int(str)
    begin
        num = Integer(str)
        if num.to_s==str
            return num
        else
            return nil
        end
    rescue => exception
        return nil
    end
end