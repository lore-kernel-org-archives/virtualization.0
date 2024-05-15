Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0529F15ADA4
	for <virtualization@lists.linux.dev>; Wed, 15 May 2024 19:51:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715802708; cv=fail; b=FRw0fhAq157vEcCROIghNWayWZtMUK5ZaIc2JvQAav3TTt4PBOMoCtQCEqIbqvBixlF0eTHVuUcObAHaDg5hsvX1AirwyfO2BXr+FJ7hGPSUQI1+D9c9cgH86VID5Asy/p16mxGrAUsTCOI90/L9cgW7uaD+ZT6eajmLiQ6M8Rk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715802708; c=relaxed/simple;
	bh=aVQVLGqFdNw6cyl+jxSkzXm3ok22FRGFGpzGJ0404dY=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=GUQy79uZIS5BtyALtcNrvLBGxupti+NVL9/Qe7ALFpebhtz6qs4KDa9GdPBcdwmrksqOKOCA0EJQYSBpeUZUloshwob5ZVmm+ieB8oiD64a8sCFQa3NeJyr4p12+jemvuSM9ZVzunJbk1nl0yBx8RB4rOdWZoOw7AjdS2WuBpds=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=HYqfx8du; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=Tj5qaruO; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="HYqfx8du";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="Tj5qaruO"
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 44FHx5BH029697;
	Wed, 15 May 2024 19:51:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=OPjW8VFCCc6AKuH4dM3LsnPAEzwKfffEpYEtcWNVjyg=;
 b=HYqfx8dunPHBL9Xy9XqiPqfCkxd9WPXW7eqiGaX3qLHSBwnLOOHn1cwpHdJvR+zj7mmr
 hwbDHvyV1gtdShsgGRmo8SwXwWLUgME0/v4LJNN1O9zCgKw0/ydPZz61vf7E8zUzdFCO
 1lBug59A5qC90+1yO32cnVcUdZPGQff442wujF7qV5xdSwyDjKGUY5AsmRkkbwqeeuzb
 c32QeVbcMrXFoAVXq7iMSqacDOefI1CeQMmACJ6Yw3X/OLM1Dio7E+muKMy14ZWLVIwi
 X/o5pio3V/D9n+LHbyRqau4sAroQgQyPdxQ7/pWpYc/v2kp3tTMIMyAOYZ4naWXvR0Sk 6w== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3y3txc3xs4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 15 May 2024 19:51:22 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 44FIi1df019166;
	Wed, 15 May 2024 19:51:21 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2101.outbound.protection.outlook.com [104.47.58.101])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3y3r86thsu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 15 May 2024 19:51:21 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Y4JtQlPjQDCwWbrNYw12cI9dWoasbb1iSunzxUSxMx9zFOQeTTnglvUANHlwJ3lEoyMKpB1E8Sr4D7a/BcGA5EjxGljkH5qqrInPvXQqdMZfmxdf8xYJ2vgj426jmUWbJL122o6Utw0rQRO8MiMNoh/v/PVZAhQ3QicG/Yhw//SP8oGJT7GQvlgVcXcXq+BfxTPVZaL9xZJYA2lVigDsI3+zJrPkBnN66Ez3uxKOlI4h3hf1oNAnz//1u67/j+EH6LHDJMVWfM4L2F2il3Yhzzlprvtx1s0TP8YvcR0lfmvOUcM0pxenKRrocLKoDU/J68LF14o1l5yMfAkugrujwA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OPjW8VFCCc6AKuH4dM3LsnPAEzwKfffEpYEtcWNVjyg=;
 b=g3cMErMmdTBme521EkXISa83oT8wPavyhJG0kfhZWh63G1jdBXZXPRgpbtXfueJSB4nnCid30m/SJSJrMc9VlWhqGoVEpMo0Ewoj2UW+6R1dztAtkTVXdTEB3Xfqz9Ie5Q6FayPARstDGy7Ue+HxHrs3k8vHL0+ZLNvYrYmCNM44u2j8zWRDQ5FOWa9bJYj0PHh9i0DLXM61U5RcyrbPzxVVkPh2sUXKzikMfKsLOrh5Z5cmvLOW2TgiQLVbgZNUkP5HyQ0hu4Ltb6casLcXUlXh3I/kjpZLfLUWTUufbsdaQsdZ4AWg0mZ6ObWytydcfDJyrcRIogNTUf52hKcdEw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OPjW8VFCCc6AKuH4dM3LsnPAEzwKfffEpYEtcWNVjyg=;
 b=Tj5qaruORNvxdCuvzgKVkMr76J/nc/zE6GsC6/yBi5OlbfKZ0BHXglFGrG9f7qZTgReyEiUeL+rkGUhJelP6nmkEr86Y4pOurbUH+4cQexhts6YkiTYPobnmFcjqTdXiBbxtVIt1Bo5aCg5RxJTlw73y7etFTEBfKWcD+A4/4KY=
Received: from SA0PR10MB6425.namprd10.prod.outlook.com (2603:10b6:806:2c0::8)
 by CO1PR10MB4803.namprd10.prod.outlook.com (2603:10b6:303:92::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7587.27; Wed, 15 May
 2024 19:51:19 +0000
Received: from SA0PR10MB6425.namprd10.prod.outlook.com
 ([fe80::447b:4d38:1f8b:28f1]) by SA0PR10MB6425.namprd10.prod.outlook.com
 ([fe80::447b:4d38:1f8b:28f1%5]) with mapi id 15.20.7587.028; Wed, 15 May 2024
 19:51:19 +0000
Message-ID: <954040a2-435d-48d9-b5de-9ce46ffba238@oracle.com>
Date: Wed, 15 May 2024 12:51:17 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] x86/vector: Fix vector leak during CPU offline
To: Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org
Cc: mingo@redhat.com, dave.hansen@linux.intel.com, hpa@zytor.com,
        joe.jin@oracle.com, linux-kernel@vger.kernel.org,
        virtualization@lists.linux.dev, Borislav Petkov <bp@alien8.de>
References: <20240510190623.117031-1-dongli.zhang@oracle.com>
 <87msotnaow.ffs@tglx> <2b8e02cd-2f2e-4bf1-9332-6dde502c22b1@oracle.com>
 <87eda5mitw.ffs@tglx>
Content-Language: en-US
From: Dongli Zhang <dongli.zhang@oracle.com>
In-Reply-To: <87eda5mitw.ffs@tglx>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR08CA0038.namprd08.prod.outlook.com
 (2603:10b6:a03:117::15) To SA0PR10MB6425.namprd10.prod.outlook.com
 (2603:10b6:806:2c0::8)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA0PR10MB6425:EE_|CO1PR10MB4803:EE_
X-MS-Office365-Filtering-Correlation-Id: 4d013df4-f128-4986-4d6b-08dc751863a4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|1800799015|376005|366007;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?RGtDQkd1dGN6am8rdjJWOHA2MnZ2dW8yYVQ5eDh2ZXAyVHZuSlN1b2VmN3Bm?=
 =?utf-8?B?RWdKTUNoaDg3c3FzV2dKdmxibjhuNUJVTEVSR0ZIbWs2YlhoaCtWaUpiaTJH?=
 =?utf-8?B?Q0hwU1FXN3MrcnFrUVYra3ZTb3hVNyszMTBQemVmd0U4MWRLMnVRMXhnUEhp?=
 =?utf-8?B?d0RqbU5qV1M4K29yVjBEenlTSmw0ZDhQcllwZ29Kb0FtY2hhbllWTC9DNXVD?=
 =?utf-8?B?bzdjQ2Y0dWlUNkNOblJscjVnSWZhdytBdzB3VGhYUktuZUllajk3TXNSNnBE?=
 =?utf-8?B?YlY2TWtubGJ5ZWdSdEh1cVZ0c2VOZ2lwbHhlWFdzV0d5VXdCalloOVM3a3Jl?=
 =?utf-8?B?UlRFdzRBR2JmWEdKcDA5dVRnT09LMEpiSldnV2xpcjVTUnJTL3lMMTcxWGFD?=
 =?utf-8?B?SHJjMmJZRnVKSHE3cjNVMDF0SVN0V0UzVmt1TFQ5ZDY5Tng0azUxWXJITGhD?=
 =?utf-8?B?eWhYYlg4Vm43OUZiaklPMWl2emVwMml2ckljS1BEQnk5WUdkc0xScEhUelQx?=
 =?utf-8?B?TnZLVzhIUEs3M05SM3JEeTFFTDlaVGYyWWR2dzlvanMxMDBKQmZMTjBmR3g1?=
 =?utf-8?B?ck9IQnFVYWVWcVlCMms2QThnZ2g3VmgxU0tJaTRCTkVCS2lVV3hqY2ZhQUJi?=
 =?utf-8?B?eW5hWHBtKzI4cTRYVXhmaDlvbzBBWjR5MDAwQkFjUzhSc3FTYi9SanVZTXdH?=
 =?utf-8?B?K3I0bWF2V0lHYVc2U3Q4MEJpRjRmdlEzMEl4QllnZVRNNzc4MkNCTWw1S1g4?=
 =?utf-8?B?eEpYU1FrTnkwWlVBR0kxbThkUjQ0SmdVWjhYcFQ5bFk5MjlJNnRld3ZkT1pZ?=
 =?utf-8?B?UHpVMldTdWVxejZ1elJGUWFFSHUxYTAzcDEwL3NBVENPeG9ldUFtQUFrd1V4?=
 =?utf-8?B?anpDdk9pNG5PVnMwYklTKzFjNy9nb2x0eVAvNDlDRzZCei9mVkNCbkxIc1E3?=
 =?utf-8?B?aWhRMWZrSmhzRFFTbUNsZUdmVVYwcExubE1GK3pIZS80SzI3YmFXREY0MW50?=
 =?utf-8?B?Z2ttQmZQNjVrb0RjRjdZOGVrRnMxMlVpaFd1MUZVNHlZcUZmK09oTFE2MUJz?=
 =?utf-8?B?NUR2UGtBN3h4NXp4ejFaTUNvK2tCU0l2ZE04M0M1NHdlM01yTlhBOXhJcHNF?=
 =?utf-8?B?eittR3BWbzBqM284WWlhRmlqUndDU1RiYk91bk5qWDYzR1MzcVMrQ1F3aE5I?=
 =?utf-8?B?dXdrUStlUjEvbWU1d3JOVXdVRVRDaVc1elBFY1VKL2duYTF4SFVlZVJlVnNx?=
 =?utf-8?B?M1JtSno2VUtlVEk4aER5Zi9lbzZzY25udFdWcWc1amw2bTI3TW9zNGM3bGZY?=
 =?utf-8?B?cUtEaXdZaUN1QXFuc2RaUFpLMUNQVlE2K2ViZzhtVXhTTFZNWFlaUHQvVThl?=
 =?utf-8?B?MXdjN3NMV0s2U0FlL0dkN2xsU0tKc2pmOTlndXNHRjNNL005RkdWYmUrNGI2?=
 =?utf-8?B?OVdCRkpJMUFzcGhTRExoTXZoczdzWU5HWC9pamNyN0xuQ3lrRExFSGg2RHE3?=
 =?utf-8?B?Vk9oMEpmT21YSFBneTI3L2NEVWE3eHpWNVMralFaUE16dlE5eHRIdnlDQlU2?=
 =?utf-8?B?ZUpTdkxGMjd0MS95NGRwWU5EckdWbmxJejlGdXg5aWFyV25VdjJLV0ZuM0h5?=
 =?utf-8?B?czF0aDcrU0J0YkgrNlRubUtaM3dib3BSVmdDdjRTZHNPZnQ0R0YvWmplZUIx?=
 =?utf-8?B?R1pSR1lhSDNvcUxjclY2a3l2bjBQL1BPS1gwcnhyanhrRTBRMk5Rd3VnPT0=?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA0PR10MB6425.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(376005)(366007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?NVRMaUcyNkh2K0hydXowVGpTa0tJNW1xTmxIVWtXa21kd3hGSXFNVUdIUGs2?=
 =?utf-8?B?WFhnZkMrbmZrWTQ4dGNFcE5ZR2dkRm1GTk5wWERKZ0haeHVPckEvN0kzdWF6?=
 =?utf-8?B?SzMyWkxidWMrRVMza0RVUWpMaHA4S2Q2Qm9BQ212UEhkcGlPdGNSbUpuWVdD?=
 =?utf-8?B?SUg2b0dMdUFlTWQ1VDNPYi8vZlVVcElBQzJ3TEhGTXlqSm9Za2JCK1R5SnEw?=
 =?utf-8?B?VTVpYUhFUm1tTWJtc3I2ellHZWJhV0dtMmUxMVROUXpiNSt5dUQ5aUtBbHFh?=
 =?utf-8?B?ZUpHdlVxWTA4SWhySEtDcFBSVS9yNmxmaDgxT2l4UXkyN0NLazZwbEY5ZDVi?=
 =?utf-8?B?TGdNOW9kaHUvZm85a0Rxa0o5ajZRU3hhN25RMVNjbkN5MitQbHRXVHVab1Vq?=
 =?utf-8?B?bEoySEdQK2JoSnE4SmZRVTh0R2VtT3RRRTlJQXFvTWs3aFRIWUd4Vk9ad01z?=
 =?utf-8?B?NXdZWWpwbk1oYmNSd2Q3OGFoZkUrNElYZ1pPeUgzYlI2NUkrajhIelFZempi?=
 =?utf-8?B?QWQxU1RNSWpqTlVyajlibjRiVXUvaEpyQ0FUWGFweGlzVkZzZUlDSVdLazEv?=
 =?utf-8?B?QlduSlFpTng4bW9tWXYxOEpua0pJY3FwdEY4TkdIYmwzVUc2QTZZVDNsbjlN?=
 =?utf-8?B?bUNWOXpFMmI1WHhMMHF3eTJtb05uRU5jU2FJVzBOdHZFSTBkOHdJVldvUzh6?=
 =?utf-8?B?NVFTN3drMDBPNlpBdldpakgySjIvdTZlSFhTa1Brb002VHB2RHVzbUVEVFlu?=
 =?utf-8?B?ZEh0aStaY3dtVTRjWjZQc3drR00za3NoWUxzbHZNVHRDTHExRTI4eWRGMVh5?=
 =?utf-8?B?Mm9zVm8xOW0xdVRnMkI4Ri81RllUOEtRc1l6S2Y1TEt0VWNRMFYwVExHWlRy?=
 =?utf-8?B?YngwdC95MlBNelVkZTY2YVEyQ3U4OE1jaXhpVFhCMkI4aENuRVNpZXFIS2hP?=
 =?utf-8?B?YWVqUDBKWm5uVHdUM29CMkZTb29hSDNjbG44eTFoOHhPR2MyWjZSQ21BMy9U?=
 =?utf-8?B?TnBLM1N5b0lvalpjZk1SOWJUMDUwU0QyV1ByUjg2WHlaelJWaTBQd3kxTjd3?=
 =?utf-8?B?MnBPS2VTM0FrUGdhK3JnOHFwbTJHemJtVGd3S0VWUWpXZGZoY1g2TWtZdVNr?=
 =?utf-8?B?SHZCU0xYTllYc1IzZDNTRkJVK1pwWGduV0xZRUhxQnJlREpSeXN6aXNJM2pn?=
 =?utf-8?B?c3dPNUN2YW9NM1gyTzZhc1Z6MmJ1S0ZKNVkva01qVTNlNk1qT1ZqOWVLQjBU?=
 =?utf-8?B?LzlDVk9BdWVhaHlPT0pLSS9VLzNzTnV3SGhRbjNzUTRkZnhrendHZmM3Y3lk?=
 =?utf-8?B?VVR4WTVXSzdZMUdlNTdoNmNaWUFhSW1POXlsVDl3Sk50NWQ1Y01SSFp2eGlj?=
 =?utf-8?B?NXBoYS96c1hubXdFL0hjbEVibFBvWmR4Q1M5bVlsdi9GM3BTdjJPYml4MXRN?=
 =?utf-8?B?dFgyY2JCK0I1WGZBc0VReVM1UkdDdGpiODFJdHZGdUx2b0NEbk5mc2VsQnhz?=
 =?utf-8?B?aWl4ZHJtSStkUXRLZlcyTjUwRktXY1prTGRlUDR1NEgydFFldG95TnFwMkZx?=
 =?utf-8?B?eDQrdlkwU0VVK1BTRXFPTXVoZUxXN1lUZVg5OEpyckVBdVhIYzV3T3lXWEIx?=
 =?utf-8?B?UFk4VnJObkJtVGJUb3RSSW12Rm9qaVp6VmlGOEpRajFtOVlXdktNamUvK2RJ?=
 =?utf-8?B?dmZsVkhSTmFFeGtCdVFQTE95MUp0bjZ3MHRia1VnQ0t3L0hNQkRERExzZllr?=
 =?utf-8?B?eEhUNFA1YjNISE9yK2dhTFlCYmpSYzYrdzZHaWlORnJ5K1hxZ3ZxL2Zmd1o4?=
 =?utf-8?B?K1JiaTVmWGdtSDZsQ2pWMDBpdS9ZWjY1QS9zcEtKRjBmNG1ka0VxR2RsbzY5?=
 =?utf-8?B?Q3dSLzQxTkFRSTVjNkRlM1hMZm5rbHpVVFlaOUp6QU9WUUEwS2VlZGtwTGVj?=
 =?utf-8?B?dW5RNTgybG1ZVU1tRzZuMGx6Ni94eW5oWndsZW1jYVZWY0o0eSt3eGdjTzl0?=
 =?utf-8?B?UjY5VitIbXMvRjBWUFlPSXhIYkQ3YXVNWEpyVmlXS2VqRmYzd2plSGxYUzVI?=
 =?utf-8?B?bXNGSGp1aTVpZTVrTTJHQjRqTUQ4YjQ3ZHZJY0k2bU1NSXpneE9YQmtlSE5z?=
 =?utf-8?Q?zulEzwBZ6qaP2SMCHi2z2ma9g?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	V0lWN3auG3XWP3+JRYJy9c0fw1dx/2zerSZQLRMEkSqe1xrFyYMUxkyhdWOJBgGhYXgn8RkYKnc5TbVZx8uJ7EFH2sfa7W2BWcdnGZjV43XLLZ5jA8t0D9l3E+f7wsXcM7TQoBFS/Mu0OJ0Zo4U++Tp3oGyXrv26yBcKzFGMgWodacbCRydE8pMVXMWQMZiBerydiFAYRRrjAatglKiVlZUngJ8Q3mI66OiBgA3zRFZ1Zq31TFTfnmY7hZDPACDy7RrwJZFo0DUXf1Q1a/Yj457XsXeKR8zUN10xwesDBfc7XaIe+/jRCmjOUl7GiXoNiIdNWVCgPR3VkoJO8Hbnr458yp7U9eJa7r1TTX1Hugu82R0tyaYIPPzbqcgDILz1R0mrRwqD36FDlRhHiuuwnGm4ilKBrCQ/AfqKVSSV0HJqhSkVl4N/V5qSGd7TNC0/+QYfgwIRqJvf4LAPVzg1FYF+rVdEV768JT4+l67UvqxmfnLEPWn6z9cAuj+mmeBtvXtMwl+XHl0TZOqNcmdiD4+muvpPlbdShzzrKIRigIM01fmSIvU4SvlCjahmPH/YDDYD2/6wge3Mu/pbWR5OudcCSVg+yHb7bbEolmeBZ8o=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4d013df4-f128-4986-4d6b-08dc751863a4
X-MS-Exchange-CrossTenant-AuthSource: SA0PR10MB6425.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 May 2024 19:51:19.2208
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AXL7WWzIINOrZlncIpzLVh0eLA56CycVF9Gj1AyTLEu+bnBnuyRVAR5DZpvXrmGjQ1WlypuVCLWgVkump8hSyg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR10MB4803
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-05-15_12,2024-05-15_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 bulkscore=0
 mlxlogscore=999 spamscore=0 suspectscore=0 mlxscore=0 malwarescore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2405010000 definitions=main-2405150142
X-Proofpoint-GUID: kn-b0itJfs_3HES53Rvi-n7HTzyqyPdz
X-Proofpoint-ORIG-GUID: kn-b0itJfs_3HES53Rvi-n7HTzyqyPdz



On 5/13/24 3:46 PM, Thomas Gleixner wrote:
> On Mon, May 13 2024 at 10:43, Dongli Zhang wrote:
>> On 5/13/24 5:44 AM, Thomas Gleixner wrote:
>>> On Fri, May 10 2024 at 12:06, Dongli Zhang wrote:
>>> Any interrupt which is affine to an outgoing CPU is migrated and
>>> eventually pending moves are enforced:
>>>
>>> cpu_down()
>>>   ...
>>>   cpu_disable_common()
>>>     fixup_irqs()
>>>       irq_migrate_all_off_this_cpu()
>>>         migrate_one_irq()
>>>           irq_force_complete_move()
>>>             free_moved_vector();
>>>
>>> No?
>>
>> I noticed this and finally abandoned the solution to fix at migrate_one_irq(),
>> because:
>>
>> 1. The objective of migrate_one_irq()-->irq_force_complete_move() looks to
>> cleanup before irq_do_set_affinity().
>>
>> 2. The irq_needs_fixup() may return false so that irq_force_complete_move() does
>> not get the chance to trigger.
>>
>> 3. Even irq_force_complete_move() is triggered, it exits early if
>> apicd->prev_vector==0.
> 
> But that's not the case, really.
> 
>> The apicd->prev_vector can be cleared by __vector_schedule_cleanup() because
>> cpu_disable_common() releases the vector_lock after CPU is flagged offline.
> 
> Nothing can schedule vector cleanup at that point because _all_ other
> CPUs spin in stop_machine() with interrupts disabled and therefore
> cannot handle interrupts which might invoke it.

Thank you very much for the explanation! Now I see why to drop the vector_lock
is not an issue.


[snip]


> 
>> diff --git a/kernel/irq/cpuhotplug.c b/kernel/irq/cpuhotplug.c
>> index 1ed2b1739363..5ecd072a34fe 100644
>> --- a/kernel/irq/cpuhotplug.c
>> +++ b/kernel/irq/cpuhotplug.c
>> @@ -69,6 +69,14 @@ static bool migrate_one_irq(struct irq_desc *desc)
>>                 return false;
>>         }
>>
>> +       /*
>> +        * Complete an eventually pending irq move cleanup. If this
>> +        * interrupt was moved in hard irq context, then the vectors need
>> +        * to be cleaned up. It can't wait until this interrupt actually
>> +        * happens and this CPU was involved.
>> +        */
>> +       irq_force_complete_move(desc);
> 
> You cannot do that here because it is only valid when the interrupt is
> affine to the outgoing CPU.
> 
> In the problem case the interrupt was affine to the outgoing CPU, but
> the core code does not know that it has not been cleaned up yet. It does
> not even know that the interrupt was affine to the outgoing CPU before.
> 
> So in principle we could just go and do:
> 
>  	} else {
> -		apicd->prev_vector = 0;
> +		free_moved_vector(apicd);
>  	}
>  	raw_spin_unlock(&vector_lock);
> 
> but that would not give enough information and would depend on the
> interrupt to actually arrive.
> 
> irq_force_complete_move() already describes this case, but obviously it
> does not work because the core code does not invoke it in that
> situation.
> 
> So yes, moving the invocation of irq_force_complete_move() before the
> irq_needs_fixup() call makes sense, but it wants this to actually work
> correctly:
> 
> --- a/arch/x86/kernel/apic/vector.c
> +++ b/arch/x86/kernel/apic/vector.c
> @@ -1036,7 +1036,8 @@ static void __vector_schedule_cleanup(st
>  			add_timer_on(&cl->timer, cpu);
>  		}
>  	} else {
> -		apicd->prev_vector = 0;
> +		pr_warn("IRQ %u schedule cleanup for offline CPU %u\n", apicd->irq, cpu);
> +		free_moved_vector(apicd);
>  	}
>  	raw_spin_unlock(&vector_lock);
>  }
> @@ -1097,10 +1098,11 @@ void irq_force_complete_move(struct irq_
>  		goto unlock;
>  
>  	/*
> -	 * If prev_vector is empty, no action required.
> +	 * If prev_vector is empty or the descriptor was previously
> +	 * not on the outgoing CPU no action required.
>  	 */
>  	vector = apicd->prev_vector;
> -	if (!vector)
> +	if (!vector || apicd->prev_cpu != smp_processor_id())
>  		goto unlock;
>  

The above may not work. migrate_one_irq() relies on irq_force_complete_move() to
always reclaim the apicd->prev_vector. Otherwise, the call of
irq_do_set_affinity() later may return -EBUSY.


 801         /*
 802          * Careful here. @apicd might either have move_in_progress set or
 803          * be enqueued for cleanup. Assigning a new vector would either
 804          * leave a stale vector on some CPU around or in case of a pending
 805          * cleanup corrupt the hlist.
 806          */
 807         if (apicd->move_in_progress || !hlist_unhashed(&apicd->clist))
 808                 return -EBUSY;


Or maybe add a flag to control whether to enforce a cleanup in any conditions?

-void irq_force_complete_move(struct irq_desc *desc)
+void irq_force_complete_move(struct irq_desc *desc, bool always_force)
 {
 	struct apic_chip_data *apicd;
 	struct irq_data *irqd;
@@ -1102,6 +1103,9 @@ void irq_force_complete_move(struct irq_desc *desc)
 	if (!vector)
 		goto unlock;

+	if (!always_force && apicd->prev_cpu != smp_processor_id())
+		goto unlock;
+
 	/*
 	 * This is tricky. If the cleanup of the old vector has not been
 	 * done yet, then the following setaffinity call will fail with

... and call irq_force_complete_move() at different places?

@@ -79,6 +79,11 @@ static bool migrate_one_irq(struct irq_desc *desc)
 	 * interrupt.
 	 */
 	if (irqd_is_per_cpu(d) || !irqd_is_started(d) || !irq_needs_fixup(d)) {
+		/*
+		 * Complete an eventually pending irq move cleanup if this
+		 * interrupt was affine to the outgoing CPU.
+		 */
+		irq_force_complete_move(desc, false);
 		/*
 		 * If an irq move is pending, abort it if the dying CPU is
 		 * the sole target.
@@ -93,7 +98,7 @@ static bool migrate_one_irq(struct irq_desc *desc)
 	 * to be cleaned up. It can't wait until this interrupt actually
 	 * happens and this CPU was involved.
 	 */
-	irq_force_complete_move(desc);
+	irq_force_complete_move(desc, true);

 	/*
 	 * If there is a setaffinity pending, then try to reuse the pending


Thank you very much!

Dongli Zhang



