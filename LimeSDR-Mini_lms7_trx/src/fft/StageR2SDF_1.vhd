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


package StageR2SDF_1 is
    type self_t is record
        shr: ShiftRegister_4.self_t;
        twiddle: complex_t(1 downto -14);
        stage1_out: complex_t(1 downto -34);
        stage2_out: complex_t(1 downto -48);
        output_index: integer;
        mode_delay: boolean;
        control: integer;
        \out\: DataValid_0.self_t;
        start_counter: DownCounter_3.self_t;
    end record;
    type StageR2SDF_1_self_t_list_t is array (natural range <>) of StageR2SDF_1.self_t;

    type self_t_const is record
        ALLOW_GAIN_CONTROL: boolean;
        INVERSE: boolean;
        GLOBAL_FFT_SIZE: integer;
        STAGE_NR: integer;
        IS_NATURAL_ORDER: boolean;
        LOCAL_FFT_SIZE: integer;
        INPUT_STRIDE: integer;
        CONTROL_MASK: integer;
        TWIDDLES: Typedefs.complex_t1downto_14_list_t(0 to 2047);
        IS_TRIVIAL_MULTIPLIER: boolean;
        shr: ShiftRegister_4.self_t_const;
        \out\: DataValid_0.self_t_const;
        start_counter: DownCounter_3.self_t_const;
    end record;
    type StageR2SDF_1_self_t_const_list_t_const is array (natural range <>) of StageR2SDF_1.self_t_const;

    procedure butterfly(self:in self_t; self_next:inout self_t; constant self_const: self_t_const; in_up: complex_t(1 downto -34); in_down: complex_t(1 downto -34); ret_0:out complex_t(1 downto -34); ret_1:out complex_t(1 downto -34));
    procedure main(self:in self_t; self_next:inout self_t; constant self_const: self_t_const; inp: DataValid_0.self_t; ret_0:out DataValid_0.self_t);
    function StageR2SDF(shr: ShiftRegister_4.self_t; twiddle: complex_t(1 downto -14); stage1_out: complex_t(1 downto -34); stage2_out: complex_t(1 downto -48); output_index: integer; mode_delay: boolean; control: integer; \out\: DataValid_0.self_t; start_counter: DownCounter_3.self_t) return self_t;
end package;

package body StageR2SDF_1 is
    procedure butterfly(self:in self_t; self_next:inout self_t; constant self_const: self_t_const; in_up: complex_t(1 downto -34); in_down: complex_t(1 downto -34); ret_0:out complex_t(1 downto -34); ret_1:out complex_t(1 downto -34)) is

        variable up: complex_t(1 downto -34);
        variable down: complex_t(1 downto -34);
    begin
        up := resize(resize(in_up + in_down, 0, -17, overflow_style=>fixed_wrap, round_style=>fixed_truncate), 0, -17, fixed_wrap, fixed_truncate);
        down := resize(resize(in_up - in_down, 0, -17, overflow_style=>fixed_wrap, round_style=>fixed_truncate), 0, -17, fixed_wrap, fixed_truncate);
        ret_0 := up;
        ret_1 := down;
        return;
    end procedure;

    procedure main(self:in self_t; self_next:inout self_t; constant self_const: self_t_const; inp: DataValid_0.self_t; ret_0:out DataValid_0.self_t) is

        variable mode: boolean;
        variable up: complex_t(1 downto -34);
        variable down: complex_t(1 downto -34);
        variable pyha_ret_0: complex_t(1 downto -34);
        variable pyha_ret_1: complex_t(1 downto -34);
        variable pyha_ret_2: complex_t(1 downto -34);
        variable pyha_ret_3: complex_t(1 downto -34);
        variable pyha_ret_4: boolean;
    begin
        if not inp.valid then
            ret_0 := DataValid(self.\out\.data, valid=>False);
            return;

            -- Stage 1: handle the loopback memory; that sets the INPUT_STRIDE; also fetch the twiddle factor for stage 2
        end if;
        if self_const.IS_NATURAL_ORDER then
            self_next.control := (self.control + 1) mod (self_const.LOCAL_FFT_SIZE);
            self_next.twiddle := resize(self_const.TWIDDLES(self.control and self_const.CONTROL_MASK), 0, -7, fixed_saturate, fixed_round);
        else
            self_next.control := (self.control + 1) mod (self_const.GLOBAL_FFT_SIZE);
            self_next.twiddle := resize(self_const.TWIDDLES(self.control sra (self_const.STAGE_NR + 1)), 0, -7, fixed_saturate, fixed_round);
        end if;
        mode := not (self.control and self_const.INPUT_STRIDE);
        self_next.mode_delay := mode;
        if mode then
            ShiftRegister_4.push_next(self.shr, self_next.shr, self_const.shr, inp.data);
            ShiftRegister_4.peek(self.shr, self_next.shr, self_const.shr, pyha_ret_0);
            self_next.stage1_out := resize(pyha_ret_0, 0, -17, fixed_wrap, fixed_truncate);
        else
            ShiftRegister_4.peek(self.shr, self_next.shr, self_const.shr, pyha_ret_1);
            butterfly(self, self_next, self_const, pyha_ret_1, inp.data, pyha_ret_2, pyha_ret_3);
            up := resize(pyha_ret_2, 0, -17, fixed_wrap, fixed_truncate);
            down := resize(pyha_ret_3, 0, -17, fixed_wrap, fixed_truncate);
            ShiftRegister_4.push_next(self.shr, self_next.shr, self_const.shr, down);
            self_next.stage1_out := resize(up, 0, -17, fixed_wrap, fixed_truncate);

            -- Stage 2: complex multiply
        end if;
        if self.mode_delay and not self_const.IS_TRIVIAL_MULTIPLIER then
            self_next.stage2_out := resize(self.stage1_out * self.twiddle, 0, -24, fixed_wrap, fixed_truncate);
        else
            self_next.stage2_out := resize(self.stage1_out, 0, -24, fixed_wrap, fixed_truncate);

            -- Stage 3: gain control and rounding
        end if;
        if self_const.ALLOW_GAIN_CONTROL and not self_const.INVERSE then
            self_next.\out\.data := resize(scalb(self.stage2_out, -1), 0, -17, fixed_wrap, fixed_round);
        else
            self_next.\out\.data := resize(self.stage2_out, 0, -17, fixed_wrap, fixed_round);

        end if;
        DownCounter_3.tick(self.start_counter, self_next.start_counter, self_const.start_counter);
        DownCounter_3.is_over(self.start_counter, self_next.start_counter, self_const.start_counter, pyha_ret_4);
        self_next.\out\.valid := pyha_ret_4;
        ret_0 := self.\out\;
        return;
    end procedure;

    function StageR2SDF(shr: ShiftRegister_4.self_t; twiddle: complex_t(1 downto -14); stage1_out: complex_t(1 downto -34); stage2_out: complex_t(1 downto -48); output_index: integer; mode_delay: boolean; control: integer; \out\: DataValid_0.self_t; start_counter: DownCounter_3.self_t) return self_t is
        -- constructor
        variable self: self_t;
    begin
        self.shr := shr;
        self.twiddle := twiddle;
        self.stage1_out := stage1_out;
        self.stage2_out := stage2_out;
        self.output_index := output_index;
        self.mode_delay := mode_delay;
        self.control := control;
        self.\out\ := \out\;
        self.start_counter := start_counter;
        return self;
    end function;
end package body;
