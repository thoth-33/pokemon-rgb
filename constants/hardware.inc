;******************************************************************************
; Game Boy hardware constant definitions
; https://github.com/gbdev/hardware.inc
;******************************************************************************

; To the extent possible under law, the authors of this work have
; waived all copyright and related or neighboring rights to the work.
; See https://creativecommons.org/publicdomain/zero/1.0/ for details.
; SPDX-License-Identifier: CC0-1.0

; If this file was already included, don't do it again
if !DEF(HARDWARE_INC)

; Check for the minimum supported RGBDS version
if !DEF(__RGBDS_MAJOR__) || !DEF(__RGBDS_MINOR__) || !DEF(__RGBDS_PATCH__)
    fail "This version of 'hardware.inc' requires RGBDS version 0.5.0 or later"
endc
if __RGBDS_MAJOR__ == 0 && __RGBDS_MINOR__ < 5
    fail "This version of 'hardware.inc' requires RGBDS version 0.5.0 or later."
endc

; Define the include guard and the current hardware.inc version
; (do this after the RGBDS version check since the `DEF` syntax depends on it)
DEF HARDWARE_INC EQU 1
DEF HARDWARE_INC_VERSION equs "5.2.0"

; Usage: rev_Check_hardware_inc <min_ver>
; Examples:
;     rev_Check_hardware_inc 1.2.3
;     rev_Check_hardware_inc 1.2   (equivalent to 1.2.0)
;     rev_Check_hardware_inc 1     (equivalent to 1.0.0)
MACRO rev_Check_hardware_inc
    if _NARG == 1 ; Actual invocation by the user
        DEF hw_inc_cur_ver\@ equs strrpl("{HARDWARE_INC_VERSION}", ".", ",")
        DEF hw_inc_min_ver\@ equs strrpl("\1", ".", ",")
        rev_Check_hardware_inc {hw_inc_cur_ver\@}, {hw_inc_min_ver\@}, 0, 0
        purge hw_inc_cur_ver\@, hw_inc_min_ver\@
    else ; Recursive invocation
        if \1 != \4 || (\2 < \5 || (\2 == \5 && \3 < \6))
            fail "Version \1.\2.\3 of 'hardware.inc' is incompatible with requested version \4.\5.\6"
        endc
    endc
ENDM


;******************************************************************************
; Memory-mapped registers ($FFxx range)
;******************************************************************************

; -- JOYP / P1 ($FF00) --------------------------------------------------------
; Joypad face buttons
DEF rJOYP EQU $FF00

DEF B_JOYP_GET_BUTTONS  EQU 5 ; 0 = reading buttons     [r/w]
DEF B_JOYP_GET_CTRL_PAD EQU 4 ; 0 = reading Control Pad [r/w]
    DEF JOYP_GET EQU %00_11_0000 ; select which inputs to read from the lower nybble
        DEF JOYP_GET_BUTTONS  EQU %00_01_0000 ; reading A/B/Select/Start buttons
        DEF JOYP_GET_CTRL_PAD EQU %00_10_0000 ; reading Control Pad directions
        DEF JOYP_GET_NONE     EQU %00_11_0000 ; reading nothing

DEF B_JOYP_START  EQU 3 ; 0 = Start is pressed  (if reading buttons)     [ro]
DEF B_JOYP_SELECT EQU 2 ; 0 = Select is pressed (if reading buttons)     [ro]
DEF B_JOYP_B      EQU 1 ; 0 = B is pressed      (if reading buttons)     [ro]
DEF B_JOYP_A      EQU 0 ; 0 = A is pressed      (if reading buttons)     [ro]
DEF B_JOYP_DOWN   EQU 3 ; 0 = Down is pressed   (if reading Control Pad) [ro]
DEF B_JOYP_UP     EQU 2 ; 0 = Up is pressed     (if reading Control Pad) [ro]
DEF B_JOYP_LEFT   EQU 1 ; 0 = Left is pressed   (if reading Control Pad) [ro]
DEF B_JOYP_RIGHT  EQU 0 ; 0 = Right is pressed  (if reading Control Pad) [ro]
    DEF JOYP_INPUTS EQU %0000_1111 ; bits equal to 0 indicate pressed (when reading inputs)
    DEF JOYP_START  EQU 1 << B_JOYP_START
    DEF JOYP_SELECT EQU 1 << B_JOYP_SELECT
    DEF JOYP_B      EQU 1 << B_JOYP_B
    DEF JOYP_A      EQU 1 << B_JOYP_A
    DEF JOYP_DOWN   EQU 1 << B_JOYP_DOWN
    DEF JOYP_UP     EQU 1 << B_JOYP_UP
    DEF JOYP_LEFT   EQU 1 << B_JOYP_LEFT
    DEF JOYP_RIGHT  EQU 1 << B_JOYP_RIGHT

; Combined input byte, with Control Pad in high nybble (conventional order)
DEF B_PAD_DOWN   EQU 7
DEF B_PAD_UP     EQU 6
DEF B_PAD_LEFT   EQU 5
DEF B_PAD_RIGHT  EQU 4
DEF B_PAD_START  EQU 3
DEF B_PAD_SELECT EQU 2
DEF B_PAD_B      EQU 1
DEF B_PAD_A      EQU 0
    DEF PAD_CTRL_PAD EQU %1111_0000
    DEF PAD_BUTTONS  EQU %0000_1111
    DEF PAD_DOWN     EQU 1 << B_PAD_DOWN
    DEF PAD_UP       EQU 1 << B_PAD_UP
    DEF PAD_LEFT     EQU 1 << B_PAD_LEFT
    DEF PAD_RIGHT    EQU 1 << B_PAD_RIGHT
    DEF PAD_START    EQU 1 << B_PAD_START
    DEF PAD_SELECT   EQU 1 << B_PAD_SELECT
    DEF PAD_B        EQU 1 << B_PAD_B
    DEF PAD_A        EQU 1 << B_PAD_A


; Combined input byte, with Control Pad in low nybble (swapped order)
DEF B_PAD_SWAP_START  EQU 7
DEF B_PAD_SWAP_SELECT EQU 6
DEF B_PAD_SWAP_B      EQU 5
DEF B_PAD_SWAP_A      EQU 4
DEF B_PAD_SWAP_DOWN   EQU 3
DEF B_PAD_SWAP_UP     EQU 2
DEF B_PAD_SWAP_LEFT   EQU 1
DEF B_PAD_SWAP_RIGHT  EQU 0
    DEF PAD_SWAP_CTRL_PAD EQU %0000_1111
    DEF PAD_SWAP_BUTTONS  EQU %1111_0000
    DEF PAD_SWAP_START    EQU 1 << B_PAD_SWAP_START
    DEF PAD_SWAP_SELECT   EQU 1 << B_PAD_SWAP_SELECT
    DEF PAD_SWAP_B        EQU 1 << B_PAD_SWAP_B
    DEF PAD_SWAP_A        EQU 1 << B_PAD_SWAP_A
    DEF PAD_SWAP_DOWN     EQU 1 << B_PAD_SWAP_DOWN
    DEF PAD_SWAP_UP       EQU 1 << B_PAD_SWAP_UP
    DEF PAD_SWAP_LEFT     EQU 1 << B_PAD_SWAP_LEFT
    DEF PAD_SWAP_RIGHT    EQU 1 << B_PAD_SWAP_RIGHT

; -- SB ($FF01) ---------------------------------------------------------------
; Serial transfer data [r/w]
DEF rSB EQU $FF01

; -- SC ($FF02) ---------------------------------------------------------------
; Serial transfer control
DEF rSC EQU $FF02

DEF B_SC_START  EQU 7 ; reading 1 = transfer in progress, writing 1 = start transfer        [r/w]
DEF B_SC_SPEED  EQU 1 ; (CGB only) 1 = use faster internal clock                            [r/w]
DEF B_SC_SOURCE EQU 0 ; 0 = use external clock ("slave"), 1 = use internal clock ("master") [r/w]
    DEF SC_START  EQU 1 << B_SC_START
    DEF SC_SPEED  EQU 1 << B_SC_SPEED
        DEF SC_SLOW EQU 0 << B_SC_SPEED
        DEF SC_FAST EQU 1 << B_SC_SPEED
    DEF SC_SOURCE EQU 1 << B_SC_SOURCE
        DEF SC_EXTERNAL EQU 0 << B_SC_SOURCE
        DEF SC_INTERNAL EQU 1 << B_SC_SOURCE

; -- $FF03 is unused ----------------------------------------------------------

; -- DIV ($FF04) --------------------------------------------------------------
; Divider register [r/w]
DEF rDIV EQU $FF04

; -- TIMA ($FF05) -------------------------------------------------------------
; Timer counter [r/w]
DEF rTIMA EQU $FF05

; -- TMA ($FF06) --------------------------------------------------------------
; Timer modulo [r/w]
DEF rTMA EQU $FF06

; -- TAC ($FF07) --------------------------------------------------------------
; Timer control
DEF rTAC EQU $FF07

DEF B_TAC_START EQU 2 ; enable incrementing TIMA [r/w]
    DEF TAC_STOP  EQU 0 << B_TAC_START
    DEF TAC_START EQU 1 << B_TAC_START

DEF TAC_CLOCK EQU %000000_11 ; the frequency at which TIMA increments [r/w]
    DEF TAC_4KHZ   EQU %000000_00 ; every 256 M-cycles = ~4 KHz on DMG
    DEF TAC_262KHZ EQU %000000_01 ; every 4 M-cycles = ~262 KHz on DMG
    DEF TAC_65KHZ  EQU %000000_10 ; every 16 M-cycles = ~65 KHz on DMG
    DEF TAC_16KHZ  EQU %000000_11 ; every 64 M-cycles = ~16 KHz on DMG

; -- $FF08-$FF0E are unused ---------------------------------------------------

; -- IF ($FF0F) ---------------------------------------------------------------
; Pending interrupts
DEF rIF EQU $FF0F

DEF B_IF_JOYPAD EQU 4 ; 1 = joypad interrupt is pending [r/w]
DEF B_IF_SERIAL EQU 3 ; 1 = serial interrupt is pending [r/w]
DEF B_IF_TIMER  EQU 2 ; 1 = timer  interrupt is pending [r/w]
DEF B_IF_STAT   EQU 1 ; 1 = STAT   interrupt is pending [r/w]
DEF B_IF_VBLANK EQU 0 ; 1 = VBlank interrupt is pending [r/w]
    DEF IF_JOYPAD EQU 1 << B_IF_JOYPAD
    DEF IF_SERIAL EQU 1 << B_IF_SERIAL
    DEF IF_TIMER  EQU 1 << B_IF_TIMER
    DEF IF_STAT   EQU 1 << B_IF_STAT
    DEF IF_VBLANK EQU 1 << B_IF_VBLANK

; -- AUD1SWEEP / NR10 ($FF10) -------------------------------------------------
; Audio channel 1 sweep
DEF rAUD1SWEEP EQU $FF10

DEF AUD1SWEEP_TIME EQU %0_111_0000 ; how long between sweep iterations
                                   ; (in 128 Hz ticks, ~7.8 ms apart) [r/w]

DEF B_AUD1SWEEP_DIR EQU 3 ; sweep direction [r/w]
    DEF AUD1SWEEP_DIR EQU 1 << B_AUD1SWEEP_DIR
        DEF AUD1SWEEP_UP   EQU 0 << B_AUD1SWEEP_DIR
        DEF AUD1SWEEP_DOWN EQU 1 << B_AUD1SWEEP_DIR

DEF AUD1SWEEP_SHIFT EQU %00000_111 ; how much the period increases/decreases per iteration [r/w]

; -- AUD1LEN / NR11 ($FF11) ---------------------------------------------------
; Audio channel 1 length timer and duty cycle
DEF rAUD1LEN EQU $FF11

DEF AUD1LEN_DUTY EQU %11_000000 ; ratio of time spent high vs. time spent low [r/w]
    DEF AUD1LEN_DUTY_12_5 EQU %00_000000 ; 12.5%
    DEF AUD1LEN_DUTY_25   EQU %01_000000 ; 25%
    DEF AUD1LEN_DUTY_50   EQU %10_000000 ; 50%
    DEF AUD1LEN_DUTY_75   EQU %11_000000 ; 75%

DEF AUD1LEN_TIMER EQU %00_111111 ; initial length timer (0-63) [wo]

; -- AUD1ENV / NR12 ($FF12) ---------------------------------------------------
; Audio channel 1 volume and envelope
DEF rAUD1ENV EQU $FF12

DEF AUD1ENV_INIT_VOLUME EQU %1111_0000 ; initial volume [r/w]

DEF B_AUD1ENV_DIR EQU 3 ; direction of volume envelope [r/w]
    DEF AUD1ENV_DIR EQU 1 << B_AUD1ENV_DIR
        DEF AUD1ENV_DOWN EQU 0 << B_AUD1ENV_DIR
        DEF AUD1ENV_UP   EQU 1 << B_AUD1ENV_DIR

DEF AUD1ENV_PACE EQU %00000_111 ; how long between envelope iterations
                                ; (in 64 Hz ticks, ~15.6 ms apart) [r/w]

; -- AUD1LOW / NR13 ($FF13) ---------------------------------------------------
; Audio channel 1 period (low 8 bits) [r/w]
DEF rAUD1LOW EQU $FF13

; -- AUD1HIGH / NR14 ($FF14) --------------------------------------------------
; Audio channel 1 period (high 3 bits) and control
DEF rAUD1HIGH EQU $FF14

DEF B_AUD1HIGH_RESTART    EQU 7 ; 1 = restart the channel [wo]
DEF B_AUD1HIGH_LEN_ENABLE EQU 6 ; 1 = reset the channel after the length timer expires [r/w]
    DEF AUD1HIGH_RESTART    EQU 1 << B_AUD1HIGH_RESTART
    DEF AUD1HIGH_LENGTH_OFF EQU 0 << B_AUD1HIGH_LEN_ENABLE
    DEF AUD1HIGH_LENGTH_ON  EQU 1 << B_AUD1HIGH_LEN_ENABLE

DEF AUD1HIGH_PERIOD_HIGH EQU %00000_111 ; upper 3 bits of the channel's period [r/w]

; -- $FF15 is unused ----------------------------------------------------------

; -- AUD2LEN / NR21 ($FF16) ---------------------------------------------------
; Audio channel 2 length timer and duty cycle
DEF rAUD2LEN EQU $FF16

DEF AUD2LEN_DUTY EQU %11_000000 ; ratio of time spent high vs. time spent low [r/w]
    DEF AUD2LEN_DUTY_12_5 EQU %00_000000 ; 12.5%
    DEF AUD2LEN_DUTY_25   EQU %01_000000 ; 25%
    DEF AUD2LEN_DUTY_50   EQU %10_000000 ; 50%
    DEF AUD2LEN_DUTY_75   EQU %11_000000 ; 75%

DEF AUD2LEN_TIMER EQU %00_111111 ; initial length timer (0-63) [wo]

; -- AUD2ENV / NR22 ($FF17) ---------------------------------------------------
; Audio channel 2 volume and envelope
DEF rAUD2ENV EQU $FF17

DEF AUD2ENV_INIT_VOLUME EQU %1111_0000 ; initial volume [r/w]

DEF B_AUD2ENV_DIR EQU 3 ; direction of volume envelope [r/w]
    DEF AUD2ENV_DIR EQU 1 << B_AUD2ENV_DIR
        DEF AUD2ENV_DOWN EQU 0 << B_AUD2ENV_DIR
        DEF AUD2ENV_UP   EQU 1 << B_AUD2ENV_DIR

DEF AUD2ENV_PACE EQU %00000_111 ; how long between envelope iterations
                                ; (in 64 Hz ticks, ~15.6 ms apart) [r/w]

; -- AUD2LOW / NR23 ($FF18) ---------------------------------------------------
; Audio channel 2 period (low 8 bits) [r/w]
DEF rAUD2LOW EQU $FF18

; -- AUD2HIGH / NR24 ($FF19) --------------------------------------------------
; Audio channel 2 period (high 3 bits) and control
DEF rAUD2HIGH EQU $FF19

DEF B_AUD2HIGH_RESTART    EQU 7 ; 1 = restart the channel [wo]
DEF B_AUD2HIGH_LEN_ENABLE EQU 6 ; 1 = reset the channel after the length timer expires [r/w]
    DEF AUD2HIGH_RESTART    EQU 1 << B_AUD2HIGH_RESTART
    DEF AUD2HIGH_LENGTH_OFF EQU 0 << B_AUD2HIGH_LEN_ENABLE
    DEF AUD2HIGH_LENGTH_ON  EQU 1 << B_AUD2HIGH_LEN_ENABLE

DEF AUD2HIGH_PERIOD_HIGH EQU %00000_111 ; upper 3 bits of the channel's period [r/w]

; -- AUD3ENA / NR30 ($FF1A) ---------------------------------------------------
; Audio channel 3 enable
DEF rAUD3ENA EQU $FF1A

DEF B_AUD3ENA_ENABLE EQU 7 ; 1 = channel is active [r/w]
    DEF AUD3ENA_OFF EQU 0 << B_AUD3ENA_ENABLE
    DEF AUD3ENA_ON  EQU 1 << B_AUD3ENA_ENABLE

; -- AUD3LEN / NR31 ($FF1B) ---------------------------------------------------
; Audio channel 3 length timer [wo]
DEF rAUD3LEN EQU $FF1B

; -- AUD3LEVEL / NR32 ($FF1C) -------------------------------------------------
; Audio channel 3 volume
DEF rAUD3LEVEL EQU $FF1C

DEF AUD3LEVEL_VOLUME EQU %0_11_00000 ; volume level [r/w]
    DEF AUD3LEVEL_MUTE EQU %0_00_00000 ; 0% (muted)
    DEF AUD3LEVEL_100  EQU %0_01_00000 ; 100%
    DEF AUD3LEVEL_50   EQU %0_10_00000 ; 50%
    DEF AUD3LEVEL_25   EQU %0_11_00000 ; 25%

; -- AUD3LOW / NR33 ($FF1D) ---------------------------------------------------
; Audio channel 3 period (low 8 bits) [r/w]
DEF rAUD3LOW EQU $FF1D

; -- AUD3HIGH / NR34 ($FF1E) --------------------------------------------------
; Audio channel 3 period (high 3 bits) and control
DEF rAUD3HIGH EQU $FF1E

DEF B_AUD3HIGH_RESTART    EQU 7 ; 1 = restart the channel [wo]
DEF B_AUD3HIGH_LEN_ENABLE EQU 6 ; 1 = reset the channel after the length timer expires [r/w]
    DEF AUD3HIGH_RESTART    EQU 1 << B_AUD3HIGH_RESTART
    DEF AUD3HIGH_LENGTH_OFF EQU 0 << B_AUD3HIGH_LEN_ENABLE
    DEF AUD3HIGH_LENGTH_ON  EQU 1 << B_AUD3HIGH_LEN_ENABLE

DEF AUD3HIGH_PERIOD_HIGH EQU %00000_111 ; upper 3 bits of the channel's period [r/w]

; -- $FF1F is unused ----------------------------------------------------------

; -- AUD4LEN / NR41 ($FF20) ---------------------------------------------------
; Audio channel 4 length timer
DEF rAUD4LEN EQU $FF20

DEF AUD4LEN_TIMER EQU %00_111111 ; initial length timer (0-63) [wo]

; -- AUD4ENV / NR42 ($FF21) ---------------------------------------------------
; Audio channel 4 volume and envelope
DEF rAUD4ENV EQU $FF21

DEF AUD4ENV_INIT_VOLUME EQU %1111_0000 ; initial volume [r/w]

DEF B_AUD4ENV_DIR EQU 3 ; direction of volume envelope [r/w]
    DEF AUD4ENV_DIR EQU 1 << B_AUD4ENV_DIR
        DEF AUD4ENV_DOWN EQU 0 << B_AUD4ENV_DIR
        DEF AUD4ENV_UP   EQU 1 << B_AUD4ENV_DIR

DEF AUD4ENV_PACE EQU %00000_111 ; how long between envelope iterations
                                ; (in 64 Hz ticks, ~15.6 ms apart) [r/w]

; -- AUD4POLY / NR43 ($FF22) --------------------------------------------------
; Audio channel 4 period and randomness
DEF rAUD4POLY EQU $FF22

DEF AUD4POLY_SHIFT EQU %1111_0000 ; coarse control of the channel's period [r/w]

DEF B_AUD4POLY_WIDTH EQU 3 ; controls the noise generator (LFSR)'s step width [r/w]
    DEF AUD4POLY_15STEP EQU 0 << B_AUD4POLY_WIDTH
    DEF AUD4POLY_7STEP  EQU 1 << B_AUD4POLY_WIDTH

DEF AUD4POLY_DIV EQU %00000_111 ; fine control of the channel's period [r/w]

; -- AUD4GO / NR44 ($FF23) ----------------------------------------------------
; Audio channel 4 control
DEF rAUD4GO EQU $FF23

DEF B_AUD4GO_RESTART    EQU 7 ; 1 = restart the channel [wo]
DEF B_AUD4GO_LEN_ENABLE EQU 6 ; 1 = reset the channel after the length timer expires [r/w]
    DEF AUD4GO_RESTART    EQU 1 << B_AUD4GO_RESTART
    DEF AUD4GO_LENGTH_OFF EQU 0 << B_AUD4GO_LEN_ENABLE
    DEF AUD4GO_LENGTH_ON  EQU 1 << B_AUD4GO_LEN_ENABLE

; -- AUDVOL / NR50 ($FF24) ----------------------------------------------------
; Audio master volume and VIN mixer
DEF rAUDVOL EQU $FF24

DEF B_AUDVOL_VIN_LEFT  EQU 7 ; 1 = output VIN to left ear (SO2, speaker 2) [r/w]
    DEF AUDVOL_VIN_LEFT EQU 1 << B_AUDVOL_VIN_LEFT

DEF AUDVOL_LEFT EQU %0_111_0000 ; 0 = barely audible, 7 = full volume [r/w]

DEF B_AUDVOL_VIN_RIGHT EQU 3 ; 1 = output VIN to right ear (SO1, speaker 1) [r/w]
    DEF AUDVOL_VIN_RIGHT EQU 1 << B_AUDVOL_VIN_RIGHT

DEF AUDVOL_RIGHT EQU %00000_111 ; 0 = barely audible, 7 = full volume [r/w]

; -- AUDTERM / NR51 ($FF25) ---------------------------------------------------
; Audio channel mixer
DEF rAUDTERM EQU $FF25

DEF B_AUDTERM_4_LEFT  EQU 7 ; 1 = output channel 4 to left  ear [r/w]
DEF B_AUDTERM_3_LEFT  EQU 6 ; 1 = output channel 3 to left  ear [r/w]
DEF B_AUDTERM_2_LEFT  EQU 5 ; 1 = output channel 2 to left  ear [r/w]
DEF B_AUDTERM_1_LEFT  EQU 4 ; 1 = output channel 1 to left  ear [r/w]
DEF B_AUDTERM_4_RIGHT EQU 3 ; 1 = output channel 4 to right ear [r/w]
DEF B_AUDTERM_3_RIGHT EQU 2 ; 1 = output channel 3 to right ear [r/w]
DEF B_AUDTERM_2_RIGHT EQU 1 ; 1 = output channel 2 to right ear [r/w]
DEF B_AUDTERM_1_RIGHT EQU 0 ; 1 = output channel 1 to right ear [r/w]
    DEF AUDTERM_4_LEFT  EQU 1 << B_AUDTERM_4_LEFT
    DEF AUDTERM_3_LEFT  EQU 1 << B_AUDTERM_3_LEFT
    DEF AUDTERM_2_LEFT  EQU 1 << B_AUDTERM_2_LEFT
    DEF AUDTERM_1_LEFT  EQU 1 << B_AUDTERM_1_LEFT
    DEF AUDTERM_4_RIGHT EQU 1 << B_AUDTERM_4_RIGHT
    DEF AUDTERM_3_RIGHT EQU 1 << B_AUDTERM_3_RIGHT
    DEF AUDTERM_2_RIGHT EQU 1 << B_AUDTERM_2_RIGHT
    DEF AUDTERM_1_RIGHT EQU 1 << B_AUDTERM_1_RIGHT

; -- AUDENA / NR52 ($FF26) ----------------------------------------------------
; Audio master enable
DEF rAUDENA EQU $FF26

DEF B_AUDENA_ENABLE     EQU 7 ; 0 = disable the APU (resets all audio registers to 0!) [r/w]
DEF B_AUDENA_ENABLE_CH4 EQU 3 ; 1 = channel 4 is running [ro]
DEF B_AUDENA_ENABLE_CH3 EQU 2 ; 1 = channel 3 is running [ro]
DEF B_AUDENA_ENABLE_CH2 EQU 1 ; 1 = channel 2 is running [ro]
DEF B_AUDENA_ENABLE_CH1 EQU 0 ; 1 = channel 1 is running [ro]
    DEF AUDENA_OFF     EQU 0 << B_AUDENA_ENABLE
    DEF AUDENA_ON      EQU 1 << B_AUDENA_ENABLE
    DEF AUDENA_CH4_OFF EQU 0 << B_AUDENA_ENABLE_CH4
    DEF AUDENA_CH4_ON  EQU 1 << B_AUDENA_ENABLE_CH4
    DEF AUDENA_CH3_OFF EQU 0 << B_AUDENA_ENABLE_CH3
    DEF AUDENA_CH3_ON  EQU 1 << B_AUDENA_ENABLE_CH3
    DEF AUDENA_CH2_OFF EQU 0 << B_AUDENA_ENABLE_CH2
    DEF AUDENA_CH2_ON  EQU 1 << B_AUDENA_ENABLE_CH2
    DEF AUDENA_CH1_OFF EQU 0 << B_AUDENA_ENABLE_CH1
    DEF AUDENA_CH1_ON  EQU 1 << B_AUDENA_ENABLE_CH1

; -- $FF27-$FF2F are unused ---------------------------------------------------

; -- AUD3WAVE ($FF30-$FF3F) ---------------------------------------------------
; Audio channel 3 wave pattern RAM [r/w]
DEF rAUD3WAVE_0 EQU $FF30
DEF rAUD3WAVE_1 EQU $FF31
DEF rAUD3WAVE_2 EQU $FF32
DEF rAUD3WAVE_3 EQU $FF33
DEF rAUD3WAVE_4 EQU $FF34
DEF rAUD3WAVE_5 EQU $FF35
DEF rAUD3WAVE_6 EQU $FF36
DEF rAUD3WAVE_7 EQU $FF37
DEF rAUD3WAVE_8 EQU $FF38
DEF rAUD3WAVE_9 EQU $FF39
DEF rAUD3WAVE_A EQU $FF3A
DEF rAUD3WAVE_B EQU $FF3B
DEF rAUD3WAVE_C EQU $FF3C
DEF rAUD3WAVE_D EQU $FF3D
DEF rAUD3WAVE_E EQU $FF3E
DEF rAUD3WAVE_F EQU $FF3F

; -- LCDC ($FF40) -------------------------------------------------------------
; PPU graphics control
DEF rLCDC EQU $FF40

DEF B_LCDC_ENABLE   EQU 7 ; whether the PPU (and LCD) are turned on          [r/w]
DEF B_LCDC_WIN_MAP  EQU 6 ; which tilemap the Window reads from              [r/w]
DEF B_LCDC_WINDOW   EQU 5 ; whether the Window is enabled                    [r/w]
DEF B_LCDC_BLOCKS   EQU 4 ; which "tile blocks" the BG and Window use        [r/w]
DEF B_LCDC_BG_MAP   EQU 3 ; which tilemap the BG reads from                  [r/w]
DEF B_LCDC_OBJ_SIZE EQU 2 ; how many pixels tall each OBJ is                 [r/w]
DEF B_LCDC_OBJS     EQU 1 ; whether OBJs are enabled                         [r/w]
DEF B_LCDC_BG       EQU 0 ; (DMG only) whether the BG is enabled             [r/w]
DEF B_LCDC_PRIO     EQU 0 ; (CGB only) whether OBJ priority bits are enabled [r/w]
    DEF LCDC_ENABLE   EQU 1 << B_LCDC_ENABLE
        DEF LCDC_OFF EQU 0 << B_LCDC_ENABLE
        DEF LCDC_ON  EQU 1 << B_LCDC_ENABLE
    DEF LCDC_WIN_MAP  EQU 1 << B_LCDC_WIN_MAP
        DEF LCDC_WIN_9800 EQU 0 << B_LCDC_WIN_MAP
        DEF LCDC_WIN_9C00 EQU 1 << B_LCDC_WIN_MAP
    DEF LCDC_WINDOW   EQU 1 << B_LCDC_WINDOW
        DEF LCDC_WIN_OFF EQU 0 << B_LCDC_WINDOW
        DEF LCDC_WIN_ON  EQU 1 << B_LCDC_WINDOW
    DEF LCDC_BLOCKS   EQU 1 << B_LCDC_BLOCKS
        DEF LCDC_BLOCK21 EQU 0 << B_LCDC_BLOCKS
        DEF LCDC_BLOCK01 EQU 1 << B_LCDC_BLOCKS
    DEF LCDC_BG_MAP   EQU 1 << B_LCDC_BG_MAP
        DEF LCDC_BG_9800 EQU 0 << B_LCDC_BG_MAP
        DEF LCDC_BG_9C00 EQU 1 << B_LCDC_BG_MAP
    DEF LCDC_OBJ_SIZE EQU 1 << B_LCDC_OBJ_SIZE
        DEF LCDC_OBJ_8  EQU 0 << B_LCDC_OBJ_SIZE
        DEF LCDC_OBJ_16 EQU 1 << B_LCDC_OBJ_SIZE
    DEF LCDC_OBJS     EQU 1 << B_LCDC_OBJS
        DEF LCDC_OBJ_OFF EQU 0 << B_LCDC_OBJS
        DEF LCDC_OBJ_ON  EQU 1 << B_LCDC_OBJS
    DEF LCDC_BG       EQU 1 << B_LCDC_BG
        DEF LCDC_BG_OFF EQU 0 << B_LCDC_BG
        DEF LCDC_BG_ON  EQU 1 << B_LCDC_BG
    DEF LCDC_PRIO     EQU 1 << B_LCDC_PRIO
        DEF LCDC_PRIO_OFF EQU 0 << B_LCDC_PRIO
        DEF LCDC_PRIO_ON  EQU 1 << B_LCDC_PRIO

; -- STAT ($FF41) -------------------------------------------------------------
; Graphics status and interrupt control
DEF rSTAT EQU $FF41

DEF B_STAT_LYC    EQU 6 ; 1 = LY match triggers the STAT interrupt [r/w]
DEF B_STAT_MODE_2 EQU 5 ; 1 = OAM Scan triggers the PPU interrupt  [r/w]
DEF B_STAT_MODE_1 EQU 4 ; 1 = VBlank triggers the PPU interrupt    [r/w]
DEF B_STAT_MODE_0 EQU 3 ; 1 = HBlank triggers the PPU interrupt    [r/w]
DEF B_STAT_LYCF   EQU 2 ; 1 = LY is currently equal to LYC         [ro]
DEF B_STAT_BUSY   EQU 1 ; 1 = the PPU is currently accessing VRAM  [ro]
    DEF STAT_LYC    EQU 1 << B_STAT_LYC
    DEF STAT_MODE_2 EQU 1 << B_STAT_MODE_2
    DEF STAT_MODE_1 EQU 1 << B_STAT_MODE_1
    DEF STAT_MODE_0 EQU 1 << B_STAT_MODE_0
    DEF STAT_LYCF   EQU 1 << B_STAT_LYCF
    DEF STAT_BUSY   EQU 1 << B_STAT_BUSY

DEF STAT_MODE EQU %000000_11 ; PPU's current status [ro]
    DEF STAT_HBLANK EQU %000000_00 ; waiting after a line's rendering (HBlank)
    DEF STAT_VBLANK EQU %000000_01 ; waiting between frames (VBlank)
    DEF STAT_OAM    EQU %000000_10 ; checking which OBJs will be rendered on this line (OAM scan)
    DEF STAT_LCD    EQU %000000_11 ; pushing pixels to the LCD

; -- SCY ($FF42) --------------------------------------------------------------
; Background Y scroll offset (in pixels) [r/w]
DEF rSCY EQU $FF42

; -- SCX ($FF43) --------------------------------------------------------------
; Background X scroll offset (in pixels) [r/w]
DEF rSCX EQU $FF43

; -- LY ($FF44) ---------------------------------------------------------------
; Y coordinate of the line currently processed by the PPU (0-153) [ro]
DEF rLY EQU $FF44

DEF LY_VBLANK EQU 145 ; 144-153 is the VBlank period

; -- LYC ($FF45) --------------------------------------------------------------
; Value that LY is constantly compared to [r/w]
DEF rLYC EQU $FF45

; -- DMA ($FF46) --------------------------------------------------------------
; OAM DMA start address (high 8 bits) and start [wo]
DEF rDMA EQU $FF46

; -- BGP ($FF47) --------------------------------------------------------------
; (DMG only) Background color mapping [r/w]
DEF rBGP EQU $FF47

DEF BGP_SGB_TRANSFER EQU %11_10_01_00 ; set BGP to this value before SGB VRAM transfer

; -- OBP0 ($FF48) -------------------------------------------------------------
; (DMG only) OBJ color mapping #0 [r/w]
DEF rOBP0 EQU $FF48

; -- OBP1 ($FF49) -------------------------------------------------------------
; (DMG only) OBJ color mapping #1 [r/w]
DEF rOBP1 EQU $FF49

; -- WY ($FF4A) ---------------------------------------------------------------
; Y coordinate of the Window's top-left pixel (0-143) [r/w]
DEF rWY EQU $FF4A

; -- WX ($FF4B) ---------------------------------------------------------------
; X coordinate of the Window's top-left pixel, plus 7 (7-166) [r/w]
DEF rWX EQU $FF4B

DEF WX_OFS EQU 7 ; subtract this to get the actual Window X coordinate

; -- SYS / KEY0 ($FF4C) -------------------------------------------------------
; (CGB boot ROM only) CPU mode select
DEF rSYS EQU $FF4C

; This is known as the "CPU mode register" in Fig. 11 of this patent:
; https://patents.google.com/patent/US6322447B1/en?oq=US6322447bi
; "OBJ priority mode designating register" in the same patent
; Credit to @mattcurrie for this finding!

DEF SYS_MODE EQU %0000_11_00 ; current system mode [r/w]
    DEF SYS_CGB  EQU %0000_00_00 ; CGB mode
    DEF SYS_DMG  EQU %0000_01_00 ; DMG compatibility mode
    DEF SYS_PGB1 EQU %0000_10_00 ; LCD is driven externally, CPU is stopped
    DEF SYS_PGB2 EQU %0000_11_00 ; LCD is driven externally, CPU is running

; -- SPD / KEY1 ($FF4D) -------------------------------------------------------
; (CGB only) Double-speed mode control
DEF rSPD EQU $FF4D

DEF B_SPD_DOUBLE  EQU 7 ; current clock speed                                  [ro]
DEF B_SPD_PREPARE EQU 0 ; 1 = next `stop` instruction will switch clock speeds [r/w]
    DEF SPD_SINGLE  EQU 0 << B_SPD_DOUBLE
    DEF SPD_DOUBLE  EQU 1 << B_SPD_DOUBLE
    DEF SPD_PREPARE EQU 1 << B_SPD_PREPARE

; -- $FF4E is unused ----------------------------------------------------------

; -- VBK ($FF4F) --------------------------------------------------------------
; (CGB only) VRAM bank number (0 or 1)
DEF rVBK EQU $FF4F

DEF VBK_BANK EQU %0000000_1 ; mapped VRAM bank [r/w]

; -- BANK ($FF50) -------------------------------------------------------------
; (boot ROM only) Boot ROM mapping control
DEF rBANK EQU $FF50

DEF B_BANK_ON EQU 0 ; whether the boot ROM is mapped [wo]
    DEF BANK_ON  EQU 0 << B_BANK_ON
    DEF BANK_OFF EQU 1 << B_BANK_ON

; -- VDMA_SRC_HIGH / HDMA1 ($FF51) --------------------------------------------
; (CGB only) VRAM DMA source address (high 8 bits) [wo]
DEF rVDMA_SRC_HIGH EQU $FF51

; -- VDMA_SRC_LOW / HDMA2 ($FF52) ---------------------------------------------
; (CGB only) VRAM DMA source address (low 8 bits) [wo]
DEF rVDMA_SRC_LOW EQU $FF52

; -- VDMA_DEST_HIGH / HDMA3 ($FF53) -------------------------------------------
; (CGB only) VRAM DMA destination address (high 8 bits) [wo]
DEF rVDMA_DEST_HIGH EQU $FF53

; -- VDMA_DEST_LOW / HDMA4 ($FF54) --------------------------------------------
; (CGB only) VRAM DMA destination address (low 8 bits) [wo]
DEF rVDMA_DEST_LOW EQU $FF54

; -- VDMA_LEN / HDMA5 ($FF55) -------------------------------------------------
; (CGB only) VRAM DMA length, mode, and start
DEF rVDMA_LEN EQU $FF55

DEF B_VDMA_LEN_MODE EQU 7 ; on write: VRAM DMA mode [wo]
    DEF VDMA_LEN_MODE EQU 1 << B_VDMA_LEN_MODE
        DEF VDMA_LEN_MODE_GENERAL EQU 0 << B_VDMA_LEN_MODE ; GDMA (general-purpose)
        DEF VDMA_LEN_MODE_HBLANK  EQU 1 << B_VDMA_LEN_MODE ; HDMA (HBlank)

DEF B_VDMA_LEN_BUSY EQU 7 ; on read: is a VRAM DMA active?
    DEF VDMA_LEN_BUSY EQU 1 << B_VDMA_LEN_BUSY
        DEF VDMA_LEN_NO  EQU 0 << B_VDMA_LEN_BUSY
        DEF VDMA_LEN_YES EQU 1 << B_VDMA_LEN_BUSY

DEF VDMA_LEN_SIZE EQU %0_1111111 ; how many 16-byte blocks (minus 1) to transfer [r/w]

; -- RP ($FF56) ---------------------------------------------------------------
; (CGB only) Infrared communications port
DEF rRP EQU $FF56

DEF RP_READ EQU %11_000000 ; whether the IR read is enabled [r/w]
    DEF RP_DISABLE EQU %00_000000
    DEF RP_ENABLE  EQU %11_000000

DEF B_RP_DATA_IN EQU 1 ; 0 = IR light is being received [ro]
DEF B_RP_LED_ON  EQU 0 ; 1 = IR light is being sent     [r/w]
    DEF RP_DATA_IN EQU 1 << B_RP_DATA_IN
    DEF RP_LED_ON  EQU 1 << B_RP_LED_ON
        DEF RP_WRITE_LOW  EQU 0 << B_RP_LED_ON
        DEF RP_WRITE_HIGH EQU 1 << B_RP_LED_ON

; -- $FF57-$FF67 are unused ---------------------------------------------------

; -- BGPI / BCPS ($FF68) ------------------------------------------------------
; (CGB only) Background palette I/O index
DEF rBGPI EQU $FF68

DEF B_BGPI_AUTOINC EQU 7 ; whether the index field is incremented after each write to BCPD [r/w]
    DEF BGPI_AUTOINC EQU 1 << B_BGPI_AUTOINC

DEF BGPI_INDEX EQU %00_111111 ; the index within Palette RAM accessed via BCPD [r/w]

; -- BGPD / BCPD ($FF69) ------------------------------------------------------
; (CGB only) Background palette I/O access [r/w]
DEF rBGPD EQU $FF69

; -- OBPI / OCPS ($FF6A) ------------------------------------------------------
; (CGB only) OBJ palette I/O index
DEF rOBPI EQU $FF6A

DEF B_OBPI_AUTOINC EQU 7 ; whether the index field is incremented after each write to OBPD [r/w]
    DEF OBPI_AUTOINC EQU 1 << B_OBPI_AUTOINC

DEF OBPI_INDEX EQU %00_111111 ; the index within Palette RAM accessed via OBPD [r/w]

; -- OBPD / OCPD ($FF6B) ------------------------------------------------------
; (CGB only) OBJ palette I/O access [r/w]
DEF rOBPD EQU $FF6B

; -- OPRI ($FF6C) -------------------------------------------------------------
; (CGB boot ROM only) OBJ draw priority mode
DEF rOPRI EQU $FF6C

DEF B_OPRI_PRIORITY EQU 0 ; which drawing priority is used for OBJs [r/w]
    DEF OPRI_PRIORITY EQU 1 << B_OPRI_PRIORITY
        DEF OPRI_OAM   EQU 0 << B_OPRI_PRIORITY ; CGB mode default: earliest OBJ in OAM wins
        DEF OPRI_COORD EQU 1 << B_OPRI_PRIORITY ; DMG mode default: leftmost OBJ wins

; -- $FF6D-$FF6F are unused ---------------------------------------------------

; -- WBK / SVBK ($FF70) -------------------------------------------------------
; (CGB only) WRAM bank number
DEF rWBK EQU $FF70

DEF WBK_BANK EQU %00000_111 ; mapped WRAM bank (0-7) [r/w]

; -- $FF71-$FF75 are unused ---------------------------------------------------

; -- PCM12 ($FF76) ------------------------------------------------------------
; Audio channels 1 and 2 output
DEF rPCM12 EQU $FF76

DEF PCM12_CH2 EQU %1111_0000 ; audio channel 2 output [ro]
DEF PCM12_CH1 EQU %0000_1111 ; audio channel 1 output [ro]

; -- PCM34 ($FF77) ------------------------------------------------------------
; Audio channels 3 and 4 output
DEF rPCM34 EQU $FF77

DEF PCM34_CH4 EQU %1111_0000 ; audio channel 4 output [ro]
DEF PCM34_CH3 EQU %0000_1111 ; audio channel 3 output [ro]

; -- $FF78-$FF7F are unused ---------------------------------------------------

; -- IE ($FFFF) ---------------------------------------------------------------
; Interrupt enable
DEF rIE EQU $FFFF

DEF B_IE_JOYPAD EQU 4 ; 1 = joypad interrupt is enabled [r/w]
DEF B_IE_SERIAL EQU 3 ; 1 = serial interrupt is enabled [r/w]
DEF B_IE_TIMER  EQU 2 ; 1 = timer  interrupt is enabled [r/w]
DEF B_IE_STAT   EQU 1 ; 1 = STAT   interrupt is enabled [r/w]
DEF B_IE_VBLANK EQU 0 ; 1 = VBlank interrupt is enabled [r/w]
    DEF IE_JOYPAD EQU 1 << B_IE_JOYPAD
    DEF IE_SERIAL EQU 1 << B_IE_SERIAL
    DEF IE_TIMER  EQU 1 << B_IE_TIMER
    DEF IE_STAT   EQU 1 << B_IE_STAT
    DEF IE_VBLANK EQU 1 << B_IE_VBLANK


;******************************************************************************
; Cartridge registers (MBC)
;******************************************************************************

; Note that these "registers" are each actually accessible at an entire address range;
; however, one address for each of these ranges is considered the "canonical" one, and
; these addresses are what's provided here.


; ** Common to most MBCs ******************************************************

; -- RAMG ($0000-$1FFF) -------------------------------------------------------
; Whether SRAM can be accessed [wo]
DEF rRAMG EQU $0000

; Common values (not for HuC1 or HuC-3)
DEF RAMG_SRAM_DISABLE EQU $00
DEF RAMG_SRAM_ENABLE  EQU $0A ; some MBCs accept any value whose low nybble is $A

; (HuC-3 only) switch SRAM to map cartridge RAM, RTC, or IR
DEF RAMG_CART_RAM_RO   EQU $00 ; select cartridge RAM [ro]
DEF RAMG_CART_RAM      EQU $0A ; select cartridge RAM [r/w]
DEF RAMG_RTC_IN        EQU $0B ; select RTC command/argument [wo]
    DEF RAMG_RTC_IN_CMD EQU %0_111_0000 ; command
    DEF RAMG_RTC_IN_ARG EQU %0_000_1111 ; argument
DEF RAMG_RTC_OUT       EQU $0C ; select RTC command/response [ro]
    DEF RAMG_RTC_OUT_CMD    EQU %0_111_0000 ; command
    DEF RAMG_RTC_OUT_RESULT EQU %0_000_1111 ; result
DEF RAMG_RTC_SEMAPHORE EQU $0D ; select RTC semaphore [r/w]
DEF RAMG_IR            EQU $0E ; (HuC1 and HuC-3 only) select IR [r/w]

; -- ROMB ($2000-$3FFF) -------------------------------------------------------
; ROM bank number (not for MBC5 or MBC6) [wo]
DEF rROMB EQU $2000

; -- RAMB ($4000-$5FFF) -------------------------------------------------------
; SRAM bank number (not for MBC2, MBC6, or MBC7) [wo]
DEF rRAMB EQU $4000

; (MBC3 only) Special RAM bank numbers that actually map values into RTCREG
DEF RAMB_RTC_S  EQU $08 ; seconds counter (0-59)
DEF RAMB_RTC_M  EQU $09 ; minutes counter (0-59)
DEF RAMB_RTC_H  EQU $0A ; hours counter (0-23)
DEF RAMB_RTC_DL EQU $0B ; days counter, low byte (0-255)
DEF RAMB_RTC_DH EQU $0C ; days counter, high bit and other flags
    DEF B_RAMB_RTC_DH_CARRY EQU 7 ; 1 = days counter overflowed    [wo]
    DEF B_RAMB_RTC_DH_HALT  EQU 6 ; 0 = run timer, 1 = stop timer  [wo]
    DEF B_RAMB_RTC_DH_HIGH  EQU 0 ; days counter, high bit (bit 8) [wo]
        DEF RAMB_RTC_DH_CARRY EQU 1 << B_RAMB_RTC_DH_CARRY
        DEF RAMB_RTC_DH_HALT  EQU 1 << B_RAMB_RTC_DH_HALT
        DEF RAMB_RTC_DH_HIGH  EQU 1 << B_RAMB_RTC_DH_HIGH

DEF B_RAMB_RUMBLE EQU 3 ; (MBC5 and MBC7 only) enable the rumble motor (if any)
    DEF RAMB_RUMBLE EQU 1 << B_RAMB_RUMBLE
        DEF RAMB_RUMBLE_OFF EQU 0 << B_RAMB_RUMBLE
        DEF RAMB_RUMBLE_ON  EQU 1 << B_RAMB_RUMBLE


; ** MBC1 and MMM01 only ******************************************************

; -- BMODE ($6000-$7FFF) ------------------------------------------------------
; Banking mode select [wo]
DEF rBMODE EQU $6000

DEF BMODE_SIMPLE   EQU $00 ; locks ROMB and RAMB to bank 0
DEF BMODE_ADVANCED EQU $01 ; allows bank-switching with RAMB


; ** MBC2 only ****************************************************************

; -- ROM2B ($0000-$3FFF with bit 8 set) ---------------------------------------
; ROM bank number [wo]
DEF rROM2B EQU $2100


; ** MBC3 only ****************************************************************

; -- RTCLATCH ($6000-$7FFF) ---------------------------------------------------
; RTC latch clock data [wo]
DEF rRTCLATCH EQU $6000

; Write $00 then $01 to latch the current time into RTCREG
DEF RTCLATCH_START  EQU $00
DEF RTCLATCH_FINISH EQU $01

; -- RTCREG ($A000-$BFFF) -----------------------------------------------------
; RTC register [r/w]
DEF rRTCREG EQU $A000


; ** MBC5 only ****************************************************************

; -- ROMB0 ($2000-$2FFF) ------------------------------------------------------
; ROM bank number low byte (bits 0-7) [wo]
DEF rROMB0 EQU $2000

; -- ROMB1 ($3000-$3FFF) ------------------------------------------------------
; ROM bank number high bit (bit 8) [wo]
DEF rROMB1 EQU $3000


; ** MBC6 only ****************************************************************

; -- RAMBA ($0400-$07FF) ------------------------------------------------------
; RAM bank A number [wo]
DEF rRAMBA EQU $0400

; -- RAMBB ($0800-$0BFF) ------------------------------------------------------
; RAM bank B number [wo]
DEF rRAMBB EQU $0800

; -- FLASH ($0C00-$0FFF) ------------------------------------------------------
; Whether the flash chip can be accessed [wo]
DEF rFLASH EQU $0C00

; -- FMODE ($1000) ------------------------------------------------------------
; Write mode select for the flash chip
DEF rFMODE EQU $1000

; -- ROMBA ($2000-$27FF) ------------------------------------------------------
; ROM/Flash bank A number [wo]
DEF rROMBA EQU $2000

; -- FLASHA ($2800-$2FFF) -----------------------------------------------------
; ROM/Flash bank A select [wo]
DEF rFLASHA EQU $2800

; -- ROMBB ($3000-$37FF) ------------------------------------------------------
; ROM/Flash bank B number [wo]
DEF rROMBB EQU $3000

; -- FLASHB ($3800-$3FFF) -----------------------------------------------------
; ROM/Flash bank B select [wo]
DEF rFLASHB EQU $3800


; ** MBC7 only ****************************************************************

; -- RAMREG ($4000-$5FFF) -----------------------------------------------------
; Enable RAM register access [wo]
DEF rRAMREG EQU $4000

DEF RAMREG_ENABLE EQU $40

; -- ACCLATCH0 ($Ax0x) --------------------------------------------------------
; Latch accelerometer start [wo]
DEF rACCLATCH0 EQU $A000

; Write $55 to ACCLATCH0 to erase the latched data
DEF ACCLATCH0_START EQU $55

; -- ACCLATCH1 ($Ax1x) --------------------------------------------------------
; Latch accelerometer finish [wo]
DEF rACCLATCH1 EQU $A010

; Write $AA to ACCLATCH1 to latch the accelerometer and update ACCEL*
DEF ACCLATCH1_FINISH EQU $AA

; -- ACCELX0 ($Ax2x) ----------------------------------------------------------
; Accelerometer X value low byte [ro]
DEF rACCELX0 EQU $A020

; -- ACCELX1 ($Ax3x) ----------------------------------------------------------
; Accelerometer X value high byte [ro]
DEF rACCELX1 EQU $A030

; -- ACCELY0 ($Ax4x) ----------------------------------------------------------
; Accelerometer Y value low byte [ro]
DEF rACCELY0 EQU $A040

; -- ACCELY1 ($Ax5x) ----------------------------------------------------------
; Accelerometer Y value high byte [ro]
DEF rACCELY1 EQU $A050

; -- EEPROM ($Ax8x) -----------------------------------------------------------
; EEPROM access [r/w]
DEF rEEPROM EQU $A080


; ** HuC1 only ****************************************************************

; -- IRREG ($A000-$BFFF) ------------------------------------------------------
; IR register [r/w]
DEF rIRREG EQU $A000

; whether the IR transmitter sees light
DEF IR_LED_OFF EQU $C0
DEF IR_LED_ON  EQU $C1


;******************************************************************************
; Screen-related constants
;******************************************************************************

DEF TILE_WIDTH  EQU  8 ; width of tile in pixels
DEF TILE_HEIGHT EQU  8 ; height of tile in pixels
DEF TILE_SIZE   EQU 16 ; size of tile in bytes (2 bits/pixel)

DEF SCREEN_WIDTH     EQU  20 ; width of screen in bytes
DEF SCREEN_HEIGHT    EQU  18 ; height of screen in bytes
DEF SCREEN_WIDTH_PX  EQU SCREEN_WIDTH  * TILE_WIDTH ; width of screen in pixels
DEF SCREEN_HEIGHT_PX EQU SCREEN_HEIGHT * TILE_WIDTH ; height of screen in pixels
DEF SCREEN_AREA      EQU SCREEN_WIDTH * SCREEN_HEIGHT ; size of screen in bytes

DEF TILEMAP_WIDTH     EQU  32 ; width of tilemap in bytes
DEF TILEMAP_HEIGHT    EQU  32 ; height of tilemap in bytes
DEF TILEMAP_WIDTH_PX  EQU TILEMAP_WIDTH * TILE_WIDTH ; width of tilemap in pixels
DEF TILEMAP_HEIGHT_PX EQU TILEMAP_HEIGHT * TILE_HEIGHT ; height of tilemap in pixels
DEF TILEMAP_AREA      EQU TILEMAP_WIDTH * TILEMAP_HEIGHT ; size of tilemap in bytes

DEF COLOR_SIZE EQU 2 ; size of color in bytes (little-endian BGR555)
    DEF B_COLOR_RED   EQU  0 ; bits 4-0
    DEF B_COLOR_GREEN EQU  5 ; bits 9-5
    DEF B_COLOR_BLUE  EQU 10 ; bits 14-10
        DEF COLOR_RED        EQU %000_11111  ; for the low byte
        DEF COLOR_GREEN_LOW  EQU %111_00000  ; for the low byte
        DEF COLOR_GREEN_HIGH EQU %0_00000_11 ; for the high byte
        DEF COLOR_BLUE       EQU %0_11111_00 ; for the high byte
DEF PAL_COLORS EQU 4 ; colors per palette
DEF PAL_SIZE   EQU COLOR_SIZE * PAL_COLORS ; size of palette in bytes

; (DMG only) grayscale shade indexes for BGP, OBP0, and OBP1
DEF SHADE_WHITE EQU %00
DEF SHADE_LIGHT EQU %01
DEF SHADE_DARK  EQU %10
DEF SHADE_BLACK EQU %11

; Tilemaps the BG or Window can read from (controlled by LCDC)
DEF TILEMAP0 EQU $9800 ; $9800-$9BFF
DEF TILEMAP1 EQU $9C00 ; $9C00-$9FFF

; (CGB only) BG tile attribute fields
DEF B_BG_PRIO  EQU 7 ; whether the BG tile colors 1-3 are drawn above OBJs
DEF B_BG_YFLIP EQU 6 ; whether the whole BG tile is flipped vertically
DEF B_BG_XFLIP EQU 5 ; whether the whole BG tile is flipped horizontally
DEF B_BG_BANK1 EQU 3 ; which VRAM bank the BG tile is taken from
DEF BG_PALETTE EQU %00000_111 ; which palette the BG tile uses
    DEF BG_PRIO  EQU 1 << B_BG_PRIO
    DEF BG_YFLIP EQU 1 << B_BG_YFLIP
    DEF BG_XFLIP EQU 1 << B_BG_XFLIP
    DEF BG_BANK0 EQU 0 << B_BG_BANK1
    DEF BG_BANK1 EQU 1 << B_BG_BANK1


;******************************************************************************
; OBJ-related constants
;******************************************************************************

; OAM attribute field offsets
rsreset
DEF OAMA_Y      rb ; 0
    DEF OAM_Y_OFS EQU 16 ; subtract 16 from what's written to OAM to get the real Y position
DEF OAMA_X      rb ; 1
    DEF OAM_X_OFS EQU  8 ; subtract 8 from what's written to OAM to get the real X position
DEF OAMA_TILEID rb ; 2
DEF OAMA_FLAGS  rb ; 3
    DEF B_OAM_PRIO  EQU 7 ; whether the OBJ is drawn below BG colors 1-3
    DEF B_OAM_YFLIP EQU 6 ; whether the whole OBJ is flipped vertically
    DEF B_OAM_XFLIP EQU 5 ; whether the whole OBJ is flipped horizontally
    DEF B_OAM_PAL1  EQU 4 ; (DMG only) which of the two palettes the OBJ uses
    DEF B_OAM_BANK1 EQU 3 ; (CGB only) which VRAM bank the OBJ takes its tile(s) from
    DEF OAM_PALETTE EQU %00000_111 ; (CGB only) which palette the OBJ uses
        DEF OAM_PRIO  EQU 1 << B_OAM_PRIO
        DEF OAM_YFLIP EQU 1 << B_OAM_YFLIP
        DEF OAM_XFLIP EQU 1 << B_OAM_XFLIP
        DEF OAM_PAL0  EQU 0 << B_OAM_PAL1
        DEF OAM_PAL1  EQU 1 << B_OAM_PAL1
        DEF OAM_BANK0 EQU 0 << B_OAM_BANK1
        DEF OAM_BANK1 EQU 1 << B_OAM_BANK1
DEF OBJ_SIZE    rb 0 ; size of OBJ in bytes = 4

DEF OAM_COUNT EQU 40 ; how many OBJs there are room for in OAM
DEF OAM_SIZE  EQU OBJ_SIZE * OAM_COUNT


;******************************************************************************
; Audio channel RAM addresses
;******************************************************************************

DEF AUD1RAM EQU $FF10 ; $FF10-$FF14
DEF AUD2RAM EQU $FF15 ; $FF15-$FF19
DEF AUD3RAM EQU $FF1A ; $FF1A-$FF1E
DEF AUD4RAM EQU $FF1F ; $FF1F-$FF23
DEF AUDRAM_SIZE EQU 5 ; size of each audio channel RAM in bytes

DEF _AUD3WAVERAM EQU $FF30 ; $FF30-$FF3F
DEF AUD3WAVE_SIZE EQU 16 ; size of wave pattern RAM in bytes


;******************************************************************************
; Interrupt vector addresses
;******************************************************************************

DEF INT_HANDLER_VBLANK EQU $0040 ; VBlank interrupt handler address
DEF INT_HANDLER_STAT   EQU $0048 ; STAT   interrupt handler address
DEF INT_HANDLER_TIMER  EQU $0050 ; timer  interrupt handler address
DEF INT_HANDLER_SERIAL EQU $0058 ; serial interrupt handler address
DEF INT_HANDLER_JOYPAD EQU $0060 ; joypad interrupt handler address


;******************************************************************************
; Boot-up register values
;******************************************************************************

; Register A = CPU type
DEF BOOTUP_A_DMG EQU $01
DEF BOOTUP_A_CGB EQU $11 ; CGB or AGB
DEF BOOTUP_A_MGB EQU $FF
    DEF BOOTUP_A_SGB  EQU BOOTUP_A_DMG
    DEF BOOTUP_A_SGB2 EQU BOOTUP_A_MGB

; Register B = CPU qualifier (if A is BOOTUP_A_CGB)
DEF B_BOOTUP_B_AGB EQU 0
    DEF BOOTUP_B_CGB EQU 0 << B_BOOTUP_B_AGB
    DEF BOOTUP_B_AGB EQU 1 << B_BOOTUP_B_AGB


;******************************************************************************
; Aliases
;******************************************************************************

; Prefer the standard names to these aliases, which may be official but are
; less directly meaningful or human-readable.

DEF rP1 EQU rJOYP

DEF rNR10 EQU rAUD1SWEEP
DEF rNR11 EQU rAUD1LEN
DEF rNR12 EQU rAUD1ENV
DEF rNR13 EQU rAUD1LOW
DEF rNR14 EQU rAUD1HIGH
DEF rNR21 EQU rAUD2LEN
DEF rNR22 EQU rAUD2ENV
DEF rNR23 EQU rAUD2LOW
DEF rNR24 EQU rAUD2HIGH
DEF rNR30 EQU rAUD3ENA
DEF rNR31 EQU rAUD3LEN
DEF rNR32 EQU rAUD3LEVEL
DEF rNR33 EQU rAUD3LOW
DEF rNR34 EQU rAUD3HIGH
DEF rNR41 EQU rAUD4LEN
DEF rNR42 EQU rAUD4ENV
DEF rNR43 EQU rAUD4POLY
DEF rNR44 EQU rAUD4GO
DEF rNR50 EQU rAUDVOL
DEF rNR51 EQU rAUDTERM
DEF rNR52 EQU rAUDENA

DEF rKEY0 EQU rSYS
DEF rKEY1 EQU rSPD

DEF rHDMA1 EQU rVDMA_SRC_HIGH
DEF rHDMA2 EQU rVDMA_SRC_LOW
DEF rHDMA3 EQU rVDMA_DEST_HIGH
DEF rHDMA4 EQU rVDMA_DEST_LOW
DEF rHDMA5 EQU rVDMA_LEN

DEF rBCPS EQU rBGPI
DEF rBCPD EQU rBGPD

DEF rOCPS EQU rOBPI
DEF rOCPD EQU rOBPD

DEF rSVBK EQU rWBK

endc ; HARDWARE_INC