----------------------------------------------------------------------------------
----------------------------------------------------------------------------------
-- Filename     AES256XTSSTG4XTop.vhd
-- Title        Top
--
-- Company      Design Gateway Co., Ltd.
-- Project      AES256XTSSTG
-- PJ No.       
-- Syntax       VHDL
-- Note         
--
-- Version      1.00
-- Author       Taksaporn Im.
-- Date         05/Mar/2024
-- Remark       New Creation
----------------------------------------------------------------------------------
----------------------------------------------------------------------------------
library IEEE;
use IEEE.std_logic_1164.ALL;
use IEEE.STD_LOGIC_ARITH.all;
use IEEE.STD_LOGIC_UNSIGNED.all;

Entity AES256XTSSTG4XTop Is
    Port 
    (
        ExtRstIn    : in    std_logic;                        -- extenal Reset, Active High        
        LED         : out   std_logic_vector( 2 downto 0 )
    );
End Entity AES256XTSSTG4XTop;
Architecture rtl Of AES256XTSSTG4XTop Is
----------------------------------------------------------------------------------
-- Component declaration
----------------------------------------------------------------------------------
    
    component system is
    port (
        UserClk : out STD_LOGIC;
        sysRstB : out STD_LOGIC
    );
    end component system;
    
    Component AES256XTSSTG4XDemo Is
    Port 
    (
        ExtRstB    : in    std_logic;    -- extenal Reset, Active Low
        Clk        : in    std_logic;
        
        LED        : out   std_logic_vector( 1 downto 0 )
    );
    End Component AES256XTSSTG4XDemo;

----------------------------------------------------------------------------------
-- Signal declaration
----------------------------------------------------------------------------------
    signal    ExtRstB: std_logic;
    signal     UserClk    : std_logic;
    signal     sysRstB    : std_logic;
    
    signal     rCounter : std_logic_vector( 31 downto 0 ) := x"00000000";

Begin
----------------------------------------------------------------------------------
-- Output assignment
----------------------------------------------------------------------------------
    LED(2)  <=  rCounter(27);

----------------------------------------------------------------------------------
-- Component mapping 
----------------------------------------------------------------------------------
    
    u_system: system
    port map (
        UserClk => UserClk,
        sysRstB => sysRstB
    );
    
    ExtRstB <= not(ExtRstIn);
    
    u_rCounter : Process (UserClk) Is
    Begin
        if ( rising_edge(UserClk) ) then
            if ( ExtRstB='0' or sysRstB='0' ) then
                rCounter    <=  (others=>'0');
            else
                rCounter    <=  rCounter + 1;
            end if;
        end if;
    End Process u_rCounter;
    
    c_AES256XTSSTG4XDemo : AES256XTSSTG4XDemo
    Port map
    ( 
        ExtRstB =>  ExtRstB    ,

        Clk     =>  UserClk    ,
        LED     =>  LED(1 downto 0)
    );
    
End Architecture rtl;
