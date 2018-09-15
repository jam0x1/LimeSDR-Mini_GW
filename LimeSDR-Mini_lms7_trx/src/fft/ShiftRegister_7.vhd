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
    use work.DataValid_21.all;
    use work.DataValid_20.all;
    use work.DataValid_19.all;
    use work.DataValid_0.all;
    use work.DataValid_17.all;
    use work.DataValid_18.all;
    use work.ShiftRegister_0.all;
    use work.DownCounter_0.all;
    use work.MovingAverage_0.all;
    use work.ShiftRegister_1.all;
    use work.MovingAverage_1.all;
    use work.ShiftRegister_2.all;
    use work.DCRemoval_0.all;
    use work.Windower_0.all;
    use work.ShiftRegister_15.all;
    use work.DownCounter_14.all;
    use work.StageR2SDF_12.all;
    use work.ShiftRegister_3.all;
    use work.DownCounter_2.all;
    use work.StageR2SDF_0.all;
    use work.ShiftRegister_4.all;
    use work.DownCounter_3.all;
    use work.StageR2SDF_1.all;
    use work.DownCounter_4.all;
    use work.StageR2SDF_2.all;
    use work.ShiftRegister_6.all;
    use work.DownCounter_5.all;
    use work.StageR2SDF_3.all;


package ShiftRegister_7 is
    type self_t is record
        data: Typedefs.complex_t1downto_34_list_t(0 to 255);
        to_push: complex_t(1 downto -34);
    end record;
    type ShiftRegister_7_self_t_list_t is array (natural range <>) of ShiftRegister_7.self_t;

    type self_t_const is record
        DUMMY: integer;
    end record;
    type ShiftRegister_7_self_t_const_list_t_const is array (natural range <>) of ShiftRegister_7.self_t_const;

    procedure peek(self:in self_t; self_next:inout self_t; constant self_const: self_t_const; ret_0:out complex_t(1 downto -34));
    procedure push_next(self:in self_t; self_next:inout self_t; constant self_const: self_t_const; item: complex_t(1 downto -34));
    function ShiftRegister(data: Typedefs.complex_t1downto_34_list_t(0 to 255); to_push: complex_t(1 downto -34)) return self_t;
end package;

package body ShiftRegister_7 is
    procedure peek(self:in self_t; self_next:inout self_t; constant self_const: self_t_const; ret_0:out complex_t(1 downto -34)) is


    begin
        ret_0 := self.data(0);
        return;
    end procedure;

    procedure push_next(self:in self_t; self_next:inout self_t; constant self_const: self_t_const; item: complex_t(1 downto -34)) is
    -- Actual push happens on the next clock cycle!

    begin
        -- CONVERSION PREPROCESSOR replace next line with:
        -- self.data = self.data[1:] + [item]
        self_next.data := self.data(1 to self.data'high) & item;
    end procedure;

    function ShiftRegister(data: Typedefs.complex_t1downto_34_list_t(0 to 255); to_push: complex_t(1 downto -34)) return self_t is
        -- constructor
        variable self: self_t;
    begin
        self.data := data;
        self.to_push := to_push;
        return self;
    end function;
end package body;
