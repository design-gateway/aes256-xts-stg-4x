----------------------------------------------------------------------------------
----------------------------------------------------------------------------------
-- Filename     AES256XTSSTG4XDemo.vhd
-- Title        Top
--
-- Company      Design Gateway Co., Ltd.
-- Project      AES256XTSSTG
-- PJ No.       
-- Syntax       VHDL
-- Note         
--
-- Version      1.00
-- Author       Pahol S.
-- Date         28/Feb/2024
-- Remark       New Creation
----------------------------------------------------------------------------------
----------------------------------------------------------------------------------
library IEEE;
use IEEE.std_logic_1164.ALL;
use IEEE.STD_LOGIC_ARITH.all;
use IEEE.STD_LOGIC_UNSIGNED.all;

Entity AES256XTSSTG4XDemo Is
    Port 
    (
        ExtRstB : in    std_logic;    -- extenal Reset, Active Low
        Clk     : in    std_logic;
        
        LED     : out   std_logic_vector( 1 downto 0 )
    );
End Entity AES256XTSSTG4XDemo;
Architecture rtl Of AES256XTSSTG4XDemo Is
----------------------------------------------------------------------------------
-- Component declaration
----------------------------------------------------------------------------------
    Component AES256XTSSTG4XENC Is
    Port 
    ( 
        RstB            : in    std_logic;
        Clk             : in    std_logic;
        version         : out   std_logic_vector( 31 downto 0 );
        
        EKeyInValid     : in    std_logic;
        EKeyInBusy      : out   std_logic;
        EKeyInFinish    : out   std_logic;
        EKeyIn          : in    std_logic_vector( 255 downto 0 );
        
        TKeyInValid     : in    std_logic;
        TKeyInBusy      : out   std_logic;
        TKeyInFinish    : out   std_logic;
        TKeyIn          : in    std_logic_vector( 255 downto 0 );
        
        InitStart       : in    std_logic;
        Busy            : out   std_logic;
        Finish          : out   std_logic;
        
        IvIncrement     : in    std_logic;
        IvIn            : in    std_logic_vector( 127 downto 0 );
        DataInReady     : out   std_logic;
        DataInValid     : in    std_logic;
        DataIn          : in    std_logic_vector( 511 downto 0 );
        
        DataOutValid    : out   std_logic;
        DataOut         : out   std_logic_vector( 511 downto 0 )
    );
    End Component AES256XTSSTG4XENC;

    Component AES256XTSSTG4XDEC Is
    Port 
    ( 
        RstB            : in    std_logic;
        Clk             : in    std_logic;
        version         : out   std_logic_vector( 31 downto 0 );
        
        EKeyInValid     : in    std_logic;
        EKeyInBusy      : out   std_logic;
        EKeyInFinish    : out   std_logic;
        EKeyIn          : in    std_logic_vector( 255 downto 0 );
        
        TKeyInValid     : in    std_logic;
        TKeyInBusy      : out   std_logic;
        TKeyInFinish    : out   std_logic;
        TKeyIn          : in    std_logic_vector( 255 downto 0 );
        
        InitStart       : in    std_logic;
        Busy            : out   std_logic;
        Finish          : out   std_logic;
        
        IvIncrement     : in    std_logic;
        IvIn            : in    std_logic_vector( 127 downto 0 );
        DataInReady     : out   std_logic;
        DataInValid     : in    std_logic;
        DataIn          : in    std_logic_vector( 511 downto 0 );
        
        DataOutValid    : out   std_logic;
        DataOut         : out   std_logic_vector( 511 downto 0 )
    );
    End Component AES256XTSSTG4XDEC;
----------------------------------------------------------------------------------
-- Signal declaration
----------------------------------------------------------------------------------
    signal    rExtRstBCnt       : std_logic_vector( 20 downto 0 );
    signal    RstB              : std_logic;

    signal    EKeyInValidEnc    : std_logic;
    signal    EKeyInBusyEnc     : std_logic;
    signal    EKeyInFinishEnc   : std_logic;
    signal    EKeyInEnc         : std_logic_vector( 255 downto 0 );
    signal    TKeyInValidEnc    : std_logic;
    signal    TKeyInBusyEnc     : std_logic;
    signal    TKeyInFinishEnc   : std_logic;
    signal    TKeyInEnc         : std_logic_vector( 255 downto 0 );
    signal    InitStartEnc      : std_logic;
    signal    BusyEnc           : std_logic;
    signal    FinishEnc         : std_logic;
    signal    IvIncrementEnc    : std_logic;
    signal    IvInEnc           : std_logic_vector( 127 downto 0 );
    signal    DataInReadyEnc    : std_logic;
    signal    rDataInValidEnc   : std_logic;
    signal    rDataInValidEnc1  : std_logic;
    signal    DataInEnc         : std_logic_vector( 511 downto 0 );
    signal    DataOutValidEnc   : std_logic;
    signal    DataOutEnc        : std_logic_vector( 511 downto 0 );

    signal    EKeyInValidDec    : std_logic;
    signal    EKeyInBusyDec     : std_logic;
    signal    EKeyInFinishDec   : std_logic;
    signal    EKeyInDec         : std_logic_vector( 255 downto 0 );
    signal    TKeyInValidDec    : std_logic;
    signal    TKeyInBusyDec     : std_logic;
    signal    TKeyInFinishDec   : std_logic;
    signal    TKeyInDec         : std_logic_vector( 255 downto 0 );
    signal    InitStartDec      : std_logic;
    signal    BusyDec           : std_logic;
    signal    FinishDec         : std_logic;
    signal    IvIncrementDec    : std_logic;
    signal    IvInDec           : std_logic_vector( 127 downto 0 );
    signal    DataInReadyDec    : std_logic;
    signal    rDataInValidDec   : std_logic;
    signal    DataInDec         : std_logic_vector( 511 downto 0 );
    signal    DataOutValidDec   : std_logic;
    signal    DataOutDec        : std_logic_vector( 511 downto 0 );

    signal    rKeyInValid       : std_logic;
    signal    rCounter          : std_logic_vector(  31 downto 0 );
    signal    PatternIn         : std_logic_vector( 511 downto 0 );
    signal    rVerifyCnt        : std_logic_vector(  31 downto 0 );
    signal    VerifyOut         : std_logic_vector( 511 downto 0 );
    signal    rWrong            : std_logic;
    
    signal    rTestCnt          : std_logic_vector( 15 downto 0 );
    signal    rInitStartEnc     : std_logic;
    signal    rInitStartDec     : std_logic;
    signal    rInitStartEnc1    : std_logic;
    signal    rInitStartDec1    : std_logic;
    signal    rIpRunning        : std_logic;

Begin
----------------------------------------------------------------------------------
-- Output assignment
----------------------------------------------------------------------------------
    LED    <=  rIpRunning & rWrong;
----------------------------------------------------------------------------------
-- Component mapping 
----------------------------------------------------------------------------------
    c_AES256XTSSTG4XEnc: AES256XTSSTG4XENC 
    Port map 
    ( 
        RstB            =>  RstB              ,
        Clk             =>  Clk               ,
        version         =>  open              ,
        
        EKeyInValid     =>  rKeyInValid       ,
        EKeyInBusy      =>  EKeyInBusyEnc     ,
        EKeyInFinish    =>  EKeyInFinishEnc   ,
        EKeyIn          =>  EKeyInEnc         ,
        
        TKeyInValid     =>  rKeyInValid       ,
        TKeyInBusy      =>  TKeyInBusyEnc     ,
        TKeyInFinish    =>  TKeyInFinishEnc   ,
        TKeyIn          =>  TKeyInEnc         ,
        
        InitStart       =>  rInitStartEnc     ,
        Busy            =>  BusyEnc           ,
        Finish          =>  FinishEnc         ,
        
        IvIncrement     =>  IvIncrementEnc    ,
        IvIn            =>  IvInEnc           ,
        DataInReady     =>  DataInReadyEnc    ,
        DataInValid     =>  rDataInValidEnc   ,
        DataIn          =>  DataInEnc         ,
        
        DataOutValid    =>  DataOutValidEnc   ,
        DataOut         =>  DataOutEnc        
    );

    PatternIn       <=  rCounter & rCounter & rCounter & rCounter & rCounter & rCounter & rCounter & rCounter & rCounter & rCounter & rCounter & rCounter & rCounter & rCounter & rCounter & rCounter;
    VerifyOut       <=  rVerifyCnt& rVerifyCnt& rVerifyCnt& rVerifyCnt& rVerifyCnt& rVerifyCnt& rVerifyCnt& rVerifyCnt& rVerifyCnt& rVerifyCnt& rVerifyCnt& rVerifyCnt& rVerifyCnt& rVerifyCnt& rVerifyCnt& rVerifyCnt;
    -- Encryption Parameter
    EKeyInEnc       <=  x"000102030405060708090a0b0c0d0e0f101112131415161718191a1b1c1d1e1f";
    TKeyInEnc       <=  x"f00102030405060708090a0b0c0d0e0f101112131415161718191a1b1c1d1e1f";
    IvInEnc         <=  x"00112233445566778899aabbccddeeff";
    IvIncrementEnc  <=  '1';
    DataInEnc       <=  PatternIn;
    -- Decryption Parameter
    EKeyInDec       <=  x"000102030405060708090a0b0c0d0e0f101112131415161718191a1b1c1d1e1f";
    TKeyInDec       <=  x"f00102030405060708090a0b0c0d0e0f101112131415161718191a1b1c1d1e1f";
    IvInDec         <=  x"00112233445566778899aabbccddeeff";
    IvIncrementDec  <=  '1';
    DataInDec       <=  DataOutEnc;
    
    c_AES256XTSSTG4XDec: AES256XTSSTG4XDEC 
    Port map 
    ( 
        RstB            =>	RstB              ,
        Clk             =>	Clk               ,
        version         =>	open              ,
        
        EKeyInValid     =>	rKeyInValid       ,
        EKeyInBusy      =>	EKeyInBusyDec     ,
        EKeyInFinish    =>	EKeyInFinishDec   ,
        EKeyIn          =>	EKeyInDec         ,
        
        TKeyInValid     =>	rKeyInValid       ,
        TKeyInBusy      =>	TKeyInBusyDec     ,
        TKeyInFinish    =>	TKeyInFinishDec   ,
        TKeyIn          =>	TKeyInDec         ,
        
        InitStart       =>	rInitStartDec     ,
        Busy            =>	BusyDec           ,
        Finish          =>	FinishDec         ,
        
        IvIncrement     =>	IvIncrementDec    ,
        IvIn            =>	IvInDec           ,
        DataInReady     =>	DataInReadyDec    ,
        DataInValid     =>	rDataInValidDec   ,
        DataIn          =>	DataInDec         ,
        
        DataOutValid    =>	DataOutValidDec   ,
        DataOut         =>	DataOutDec        
    );

----------------------------------------------------------------------------------
-- Logics 
----------------------------------------------------------------------------------
    u_rExtRstBCnt : Process (Clk) Is
    Begin
        if ( rising_edge(Clk) ) then
            if ( ExtRstB='0' ) then
                rExtRstBCnt(20 downto 0)    <= (others=>'0');
            else
                if ( rExtRstBCnt(20)='0' ) then
                    rExtRstBCnt(20 downto 0)    <= rExtRstBCnt(20 downto 0) + 1;
                else
                    rExtRstBCnt(20 downto 0)    <= rExtRstBCnt(20 downto 0);
                end if;
            end if;
        end if;
    End Process u_rExtRstBCnt;
    
    RstB    <=  rExtRstBCnt(20);
    
    p_Enc : process (Clk) is
    begin
        if ( rising_edge(Clk) ) then

            if ( RstB='0' ) then
                rCounter    <=  (others=>'0');
            else
                rCounter    <=  rCounter+1;
            end if;
            
            if ( RstB='0' ) then
                rVerifyCnt  <=  x"00000000";
            else
                if ( rDataInValidEnc1='0' and rDataInValidEnc='1' ) then
                    rVerifyCnt  <=  rCounter;
                elsif ( DataOutValidDec='1' ) then
                    rVerifyCnt  <=  rVerifyCnt+1;
                else
                    rVerifyCnt  <=  rVerifyCnt;
                end if;
            end if;

            if ( RstB='0' ) then
                rTestCnt    <=  (others=>'0');
            else
                if ( rTestCnt=x"0202" ) then
                    rTestCnt    <=  (others=>'0');
                else
                    rTestCnt    <=  rTestCnt+1;
                end if;
            end if;
            
            if ( RstB='0' ) then
                rKeyInValid <=  '0';
            else
                if ( rTestCnt=2 ) then
                    rKeyInValid <=  '1';
                else
                    rKeyInValid <=  '0';
                end if;
            end if;

            rInitStartEnc1  <=  rInitStartEnc;
            if ( RstB='0' ) then
                rInitStartEnc   <=  '0';
            else
                if ( rTestCnt(7 downto 0)=40 ) then
                    rInitStartEnc   <=  '1';
                else
                    rInitStartEnc   <=  '0';
                end if;
            end if;

            rInitStartDec1  <=  rInitStartDec;
            if ( RstB='0' ) then
                rInitStartDec   <=  '0';
            else
                if ( rTestCnt(7 downto 0)=42 ) then
                    rInitStartDec   <=  '1';
                else
                    rInitStartDec   <=  '0';
                end if;
            end if;
            
            rDataInValidEnc1    <=  rDataInValidEnc;
            if ( RstB='0' ) then
                rDataInValidEnc <=  '0';
            else
                if ( rTestCnt(7 downto 0)=60 ) then
                    rDataInValidEnc <=  '1';
                elsif ( rTestCnt(7 downto 0)=124 ) then
                    rDataInValidEnc <=  '0';
                else
                    rDataInValidEnc <=  rDataInValidEnc;
                end if;
            end if;
            
            if ( RstB='0' ) then
                rDataInValidDec <=  '0';
            else
                if ( rTestCnt(7 downto 0)=77 ) then
                    rDataInValidDec <=  '1';
                elsif ( rTestCnt(7 downto 0)=141 ) then
                    rDataInValidDec <=  '0';
                else
                    rDataInValidDec <=  rDataInValidDec;
                end if;
            end if;
            
            -- To detect IP Core still running, after 'InitStart' is actived, 'Busy' must be actived.
            if ( RstB='0' ) then
                rIpRunning  <=  '0';
            else
                if ( rInitStartEnc1='1' ) then
                    if ( BusyEnc='1' ) then
                        rIpRunning  <=  '1';
                    else
                        rIpRunning  <=  '0';
                    end if;
                elsif ( rInitStartDec1='1' ) then
                    if ( BusyDec='1' ) then
                        rIpRunning  <=  '1';
                    else
                        rIpRunning  <=  '0';
                    end if;
                else
                    rIpRunning  <=  rIpRunning;
                end if;
            end if;
            
            if ( RstB='0' ) then
                rWrong  <=  '0';
            else
                if ( DataOutValidDec='1' ) then
                    if ( not(DataOutDec=VerifyOut) ) then
                        rWrong  <=  '1';
                    else
                        rWrong  <=  rWrong;
                    end if;
                else
                    rWrong  <=  rWrong;
                end if;
            end if;
            
        end if;
    end process p_Enc;

End Architecture rtl;
