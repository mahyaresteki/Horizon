import sys
from pony import orm
from datetime import datetime
import configparser
config = configparser.ConfigParser()
config.sections()
config.read('config/conf.ini')

db = orm.Database()

class Countries(db.Entity):
        _table_ = ('public', 'Countries')
        CountryID = orm.PrimaryKey(int, auto=True)
        CountryIsoCode = orm.Required(str, unique=True)
        CountryName = orm.Required(str)
        CountryNicename= orm.Required(str)
        CountryIso3Code = orm.Optional(str, nullable=True)
        CountryNumCode = orm.Optional(int, nullable=True)
        CountryPhoneCode = orm.Required(int)
        LatestUpdateDate = orm.Required(datetime, default=datetime.utcnow)
        StateCountry = orm.Set("States", reverse="CountryID")



class States(db.Entity):
        _table_ = ('public', 'States')
        StateID = orm.PrimaryKey(int, auto=True)
        CountryID = orm.Required("Countries", reverse="StateCountry")
        StateName = orm.Required(str)
        Latitude= orm.Optional(str, nullable=True)
        Longitude = orm.Optional(str, nullable=True)
        LatestUpdateDate = orm.Required(datetime, default=datetime.utcnow)
        CityState = orm.Set("Cities", reverse="StateID")



class Cities(db.Entity):
        _table_ = ('public', 'Cities')
        CityID = orm.PrimaryKey(int, auto=True)
        StateID = orm.Required("States", reverse="CityState")
        CityName = orm.Required(str)
        Latitude= orm.Optional(str, nullable=True)
        Longitude = orm.Optional(str, nullable=True)
        LatestUpdateDate = orm.Required(datetime, default=datetime.utcnow)
        BranchCity = orm.Set("Branches", reverse="CityID")



class Currencies(db.Entity):
        _table_ = ('public', 'Currencies')
        CurrencyID = orm.PrimaryKey(int, auto=True)
        CurrencyName = orm.Required(str)
        CurrencyCode = orm.Required(str)
        CurrencySymbol = orm.Required(str)
        IsActive = orm.Required(bool)
        LatestUpdateDate = orm.Required(datetime, default=datetime.utcnow)



class Banks(db.Entity):
        _table_ = ('public', 'Banks')
        BankID = orm.PrimaryKey(int, auto=True)
        BankCode = orm.Required(str, unique=True)
        BankName = orm.Required(str)
        IsOwner = orm.Required(bool)
        LatestUpdateDate = orm.Required(datetime, default=datetime.utcnow)
        BankCardPrefix = orm.Set("CardPrefixCodes", reverse="BankID")
        BankBranch = orm.Set("Branches", reverse="BankID")



class Branches(db.Entity):
        _table_ = ('public', 'Branches')
        BranchID = orm.PrimaryKey(int, auto=True)
        BranchCode = orm.Required(int)
        CenteralBankID = orm.Required(int, unique=True)
        CityID = orm.Required("Cities", reverse="BranchCity")
        BankID = orm.Required("Banks", reverse="BankBranch")
        Description = orm.Optional(str, nullable=True)
        LatestUpdateDate = orm.Required(datetime, default=datetime.utcnow)
        TerminalBranch = orm.Set("Terminals", reverse="BranchID") 
        AuthorizationRequestBranch = orm.Set("AuthorizationRequests", reverse="BranchID")
        FinantionalRequestBranch = orm.Set("FinantionalRequests", reverse="BranchID")
        ReversalRequestBranch = orm.Set("ReversalRequests", reverse="BranchID")
        SettlementRequestBranch = orm.Set("SettlementRequests", reverse="BranchID")
        AdministrativeRequestBranch = orm.Set("AdministrativeRequests", reverse="BranchID")
        NetworkManagementRequestBranch = orm.Set("NetworkManagementRequests", reverse="BranchID")
        KeyExchangeRequestBranch = orm.Set("KeyExchangeRequests", reverse="BranchID")
        



class CardPrefixCodes(db.Entity):
        _table_ = ('public', 'CardPrefixCodes')
        CardID = orm.PrimaryKey(int, auto=True)
        CardPrefixCode = orm.Required(str, unique=True)
        BankID = orm.Required("Banks", reverse="BankCardPrefix")
        LatestUpdateDate = orm.Required(datetime, default=datetime.utcnow)



class CardTypes(db.Entity):
        _table_ = ('public', 'CardTypes')
        CardTypeID = orm.PrimaryKey(int, auto=True)
        CardTypeTitle = orm.Required(str)
        LatestUpdateDate = orm.Required(datetime, default=datetime.utcnow)



class TransTypes(db.Entity):
        _table_ = ('public', 'TarnsTypes')
        TransTypeID = orm.PrimaryKey(int, auto=True)
        TransTypeCode = orm.Required(str, unique=True)
        TransTypeTitle = orm.Required(str)
        DbTableName = orm.Required(str)
        LatestUpdateDate = orm.Required(datetime, default=datetime.utcnow)
        TransServiceTransType = orm.Set("TransServices", reverse="TransTypeID")
        RequestTransType = orm.Set("TransRequestResponseMapping", reverse="RequestID")
        ResponseTransType = orm.Set("TransRequestResponseMapping", reverse="ResponseID")



class TransRequestResponseMapping(db.Entity):
        _table_ = ('public', 'TransRequestResponseMapping')
        TransRequestResponsID = orm.PrimaryKey(int, auto=True)
        RequestID = orm.Required("TransTypes", reverse="RequestTransType")
        ResponseID = orm.Required("TransTypes", reverse="ResponseTransType")
        LatestUpdateDate = orm.Required(datetime, default=datetime.utcnow)



class IsoServices(db.Entity):
        _table_ = ('public', 'IsoServices')
        IsoServiceID = orm.PrimaryKey(int, auto=True)
        ProcessCode = orm.Required(str)
        ServiceTitle = orm.Required(str, unique=True)
        LatestUpdateDate = orm.Required(datetime, default=datetime.utcnow)
        TransServiceIsoService = orm.Set("TransServices", reverse="IsoServiceID")



class TransServices(db.Entity):
        _table_ = ('public', 'TransServices')
        TransServiceID = orm.PrimaryKey(int, auto=True)
        IsoServiceID = orm.Required("IsoServices", reverse="TransServiceIsoService")
        TransTypeID = orm.Required("TransTypes", reverse="TransServiceTransType")
        BitValue = orm.Required(str)
        LatestUpdateDate = orm.Required(datetime, default=datetime.utcnow)
        IsoRoleAccessesTransService = orm.Set("IsoRoleAccesses", reverse="TransServiceID")
        AuthorizationRequestService = orm.Set("AuthorizationRequests", reverse="TransServiceID")
        AuthorizationResponseService = orm.Set("AuthorizationResponses", reverse="TransServiceID")
        FinantionalRequestService = orm.Set("FinantionalRequests", reverse="TransServiceID")
        FinantionalResponseService = orm.Set("FinantionalResponses", reverse="TransServiceID")
        ReversalRequestService = orm.Set("ReversalRequests", reverse="TransServiceID")
        ReversalResponseService = orm.Set("ReversalResponses", reverse="TransServiceID")
        SettlementRequestService = orm.Set("SettlementRequests", reverse="TransServiceID")
        SettlementResponseService = orm.Set("SettlementResponses", reverse="TransServiceID")
        AdministrativeRequestService = orm.Set("AdministrativeRequests", reverse="TransServiceID")
        AdministrativeResponseService = orm.Set("AdministrativeResponses", reverse="TransServiceID")
        NetworkManagementRequestService = orm.Set("NetworkManagementRequests", reverse="TransServiceID")
        NetworkManagementResponseService = orm.Set("NetworkManagementResponses", reverse="TransServiceID")
        KeyExchangeRequestService = orm.Set("KeyExchangeRequests", reverse="TransServiceID")
        KeyExchangeResponseService = orm.Set("KeyExchangeResponses", reverse="TransServiceID")



class NonIsoServices(db.Entity):
        _table_ = ('public', 'NonIsoServices')
        NonIsoServiceID = orm.PrimaryKey(int, auto=True)
        ServiceTitle = orm.Required(str, unique=True)
        LatestUpdateDate = orm.Required(datetime, default=datetime.utcnow)
        NonIsoRoleAccessService = orm.Set("NonIsoRoleAccesses", reverse="NonIsoServiceID")



class AdministrativeServices(db.Entity):
        _table_ = ('public', 'AdministrativeServices')
        AdministrativeServiceID = orm.PrimaryKey(int, auto=True)
        ServiceTitle = orm.Required(str, unique=True)
        LatestUpdateDate = orm.Required(datetime, default=datetime.utcnow)
        AdministrativeRoleAccessService = orm.Set("AdministrativeRoleAccesses", reverse="AdministrativeServiceID")



class Roles(db.Entity):
        _table_ = ('public', 'Roles')
        RoleID = orm.PrimaryKey(int, auto=True)
        RoleTitle = orm.Required(str)
        Description = orm.Optional(str, nullable=True)
        LatestUpdateDate = orm.Required(datetime, default=datetime.utcnow)
        UserRole = orm.Set("Users", reverse="RoleID")
        IsoRoleAccessesRole = orm.Set("IsoRoleAccesses", reverse="RoleID")
        NonIsoRoleAccessesRole = orm.Set("NonIsoRoleAccesses", reverse="RoleID")
        AdministrativeRoleAccessesRole = orm.Set("AdministrativeRoleAccesses", reverse="RoleID")



class IsoRoleAccesses(db.Entity):
        _table_ = ('public', 'IsoRoleAccesses')
        IsoRoleAccessID = orm.PrimaryKey(int, auto=True)
        RoleID = orm.Required("Roles", reverse="IsoRoleAccessesRole")
        TransServiceID = orm.Required("TransServices", reverse="IsoRoleAccessesTransService")
        LatestUpdateDate = orm.Required(datetime, default=datetime.utcnow)



class NonIsoRoleAccesses(db.Entity):
        _table_ = ('public', 'NonIsoRoleAccesses')
        NonIsoRoleAccessID = orm.PrimaryKey(int, auto=True)
        RoleID = orm.Required("Roles", reverse="NonIsoRoleAccessesRole")
        NonIsoServiceID = orm.Required("NonIsoServices", reverse="NonIsoRoleAccessService")
        LatestUpdateDate = orm.Required(datetime, default=datetime.utcnow)



class AdministrativeRoleAccesses(db.Entity):
        _table_ = ('public', 'AdministrativeRoleAccesses')
        AdministrativeRoleAccessID = orm.PrimaryKey(int, auto=True)
        RoleID = orm.Required("Roles", reverse="AdministrativeRoleAccessesRole")
        AdministrativeServiceID = orm.Required("AdministrativeServices", reverse="AdministrativeRoleAccessService")
        LatestUpdateDate = orm.Required(datetime, default=datetime.utcnow)



class Users(db.Entity):
        _table_ = ('public', 'Users')
        UserID = orm.PrimaryKey(int, auto=True)
        Username = orm.Required(str, unique=True)
        Password = orm.Required(str)
        FirstName = orm.Required(str)
        LastName = orm.Required(str)
        PersonelCode = orm.Required(str, unique=True)
        RoleID = orm.Required("Roles", reverse="UserRole")
        IsActive = orm.Required(bool)
        LatestUpdateDate = orm.Required(datetime, default=datetime.utcnow)
        UserToken = orm.Set("Tokens", reverse="UserID")



class Tokens(db.Entity):
        _table_ = ('public', 'Tokens')
        TokenID = orm.PrimaryKey(int, auto=True)
        Token = orm.Required(str, unique=True)
        ClientIP = orm.Required(str)
        UserID = orm.Required("Users", reverse="UserToken")
        GenerationDate = orm.Required(datetime)
        AuthorizationRequestToken = orm.Set("AuthorizationRequests", reverse="TokenID")
        FinantionalRequestToken = orm.Set("FinantionalRequests", reverse="TokenID")
        ReversalRequestToken = orm.Set("ReversalRequests", reverse="TokenID")
        SettlementRequestToken = orm.Set("SettlementRequests", reverse="TokenID")
        AdministrativeRequestToken = orm.Set("AdministrativeRequests", reverse="TokenID")
        NetworkManagementRequestToken = orm.Set("NetworkManagementRequests", reverse="TokenID")
        KeyExchangeRequestToken = orm.Set("KeyExchangeRequests", reverse="TokenID")



class ChannelTypes(db.Entity):
        _table_ = ('public', 'ChannelTypes')
        ChannelTypeID = orm.PrimaryKey(int, auto=True)
        ChannelTypeTitle = orm.Required(str, unique=True)
        Description = orm.Optional(str, nullable=True)
        IsTokenRequired = orm.Required(bool)
        HasNoteSituation = orm.Required(bool)
        HasWithdrawalService = orm.Required(bool)
        HasDepositService = orm.Required(bool)
        LatestUpdateDate = orm.Required(datetime, default=datetime.utcnow)
        TerminalChannelType = orm.Set("Terminals", reverse="ChannelTypeID")



class Terminals(db.Entity):
        _table_ = ('public', 'Terminals')
        TerminalID = orm.PrimaryKey(int, auto=True)
        TerminalCode = orm.Required(str, unique=True)
        BranchID = orm.Required("Branches", reverse="TerminalBranch")
        ChannelTypeID = orm.Required("ChannelTypes", reverse="TerminalChannelType")
        IPAddress = orm.Required(str, unique=True)
        MacKey = orm.Required(str, unique=True)
        PinKey = orm.Required(str, unique=True)
        MasterKey = orm.Required(str, unique=True)
        TopUpKey = orm.Required(str, unique=True)
        LatestUpdateDate = orm.Required(datetime, default=datetime.utcnow)
        AuthorizationRequestTermial = orm.Set("AuthorizationRequests", reverse="TerminalID")
        FinantionalRequestTermial = orm.Set("FinantionalRequests", reverse="TerminalCode")
        ReversalRequestTermial = orm.Set("ReversalRequests", reverse="TerminalCode")
        SettlementRequestTermial = orm.Set("SettlementRequests", reverse="TerminalCode")
        AdministrativeRequestTermial = orm.Set("AdministrativeRequests", reverse="TerminalCode")
        NetworkManagementRequestTermial = orm.Set("NetworkManagementRequests", reverse="TerminalCode")
        KeyExchangeRequestTermial = orm.Set("KeyExchangeRequests", reverse="TerminalCode")



# 0100 Messages
class AuthorizationRequests(db.Entity):
        _table_ = ('public', 'AuthorizationRequests')
        AuthorizationRequestID = orm.PrimaryKey(int, auto=True)
        MessageType = orm.Required(int) # ISO-2
        PAN = orm.Optional(str) # P-2
        TransServiceID = orm.Required("TransServices", reverse="AuthorizationRequestService") # P-3
        Amount = orm.Required(int) # P-4
        TransmissionDateTime = orm.Required(str) # P-7
        STAN = orm.Required(str) # P-11
        LocalTransactionTime = orm.Required(str) # P-12
        LocalTransactionDate = orm.Required(str) # P-13
        ExpirationDate = orm.Required(str) # P-14
        PointOfServiceEntryMode = orm.Required(str) # P-22
        FunctionCode = orm.Required(str) # P-24
        PointOfServiceConditionCode = orm.Required(str) # P-25
        AcquiringInstitutionIdentificationCode = orm.Required(int) # P-32
        Track2 = orm.Optional(str) # P-35
        RRN = orm.Required(str) # P-37
        CardAcceptor = orm.Required(str) # P-41
        CardAcceptorCode = orm.Required(str) # P-42
        AddtionalData = orm.Optional(str) # P-48
        TransactionCurrencyCode = orm.Optional(int) # P-49
        PinBlock = orm.Optional(str) # P-52
        MAC = orm.Required(str) # P-64
        LatestUpdateDate = orm.Required(datetime, default=datetime.utcnow)
        TerminalID = orm.Required("Terminals", reverse="AuthorizationRequestTermial")
        TerminalIpAddress = orm.Required(str)
        BranchID = orm.Required("Branches", reverse="AuthorizationRequestBranch") # S-100
        TokenID = orm.Required("Tokens", reverse="AuthorizationRequestToken")
        AuthorizationReq = orm.Set("AuthorizationResponses", reverse="AuthorizationRequestID")



# 0110 Messages
class AuthorizationResponses(db.Entity):
        _table_ = ('public', 'AuthorizationResponses')
        AuthorizationResponseID = orm.PrimaryKey(int, auto=True)
        AuthorizationRequestID = orm.Required("AuthorizationRequests", reverse="AuthorizationReq")
        MessageType = orm.Required(int) # ISO-2
        SecondBitmap = orm.Required(bytes) # P-1
        PAN = orm.Optional(str) # P-2
        TransServiceID = orm.Required("TransServices", reverse="AuthorizationResponseService") # P-3
        Amount = orm.Required(int) # P-4
        CurrencyAmount = orm.Optional(int) # P-6
        TransmissionDateTime = orm.Required(str) # P-7
        STAN = orm.Required(str) # P-11
        LocalTransactionTime = orm.Required(str) # P-12
        LocalTransactionDate = orm.Required(str) # P-13
        CaptureDate = orm.Required(datetime) # P-17
        AcquiringInstitutionIdentificationCode = orm.Required(int) # P-32
        ForwardingInstitutionIdentificationCode = orm.Optional(int) # P-33
        RRN = orm.Required(str) # P-37
        ResponseCode = orm.Required(str) # P-39
        CardAcceptor = orm.Required(str) # P-41
        CardAcceptorCode = orm.Required(str) # P-42
        CardAcceptorName = orm.Required(str) # P-43
        AdditionalResponseData = orm.Required(str) # P-44
        AddtionalData = orm.Optional(str) # P-48
        TransactionCurrencyCode = orm.Optional(int) # P-49
        BillingCurrencyCode = orm.Optional(int) # P-51
        Payee = orm.Optional(int) # P-98
        AccountIdentification1 = orm.Optional(str) # S-102
        AccountIdentification2 = orm.Optional(str) # S-103
        PrivateAdditionalData = orm.Optional(str) # S-121
        MAC = orm.Required(int) # S-128
        LatestUpdateDate = orm.Required(datetime, default=datetime.utcnow)



# 0200 and 220 Messages
class FinantionalRequests(db.Entity):
        _table_ = ('public', 'FinantionalRequests')
        FinantionalRequestID = orm.PrimaryKey(int, auto=True)
        MessageType = orm.Required(int) # ISO-2
        SecondBitmap = orm.Required(bytes) # P-1
        PAN = orm.Required(str) # P-2
        TransServiceID = orm.Required("TransServices", reverse="FinantionalRequestService") # P-3
        Amount = orm.Required(int) # P-4
        TransmissionDateTime = orm.Required(str) # P-7
        STAN = orm.Required(str) # P-11
        LocalTransactionTime = orm.Required(str) # P-12
        LocalTransactionDate = orm.Required(str) # P-13
        ExpirationDate = orm.Required(str) # P-14
        PointOfServiceEntryMode = orm.Required(int) # P-22
        FunctionCode = orm.Required(int) # P-24
        PointOfServiceConditionCode = orm.Required(int) # P-25
        AcquiringInstitutionIdentificationCode = orm.Required(int) # P-32
        ForwardingInstitutionIdentificationCode = orm.Optional(int) # P-33
        Track2 = orm.Optional(int) # P-35
        RRN = orm.Optional(int) # P-37
        CardAcceptor = orm.Optional(int) # P-41
        CardAcceptorCode = orm.Required(str) # P-42
        CardAcceptorName = orm.Required(str) # P-43
        AddtionalData = orm.Optional(int) # P-48
        TransactionCurrencyCode = orm.Optional(int) # P-49
        PinBlock = orm.Optional(int) # P-52
        Payee = orm.Optional(int) # S-98
        AccountIdentification1 = orm.Optional(int) # S-102
        AccountIdentification2 = orm.Optional(int) # S-103
        PrivateAdditionalData = orm.Optional(str) # S-121
        NewPinBlock = orm.Optional(int) # S-123
        MAC = orm.Optional(int) # S-128
        LatestUpdateDate = orm.Required(datetime, default=datetime.utcnow)
        TerminalCode = orm.Required("Terminals", reverse="FinantionalRequestTermial")
        TerminalIpAddress = orm.Required(str)
        BranchID = orm.Required("Branches", reverse="FinantionalRequestBranch") # S-100
        TokenID = orm.Required("Tokens", reverse="FinantionalRequestToken")
        FinantionalReq = orm.Set("FinantionalResponses", reverse="FinantionalRequestID")



# 0210 and 0230 Messages
class FinantionalResponses(db.Entity):
        _table_ = ('public', 'FinantionalResponses')
        FinantionalResponseID = orm.PrimaryKey(int, auto=True)
        FinantionalRequestID = orm.Required("FinantionalRequests", reverse="FinantionalReq")
        MessageType = orm.Required(int) # ISO-2
        PAN = orm.Optional(str) # P-2
        TransServiceID = orm.Required("TransServices", reverse="FinantionalResponseService") # P-3
        Amount = orm.Required(int) # P-4
        CurrencyAmount = orm.Optional(int) # P-6
        TransmissionDateTime = orm.Required(str) # P-7
        STAN = orm.Required(str) # P-11
        LocalTransactionTime = orm.Required(str) # P-12
        LocalTransactionDate = orm.Required(str) # P-13
        SettlementDate = orm.Required(datetime) # P-15
        CaptureDate = orm.Required(datetime) # P-17
        FunctionCode = orm.Required(int) # P-24
        AcquiringInstitutionIdentificationCode = orm.Required(int) # P-32
        ForwardingInstitutionIdentificationCode = orm.Optional(int) # P-33
        RRN = orm.Optional(int) # P-37
        ResponseCode = orm.Optional(int) # P-39
        CardAcceptorTerminalId = orm.Optional(int) # P-41
        CardAcceptorCode = orm.Optional(int) # P-42
        AddtionalData = orm.Optional(str) # P-48
        TransactionCurrencyCode = orm.Optional(int) # P-49
        AdditionalAmounts = orm.Optional(int) # P-54
        AccountIdentification1 = orm.Optional(int) # S-102
        AccountIdentification2 = orm.Optional(int) # S-103
        PrivateAdditionalData = orm.Optional(int) # S-121
        MAC = orm.Optional(int) # S-128
        LatestUpdateDate = orm.Required(datetime, default=datetime.utcnow) 



# 0400 and 0420 Messages
class ReversalRequests(db.Entity):
        _table_ = ('public', 'ReversalRequests')
        ReversalRequestID = orm.PrimaryKey(int, auto=True)
        MessageType = orm.Required(int) # ISO-2
        SecondBitmap = orm.Required(bytes) # P-1
        PAN = orm.Optional(str) # P-2
        TransServiceID = orm.Required("TransServices", reverse="ReversalRequestService") # P-3
        Amount = orm.Required(int) # P-4
        CurrencyAmount = orm.Optional(int) # P-6
        TransmissionDateTime = orm.Required(str) # P-7
        STAN = orm.Required(str) # P-11
        LocalTransactionTime = orm.Required(str) # P-12
        LocalTransactionDate = orm.Required(str) # P-13
        FunctionCode = orm.Required(int) # P-24
        PointOfServiceConditionCode = orm.Required(int) # P-25
        AcquiringInstitutionIdentificationCode = orm.Required(int) # P-32
        ForwardingInstitutionIdentificationCode = orm.Optional(int) # P-33
        RRN = orm.Optional(int) # P-37
        ResponseCode = orm.Optional(int) # P-39
        CardAcceptor = orm.Optional(int) # P-41
        CardAcceptorCode = orm.Optional(int) # P-42
        CardAcceptorName = orm.Required(str) # P-43
        AddtionalData = orm.Optional(int) # P-48
        TransactionCurrencyCode = orm.Optional(int) # P-49
        OriginalData = orm.Optional(str) # S-90
        ReplacementAmounts = orm.Optional(int) # S-95
        AccountIdentification1 = orm.Optional(int) # S-102
        AccountIdentification2 = orm.Optional(int) # S-103
        MAC = orm.Optional(int) # S-128
        LatestUpdateDate = orm.Required(datetime, default=datetime.utcnow)
        TerminalCode = orm.Required("Terminals", reverse="ReversalRequestTermial")
        TerminalIpAddress = orm.Required(str)
        BranchID = orm.Required("Branches", reverse="ReversalRequestBranch") # S-100
        TokenID = orm.Required("Tokens", reverse="ReversalRequestToken")
        ReversalReq = orm.Set("ReversalResponses", reverse="ReversalRequestID")



# 0410 and 0430 Messages
class ReversalResponses(db.Entity):
        _table_ = ('public', 'ReversalResponses')
        ReversalResponseID = orm.PrimaryKey(int, auto=True)
        ReversalRequestID = orm.Required("ReversalRequests", reverse="ReversalReq")
        SecondBitmap = orm.Required(bytes) # P-1
        PAN = orm.Optional(str) # P-2
        TransServiceID = orm.Required("TransServices", reverse="ReversalResponseService") # P-3
        Amount = orm.Required(int) # P-4
        CurrencyAmount = orm.Optional(int) # P-6
        TransmissionDateTime = orm.Required(str) # P-7
        STAN = orm.Required(str) # P-11
        LocalTransactionTime = orm.Required(str) # P-12
        LocalTransactionDate = orm.Required(str) # P-13
        SettlementDate = orm.Required(datetime) # P-15
        CaptureDate = orm.Required(datetime) # P-17
        AcquiringInstitutionIdentificationCode = orm.Required(int) # P-32
        ForwardingInstitutionIdentificationCode = orm.Optional(int) # P-33
        RRN = orm.Optional(int) # P-37
        ResponseCode = orm.Optional(int) # P-39
        CardAcceptor = orm.Optional(int) # P-41
        CardAcceptorCode = orm.Optional(int) # P-42
        AddtionalData = orm.Optional(int) # P-48
        TransactionCurrencyCode = orm.Optional(int) # P-49
        BillingCurrencyCode = orm.Optional(int) # P-51
        AdditionalAmounts = orm.Optional(int) # P-54
        MAC = orm.Required(str) # P-64
        LatestUpdateDate = orm.Required(datetime, default=datetime.utcnow)



# 0500 and 0520 Messages
class SettlementRequests(db.Entity):
        _table_ = ('public', 'SettlementRequests')
        SettlementRequestID = orm.PrimaryKey(int, auto=True)
        MessageType = orm.Optional(int) # ISO-2
        SecondBitmap = orm.Required(bytes) # P-1
        TransServiceID = orm.Required("TransServices", reverse="SettlementRequestService") # P-3
        TransmissionDateTime = orm.Required(str) # P-7
        STAN = orm.Required(str) # P-11
        SettlementDate = orm.Required(datetime) # P-15
        CaptureDate = orm.Required(datetime) # P-17
        AcquiringInstitutionIdentificationCode = orm.Optional(int) # P-32
        ForwardingInstitutionIdentificationCode = orm.Optional(int) # P-33
        SettlementCurrencyCode = orm.Optional(int) # P-50
        NumberOfCredits = orm.Optional(int) # S-74
        CreditsReversalNumber = orm.Optional(int) # S-75
        NumberOfDebits = orm.Optional(int) # S-76
        DebitsReversalNumber = orm.Optional(int) # S-77
        TransferNumber = orm.Optional(int) # S-78
        TransferReversalNumber = orm.Optional(int) # S-79
        NumberOfInquiries = orm.Optional(int) # S-80
        NumberOfAuthorizations = orm.Optional(int) # S-81
        CreditsProcessingFeeAmount = orm.Optional(int) # S-82
        CreditsTransactionFeeAmount = orm.Optional(int) # S-83
        DebitsProcessingFeeAmount = orm.Optional(int) # S-84
        DebitsTransactionFeeAmount = orm.Optional(int) # S-85
        TotalAmountOfCredits = orm.Optional(int) # S-86
        CreditsReversalAmount = orm.Optional(int) # S-87
        TotalAmountOfDebits = orm.Optional(int) # S-88
        DebitsReversalAmount = orm.Optional(int) # S-89
        NetSettlementAmount = orm.Optional(int) # S-97
        SettlementInstitutionIdentificationCode = orm.Optional(int) # S-99
        SettlementAdditionalData = orm.Optional(int) # S-124
        MAC = orm.Optional(int) # S-128
        LatestUpdateDate = orm.Required(datetime, default=datetime.utcnow)
        TerminalCode = orm.Required("Terminals", reverse="SettlementRequestTermial")
        TerminalIpAddress = orm.Required(str)
        BranchID = orm.Required("Branches", reverse="SettlementRequestBranch") # S-100
        TokenID = orm.Required("Tokens", reverse="SettlementRequestToken")
        SettlementReq = orm.Set("SettlementResponses", reverse="SettlementRequestID")



# 0510 and 0530 Messages
class SettlementResponses(db.Entity):
        _table_ = ('public', 'SettlementResponses')
        SettlementResponseID = orm.PrimaryKey(int, auto=True)
        SettlementRequestID = orm.Required("SettlementRequests", reverse="SettlementReq")
        MessageType = orm.Optional(int) # ISO-2
        SecondBitmap = orm.Required(bytes) # P-1
        TransServiceID = orm.Required("TransServices", reverse="SettlementResponseService") # P-3
        TransmissionDateTime = orm.Required(str) # P-7
        STAN = orm.Required(str) # P-11
        SettlementDate = orm.Required(datetime) # P-15
        SettlementCurrencyCode = orm.Optional(int) # P-50
        SettlementCode = orm.Optional(int) # P-66
        SettlementInstitutionIdentificationCode = orm.Optional(int) # S-99
        MAC = orm.Optional(int) # S-128 



# 0600 Messages
class AdministrativeRequests(db.Entity):
        _table_ = ('public', 'AdministrativeRequests')
        AdministrativeRequestID = orm.PrimaryKey(int, auto=True)
        MessageType = orm.Required(int) # ISO-2
        SecondBitmap = orm.Required(bytes) # P-1
        PAN = orm.Optional(str) # P-2
        TransServiceID = orm.Required("TransServices", reverse="AdministrativeRequestService") # P-3
        TransmissionDateTime = orm.Required(str) # P-7
        STAN = orm.Required(str) # P-11
        LocalTransactionTime = orm.Required(str) # P-12
        LocalTransactionDate = orm.Required(str) # P-13
        FunctionCode = orm.Required(int) # P-24
        PointOfServiceConditionCode = orm.Required(int) # P-25
        AcquiringInstitutionIdentificationCode = orm.Optional(int) # P-32
        ForwardingInstitutionIdentificationCode = orm.Optional(int) # P-33
        CardAcceptor = orm.Optional(int) # P-41
        CardAcceptorCode = orm.Optional(int) # P-42
        AdditionalResponseData = orm.Optional(int) # P-44
        AddtionalData = orm.Optional(int) # P-48
        AccountIdentification1 = orm.Optional(int) # S-102
        MAC = orm.Optional(int) # S-128
        TerminalCode = orm.Required("Terminals", reverse="AdministrativeRequestTermial")
        TerminalIpAddress = orm.Required(str)
        BranchID = orm.Required("Branches", reverse="AdministrativeRequestBranch") # S-100
        TokenID = orm.Required("Tokens", reverse="AdministrativeRequestToken")
        AdministrativeReq = orm.Set("AdministrativeResponses", reverse="AdministrativeRequestID")



# 0610 Messages
class AdministrativeResponses(db.Entity):
        _table_ = ('public', 'AdministrativeResponses')
        AdministrativeResponseID = orm.PrimaryKey(int, auto=True)
        AdministrativeRequestID = orm.Required("AdministrativeRequests", reverse="AdministrativeReq")
        MessageType = orm.Required(int) # ISO-2
        SecondBitmap = orm.Required(bytes) # P-1
        PAN = orm.Optional(str) # P-2
        TransServiceID = orm.Required("TransServices", reverse="AdministrativeResponseService") # P-3
        TransmissionDateTime = orm.Required(str) # P-7
        STAN = orm.Required(str) # P-11
        LocalTransactionTime = orm.Required(str) # P-12
        LocalTransactionDate = orm.Required(str) # P-13
        FunctionCode = orm.Required(int) # P-24
        AcquiringInstitutionIdentificationCode = orm.Optional(int) # P-32
        ForwardingInstitutionIdentificationCode = orm.Optional(int) # P-33
        RRN = orm.Optional(int) # P-37
        ResponseCode = orm.Optional(int) # P-39
        CardAcceptor = orm.Optional(int) # P-41
        AdditionalResponseData = orm.Optional(int) # P-44
        PrivateAdditionalData = orm.Optional(int) # S-121
        MAC = orm.Optional(int) # S-128 



# 0800 and 0820 Messages
class NetworkManagementRequests(db.Entity):
        _table_ = ('public', 'NetworkManagementRequests')
        NetworkManagementRequestID = orm.PrimaryKey(int, auto=True)
        MessageType = orm.Optional(int) # ISO-2
        SecondBitmap = orm.Required(bytes) # P-1
        TransServiceID = orm.Required("TransServices", reverse="NetworkManagementRequestService") # P-3
        TransmissionDateTime = orm.Required(str) # P-7
        STAN = orm.Required(str) # P-11
        SettlementDate = orm.Required(datetime) # P-15
        AcquiringInstitutionIdentificationCode = orm.Optional(int) # P-32
        ForwardingInstitutionIdentificationCode = orm.Optional(int) # P-33
        AddtionalData = orm.Optional(int) # P-48
        SecurityRelatedControlInformation = orm.Optional(int) # P-53
        NetworkManagementInformationCode = orm.Optional(int) # S-70
        MessageSecurityCode = orm.Optional(int) # S-96
        MAC = orm.Optional(int) # S-128
        TerminalCode = orm.Required("Terminals", reverse="NetworkManagementRequestTermial")
        TerminalIpAddress = orm.Required(str)
        BranchID = orm.Required("Branches", reverse="NetworkManagementRequestBranch") # S-100
        TokenID = orm.Required("Tokens", reverse="NetworkManagementRequestToken")
        NetworkManagementReq = orm.Set("NetworkManagementResponses", reverse="NetworkManagementRequestID")
        


# 0810 and 0830 Messages
class NetworkManagementResponses(db.Entity):
        _table_ = ('public', 'NetworkManagementResponses')
        NetworkManagementResponseID = orm.PrimaryKey(int, auto=True)
        NetworkManagementRequestID = orm.Required("NetworkManagementRequests", reverse="NetworkManagementReq")
        MessageType = orm.Optional(int) # ISO-2
        SecondBitmap = orm.Required(bytes) # P-1
        TransServiceID = orm.Required("TransServices", reverse="NetworkManagementResponseService") # P-3
        TransmissionDateTime = orm.Required(str) # P-7
        STAN = orm.Required(str) # P-11
        SettlementDate = orm.Required(datetime) # P-15
        AcquiringInstitutionIdentificationCode = orm.Optional(int) # P-32
        ForwardingInstitutionIdentificationCode = orm.Optional(int) # P-33
        ResponseCode = orm.Optional(int) # P-39
        AddtionalData = orm.Optional(int) # P-48
        NetworkManagementInformationCode = orm.Optional(int) # S-70
        MessageSecurityCode = orm.Optional(int) # S-96
        MAC = orm.Optional(int) # S-128



# 0804 Messages
class KeyExchangeRequests(db.Entity):
        _table_ = ('public', 'KeyExchangeRequests')
        KeyExchangeRequestID = orm.PrimaryKey(int, auto=True)
        MessageType = orm.Required(int) # ISO-2
        SecondBitmap = orm.Required(bytes) # P-1
        TransServiceID = orm.Required("TransServices", reverse="KeyExchangeRequestService") # P-3
        TransmissionDateTime = orm.Required(str) # P-7
        STAN = orm.Required(str) # P-11
        LocalTransactionTime = orm.Required(str) # P-12
        LocalTransactionDate = orm.Required(str) # P-13
        FunctionCode = orm.Required(int) # P-24
        AcquiringInstitutionIdentificationCode = orm.Optional(int) # P-32
        CardAcceptor = orm.Optional(int) # P-41
        CardAcceptorCode = orm.Optional(int) # P-42
        PrivateAdditionalData = orm.Optional(int) # S-121
        TerminalCode = orm.Required("Terminals", reverse="KeyExchangeRequestTermial")
        TerminalIpAddress = orm.Required(str)
        BranchID = orm.Required("Branches", reverse="KeyExchangeRequestBranch") # S-100
        TokenID = orm.Required("Tokens", reverse="KeyExchangeRequestToken")
        KeyExchangeReq = orm.Set("KeyExchangeResponses", reverse="KeyExchangeRequestID")



# 0814 Messages
class KeyExchangeResponses(db.Entity):
        _table_ = ('public', 'KeyExchangeResponses')
        KeyExchangeResponseID = orm.PrimaryKey(int, auto=True)
        KeyExchangeRequestID = orm.Required("KeyExchangeRequests", reverse="KeyExchangeReq")
        MessageType = orm.Required(int) # ISO-2
        SecondBitmap = orm.Required(bytes) # P-1
        TransServiceID = orm.Required("TransServices", reverse="KeyExchangeResponseService") # P-3
        TransmissionDateTime = orm.Required(str) # P-7
        STAN = orm.Required(str) # P-11
        LocalTransactionTime = orm.Required(str) # P-12
        LocalTransactionDate = orm.Required(str) # P-13
        FunctionCode = orm.Required(int) # P-24
        AcquiringInstitutionIdentificationCode = orm.Optional(int) # P-32
        ResponseCode = orm.Optional(int) # P-39
        CardAcceptor = orm.Optional(int) # P-41
        CardAcceptorCode = orm.Optional(int) # P-42
        AddtionalData = orm.Optional(int) # P-48



if config['ConnectionString']['host'] != 'NotSet' and config['ConnectionString']['database'] != 'NotSet':
        if config['ConnectionString']['provider'] == 'postgres':
                isBinded = True
                db.bind(provider=config['ConnectionString']['provider'], user=config['ConnectionString']['user'], password=config['ConnectionString']['password'], host=config['ConnectionString']['host'], database=config['ConnectionString']['database'])
        elif config['ConnectionString']['provider'] == 'mysql':
                isBinded = True
                db.bind(provider=config['ConnectionString']['provider'], host=config['ConnectionString']['host'], user=config['ConnectionString']['user'], passwd=config['ConnectionString']['password'], db=config['ConnectionString']['database'])
        db.generate_mapping(create_tables=True)