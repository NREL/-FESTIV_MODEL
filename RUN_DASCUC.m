%Everything here will start from NAME_VAL, converted to GAMS format, per
%unitized, written to gdx, run GAMS, then bring data back to matlab.

CREATE_DAC_GAMS_VARIABLES;

PER_UNITIZE;

if Solving_Initial_Models
wgdx(['TEMP', filesep, 'DASCUCINPUT1'],START_PARAMETER,...
    LOAD_DIST,PTDF,LODF,PTDF_PAR,RESERVEVALUE,BLOCK_COST,BLOCK_CAP,QSC,COST_CURVE,RESERVE_COST,STARTUP_VALUE,BRANCHDATA,...
    OFFLINE_BLOCK,STARTUP_COST_BLOCK,STARTUP_PERIOD,SHUTDOWN_PERIOD,PUMPUP_PERIOD,PUMPDOWN_PERIOD,INJECTION_FACTOR,GENBUS,BRANCHBUS); 
end;

wgdx(['TEMP', filesep, 'DASCUCINPUT2'],LOSS_BIAS,BUS_DELIVERY_FACTORS,GEN_DELIVERY_FACTORS,LOAD,GENVALUE,STORAGEVALUE,UNIT_STATUS_ENFORCED_ON,UNIT_STATUS_ENFORCED_OFF,...
    VG_FORECAST,RESERVELEVEL,END_STORAGE_PENALTY_PLUS_PRICE,END_STORAGE_PENALTY_MINUS_PRICE,PUMPING_ENFORCED_ON,PUMPING_ENFORCED_OFF,INTERVAL_MINUTES,...
    GEN_FORCED_OUT,MAX_OFFLINE_TIME,INITIAL_STARTUP_COST_HELPER,PREVIOUS_UNIT_STARTUP,INTERVALS_STARTED_AGO,PREVIOUS_UNIT_PUMPUP,INTERVALS_PUMPUP_AGO,...
    INITIAL_SHUTDOWN_PERIODS,INTERVALS_SHUTDOWN_AGO,INITIAL_PUMPDOWN_PERIODS,INTERVALS_PUMPDOWN_AGO,NDACINTERVAL,DACINTERVAL_LENGTH,INTERVAL);

system(DASCUC_GAMS_CALL);

[SCUCPRODCOST,SCUCGENSCHEDULE,SCUCLMP,SCUCUNITSTATUS,SCUCUNITSTARTUP,SCUCUNITSHUTDOWN,SCUCGENRESERVESCHEDULE,...
    SCUCRCP,SCUCVGCURTAILMENT,SCUCLOSSLOAD,SCUCINSUFFRESERVE,SCUCPUMPSCHEDULE,SCUCSTORAGELEVEL,SCUCPUMPING] ...
    = getgamsdata('TOTAL_DASCUCOUTPUT','DASCUC','YES',GEN,INTERVAL,BUS,BRANCH,RESERVETYPE,SYSTEMVALUE_VAL,RESERVEVALUE_VAL,GENPARAM,STORAGEVALUE_VAL,BRANCHPARAM);
