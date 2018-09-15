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
    use work.DataValid_39.all;
    use work.DataValid_38.all;
    use work.DataValid_37.all;
    use work.DataValid_0.all;
    use work.DataValid_17.all;
    use work.DataValid_36.all;


package ShiftRegister_16 is
    type self_t is record
        data: Typedefs.complex_t1downto_22_list_t(0 to 1023);
        to_push: complex_t(1 downto -22);
    end record;
    type ShiftRegister_16_self_t_list_t is array (natural range <>) of ShiftRegister_16.self_t;

    type self_t_const is record
        DUMMY: integer;
    end record;
    type ShiftRegister_16_self_t_const_list_t_const is array (natural range <>) of ShiftRegister_16.self_t_const;

    procedure peek(self:in self_t; self_next:inout self_t; constant self_const: self_t_const; ret_0:out complex_t(1 downto -22));
    procedure push_next(self:in self_t; self_next:inout self_t; constant self_const: self_t_const; item: complex_t(1 downto -22));
    function ShiftRegister(data: Typedefs.complex_t1downto_22_list_t(0 to 1023); to_push: complex_t(1 downto -22)) return self_t;
end package;

package body ShiftRegister_16 is
    procedure peek(self:in self_t; self_next:inout self_t; constant self_const: self_t_const; ret_0:out complex_t(1 downto -22)) is


    begin
        ret_0 := self.data(0);
        return;
    end procedure;

    procedure push_next(self:in self_t; self_next:inout self_t; constant self_const: self_t_const; item: complex_t(1 downto -22)) is
    -- Actual push happens on the next clock cycle!

    begin
        -- CONVERSION PREPROCESSOR replace next line with:
        -- self.data = self.data[1:] + [item]
        self_next.data := self.data(1 to self.data'high) & item;
    end procedure;

    function ShiftRegister(data: Typedefs.complex_t1downto_22_list_t(0 to 1023); to_push: complex_t(1 downto -22)) return self_t is
        -- constructor
        variable self: self_t;
    begin
        self.data := data;
        self.to_push := to_push;
        return self;
    end function;
end package body;
