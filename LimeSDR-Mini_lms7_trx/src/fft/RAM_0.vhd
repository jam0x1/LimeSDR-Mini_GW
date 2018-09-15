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
    use work.ShiftRegister_7.all;
    use work.DownCounter_6.all;
    use work.StageR2SDF_4.all;
    use work.ShiftRegister_8.all;
    use work.DownCounter_7.all;
    use work.StageR2SDF_5.all;
    use work.ShiftRegister_9.all;
    use work.DownCounter_8.all;
    use work.StageR2SDF_6.all;
    use work.ShiftRegister_10.all;
    use work.DownCounter_9.all;
    use work.StageR2SDF_7.all;
    use work.ShiftRegister_11.all;
    use work.DownCounter_10.all;
    use work.StageR2SDF_8.all;
    use work.ShiftRegister_12.all;
    use work.DownCounter_11.all;
    use work.StageR2SDF_9.all;
    use work.ShiftRegister_13.all;
    use work.DownCounter_12.all;
    use work.StageR2SDF_10.all;
    use work.ShiftRegister_14.all;
    use work.StageR2SDF_11.all;
    use work.R2SDF_0.all;
    use work.FFTPower_0.all;

-- Inital values works. No LUTs used if init is all 0, if init is omited some LUTs will be strangely used.
package RAM_0 is
    type self_t is record
        data: Typedefs.sfixed_5downto_40_list_t(0 to 511);
        write_value: sfixed(-5 downto -40);
        write_enable: boolean;
        write_address: integer;
        read_reg: sfixed(-5 downto -40);
        read_address: integer;
    end record;
    type RAM_0_self_t_list_t is array (natural range <>) of RAM_0.self_t;

    type self_t_const is record
        DUMMY: integer;
    end record;
    type RAM_0_self_t_const_list_t_const is array (natural range <>) of RAM_0.self_t_const;

    procedure delayed_read(self:in self_t; self_next:inout self_t; constant self_const: self_t_const; address: integer; ret_0:out sfixed(-5 downto -40));
    procedure delayed_write(self:in self_t; self_next:inout self_t; constant self_const: self_t_const; address: integer; value: sfixed(-5 downto -40));
    procedure get_readregister(self:in self_t; self_next:inout self_t; constant self_const: self_t_const; ret_0:out sfixed(-5 downto -40));
    function RAM(data: Typedefs.sfixed_5downto_40_list_t(0 to 511); write_value: sfixed(-5 downto -40); write_enable: boolean; write_address: integer; read_reg: sfixed(-5 downto -40); read_address: integer) return self_t;
end package;

package body RAM_0 is
    procedure delayed_read(self:in self_t; self_next:inout self_t; constant self_const: self_t_const; address: integer; ret_0:out sfixed(-5 downto -40)) is


    begin
        self_next.read_address := address;
        ret_0 := self.read_reg;
        return;
    end procedure;

    procedure delayed_write(self:in self_t; self_next:inout self_t; constant self_const: self_t_const; address: integer; value: sfixed(-5 downto -40)) is


    begin
        self_next.write_address := address;
        self_next.write_enable := True;
        self_next.write_value := resize(value, -5, -40, fixed_wrap, fixed_truncate);
    end procedure;

    procedure get_readregister(self:in self_t; self_next:inout self_t; constant self_const: self_t_const; ret_0:out sfixed(-5 downto -40)) is


    begin
        ret_0 := self.read_reg;
        return;
    end procedure;

    function RAM(data: Typedefs.sfixed_5downto_40_list_t(0 to 511); write_value: sfixed(-5 downto -40); write_enable: boolean; write_address: integer; read_reg: sfixed(-5 downto -40); read_address: integer) return self_t is
        -- constructor
        variable self: self_t;
    begin
        self.data := data;
        self.write_value := write_value;
        self.write_enable := write_enable;
        self.write_address := write_address;
        self.read_reg := read_reg;
        self.read_address := read_address;
        return self;
    end function;
end package body;
