Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB2F2249F5
	for <virtualization@lists.linux.dev>; Mon, 13 May 2024 17:48:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715622540; cv=fail; b=POEpN6bvy3ozxa1KLTPkcpT3ZYoqoGKASZTrihKvzyULTPc2vFnEU8H8SPxZnZQojiAqmhO/lLP4EDfy+L3Br4WIps+0pOoVcFkaJ61hX1GllNUJE0dMyGKbOmL3XRSzijWzIJLA5xY8rt19UbWlNT2RhlcVlH86yzWpFOTKRDE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715622540; c=relaxed/simple;
	bh=qk+z4ZeIdN4L3vDIM4hkkofvXVUmpnLCKK85R+aVvgo=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Ok7rkRlg9g+Qx2a0dB+PqEOlKGU6CwTcCNGVtXTEQ2yCq1B6AZtvdNG2yDJtG4WlLfq5kGOmU7QkkcgNKZpQP/48XyYDI2OBMsgE/MWCyEJp+/VDvmN6GQitVhPgmJFWStxpqGqMKV9MQXjnuUVsLYqOEVgel6nO14iAuNixf5s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=NeMDPSqn; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=BlHNu9SS; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="NeMDPSqn";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="BlHNu9SS"
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 44DHalmM026418;
	Mon, 13 May 2024 17:48:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=lUWBaEoYRM78uvom9Pp6rjOyxbHSmRFLUuVGbDaBm4g=;
 b=NeMDPSqnY476nvDFgI3MTeJWSW4P28FuefaW3N1e+Qe5ZClLZ6fcvXZFx6lKz8SqsiP7
 MDwPLaEZlqzIzaRmDNSDAKKJGtP4p7pE7kGa2f8MXDeS6Wn4jPYVyyttCIhtbIQgSnO7
 VYf/ZutsMUd2cU2dq841G/oXeR5vp7HjkCP0nzYC1yNJaJDhKfJRhAj2TcUcFYswybDs
 UT9HK9+USEYwCmEMcR809Sh5++brE52YupMQy76Dkh9+xxHz7TSkkYujpIRbbPDlCFDI
 Ctlzj3rowxDXW38BPeQvO9ZrBE8i/pnTFRHH9a58+iQMBcwgNBIlzo7kPkWitqkwWiky 8Q== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3y3qdj016a-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 13 May 2024 17:48:32 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 44DGZ1dW005732;
	Mon, 13 May 2024 17:43:54 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2169.outbound.protection.outlook.com [104.47.56.169])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3y1y464k44-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 13 May 2024 17:43:54 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aLkhRVPjcA/Pwrb/jft80+fpXrsxhaSNsIp8EcAnjKfTTPUZmuG28GXsQInwQMMRzflp2rbAXmKgcvM5TYHeTDtRj/ScVy+Ut+51td9OMAzLUX0ZosRwy3v/Ags+ieyOYRdppxLESkP95n5pAIdaj6wTrEJ1Dipwwo5HLoecgCepmAVn0Hf3A0EDQFIsktt/vGp7WaaGJZAFKj5V588ynDw79oz6iCfr/wFybXm//nedV1m6mHYP6egBLA9u8RiB4kG8MI14qN1iAfVpNALVdu6Xqd0QFovdNVlcQ3HxMeM1Zm6I40AW06s6UR9iOaax0clkKebn5IFcd1oRRQjIPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lUWBaEoYRM78uvom9Pp6rjOyxbHSmRFLUuVGbDaBm4g=;
 b=A409g4AQnqRodn8Yhieqz741d9NOIOKdQAuAw240uQkwMhpNrvq468OA9zBNG3BcZtUs+6hhhfs7NBHJxtCWVFtsGvSkroMNRckun6ZofQ/oAZbqxYz6C+krRLvDfhA7/arJWrzVDrLRZSi6npAjuRwJmZGhxPzf8tkAcqDv/03HF2061/qIlIrX1aPWMhHEFFRNr0oN3xHiyrL0gBSkgeDgaTRuCb8q2OLVvBgEFLJVCxQrrtAM6STKyjorWYNRQEJiwNCsZupDN9A4d921r/7eezj5T7Eh+HJ4BztHsj7guewlecDs8qAwd9M40WSWeUeGs7lhHUAEId+r3phXLw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lUWBaEoYRM78uvom9Pp6rjOyxbHSmRFLUuVGbDaBm4g=;
 b=BlHNu9SSUyIZHjDbAAmIaiCsP61JQZwwQSyM7xAfFnt4KlggRT+/I6o4J65QJZNBKWVR45WnPgsB4gZ1K6pEnEGywpcX9hJEI3jFIMaox2hGQM+C8R6ixQQHH8gvMDYbhOMQB9/ITrWizqgxgsAsMlm6+/v9iQWBoQyxMbFZFyA=
Received: from SA0PR10MB6425.namprd10.prod.outlook.com (2603:10b6:806:2c0::8)
 by CH0PR10MB5003.namprd10.prod.outlook.com (2603:10b6:610:ca::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.55; Mon, 13 May
 2024 17:43:51 +0000
Received: from SA0PR10MB6425.namprd10.prod.outlook.com
 ([fe80::447b:4d38:1f8b:28f1]) by SA0PR10MB6425.namprd10.prod.outlook.com
 ([fe80::447b:4d38:1f8b:28f1%5]) with mapi id 15.20.7544.052; Mon, 13 May 2024
 17:43:51 +0000
Message-ID: <2b8e02cd-2f2e-4bf1-9332-6dde502c22b1@oracle.com>
Date: Mon, 13 May 2024 10:43:48 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] x86/vector: Fix vector leak during CPU offline
To: Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org
Cc: mingo@redhat.com, Borislavbp@alien8.de, dave.hansen@linux.intel.com,
        hpa@zytor.com, joe.jin@oracle.com, linux-kernel@vger.kernel.org,
        virtualization@lists.linux.dev
References: <20240510190623.117031-1-dongli.zhang@oracle.com>
 <87msotnaow.ffs@tglx>
Content-Language: en-US
From: Dongli Zhang <dongli.zhang@oracle.com>
In-Reply-To: <87msotnaow.ffs@tglx>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MN2PR08CA0023.namprd08.prod.outlook.com
 (2603:10b6:208:239::28) To SA0PR10MB6425.namprd10.prod.outlook.com
 (2603:10b6:806:2c0::8)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA0PR10MB6425:EE_|CH0PR10MB5003:EE_
X-MS-Office365-Filtering-Correlation-Id: 5ba45784-2876-4603-9f1b-08dc73744081
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|366007|1800799015|376005;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?N3o3dkgyUXRnQjkrN2VoSWw0Nm1VUytTdGkzMWFnQTdMb3lNL3k3RFVSQUNR?=
 =?utf-8?B?TWpiR0ppaFFPWVkxUWczdFM1SVV6T2FOazJRb0RiMG1STWdNM2U3cjVHTWNa?=
 =?utf-8?B?OW5TcFZOTUVacEtlaytwWTUwYWR1dVZOczhucmp6Y3J1TXFrTFA3ZzdVeGls?=
 =?utf-8?B?L0JrNjkrL0wxK295OStwK2V4blZDNXdSd3ZmZ08yK0FTT2xkRHZGb09BVzVM?=
 =?utf-8?B?ZXhxb0hWeU9MNGRxMGlDSndEM0hxOUlQQ2Fua01mMnNMekxOc2R1R2p0eDVC?=
 =?utf-8?B?czNuNWdPV29zcVg0a04rekFZb2lhUXFvSlJaRmFBTlRiYmFmVkp4VE9Gckxr?=
 =?utf-8?B?WDdoemd5MmR6cUhVQmFCc0FwamNBbGttN1FCcmloY1Z0VnFtcCt3YkNFRHVQ?=
 =?utf-8?B?aVRrRU1IM0wrLy83K0xLVDB2NEtmUWF1UnJaeUMxS3pqVTkzeWFkTGFPQU9h?=
 =?utf-8?B?am90Z0xuMDlHTDJJR1NwMFZxaGtpdUdHWlJJTG95WithMzZOWjZYeHIvMGpk?=
 =?utf-8?B?S29jYlRSZXJzWnlrZG1oZlc1R1Y5LzJOTzFpNEVGWGJDcEVZUlFhWUdYcjc5?=
 =?utf-8?B?L04xV2VwU2RhVWRmdjhjSW5WSGpsNVMxWFdHdEVlN2Z2QXNCMmVWUGE4VE9W?=
 =?utf-8?B?M2dQQWxPZ2F1aXJVNTB1NGtzZXVtbEdGSFFtcjZqaFF3RkU3dk1uTkVjNVhx?=
 =?utf-8?B?ckNPSEhSY1kvWkJBdkIwYVoxNmVqdXNmWkwvT1JwdzBLVS92NjZLS2IzdFZZ?=
 =?utf-8?B?a1pQdk42ZXpyZnYrb0NpcU5LYmdsRmp1MS9KcDl4ZmdzSjlVbUF2dDVyZGpp?=
 =?utf-8?B?VkJTUnowQkQ5R0FXWGZpMW5FdEVVeEpGWmhibDlvN0YxeHBuWlJMZE1LY3gv?=
 =?utf-8?B?Z2Z2VkdPQk5KNjNrRDhwcWFYNFl0eXNMNUo1dWlKMDVVV1ZzZDIyNlNldXRr?=
 =?utf-8?B?a1RZVjJyc3ZHVDNrWjZKSFF0QUdjK3JMTzVJQ2FMa0xEeWowSmxLclMvWlUz?=
 =?utf-8?B?Y25rUVdsYUVjYWxIS1JzRHUrT1Y1L1U3anlWUm1OS3dLcTBoek54b2JGcmsz?=
 =?utf-8?B?a2xlcWQwalNYTm4yajhHZHhlWnVIK1ptTWJNZ1I1OEFLZlFmY3VtdlpZQVJv?=
 =?utf-8?B?TjBSbmtENGZ1KzA3bmdQa2RFd0xLR0ZFZzY0NHVMYnAwWGdIdFBjQmdoWDNt?=
 =?utf-8?B?MHQvNXZqbzhqWUlJZnJOaUY5M2VpMUNEVFZPWUs0V2dRL2JzVUFIc0hpTDEy?=
 =?utf-8?B?bUkxSTlVZ2h5RTJLMUVFMmVKVnYwRFRFd2pVSG1Sb21PblEwTFk4dWJuTzJr?=
 =?utf-8?B?OGlaangwWTA2NnJWYm5xYVAxK3JQVTFCN1F1S3ZXT0RORHg0Rldaeit6VlRS?=
 =?utf-8?B?TkZDVWxCdTFteWdKL09SUWwyeXVZUndKVkM2ck9DejVIWGdqWlFoRFB6RERo?=
 =?utf-8?B?YmZxOGNzVGM4VFkyL25EdFo2VGFKSUtDVmJxdGxXbVVPYVRkcjhZMURWU3Zu?=
 =?utf-8?B?dEtPMHRzYVlzb0tYT3FXQjlxN1NmNExVbWx1S012cXhPN01lMjNtRnJUa2U5?=
 =?utf-8?B?azNydFBjV1VvWGlUMXBxbEJPUXJBZUVLWGNzMFZFYXhKWTdQMWU1Y0V4b052?=
 =?utf-8?B?K3RSRm5QRlhBVHZKVVJHVFl0UWNFNjRxOFlhaHVrS0JNcUZlZ1BmMVNucVZm?=
 =?utf-8?B?Uk4wK1JtTDBvbnN5RHdGb1RzckxTa3d2YzBUNmt3TW5rbERNR0lTeExBPT0=?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA0PR10MB6425.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(1800799015)(376005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?UnhrSmxHUzZzK216Y01iNE8rVkZZM0JVWmNVZ3JzdFd3dFFDcnpxU3o3bi84?=
 =?utf-8?B?dGRGOEJhZjFveUVYb09ZbGlUczk1N0xmV29wbnp4ZzJSemhFTENrd1gxRTB3?=
 =?utf-8?B?RUVTVTJYcmtPRW5BeS9CMlJJMjc4Z29xa0R2TDRDVVBVSkJoc2ROYnRVcVNY?=
 =?utf-8?B?SXFqSFd2Mm85Y2tCa0IyQTVXU1FxejVnZ05LTGJtV1dsMHhUcHl6bERDZXNL?=
 =?utf-8?B?VHBhSkJXWUp4RkdubWJyMXdWa3ovUGFkNDlyM29acnBmWFNYTjA0dzdCSFhw?=
 =?utf-8?B?Tm4wa0VBajJJenNVaUpvZ08rSDZoeFFnZGNhMFB6aUNHdVJUbXA0YWNlMGFs?=
 =?utf-8?B?L0JPbkhkQWx1M1E4NWVFTFByeCtlTitqaWpSMlFYb1ZKUDFvTWxsYytuejZV?=
 =?utf-8?B?QmpLSzBCTUhIOWJQUGMxRHQ1RE9tckE0WXVTWTJmay9IcHk3MGRMbTFPWGJJ?=
 =?utf-8?B?eERESDgyVFd6YjlxSHhMcTNMQzFHZzg0ZlkxTnZ1OUdyd01ZVUZGNTZMWmlF?=
 =?utf-8?B?dG12R2VSNkhKV1JZQXI5MmZ1Mk40Yjd2aEl4UWEzQXoxNTJVZVVObm5qZVBC?=
 =?utf-8?B?YUJHWDIva3YzOHlQV1k3QXVxbldsUjZKVVpEcHFhVDMwaEhDWTJaQTRXR2FD?=
 =?utf-8?B?VmZtWm1oeWwzNWVXYm5IRDdYcE9EbSszNWVycVB4Z2JnTDl6MmwrUjdCNVlM?=
 =?utf-8?B?ck12bG4raDNCa3BrclVPRldsWFdHd3dWSEwwSS8ya1VtWXk3elduSysza0x0?=
 =?utf-8?B?ZHUwenZwT1MvT1dVZnVacEJiOCs3UmtKbEJtaWdXcGhGSjdmT3VoQ1kwek9z?=
 =?utf-8?B?ZkdKOTRlOVJ5SXptZ0VJZENBR3lVeSt0c0J5aXVQelQyV2V3dGZqWjFpRHJs?=
 =?utf-8?B?MEJwbmhLSmtYZGVQaVIwMmFEa2o3UTR2ODZ1Y0tXSi9UMjZraHBUU1U5U213?=
 =?utf-8?B?b0dmTVoweVFabC8relFkTk1za1VxWXJuRFBkekZIZXlDYm1aWWJ5N0hueXFG?=
 =?utf-8?B?QnByWUxqeXByUkNtQlZhbyt5VXpHUEdrN0JhdGVUenRwVmh2Tm1QclFpZHo2?=
 =?utf-8?B?bFlqbFg5cThmbFhZSm5CYUlmRWxSVEtrTFhXUEo2NDdYQ0l6VW9TaUd0elBS?=
 =?utf-8?B?a0pNdTNJWTJ6TWNGeHBtUXUySVFWVWRjRFdRenA1UUxKb0xoWExvQktBeHJ5?=
 =?utf-8?B?OG5HV1g2eUlIV3owVXFBeFZPY0E0d1AwMmVNQktaUVRKWSt6dldBSjh5RSsx?=
 =?utf-8?B?R1RPaGp3dlVraENoV1ZhY0Z1VXZrMHY0TndHbU92NmN5bU5LVWRZdkhGZlY5?=
 =?utf-8?B?RThIajBBYnNqcDlhWEM4NGRpWERYUmgrZWtKVGxmaXJDUU9venVtRVVGN2lS?=
 =?utf-8?B?TjBqSyt0OTkyZ1h2Sk5LenVkMG1pTlJ4aWsvY1dVc3FNa0M0OHduMnNPVDdL?=
 =?utf-8?B?YlBZZ3dJNkV6dUNjb3k5eEx0WGp6emdUYnUvMEE4Ym1rRmcrQ0xrazNPMGNT?=
 =?utf-8?B?QnZqRFZRK0NidDRCcGVDaXJnd0FMVzNDSVcybHdaaXlWbkg1MlhMZFoyL3Ax?=
 =?utf-8?B?eFRlcUtiSFlhdDFIVUNGOWc5dlE5dUdLSHZwcWVJL0M5R2x3aTIrZUhQMkt1?=
 =?utf-8?B?OUNHYlJHZzgyVkhtL3FYejJsVmdra25RSG9JaGtmQ0FQNitCNWMxQ1FrbGV0?=
 =?utf-8?B?T1oyQ1ZSdjVYY283OHBlVFZlQWNPSHFwV2laYTI2ZzdQY3VsdmFHWFpYd1NF?=
 =?utf-8?B?SEc0blF6V0NDMjByS2NqWTV5dkM2R2lGVElDRmR2Tk9BSDExVDVKc2ZuVE8w?=
 =?utf-8?B?NXZ5MTZzR3dSQU8wWituaVRtaThnNVRmaTNhTjk1cEM4anVyblo3MndxRzV4?=
 =?utf-8?B?ZUxRdktqZkNCS1dEOXNneW9MdWhyYldkRUxjV0xvdkVCMFlialZ3cDJ5amdr?=
 =?utf-8?B?WlR2QXN4RTNMS0VNdUZ5WEhlekM1b3pKY0psR0xGc3NyaGZSNThEeElydS9j?=
 =?utf-8?B?d290dXlzdW9qQ2VwdWRxMmdJelZ6NzQwVkV6SDZuamR1VFFNTFllNjBIdWtw?=
 =?utf-8?B?eTBqeGhYSFpBZXdmeGlMbElRc1BOMWl1ckVLNW15MDJDMExHbExvSC85bnhk?=
 =?utf-8?Q?c9nqilRzRJPq4WQdhAp0DEzhK?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	iTnKavBJfNk+g9kdXeQ3Rv7YGqIlGSk3g+M/eEfRejwdgxKbMGm5glH0JjZKq8fTwe7zaOKzze4SOItzYpZ72/UxMYZPSlbD9Sm9dhmet8h4vGdgP75SXkHazbAP4PK3GYUejRoDoGy4OkFMQR3/7V1p+P31JJOqPbw+XTDPrGqmP6MhOK4gaWKkDgzHEufK8I3RlMKkUb/hXChStYcOMr90pgQl+2gMryyMFBtO1x7Sc1Y010vhqVU/mNQw+hAElihQYiGOEgUNNSFq6nuy2dMHPfHZXnAbyTZmc/CjZcjItfRJFgdenENPZ1CFHiCnhg/T9e372yOUDaiDgYFJvH7Mz01rHDDazZixdqHtV5epTEU8UTHfKUaCvlT8LjHgIm/R4MgLYy+cHpLslYJ+WsZBkNO9+jk3xBVvwarAPOJbbXArKlm2EDK549nyK7nPJGtGZddCwgik8w1OmjESrxwGEWBAMwB+ifnrwX7bUAJmxoCWTdJsPccbacLo4+0JEj7gDIn/xt3T7/qIogn5PSe7il4x5df766U64N8PbvBpEA9mFFEtrm1jCoSVoNhJQfax+kn3WtO3ydmDrDcI/DFhGVWXloOssrsxFdDazKs=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5ba45784-2876-4603-9f1b-08dc73744081
X-MS-Exchange-CrossTenant-AuthSource: SA0PR10MB6425.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 May 2024 17:43:51.7264
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OuA/9NNt2k076X2qy/EALTdMj11K8dh7UU6maWXqMfXkcNxvyheeQjOrLUxC9EGQMGB8OKXbkU23tR2ERx1SBA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR10MB5003
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-05-13_12,2024-05-10_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 adultscore=0
 mlxlogscore=999 phishscore=0 malwarescore=0 suspectscore=0 mlxscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2405010000 definitions=main-2405130117
X-Proofpoint-GUID: GW0wYmFQdxtYJBhz-dmjRgGvFKstORBX
X-Proofpoint-ORIG-GUID: GW0wYmFQdxtYJBhz-dmjRgGvFKstORBX

Hi Thomas,

On 5/13/24 5:44 AM, Thomas Gleixner wrote:
> On Fri, May 10 2024 at 12:06, Dongli Zhang wrote:
>> The absence of IRQD_MOVE_PCNTXT prevents immediate effectiveness of
>> interrupt affinity reconfiguration via procfs. Instead, the change is
>> deferred until the next instance of the interrupt being triggered on the
>> original CPU.
>>
>> When the interrupt next triggers on the original CPU, the new affinity is
>> enforced within __irq_move_irq(). A vector is allocated from the new CPU,
>> but if the old vector on the original CPU remains online, it is not
>> immediately reclaimed. Instead, apicd->move_in_progress is flagged, and the
>> reclaiming process is delayed until the next trigger of the interrupt on
>> the new CPU.
>>
>> Upon the subsequent triggering of the interrupt on the new CPU,
>> irq_complete_move() adds a task to the old CPU's vector_cleanup list if it
>> remains online. Subsequently, the timer on the old CPU iterates over its
>> vector_cleanup list, reclaiming vectors.
>>
>> However, if the old CPU is offline before the interrupt triggers again on
>> the new CPU, irq_complete_move() simply resets both apicd->move_in_progress
>> and apicd->prev_vector to 0. Consequently, the vector remains unreclaimed
>> in vector_matrix, resulting in a CPU vector leak.
> 
> I doubt that.
> 
> Any interrupt which is affine to an outgoing CPU is migrated and
> eventually pending moves are enforced:
> 
> cpu_down()
>   ...
>   cpu_disable_common()
>     fixup_irqs()
>       irq_migrate_all_off_this_cpu()
>         migrate_one_irq()
>           irq_force_complete_move()
>             free_moved_vector();
> 
> No?

I noticed this and finally abandoned the solution to fix at migrate_one_irq(),
because:

1. The objective of migrate_one_irq()-->irq_force_complete_move() looks to
cleanup before irq_do_set_affinity().

2. The irq_needs_fixup() may return false so that irq_force_complete_move() does
not get the chance to trigger.

3. Even irq_force_complete_move() is triggered, it exits early if
apicd->prev_vector==0.

The apicd->prev_vector can be cleared by __vector_schedule_cleanup() because
cpu_disable_common() releases the vector_lock after CPU is flagged offline.

void cpu_disable_common(void)
{
    int cpu = smp_processor_id();

    remove_siblinginfo(cpu);

    /* It's now safe to remove this processor from the online map */
    lock_vector_lock();
    remove_cpu_from_maps(cpu); ---> CPU is flagged offline
    unlock_vector_lock();      ---> release the vector_lock here!
    fixup_irqs();
    lapic_offline();
}


Therefore, the bugfix may become something like (just to demo the idea):

diff --git a/arch/x86/kernel/apic/vector.c b/arch/x86/kernel/apic/vector.c
index 185738c72766..247a53fe9ada 100644
--- a/arch/x86/kernel/apic/vector.c
+++ b/arch/x86/kernel/apic/vector.c
@@ -1035,8 +1035,6 @@ static void __vector_schedule_cleanup(struct
apic_chip_data *apicd)
                        cl->timer.expires = jiffies + 1;
                        add_timer_on(&cl->timer, cpu);
                }
-       } else {
-               apicd->prev_vector = 0; // or print a warning
        }
        raw_spin_unlock(&vector_lock);
 }
diff --git a/kernel/irq/cpuhotplug.c b/kernel/irq/cpuhotplug.c
index 1ed2b1739363..5ecd072a34fe 100644
--- a/kernel/irq/cpuhotplug.c
+++ b/kernel/irq/cpuhotplug.c
@@ -69,6 +69,14 @@ static bool migrate_one_irq(struct irq_desc *desc)
                return false;
        }

+       /*
+        * Complete an eventually pending irq move cleanup. If this
+        * interrupt was moved in hard irq context, then the vectors need
+        * to be cleaned up. It can't wait until this interrupt actually
+        * happens and this CPU was involved.
+        */
+       irq_force_complete_move(desc);
+
        /*
         * No move required, if:
         * - Interrupt is per cpu
@@ -87,14 +95,6 @@ static bool migrate_one_irq(struct irq_desc *desc)
                return false;
        }

-       /*
-        * Complete an eventually pending irq move cleanup. If this
-        * interrupt was moved in hard irq context, then the vectors need
-        * to be cleaned up. It can't wait until this interrupt actually
-        * happens and this CPU was involved.
-        */
-       irq_force_complete_move(desc);
-
        /*
         * If there is a setaffinity pending, then try to reuse the pending
         * mask, so the last change of the affinity does not get lost. If



That's why I modify only the __vector_schedule_cleanup() as it looked simple.

I will fix in the CPU hotplug interrupt migration code.

> 
> In fact irq_complete_move() should never see apicd->move_in_progress
> with apicd->prev_cpu pointing to an offline CPU.

I think it is possible. The fact that a CPU is offline doesn't indicate
fixup_irqs() has already been triggered. The vector_lock is released after CPU
is flagged offline.

> 
> The CPU offline case in __vector_schedule_cleanup() should not even
> exist or at least just emit a warning.
> 
> If you can trigger that case, then there is something fundamentally
> wrong with the CPU hotplug interrupt migration code and that needs to be
> investigated and fixed.
> 

I can easily reproduce the issue.

1. Create a QEMU VM (12 vCPUs) with virtio-net, and 8 RX/TX queues (16 vectors).
Triggered active iperf3 multiqueue workload.

2. Affine all 16 vectors to CPU=11, and sleep 1 second.

3. Affine all 16 vectors to CPU=10.

4. Offline CPU=11, and sleep for 2-seconds.

5. Online CPU=11, goto step 2 in a loop.


After hours, the CPU=11 has many un-reclaimed vectors.

# cat /sys/kernel/debug/irq/domains/VECTOR
name:   VECTOR
 size:   0
 mapped: 47
 flags:  0x00000103
Online bitmaps:       12
Global available:   2302
Global reserved:       7
Total allocated:     122
System: 38: 0-19,21,50,128,236,240-242,244,246-255
 | CPU | avl | man | mac | act | vectors
     0   198     1     1    4  32-34,48
     1   198     1     1    4  32-35
     2   198     1     1    4  32-35
     3   199     1     1    3  32-34
     4   199     1     1    3  32-34
     5   199     1     1    3  32-34
     6   198     1     1    4  32-35
     7   200     1     1    2  32-33
     8   199     1     1    3  32,34-35
     9   198     1     1    4  32-33,36-37
    10   198     1     1    4  32-33,35,41
    11   118     1     1   84  32-49,51-110,113-115,117,119,121


I will fix in the interrupt migration code.

Thank you very much!

Dongli Zhang

