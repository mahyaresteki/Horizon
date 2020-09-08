INSERT INTO public."Branches" (BranchCode, BranchTitle, LatestUpdateDate) 
    VALUES ('1001','Central Branch',CURRENT_TIMESTAMP);


INSERT INTO public."Terminals" (TerminalCode, BranchCode, ChannelTypeID, IPAddress, MacKey, PinKey, MasterKey, TopUpKey, LatestUpdateDate) 
    VALUES ('5001','1001',(SELECT ChannelTypeID FROM public."ChannelTypes" WHERE ChannelTypeTitle = 'Internet Bank'), '127.0.0.1', '1', '2', '3', '4', CURRENT_TIMESTAMP);