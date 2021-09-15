class ProcExample
    def store_proc(&action)
        @action = action
        p @action
    end
    
    def use_proc(number)
        @action.call(number)  # вызов блока
        @action.call(number+100)
    end
end

proc_example = ProcExample.new
proc_example.store_proc {|number|puts "Hello from proc! Number:#{number}"}
proc_example.use_proc(42)