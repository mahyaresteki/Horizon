import sys
from pony.orm import *
from datetime import datetime
import configparser
config = configparser.ConfigParser()
config.sections()
config.read('config/conf.ini')

db = Database()

class Roles(db.Entity):
        _table_ = ('public', 'Roles')
        RoleID = PrimaryKey(int, auto=True)
        RoleTitle = Required(str)
        Description = Optional(str)
        LatestUpdateDate = Required(datetime)
        UserRole = Set("Users", reverse="RoleID")


class Users(db.Entity):
        _table_ = ('public', 'Users')
        UserID = PrimaryKey(int, auto=True)
        Username = Required(str, unique=True)
        Password = Required(str)
        FirstName = Required(str)
        LastName = Required(str)
        PersonelCode = Required(str, unique=True)
        RoleID = Required("Roles", reverse="UserRole")
        IsActive = Required(bool)
        LatestUpdateDate = Required(datetime)
        UserToken = Set("Tokens", reverse="UserID")


class Tokens(db.Entity):
        _table_ = ('public', 'Tokens')
        TokenID = PrimaryKey(int, auto=True)
        Token = Required(str, unique=True)
        ClientIP = Required(str)
        UserID = Required("Users", reverse="UserToken")
        GenerationDate = Required(datetime)
        AuthorizationRequestToken = Set("AuthorizationRequests", reverse="TokenID")
        FinantionalRequestToken = Set("FinantionalRequests", reverse="TokenID")
        ReversalRequestToken = Set("ReversalRequests", reverse="TokenID")
        SettlementRequestToken = Set("SettlementRequests", reverse="TokenID")
        AdministrativeRequestToken = Set("AdministrativeRequests", reverse="TokenID")
        NetworkManagementRequestToken = Set("NetworkManagementRequests", reverse="TokenID")
        KeyExchangeRequestToken = Set("KeyExchangeRequests", reverse="TokenID")


class ChannelTypes(db.Entity):
        _table_ = ('public', 'ChannelTypes')
        ChannelTypeID = PrimaryKey(int, auto=True)
        ChannelTypeTitle = Required(str, unique=True)
        Description = Optional(str)
        IsTokenRequired = Required(bool)
        TerminalChannelType = Set("Terminals", reverse="ChannelTypeID")
        AuthorizationRequestChannelType = Set("AuthorizationRequests", reverse="ChannelTypeID")
        FinantionalRequestChannelType = Set("FinantionalRequests", reverse="ChannelTypeID")
        ReversalRequestChannelType = Set("ReversalRequests", reverse="ChannelTypeID")
        SettlementRequestChannelType = Set("SettlementRequests", reverse="ChannelTypeID")
        AdministrativeRequestChannelType = Set("AdministrativeRequests", reverse="ChannelTypeID")
        NetworkManagementRequestChannelType = Set("NetworkManagementRequests", reverse="ChannelTypeID")
        KeyExchangeRequestChannelType = Set("KeyExchangeRequests", reverse="ChannelTypeID")


class Processes(db.Entity):
        _table_ = ('public', 'Processes')
        ProcessingCode = PrimaryKey(str)
        ProcessTitle = Required(str, unique=True)
        Description = Optional(str)
        AuthorizationRequestProcess = Set("AuthorizationRequests", reverse="ProcessingCode")
        FinantionalRequestProcess = Set("FinantionalRequests", reverse="ProcessingCode")
        ReversalRequestProcess = Set("ReversalRequests", reverse="ProcessingCode")
        AdministrativeRequestProcess = Set("AdministrativeRequests", reverse="ProcessingCode")
        AuthorizationResponseProcess = Set("AuthorizationResponses", reverse="ProcessingCode")
        FinantionalResponseProcess = Set("FinantionalResponses", reverse="ProcessingCode")
        ReversalResponseProcess = Set("ReversalResponses", reverse="ProcessingCode")
        AdministrativeResponseProcess = Set("AdministrativeResponses", reverse="ProcessingCode")


class Branches(db.Entity):
        _table_ = ('public', 'Branches')
        BranchCode = PrimaryKey(str)
        BranchTitle = Required(str, unique=True)
        Description = Optional(str)
        AuthorizationRequestBranch = Set("AuthorizationRequests", reverse="BranchCode")
        FinantionalRequestBranch = Set("FinantionalRequests", reverse="BranchCode")
        ReversalRequestBranch = Set("ReversalRequests", reverse="BranchCode")
        SettlementRequestBranch = Set("SettlementRequests", reverse="BranchCode")
        AdministrativeRequestBranch = Set("AdministrativeRequests", reverse="BranchCode")
        NetworkManagementRequestBranch = Set("NetworkManagementRequests", reverse="BranchCode")
        KeyExchangeRequestBranch = Set("KeyExchangeRequests", reverse="BranchCode")
        TerminalBranch = Set("Terminals", reverse="BranchCode")


class Terminals(db.Entity):
        _table_ = ('public', 'Terminals')
        TerminalCode = PrimaryKey(str)
        BranchCode = Required("Branches", reverse="TerminalBranch")
        ChannelTypeID = Required("ChannelTypes", reverse="TerminalChannelType")
        IPAddress = Required(str, unique=True)
        MacKey = Required(str, unique=True)
        PinKey = Required(str, unique=True)
        MasterKey = Required(str, unique=True)
        TopUpKey = Required(str, unique=True)
        AuthorizationRequestTermial = Set("AuthorizationRequests", reverse="TerminalCode")
        FinantionalRequestTermial = Set("FinantionalRequests", reverse="TerminalCode")
        ReversalRequestTermial = Set("ReversalRequests", reverse="TerminalCode")
        SettlementRequestTermial = Set("SettlementRequests", reverse="TerminalCode")
        AdministrativeRequestTermial = Set("AdministrativeRequests", reverse="TerminalCode")
        NetworkManagementRequestTermial = Set("NetworkManagementRequests", reverse="TerminalCode")
        KeyExchangeRequestTermial = Set("KeyExchangeRequests", reverse="TerminalCode")


# 0100 Messages
class AuthorizationRequests(db.Entity):
        _table_ = ('public', 'AuthorizationRequests')
        AuthorizationRequestID = PrimaryKey(int, auto=True)
        MessageType = Required(int) # ISO-2
        PAN = Optional(str) # P-2
        ProcessingCode = Required("Processes", reverse="AuthorizationRequestProcess") # P-3
        Amount = Required(int) # P-4
        TransmissionDateTime = Required(str) # P-7
        STAN = Required(str) # P-11
        LocalTransactionTime = Required(str) # P-12
        LocalTransactionDate = Required(str) # P-13
        ExpirationDate = Required(str) # P-14
        PointOfServiceEntryMode = Required(str) # P-22
        FunctionCode = Required(str) # P-24
        PointOfServiceConditionCode = Required(str) # P-25
        AcquiringInstitutionIdentificationCode = Required(int) # P-32
        Track2 = Optional(str) # P-35
        RRN = Required(str) # P-37
        CardAcceptor = Required(str) # P-41
        CardAcceptorCode = Required(str) # P-42
        AddtionalData = Optional(str) # P-48
        TransactionCurrencyCode = Optional(int) # P-49
        PinBlock = Optional(str) # P-52
        MAC = Required(str) # P-64
        ChannelTypeID = Required("ChannelTypes", reverse="AuthorizationRequestChannelType")
        TerminalCode = Required("Terminals", reverse="AuthorizationRequestTermial")
        TerminalIpAddress = Required(str)
        BranchCode = Required("Branches", reverse="AuthorizationRequestBranch") # S-100
        TokenID = Required("Tokens", reverse="AuthorizationRequestToken")
        AuthorizationReq = Set("AuthorizationResponses", reverse="AuthorizationRequestID")


# 0110 Messages
class AuthorizationResponses(db.Entity):
        _table_ = ('public', 'AuthorizationResponses')
        AuthorizationResponseID = PrimaryKey(int, auto=True)
        AuthorizationRequestID = Required("AuthorizationRequests", reverse="AuthorizationReq")
        MessageType = Required(int) # ISO-2
        SecondBitmap = Required(bytes) # P-1
        PAN = Optional(str) # P-2
        ProcessingCode = Required("Processes", reverse="AuthorizationResponseProcess") # P-3
        Amount = Required(int) # P-4
        CurrencyAmount = Optional(int) # P-6
        TransmissionDateTime = Required(str) # P-7
        STAN = Required(str) # P-11
        LocalTransactionTime = Required(str) # P-12
        LocalTransactionDate = Required(str) # P-13
        CaptureDate = Required(datetime) # P-17
        AcquiringInstitutionIdentificationCode = Required(int) # P-32
        ForwardingInstitutionIdentificationCode = Optional(int) # P-33
        RRN = Required(str) # P-37
        ResponseCode = Required(str) # P-39
        CardAcceptor = Required(str) # P-41
        CardAcceptorCode = Required(str) # P-42
        CardAcceptorName = Required(str) # P-43
        AdditionalResponseData = Required(str) # P-44
        AddtionalData = Optional(str) # P-48
        TransactionCurrencyCode = Optional(int) # P-49
        BillingCurrencyCode = Optional(int) # P-51
        Payee = Optional(int) # P-98
        AccountIdentification1 = Optional(str) # S-102
        AccountIdentification2 = Optional(str) # S-103
        PrivateAdditionalData = Optional(str) # S-121
        MAC = Required(int) # S-128
        

# 0200 and 220 Messages
class FinantionalRequests(db.Entity):
        _table_ = ('public', 'FinantionalRequests')
        FinantionalRequestID = PrimaryKey(int, auto=True)
        MessageType = Required(int) # ISO-2
        SecondBitmap = Required(bytes) # P-1
        PAN = Required(str) # P-2
        ProcessingCode = Required("Processes", reverse="FinantionalRequestProcess") # P-3
        Amount = Required(int) # P-4
        TransmissionDateTime = Required(str) # P-7
        STAN = Required(str) # P-11
        LocalTransactionTime = Required(str) # P-12
        LocalTransactionDate = Required(str) # P-13
        ExpirationDate = Required(str) # P-14
        PointOfServiceEntryMode = Required(int) # P-22
        FunctionCode = Required(int) # P-24
        PointOfServiceConditionCode = Required(int) # P-25
        AcquiringInstitutionIdentificationCode = Required(int) # P-32
        ForwardingInstitutionIdentificationCode = Optional(int) # P-33
        Track2 = Optional(int) # P-35
        RRN = Optional(int) # P-37
        CardAcceptor = Optional(int) # P-41
        CardAcceptorCode = Required(str) # P-42
        CardAcceptorName = Required(str) # P-43
        AddtionalData = Optional(int) # P-48
        TransactionCurrencyCode = Optional(int) # P-49
        PinBlock = Optional(int) # P-52
        Payee = Optional(int) # S-98
        AccountIdentification1 = Optional(int) # S-102
        AccountIdentification2 = Optional(int) # S-103
        PrivateAdditionalData = Optional(str) # S-121
        NewPinBlock = Optional(int) # S-123
        MAC = Optional(int) # S-128
        ChannelTypeID = Required("ChannelTypes", reverse="FinantionalRequestChannelType")
        TerminalCode = Required("Terminals", reverse="FinantionalRequestTermial")
        TerminalIpAddress = Required(str)
        BranchCode = Required("Branches", reverse="FinantionalRequestBranch") # S-100
        TokenID = Required("Tokens", reverse="FinantionalRequestToken")
        FinantionalReq = Set("FinantionalResponses", reverse="FinantionalRequestID")
        

# 0210 and 0230 Messages
class FinantionalResponses(db.Entity):
        _table_ = ('public', 'FinantionalResponses')
        FinantionalResponseID = PrimaryKey(int, auto=True)
        FinantionalRequestID = Required("FinantionalRequests", reverse="FinantionalReq")
        MessageType = Required(int) # ISO-2
        PAN = Optional(str) # P-2
        ProcessingCode = Required("Processes", reverse="FinantionalResponseProcess") # P-3
        Amount = Required(int) # P-4
        CurrencyAmount = Optional(int) # P-6
        TransmissionDateTime = Required(str) # P-7
        STAN = Required(str) # P-11
        LocalTransactionTime = Required(str) # P-12
        LocalTransactionDate = Required(str) # P-13
        SettlementDate = Required(datetime) # P-15
        CaptureDate = Required(datetime) # P-17
        FunctionCode = Required(int) # P-24
        AcquiringInstitutionIdentificationCode = Required(int) # P-32
        ForwardingInstitutionIdentificationCode = Optional(int) # P-33
        RRN = Optional(int) # P-37
        ResponseCode = Optional(int) # P-39
        CardAcceptorTerminalId = Optional(int) # P-41
        CardAcceptorCode = Optional(int) # P-42
        AddtionalData = Optional(str) # P-48
        TransactionCurrencyCode = Optional(int) # P-49
        AdditionalAmounts = Optional(int) # P-54
        AccountIdentification1 = Optional(int) # S-102
        AccountIdentification2 = Optional(int) # S-103
        PrivateAdditionalData = Optional(int) # S-121
        MAC = Optional(int) # S-128 


# 0400 and 0420 Messages
class ReversalRequests(db.Entity):
        _table_ = ('public', 'ReversalRequests')
        ReversalRequestID = PrimaryKey(int, auto=True)
        MessageType = Required(int) # ISO-2
        SecondBitmap = Required(bytes) # P-1
        PAN = Optional(str) # P-2
        ProcessingCode = Required("Processes", reverse="ReversalRequestProcess") # P-3
        Amount = Required(int) # P-4
        CurrencyAmount = Optional(int) # P-6
        TransmissionDateTime = Required(str) # P-7
        STAN = Required(str) # P-11
        LocalTransactionTime = Required(str) # P-12
        LocalTransactionDate = Required(str) # P-13
        FunctionCode = Required(int) # P-24
        PointOfServiceConditionCode = Required(int) # P-25
        AcquiringInstitutionIdentificationCode = Required(int) # P-32
        ForwardingInstitutionIdentificationCode = Optional(int) # P-33
        RRN = Optional(int) # P-37
        ResponseCode = Optional(int) # P-39
        CardAcceptor = Optional(int) # P-41
        CardAcceptorCode = Optional(int) # P-42
        CardAcceptorName = Required(str) # P-43
        AddtionalData = Optional(int) # P-48
        TransactionCurrencyCode = Optional(int) # P-49
        OriginalData = Optional(str) # S-90
        ReplacementAmounts = Optional(int) # S-95
        AccountIdentification1 = Optional(int) # S-102
        AccountIdentification2 = Optional(int) # S-103
        MAC = Optional(int) # S-128
        ChannelTypeID = Required("ChannelTypes", reverse="ReversalRequestChannelType")
        TerminalCode = Required("Terminals", reverse="ReversalRequestTermial")
        TerminalIpAddress = Required(str)
        BranchCode = Required("Branches", reverse="ReversalRequestBranch") # S-100
        TokenID = Required("Tokens", reverse="ReversalRequestToken")
        ReversalReq = Set("ReversalResponses", reverse="ReversalRequestID")


# 0410 and 0430 Messages
class ReversalResponses(db.Entity):
        _table_ = ('public', 'ReversalResponses')
        ReversalResponseID = PrimaryKey(int, auto=True)
        ReversalRequestID = Required("ReversalRequests", reverse="ReversalReq")
        SecondBitmap = Required(bytes) # P-1
        PAN = Optional(str) # P-2
        ProcessingCode = Required("Processes", reverse="ReversalResponseProcess") # P-3
        Amount = Required(int) # P-4
        CurrencyAmount = Optional(int) # P-6
        TransmissionDateTime = Required(str) # P-7
        STAN = Required(str) # P-11
        LocalTransactionTime = Required(str) # P-12
        LocalTransactionDate = Required(str) # P-13
        SettlementDate = Required(datetime) # P-15
        CaptureDate = Required(datetime) # P-17
        AcquiringInstitutionIdentificationCode = Required(int) # P-32
        ForwardingInstitutionIdentificationCode = Optional(int) # P-33
        RRN = Optional(int) # P-37
        ResponseCode = Optional(int) # P-39
        CardAcceptor = Optional(int) # P-41
        CardAcceptorCode = Optional(int) # P-42
        AddtionalData = Optional(int) # P-48
        TransactionCurrencyCode = Optional(int) # P-49
        BillingCurrencyCode = Optional(int) # P-51
        AdditionalAmounts = Optional(int) # P-54
        MAC = Required(str) # P-64


# 0500 and 0520 Messages
class SettlementRequests(db.Entity):
        _table_ = ('public', 'SettlementRequests')
        SettlementRequestID = PrimaryKey(int, auto=True)
        MessageType = Optional(int) # ISO-2
        SecondBitmap = Required(bytes) # P-1
        TransmissionDateTime = Required(str) # P-7
        STAN = Required(str) # P-11
        SettlementDate = Required(datetime) # P-15
        CaptureDate = Required(datetime) # P-17
        AcquiringInstitutionIdentificationCode = Optional(int) # P-32
        ForwardingInstitutionIdentificationCode = Optional(int) # P-33
        SettlementCurrencyCode = Optional(int) # P-50
        NumberOfCredits = Optional(int) # S-74
        CreditsReversalNumber = Optional(int) # S-75
        NumberOfDebits = Optional(int) # S-76
        DebitsReversalNumber = Optional(int) # S-77
        TransferNumber = Optional(int) # S-78
        TransferReversalNumber = Optional(int) # S-79
        NumberOfInquiries = Optional(int) # S-80
        NumberOfAuthorizations = Optional(int) # S-81
        CreditsProcessingFeeAmount = Optional(int) # S-82
        CreditsTransactionFeeAmount = Optional(int) # S-83
        DebitsProcessingFeeAmount = Optional(int) # S-84
        DebitsTransactionFeeAmount = Optional(int) # S-85
        TotalAmountOfCredits = Optional(int) # S-86
        CreditsReversalAmount = Optional(int) # S-87
        TotalAmountOfDebits = Optional(int) # S-88
        DebitsReversalAmount = Optional(int) # S-89
        NetSettlementAmount = Optional(int) # S-97
        SettlementInstitutionIdentificationCode = Optional(int) # S-99
        SettlementAdditionalData = Optional(int) # S-124
        MAC = Optional(int) # S-128
        ChannelTypeID = Required("ChannelTypes", reverse="SettlementRequestChannelType")
        TerminalCode = Required("Terminals", reverse="SettlementRequestTermial")
        TerminalIpAddress = Required(str)
        BranchCode = Required("Branches", reverse="SettlementRequestBranch") # S-100
        TokenID = Required("Tokens", reverse="SettlementRequestToken")
        SettlementReq = Set("SettlementResponses", reverse="SettlementRequestID")


# 0510 and 0530 Messages
class SettlementResponses(db.Entity):
        _table_ = ('public', 'SettlementResponses')
        SettlementResponseID = PrimaryKey(int, auto=True)
        SettlementRequestID = Required("SettlementRequests", reverse="SettlementReq")
        MessageType = Optional(int) # ISO-2
        SecondBitmap = Required(bytes) # P-1
        TransmissionDateTime = Required(str) # P-7
        STAN = Required(str) # P-11
        SettlementDate = Required(datetime) # P-15
        SettlementCurrencyCode = Optional(int) # P-50
        SettlementCode = Optional(int) # P-66
        SettlementInstitutionIdentificationCode = Optional(int) # S-99
        MAC = Optional(int) # S-128 


# 0600 Messages
class AdministrativeRequests(db.Entity):
        _table_ = ('public', 'AdministrativeRequests')
        AdministrativeRequestID = PrimaryKey(int, auto=True)
        MessageType = Required(int) # ISO-2
        SecondBitmap = Required(bytes) # P-1
        PAN = Optional(str) # P-2
        ProcessingCode = Required("Processes", reverse="AdministrativeRequestProcess") # P-3
        TransmissionDateTime = Required(str) # P-7
        STAN = Required(str) # P-11
        LocalTransactionTime = Required(str) # P-12
        LocalTransactionDate = Required(str) # P-13
        FunctionCode = Required(int) # P-24
        PointOfServiceConditionCode = Required(int) # P-25
        AcquiringInstitutionIdentificationCode = Optional(int) # P-32
        ForwardingInstitutionIdentificationCode = Optional(int) # P-33
        CardAcceptor = Optional(int) # P-41
        CardAcceptorCode = Optional(int) # P-42
        AdditionalResponseData = Optional(int) # P-44
        AddtionalData = Optional(int) # P-48
        AccountIdentification1 = Optional(int) # S-102
        MAC = Optional(int) # S-128
        ChannelTypeID = Required("ChannelTypes", reverse="AdministrativeRequestChannelType")
        TerminalCode = Required("Terminals", reverse="AdministrativeRequestTermial")
        TerminalIpAddress = Required(str)
        BranchCode = Required("Branches", reverse="AdministrativeRequestBranch") # S-100
        TokenID = Required("Tokens", reverse="AdministrativeRequestToken")
        AdministrativeReq = Set("AdministrativeResponses", reverse="AdministrativeRequestID")


# 0610 Messages
class AdministrativeResponses(db.Entity):
        _table_ = ('public', 'AdministrativeResponses')
        AdministrativeResponseID = PrimaryKey(int, auto=True)
        AdministrativeRequestID = Required("AdministrativeRequests", reverse="AdministrativeReq")
        MessageType = Required(int) # ISO-2
        SecondBitmap = Required(bytes) # P-1
        PAN = Optional(str) # P-2
        ProcessingCode = Required("Processes", reverse="AdministrativeResponseProcess") # P-3
        TransmissionDateTime = Required(str) # P-7
        STAN = Required(str) # P-11
        LocalTransactionTime = Required(str) # P-12
        LocalTransactionDate = Required(str) # P-13
        FunctionCode = Required(int) # P-24
        AcquiringInstitutionIdentificationCode = Optional(int) # P-32
        ForwardingInstitutionIdentificationCode = Optional(int) # P-33
        RRN = Optional(int) # P-37
        ResponseCode = Optional(int) # P-39
        CardAcceptor = Optional(int) # P-41
        AdditionalResponseData = Optional(int) # P-44
        PrivateAdditionalData = Optional(int) # S-121
        MAC = Optional(int) # S-128 


# 0800 and 0820 Messages
class NetworkManagementRequests(db.Entity):
        _table_ = ('public', 'NetworkManagementRequests')
        NetworkManagementRequestID = PrimaryKey(int, auto=True)
        MessageType = Optional(int) # ISO-2
        SecondBitmap = Required(bytes) # P-1
        TransmissionDateTime = Required(str) # P-7
        STAN = Required(str) # P-11
        SettlementDate = Required(datetime) # P-15
        AcquiringInstitutionIdentificationCode = Optional(int) # P-32
        ForwardingInstitutionIdentificationCode = Optional(int) # P-33
        AddtionalData = Optional(int) # P-48
        SecurityRelatedControlInformation = Optional(int) # P-53
        NetworkManagementInformationCode = Optional(int) # S-70
        MessageSecurityCode = Optional(int) # S-96
        MAC = Optional(int) # S-128
        ChannelTypeID = Required("ChannelTypes", reverse="NetworkManagementRequestChannelType")
        TerminalCode = Required("Terminals", reverse="NetworkManagementRequestTermial")
        TerminalIpAddress = Required(str)
        BranchCode = Required("Branches", reverse="NetworkManagementRequestBranch") # S-100
        TokenID = Required("Tokens", reverse="NetworkManagementRequestToken")
        NetworkManagementReq = Set("NetworkManagementResponses", reverse="NetworkManagementRequestID")
        

# 0810 and 0830 Messages
class NetworkManagementResponses(db.Entity):
        _table_ = ('public', 'NetworkManagementResponses')
        NetworkManagementResponseID = PrimaryKey(int, auto=True)
        NetworkManagementRequestID = Required("NetworkManagementRequests", reverse="NetworkManagementReq")
        MessageType = Optional(int) # ISO-2
        SecondBitmap = Required(bytes) # P-1
        TransmissionDateTime = Required(str) # P-7
        STAN = Required(str) # P-11
        SettlementDate = Required(datetime) # P-15
        AcquiringInstitutionIdentificationCode = Optional(int) # P-32
        ForwardingInstitutionIdentificationCode = Optional(int) # P-33
        ResponseCode = Optional(int) # P-39
        AddtionalData = Optional(int) # P-48
        NetworkManagementInformationCode = Optional(int) # S-70
        MessageSecurityCode = Optional(int) # S-96
        MAC = Optional(int) # S-128


# 0804 Messages
class KeyExchangeRequests(db.Entity):
        _table_ = ('public', 'KeyExchangeRequests')
        KeyExchangeRequestID = PrimaryKey(int, auto=True)
        MessageType = Required(int) # ISO-2
        SecondBitmap = Required(bytes) # P-1
        TransmissionDateTime = Required(str) # P-7
        STAN = Required(str) # P-11
        LocalTransactionTime = Required(str) # P-12
        LocalTransactionDate = Required(str) # P-13
        FunctionCode = Required(int) # P-24
        AcquiringInstitutionIdentificationCode = Optional(int) # P-32
        CardAcceptor = Optional(int) # P-41
        CardAcceptorCode = Optional(int) # P-42
        PrivateAdditionalData = Optional(int) # S-121
        ChannelTypeID = Required("ChannelTypes", reverse="KeyExchangeRequestChannelType")
        TerminalCode = Required("Terminals", reverse="KeyExchangeRequestTermial")
        TerminalIpAddress = Required(str)
        BranchCode = Required("Branches", reverse="KeyExchangeRequestBranch") # S-100
        TokenID = Required("Tokens", reverse="KeyExchangeRequestToken")
        KeyExchangeReq = Set("KeyExchangeResponses", reverse="KeyExchangeRequestID")
        

# 0814 Messages
class KeyExchangeResponses(db.Entity):
        _table_ = ('public', 'KeyExchangeResponses')
        KeyExchangeResponseID = PrimaryKey(int, auto=True)
        KeyExchangeRequestID = Required("KeyExchangeRequests", reverse="KeyExchangeReq")
        MessageType = Required(int) # ISO-2
        SecondBitmap = Required(bytes) # P-1
        TransmissionDateTime = Required(str) # P-7
        STAN = Required(str) # P-11
        LocalTransactionTime = Required(str) # P-12
        LocalTransactionDate = Required(str) # P-13
        FunctionCode = Required(int) # P-24
        AcquiringInstitutionIdentificationCode = Optional(int) # P-32
        ResponseCode = Optional(int) # P-39
        CardAcceptor = Optional(int) # P-41
        CardAcceptorCode = Optional(int) # P-42
        AddtionalData = Optional(int) # P-48

if config['ConnectionString']['host'] != 'NotSet' and config['ConnectionString']['database'] != 'NotSet':
    if config['ConnectionString']['provider'] == 'postgres':
        isBinded = True
        db.bind(provider=config['ConnectionString']['provider'], user=config['ConnectionString']['user'], password=config['ConnectionString']['password'], host=config['ConnectionString']['host'], database=config['ConnectionString']['database'])
    elif config['ConnectionString']['provider'] == 'mysql':
        isBinded = True
        db.bind(provider=config['ConnectionString']['provider'], host=config['ConnectionString']['host'], user=config['ConnectionString']['user'], passwd=config['ConnectionString']['password'], db=config['ConnectionString']['database'])
    db.generate_mapping(create_tables=True)