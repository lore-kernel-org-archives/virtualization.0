Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9024A45034
	for <virtualization@lists.linux.dev>; Fri, 10 May 2024 19:12:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715368338; cv=fail; b=ZCsecTnk5Qx2xLowGIDX0ltlmIEU/9fP4VlO3g1iHymAmVOyhvZfYl3Qa3QabfjKtQGRyB4ar8YiPFHb6QonEdcUYykY+gOHyIyGBoodQMCXv90cRjt6iWVWJhIjdo4UzYVmBCCsvEbXwpmg5iOjr/Mj7YG35NwOSeHUfsVj+Ks=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715368338; c=relaxed/simple;
	bh=HPvR1n+wOJdQBs9XxvHSXeRC69m44cX/uew3oQVCKnc=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=dZYRBMo55JFHF7RgjWAeVS+tWFamWa+wB11WAaWR7j38g1dVIcYW+V5eOdGzX/bKVieXqAMFP9Ou9cugQn+xOwrdjH9jkQjJbgfWljR93LjKAMV8jDxpYmVYgI7F94tv7QJDc9ddFPzpc/hjQES+jIBGjzqJyVLUtrxKxNe7Fok=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=Q4mt06JC; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=hFD5ykFQ; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Q4mt06JC";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="hFD5ykFQ"
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 44AI2X5L031689;
	Fri, 10 May 2024 19:11:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : content-transfer-encoding : content-type :
 mime-version; s=corp-2023-11-20;
 bh=sZIn7jNGX0lWEhyMs59As0EQSaT1V8jj6GfQtAqBTao=;
 b=Q4mt06JCfJDCq2pG2kHzxzyG9/85QJSm9Z/VDbWGAmN61IFjuKzkJb2xIYJGanHQs/Wj
 ULHyHI5Kx6sgCegq8dI4IjdUNpclQaZ5859/tmXimXuIWsl/rKyvQ8vNmb/H5k86yR+N
 x3LZFmO/eLxUG8p7KakO3kW+oepvSzMh4SvPVN+NAa1rPOv7Qjk6iEaKLB/fGoFa45Jn
 USbQbzpmYWet8QYVPlYfnKKICJo28q2aZjFZVc9i88iz9YUxVmRpD12M/jl/H6AF9u8B
 8Pvja+MDrS3DXU00T02JJBUZb5kEMNKBuLeOpH0VaUfP/C/yXPjY8jgJUAAQAxwAYoQy Eg== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3y1nfr8meb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 10 May 2024 19:11:38 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 44AHoXnS025085;
	Fri, 10 May 2024 19:11:37 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2101.outbound.protection.outlook.com [104.47.55.101])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3xysfq5s4a-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 10 May 2024 19:11:37 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fth0ktL3VAk5bZX1jq2uOwJKGUZuOP7oXgmzXSu1tMy5fw8W1Cwg9CDz0DklLuNtfIC/DfAVKxWZs2ZuVN992YzI8aZW64st18bYzBOs5iTp9Iv8c+6yomDJ/jHfLGZW+lZxjwtXgqzs/n7ichMdxxO2O0Qg1io5C78XcNhsFIcm9vorNBtvjezxDAXOREEVT6YFVodK8G88iiwJ6LrFlCSrh9aLYDgSMlxUrnMNv66mNYtbXbO5Xt72X/75lO0kKivy1ZdANM8gIr1Q51vKXjk/WBQMHPE5nxc0M5iENjijUNg9KKlQe9n6qxtXdPdlUFJ3il15KcLwoag+Dhfltg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sZIn7jNGX0lWEhyMs59As0EQSaT1V8jj6GfQtAqBTao=;
 b=a8uL9yFOSrlO8RWWcBga48QmJ3mu2Exs4+gYqIGycztE6iOsPMhn02JHu23LTNG1gxS/VSeeT4l3r1PwnEVkJmMUpnjY/sZV91EqZz4lxcetKU5iineQnNsMA7i+R1XgVgcZieiBuOSkwikW4o8XIeuIor6SzCIpLfYllRqti+L54dmhjN006dXcOnGmvDQjoJ/MiYgylX+/OFCkFR3M1VQaqWBB1Key7U9a0Z15rQzXBMlyPO2ZXBVuvx6f0i1KXD9edDLO45n3jANF9TgzwpeLlo3dGyKwvJAAWwd5pQS2VLYIzgzfnY4giA4tL0gbN3qU6w3yhz9ls2gCk99TKQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sZIn7jNGX0lWEhyMs59As0EQSaT1V8jj6GfQtAqBTao=;
 b=hFD5ykFQmTEihO4LSbsv4YwD6xbSPSrn4sZ61mCJTsQDgBehFUlrWSzaFUH66WuoLWdjFusdmKUBFuJrsqvKgeFa/tXG5fqeDytN5agbKy6pjDZF5ZmIRhKsgNEYd+uu4N5d1x2eh0HyQfxnCcIPmVlb5lId7shFp54/k3IqTIw=
Received: from SA0PR10MB6425.namprd10.prod.outlook.com (2603:10b6:806:2c0::8)
 by IA1PR10MB7113.namprd10.prod.outlook.com (2603:10b6:208:3fb::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.51; Fri, 10 May
 2024 19:11:33 +0000
Received: from SA0PR10MB6425.namprd10.prod.outlook.com
 ([fe80::447b:4d38:1f8b:28f1]) by SA0PR10MB6425.namprd10.prod.outlook.com
 ([fe80::447b:4d38:1f8b:28f1%5]) with mapi id 15.20.7544.049; Fri, 10 May 2024
 19:11:31 +0000
From: Dongli Zhang <dongli.zhang@oracle.com>
To: x86@kernel.org
Cc: tglx@linutronix.de, mingo@redhat.com, Borislavbp@alien8.de,
        dave.hansen@linux.intel.com, hpa@zytor.com, joe.jin@oracle.com,
        linux-kernel@vger.kernel.org, virtualization@lists.linux.dev
Subject: [PATCH 1/1] x86/vector: Fix vector leak during CPU offline
Date: Fri, 10 May 2024 12:06:23 -0700
Message-Id: <20240510190623.117031-1-dongli.zhang@oracle.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MN2PR16CA0044.namprd16.prod.outlook.com
 (2603:10b6:208:234::13) To SA0PR10MB6425.namprd10.prod.outlook.com
 (2603:10b6:806:2c0::8)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA0PR10MB6425:EE_|IA1PR10MB7113:EE_
X-MS-Office365-Filtering-Correlation-Id: efb45953-ea36-45a4-469e-08dc71250085
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|1800799015|366007|376005;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?BqwUhTV4Q34Oc4jHZvwr3/Kxs55qLszxPh6JPHdGMRdkKX8WHfqcEJtmbTdv?=
 =?us-ascii?Q?f/If0AOa0jON07v5HayShvGzzdf/AZ8NNiYr9wgjyE+/hwTuPePqLyo4c8mM?=
 =?us-ascii?Q?9ucI0GarkzUTovry3Rx/mhTrURrfqrBkDM9qlgPN23KwVKj4BmQbZ3n46ltB?=
 =?us-ascii?Q?m3fqa3WfiyYS88WL0dX5CbMWNvu3qO3QVd9pwjCsV8mWWDC60qamkGJzgY5n?=
 =?us-ascii?Q?TYEIDuhBcVHVE2kZZ7SHAvFNup5Anuq3tY8A3wpdpA2LLfiIVvfyF/GG0HLE?=
 =?us-ascii?Q?NroYHyQ+OOL0nIoFhad9BgDlhG/vaywoPFUgUTSO826kh4Pu1njNxTljqk3l?=
 =?us-ascii?Q?8bqbR6S/ju5+aJztyjH3C9zALs7iUbpVFH+2gIi1X3iQRzIRxfLAMbU7NoK0?=
 =?us-ascii?Q?/h0qX5YHRua5H13msBTeTVJc7oqtBV0ppipH5dUJR3noNZxTotAxL6osXIcP?=
 =?us-ascii?Q?ZUZwJO6ziso/6PUYhrL+z8vi0ccGLCGmvBOTpEFsu+kgz6+EtJ288jXsiMLr?=
 =?us-ascii?Q?uhAB9n+94Zk8SXCWuC09+3kCJvES2ZbNSy0F+R+Z4kTjkIyctVsSFVmCSmRn?=
 =?us-ascii?Q?NrB7Yv4hBdPwytB4/7sLaiYC8Nw8gRFEmwkXAq8fzMcogmAlcE5Xk6QITlnw?=
 =?us-ascii?Q?EwMyEEGIaG4N9K2poU1rx43jeOZEomSsmgW/ngGcZajHt+s0oYtAyFmpEtqz?=
 =?us-ascii?Q?EU5GkY/le8v/PgDl8MubF9mBUrV10nmQmARjKkKXx35l6bfXdCMkUqqLNoQ1?=
 =?us-ascii?Q?jzG2qOnpPOBTCy5I7nAphh66TQv9+e7fH0wSQ5m+ECu5mBNietlOZdB0gZLd?=
 =?us-ascii?Q?WdVRPsru7G55zaLNx8F27MePXnos8SjrQNk/8E5ldl43kYm9tZb3tqbKtyUd?=
 =?us-ascii?Q?bLsinD+Uzb0CWYmBnB4z0TBxpkgpQx/AV/IwfgndFu+/cgEzbWZjT+8h50Wk?=
 =?us-ascii?Q?ztF/iLSgimxeKrwoZg1xVSBD+QJncaWSlq4pfZWTXqP5uBXGvugPQHda+3gt?=
 =?us-ascii?Q?/kUO4/d3x1BOWmQ5lGKo/vP11FUKhudQlEf4BghtIUnuLfl6sL9GoJSfFYvK?=
 =?us-ascii?Q?k5IrFfhqRTKybyAiAo5w86KpM6iyZG4zPmDT0Wp+cVlDNXpArOV8F2UA0nY6?=
 =?us-ascii?Q?UVLQPgD/KhS2FhcLM7iJU1/+S+tPQ16RllD3gJB7+c3cUIyw2NEfC3YfT8Eb?=
 =?us-ascii?Q?lMLRDaHI8KejXWAaF4HQWRCwsVQc1nouI9kTQhTYlTnmICWGu5mlZz9B1OcL?=
 =?us-ascii?Q?71H/2AI7Bll5uOSJ9Twv1rAioK6nI/zf4TJ9+oeSng=3D=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA0PR10MB6425.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(366007)(376005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?DAjITnozhBWV80DBaf9ttLEtSkSYBQXblL0bQ+htYa4OMSoiL3rub1+REwVB?=
 =?us-ascii?Q?Wzrgi11v+DOzKWF0tGn44Pl4iFqQJv0QquPyQeDV95ifOx/8XVOxAmd//EcC?=
 =?us-ascii?Q?/8nB3m4dr8wlavCeeikSTeX7UEFZsLq1od/FtvM9CaeoMOTK0jPWZWPL/Y5+?=
 =?us-ascii?Q?w1ooMJItkZ2JstVqV1iCInIrB60fwrZ/5zKqefkb8TysBLXo6/Gkf4UGpTKc?=
 =?us-ascii?Q?wE7jOrxVoCHHvsYI/l5Zje2r92QBsvCrYagcaqW4pt1T9HI3ns0f9nnRbSm4?=
 =?us-ascii?Q?Wck3UjsLs2/B+6EpB1I9kxxgqDdjhrUjh5CTOnrDutlNOvXC6onSZhLlBKO+?=
 =?us-ascii?Q?e0kuFoMYucdwtbcaf+4QJqeQW1NTKQYvALvAIoy5I3TKnNd0iSWir9zIa5Yt?=
 =?us-ascii?Q?K61Lii8nMmcAr87HbiEPbJrhj97+e3jMkJQBm9ndeO0WacdzmL2yCnpMBIRq?=
 =?us-ascii?Q?QedDe107XzTwaEmeflT2B3XLniJHB8GE+OyWpe699eTQPagrRaiJowF8gsGa?=
 =?us-ascii?Q?mlI45Mbs4OCeQmZuUUfnn3lxfT0TEIw3NDCrDv75J6vGun0DoIF/1z3ne5tW?=
 =?us-ascii?Q?762SdJ72hQ1o8NrwMcs2KFVrNyROdU1TEl2wvXa3bEmTtZSjMvzvOkwhRnBE?=
 =?us-ascii?Q?Cm+YtHEHmD2Nt6bdFwQhbxQ/IUP3F3VINrVRSkT4knByBhkgoOy5urLbwuyn?=
 =?us-ascii?Q?GE5uga7Et96ODc20p36mX4Edtp0nuL6WSdDBF0CC/vzP5Sm9huQFxxqBg1KU?=
 =?us-ascii?Q?wlHmbTu8rOP1gmqQWdyeoCcpJIEt2IMTDZ6HqWxPinunGb0FzFVpz/KPG3ib?=
 =?us-ascii?Q?ArQCxu7l9TrKtrvvzwRojmNatHetuC3FXzy2aI5SROsMHI3cBeqK2YE4P1Or?=
 =?us-ascii?Q?RilrplM7eNiuuKdXzFyEGQXOE6Z7O/v8OncGQiQclFSz0lWezNwkFsWRrnW+?=
 =?us-ascii?Q?J+PE+6NtmEXUw+4B1o8Wgsnoq3eyPpMDg51p77KOal6iMjOeMFFUgmaS+TYU?=
 =?us-ascii?Q?FBIOtSPMuZmHBhmpBVfJBR4WCB/YgutzjeRBWuIvm9jePeIPmSAidqet6HDU?=
 =?us-ascii?Q?QrZqANcxk++ftAfQLil0d8MfjLfO8dvyZ/qWhpNin6lpuJdH+k9Uof5q9Vqv?=
 =?us-ascii?Q?8Oe+/HzPLwO2E5DKiqypuc1vAZHZFU1IsIDymNzQfbJX5OKbRtOzQaffRzly?=
 =?us-ascii?Q?j19ITL/OPe1SmCXCSMIZipabtE/jauLuPVTSItQMZtpoCjVcY4JTJ4BvI3cY?=
 =?us-ascii?Q?T4cP5KumJ78RuAuLpq8wVBA4oUVDcd9uYRVU/tOkaQDkjHiv3JwiWx9KZrHe?=
 =?us-ascii?Q?dNHdu8O3NfqdAxqVBGQmDcoZb9CZskzqU34HnCMfcS4M32ID+ALuHQygAq1J?=
 =?us-ascii?Q?78hirr1GdUmqIZGwmfdSDSKkAFh05Cw8oY7KkPQ/bc2cdfF92AR5YROXIJou?=
 =?us-ascii?Q?jiLEFh681acePEaqRbMjdTZ9TiofXjrRuaJmqxUvvcJJxUG5PpwkNdtV7415?=
 =?us-ascii?Q?2Znu9u+UJORlNHKKy1gWLatfupFIgnyg2AqAKSxsFZAnNTech37rkg+HyPtc?=
 =?us-ascii?Q?Y7JS19T5+fnYx9c5WnZt4jJj39jlPu/gPF+NyvRs?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	CO958NW/uBZPi6bgtioq4Xiq4YNyiCK1/m471jRhLdvnTD60rx1yddr1bB+L8LxnR4eNLZ1qXxgem+n6PWluvChI94Z++fOiIlW0g0uvuxFpLRcw6WsLjlM7K+v0oZmq10dwlL/wzPJ6/WgA9sPWui2Khrh3D2zID337zQZHxLaCsNNiT5rcG5sLAaDUo7aVnEVV7fCHw53zcQJaxJfbfkwAUIKjMDRDB4d/c+2EjefAePJFGursvHfCGfMyuOHVOZmUjoYOBSvmDrc0++1CmGMoeGXw9H7z5GdooykbzMCXv32xMJcKkQJ5VIzUm/CO1VUE5/7dJmPHH5PJKM5MgmWGcTMlignHHzs2mlLkBLU+7pRQrmljmlgBa3KflN/vJBQDSePLzutlEdjrctn6LdIYnfjj5Q+B4B8fWdDdtK+JtShXXkjxgcS3u5Bt+q6VjcmvFcwKYZfliYQS0UQbc+3os6KAiXOg1GFnX6QPZlG/rErVW4aWcqL3rD4sUJjY6ST9tYxywqoC/r/69e4Lbvglm/oxyHAiRHh61Mii4zv0OBT53wDSlEX5ddvilcACXDkbkk4oeuxU7qbSepncaHyDqDUaM2zJnjI9qm3bygE=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: efb45953-ea36-45a4-469e-08dc71250085
X-MS-Exchange-CrossTenant-AuthSource: SA0PR10MB6425.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 May 2024 19:11:31.8058
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TNxG3fvWjY+sEFFSxA8r3+wMPRiHiCurR+5A8ygkAvpWEI1q7Y28E0Qt2Dei3goWZUkHIrYm3Fl7C46bd1mgMg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR10MB7113
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-05-10_14,2024-05-10_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 phishscore=0
 suspectscore=0 spamscore=0 bulkscore=0 mlxlogscore=999 adultscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2405010000 definitions=main-2405100137
X-Proofpoint-ORIG-GUID: IOHuvzSYcqHGZuzSdoB72_iEW2nMAomr
X-Proofpoint-GUID: IOHuvzSYcqHGZuzSdoB72_iEW2nMAomr

The absence of IRQD_MOVE_PCNTXT prevents immediate effectiveness of
interrupt affinity reconfiguration via procfs. Instead, the change is
deferred until the next instance of the interrupt being triggered on the
original CPU.

When the interrupt next triggers on the original CPU, the new affinity is
enforced within __irq_move_irq(). A vector is allocated from the new CPU,
but if the old vector on the original CPU remains online, it is not
immediately reclaimed. Instead, apicd->move_in_progress is flagged, and the
reclaiming process is delayed until the next trigger of the interrupt on
the new CPU.

Upon the subsequent triggering of the interrupt on the new CPU,
irq_complete_move() adds a task to the old CPU's vector_cleanup list if it
remains online. Subsequently, the timer on the old CPU iterates over its
vector_cleanup list, reclaiming vectors.

However, if the old CPU is offline before the interrupt triggers again on
the new CPU, irq_complete_move() simply resets both apicd->move_in_progress
and apicd->prev_vector to 0. Consequently, the vector remains unreclaimed
in vector_matrix, resulting in a CPU vector leak.

To address this issue, the fix borrows from the comments and implementation
of apic_update_vector(): "If the target CPU is offline then the regular
release mechanism via the cleanup vector is not possible and the vector can
be immediately freed in the underlying matrix allocator.".

Cc: Joe Jin <joe.jin@oracle.com>
Signed-off-by: Dongli Zhang <dongli.zhang@oracle.com>
---
 arch/x86/kernel/apic/vector.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/arch/x86/kernel/apic/vector.c b/arch/x86/kernel/apic/vector.c
index 185738c72766..aad189a3bac9 100644
--- a/arch/x86/kernel/apic/vector.c
+++ b/arch/x86/kernel/apic/vector.c
@@ -1036,6 +1036,15 @@ static void __vector_schedule_cleanup(struct apic_chip_data *apicd)
 			add_timer_on(&cl->timer, cpu);
 		}
 	} else {
+		/*
+		 * This call borrows from the comments and implementation
+		 * of apic_update_vector(): "If the target CPU is offline
+		 * then the regular release mechanism via the cleanup
+		 * vector is not possible and the vector can be immediately
+		 * freed in the underlying matrix allocator.".
+		 */
+		irq_matrix_free(vector_matrix, apicd->prev_cpu,
+				apicd->prev_vector, apicd->is_managed);
 		apicd->prev_vector = 0;
 	}
 	raw_spin_unlock(&vector_lock);
-- 
2.39.3

