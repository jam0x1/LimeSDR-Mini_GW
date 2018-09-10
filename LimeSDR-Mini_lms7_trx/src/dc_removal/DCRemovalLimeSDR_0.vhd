-- generated by pyha 0.0.10
library ieee;
    use ieee.std_logic_1164.all;
    use ieee.numeric_std.all;
    use ieee.fixed_float_types.all;
    use ieee.fixed_pkg.all;
    use ieee.math_real.all;

library work;
    use work.complex_pkg.all;
    use work.PyhaUtil.all;
    use work.Typedefs.all;
    use work.all;
    use work.DataValid_3.all;
    use work.DataValid_0.all;
    use work.ShiftRegister_0.all;
    use work.DownCounter_0.all;
    use work.MovingAverage_0.all;
    use work.ShiftRegister_1.all;
    use work.MovingAverage_1.all;
    use work.ShiftRegister_2.all;
    use work.DCRemoval_0.all;

-- Filter out DC component, based on: https://www.dsprelated.com/showarticle/58.php
package DCRemovalLimeSDR_0 is
    type self_t is record
        dc_removal: DCRemoval_0.self_t;
        \out\: DataValid_3.self_t;
    end record;
    type DCRemovalLimeSDR_0_self_t_list_t is array (natural range <>) of DCRemovalLimeSDR_0.self_t;

    type self_t_const is record
        dc_removal: DCRemoval_0.self_t_const;
        \out\: DataValid_3.self_t_const;
    end record;
    type DCRemovalLimeSDR_0_self_t_const_list_t_const is array (natural range <>) of DCRemovalLimeSDR_0.self_t_const;

    procedure main(self:in self_t; self_next:inout self_t; constant self_const: self_t_const; inp: DataValid_3.self_t; ret_0:out DataValid_3.self_t);
    function DCRemovalLimeSDR(dc_removal: DCRemoval_0.self_t; \out\: DataValid_3.self_t) return self_t;
end package;

package body DCRemovalLimeSDR_0 is
    procedure main(self:in self_t; self_next:inout self_t; constant self_const: self_t_const; inp: DataValid_3.self_t; ret_0:out DataValid_3.self_t) is

        variable nodc: DataValid_0.self_t;
        variable pyha_ret_0: DataValid_0.self_t;
    begin
        DCRemoval_0.main(self.dc_removal, self_next.dc_removal, self_const.dc_removal, inp, pyha_ret_0);
        nodc := pyha_ret_0;
        self_next.\out\.data := resize(nodc.data, 0, -11, fixed_wrap, fixed_round);
        self_next.\out\.valid := nodc.valid;
        ret_0 := self.\out\;
        return;
    end procedure;

    function DCRemovalLimeSDR(dc_removal: DCRemoval_0.self_t; \out\: DataValid_3.self_t) return self_t is
        -- limited constructor
        variable self: self_t;
    begin
        self.dc_removal := dc_removal;
        self.\out\ := \out\;
        return self;
    end function;
end package body;
