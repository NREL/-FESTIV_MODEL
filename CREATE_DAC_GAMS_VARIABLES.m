% Create GAMS variables for DASCUC model solve


NDACINTERVAL.val = HDAC;
NDACINTERVAL.name = 'NUMINTERVAL';
NDACINTERVAL.form = 'full';
NDACINTERVAL.uels = cell(1,0);
NDACINTERVAL.type = 'parameter';

DACINTERVAL_LENGTH.val = IDAC;
DACINTERVAL_LENGTH.name = 'INTERVAL_LENGTH';
DACINTERVAL_LENGTH.form = 'full';
DACINTERVAL_LENGTH.uels = cell(1,0);
DACINTERVAL_LENGTH.type = 'parameter';

DACINTERVAL_UPDATE.val = tDAC;
DACINTERVAL_UPDATE.name = 'INTERVAL_UPDATE';
DACINTERVAL_UPDATE.form = 'full';
DACINTERVAL_UPDATE.uels = cell(1,0);
DACINTERVAL_UPDATE.type = 'parameter';

INTERVAL_VAL = {'1'};
for t=2:HDAC
    INTERVAL_VAL = [INTERVAL_VAL; num2str(t)];
end
INTERVAL.uels = INTERVAL_VAL';
INTERVAL.val = ones(NDACINTERVAL.val,1);
INTERVAL.name = 'INTERVAL';
INTERVAL.form = 'full';
INTERVAL.type = 'set';

INTERVAL_MINUTES.name = 'INTERVAL_MINUTES';
INTERVAL_MINUTES.val = INTERVAL_MINUTES_VAL;
INTERVAL_MINUTES.uels = {INTERVAL_VAL'};
INTERVAL_MINUTES.form = 'full';
INTERVAL_MINUTES.type = 'parameter';

VG_FORECAST.val = VG_FORECAST_VAL;
VG_FORECAST.name = 'VG_FORECAST';
VG_FORECAST.uels = {INTERVAL.uels GEN.uels};
VG_FORECAST.form = 'full';
VG_FORECAST.type = 'parameter';

GEN_FORCED_OUT.val = GEN_FORCED_OUT_VAL;
GEN_FORCED_OUT.name = 'GEN_FORCED_OUT';
GEN_FORCED_OUT.form = 'full';
GEN_FORCED_OUT.type = 'parameter';
GEN_FORCED_OUT.uels = GEN.uels;

RESERVELEVEL.val = RESERVELEVEL_VAL;
RESERVELEVEL.uels = {INTERVAL.uels DAC_RESERVE_FIELD(1,3:end)};
RESERVELEVEL.name = 'RESERVELEVEL';
RESERVELEVEL.form = 'full';
RESERVELEVEL.type = 'parameter';

LOAD.val = LOAD_VAL;
LOAD.uels = INTERVAL.uels;
LOAD.name = 'LOAD';
LOAD.form = 'full';
LOAD.type = 'parameter';

clear BUS_DELIVERY_FACTORS GEN_DELIVERY_FACTORS;

GEN_DELIVERY_FACTORS.val=DAC_GEN_DELIVERY_FACTORS_VAL;
GEN_DELIVERY_FACTORS.name='GEN_DELIVERY_FACTORS';
GEN_DELIVERY_FACTORS.form='full';
GEN_DELIVERY_FACTORS.type='parameter';
GEN_DELIVERY_FACTORS.uels={GEN.uels INTERVAL.uels};

BUS_DELIVERY_FACTORS.val=DAC_BUS_DELIVERY_FACTORS_VAL;
BUS_DELIVERY_FACTORS.name='BUS_DELIVERY_FACTORS';
BUS_DELIVERY_FACTORS.form='full';
BUS_DELIVERY_FACTORS.type='parameter';
BUS_DELIVERY_FACTORS.uels={BUS.uels INTERVAL.uels};

if ninterchange > 0
    UNIT_STATUS_ENFORCED_ON_VAL(interchanges,:)=1;
    UNIT_STATUS_ENFORCED_OFF_VAL(interchanges,:)=1;
end
UNIT_STATUS_ENFORCED_ON.name = 'UNIT_STATUS_ENFORCED_ON';
UNIT_STATUS_ENFORCED_ON.val = UNIT_STATUS_ENFORCED_ON_VAL(:,1:HDAC);
UNIT_STATUS_ENFORCED_ON.uels = {GEN.uels INTERVAL.uels};
UNIT_STATUS_ENFORCED_ON.form = 'full';
UNIT_STATUS_ENFORCED_ON.type = 'parameter';

UNIT_STATUS_ENFORCED_OFF.name = 'UNIT_STATUS_ENFORCED_OFF';
UNIT_STATUS_ENFORCED_OFF.val = UNIT_STATUS_ENFORCED_OFF_VAL(:,1:HDAC);
UNIT_STATUS_ENFORCED_OFF.uels = {GEN.uels INTERVAL.uels};
UNIT_STATUS_ENFORCED_OFF.form = 'full';
UNIT_STATUS_ENFORCED_OFF.type = 'parameter';

PUMPING_ENFORCED_ON.name = 'PUMPING_ENFORCED_ON';
PUMPING_ENFORCED_ON.val = PUMPING_ENFORCED_ON_VAL(:,1:HDAC);
PUMPING_ENFORCED_ON.uels = {GEN.uels INTERVAL.uels};
PUMPING_ENFORCED_ON.form = 'full';
PUMPING_ENFORCED_ON.type = 'parameter';

PUMPING_ENFORCED_OFF.name = 'PUMPING_ENFORCED_OFF';
PUMPING_ENFORCED_OFF.val = PUMPING_ENFORCED_OFF_VAL(:,1:HDAC);
PUMPING_ENFORCED_OFF.uels = {GEN.uels INTERVAL.uels};
PUMPING_ENFORCED_OFF.form = 'full';
PUMPING_ENFORCED_OFF.type = 'parameter';

LOSS_BIAS.val = LOSS_BIAS_VAL;
LOSS_BIAS.name = 'LOSS_BIAS';
LOSS_BIAS.form = 'full';
LOSS_BIAS.uels = cell(1,0);
LOSS_BIAS.type = 'parameter';

QSC.val = QSC_VAL;
QSC.name='QSC';
QSC.uels={GEN_VAL' RESERVETYPE_VAL'};
QSC.form='FULL';
QSC.type='parameter';

OFFLINE_BLOCK.name='OFFLINE_BLOCK';
OFFLINE_BLOCK.uels={STARTUP_VALUE_STRING1' STARTUP_VALUE_STRING2};
OFFLINE_BLOCK.form='FULL';
OFFLINE_BLOCK.type='parameter';
if ~isempty(STARTUP_VALUE_VAL)
    OFFLINE_BLOCK.val=STARTUP_VALUE_VAL(:,[1:2:size(STARTUP_VALUE_VAL,2)]);
    STARTUP_COST_BLOCK.val=STARTUP_VALUE_VAL(:,[2:2:size(STARTUP_VALUE_VAL,2)]);
else
    OFFLINE_BLOCK.val=[];
    STARTUP_COST_BLOCK.val=[];
end

STARTUP_COST_BLOCK.name='STARTUP_COST_BLOCK';
STARTUP_COST_BLOCK.uels={STARTUP_VALUE_STRING1' STARTUP_VALUE_STRING2};
STARTUP_COST_BLOCK.form='FULL';
STARTUP_COST_BLOCK.type='parameter';

MAX_OFFLINE_TIME.name='MAX_OFFLINE_TIME';
MAX_OFFLINE_TIME.uels={GEN_VAL'};
MAX_OFFLINE_TIME.form='FULL';
MAX_OFFLINE_TIME.type='parameter';
MAX_OFFLINE_TIME.val=MAX_OFFLINE_TIME_VAL;

INITIAL_STARTUP_COST_HELPER.val=INITIAL_STARTUP_COST_HELPER_VAL;
INITIAL_STARTUP_COST_HELPER.name='INITIAL_STARTUP_COST_HELPER';
INITIAL_STARTUP_COST_HELPER.uels={GEN_VAL'};
INITIAL_STARTUP_COST_HELPER.form='FULL';
INITIAL_STARTUP_COST_HELPER.type='PARAMETER';

PREVIOUS_UNIT_STARTUP.name='PREVIOUS_UNIT_STARTUP';
PREVIOUS_UNIT_STARTUP.uels={GEN_VAL'};
PREVIOUS_UNIT_STARTUP.form='full';
PREVIOUS_UNIT_STARTUP.type='parameter';
INTERVALS_STARTED_AGO.name='INTERVALS_STARTED_AGO';
INTERVALS_STARTED_AGO.uels={GEN_VAL'};
INTERVALS_STARTED_AGO.form='full';
INTERVALS_STARTED_AGO.type='parameter';
PREVIOUS_UNIT_STARTUP.val=PREVIOUS_UNIT_STARTUP_VAL;
INTERVALS_STARTED_AGO.val=INTERVALS_STARTED_AGO_VAL;
PREVIOUS_UNIT_PUMPUP.name='PREVIOUS_UNIT_PUMPUP';
PREVIOUS_UNIT_PUMPUP.uels={STORAGE_UNITS'};
PREVIOUS_UNIT_PUMPUP.form='full';
PREVIOUS_UNIT_PUMPUP.type='parameter';
INTERVALS_PUMPUP_AGO.name='INTERVALS_PUMPUP_AGO';
INTERVALS_PUMPUP_AGO.uels={STORAGE_UNITS'};
INTERVALS_PUMPUP_AGO.form='full';
INTERVALS_PUMPUP_AGO.type='parameter';
PREVIOUS_UNIT_PUMPUP.val=PREVIOUS_UNIT_PUMPUP_VAL;
INTERVALS_PUMPUP_AGO.val=INTERVALS_PUMPUP_AGO_VAL;

STARTUP_PERIOD.val=STARTUP_PERIOD_VAL;
SHUTDOWN_PERIOD.val=SHUTDOWN_PERIOD_VAL;
PUMPUP_PERIOD.val=PUMPUP_PERIOD_VAL;
PUMPDOWN_PERIOD.val=PUMPDOWN_PERIOD_VAL;
STARTUP_PERIOD.name='STARTUP_PERIOD';
SHUTDOWN_PERIOD.name='SHUTDOWN_PERIOD';
PUMPUP_PERIOD.name='PUMPUP_PERIOD';
PUMPDOWN_PERIOD.name='PUMPDOWN_PERIOD';
STARTUP_PERIOD.uels={GEN_VAL'};
SHUTDOWN_PERIOD.uels={GEN_VAL'};
PUMPUP_PERIOD.uels={STORAGE_UNITS'};
PUMPDOWN_PERIOD.uels={STORAGE_UNITS'};
STARTUP_PERIOD.type='parameter';
SHUTDOWN_PERIOD.type='parameter';
PUMPUP_PERIOD.type='parameter';
PUMPDOWN_PERIOD.type='parameter';
STARTUP_PERIOD.form='full';
SHUTDOWN_PERIOD.form='full';
PUMPUP_PERIOD.form='full';
PUMPDOWN_PERIOD.form='full';

INITIAL_SHUTDOWN_PERIODS.name='INITIAL_SHUTDOWN_PERIODS';
INITIAL_SHUTDOWN_PERIODS.uels={GEN_VAL'};
INITIAL_SHUTDOWN_PERIODS.form='full';
INITIAL_SHUTDOWN_PERIODS.type='parameter';
INTERVALS_SHUTDOWN_AGO.name='INTERVALS_SHUTDOWN_AGO';
INTERVALS_SHUTDOWN_AGO.uels={GEN_VAL'};
INTERVALS_SHUTDOWN_AGO.form='full';
INTERVALS_SHUTDOWN_AGO.type='parameter';
INITIAL_SHUTDOWN_PERIODS.val=INITIAL_SHUTDOWN_PERIODS_VAL;
INTERVALS_SHUTDOWN_AGO.val=INTERVALS_SHUTDOWN_AGO_VAL;
INITIAL_PUMPDOWN_PERIODS.name='INITIAL_PUMPDOWN_PERIODS';
INITIAL_PUMPDOWN_PERIODS.uels={STORAGE_UNITS'};
INITIAL_PUMPDOWN_PERIODS.form='full';
INITIAL_PUMPDOWN_PERIODS.type='parameter';
INTERVALS_PUMPDOWN_AGO.name='INTERVALS_PUMPDOWN_AGO';
INTERVALS_PUMPDOWN_AGO.uels={STORAGE_UNITS'};
INTERVALS_PUMPDOWN_AGO.form='full';
INTERVALS_PUMPDOWN_AGO.type='parameter';
INITIAL_PUMPDOWN_PERIODS.val=INITIAL_PUMPDOWN_PERIODS_VAL;
INTERVALS_PUMPDOWN_AGO.val=INTERVALS_PUMPDOWN_AGO_VAL;

END_STORAGE_PENALTY_PLUS_PRICE.name='END_STORAGE_PENALTY_PLUS_PRICE';
END_STORAGE_PENALTY_PLUS_PRICE.form='full';
END_STORAGE_PENALTY_PLUS_PRICE.type='parameter';
END_STORAGE_PENALTY_PLUS_PRICE.uels={STORAGE_UNITS'};
END_STORAGE_PENALTY_PLUS_PRICE.val=zeros(nESR,1);
END_STORAGE_PENALTY_MINUS_PRICE.name='END_STORAGE_PENALTY_MINUS_PRICE';
END_STORAGE_PENALTY_MINUS_PRICE.form='full';
END_STORAGE_PENALTY_MINUS_PRICE.type='parameter';
END_STORAGE_PENALTY_MINUS_PRICE.uels={STORAGE_UNITS'};
END_STORAGE_PENALTY_MINUS_PRICE.val=zeros(nESR,1);
if nESR>0
    temp_idx=STORAGEVALUE_VAL(:,enforce_final_storage) > 1-eps;
    END_STORAGE_PENALTY_PLUS_PRICE.val(temp_idx,1)=SYSTEMVALUE_VAL(voll,1);
END_STORAGE_PENALTY_MINUS_PRICE.val(temp_idx,1)=SYSTEMVALUE_VAL(voll,1);
end;

GENVALUE.val=GENVALUE_VAL;
STORAGEVALUE.val=STORAGEVALUE_VAL;
BRANCHDATA.val=BRANCHDATA_VAL;
RESERVEVALUE.val=RESERVEVALUE_VAL;
SYSTEMVALUE.val=SYSTEMVALUE_VAL;


