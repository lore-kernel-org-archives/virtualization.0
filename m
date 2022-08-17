Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 101A1C25B08
	for <virtualization@archiver.kernel.org>; Wed, 17 Aug 2022 18:49:09 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 749FC82925;
	Wed, 17 Aug 2022 18:49:09 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 749FC82925
Authentication-Results: smtp1.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.a=rsa-sha256 header.s=corp-2022-7-12 header.b=VcebPvdB;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.a=rsa-sha256 header.s=selector2-oracle-onmicrosoft-com header.b=YU2t+CFW
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 8vBsUiyI5ml4; Wed, 17 Aug 2022 18:49:07 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 2B7B6830E2;
	Wed, 17 Aug 2022 18:49:07 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 2B7B6830E2
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id DEF9CC0032;
	Wed, 17 Aug 2022 18:49:06 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 6EC81C002D
 for <virtualization@lists.linux-foundation.org>;
 Wed, 17 Aug 2022 18:49:05 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 4518B60E2F
 for <virtualization@lists.linux-foundation.org>;
 Wed, 17 Aug 2022 18:49:05 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 4518B60E2F
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com
 header.a=rsa-sha256 header.s=corp-2022-7-12 header.b=VcebPvdB; 
 dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com
 header.i=@oracle.onmicrosoft.com header.a=rsa-sha256
 header.s=selector2-oracle-onmicrosoft-com header.b=YU2t+CFW
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id rfGZ-RvF5CPg
 for <virtualization@lists.linux-foundation.org>;
 Wed, 17 Aug 2022 18:49:01 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 60F8E605E0
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com
 [205.220.165.32])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 60F8E605E0
 for <virtualization@lists.linux-foundation.org>;
 Wed, 17 Aug 2022 18:49:00 +0000 (UTC)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 27HIZR3Q015322;
 Wed, 17 Aug 2022 18:48:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=content-type :
 message-id : date : subject : to : cc : references : from : in-reply-to :
 mime-version; s=corp-2022-7-12;
 bh=Z3N/ScMJjziQ8o7G3wzpdYlPToH8Vi8ytaZY6JQn1Ms=;
 b=VcebPvdBz1u+aFNWY9GSx+NQxZ8nquMR6nMpPbonL0c8nSn+kNmSA1t3GaVWM8pW9S84
 Kp0Nel6/BRbzeAWBeR5lb1l0wkgyLQe+qkZ4vmuWEghp0nfVJhWaXHMOd0weMBHkWuHF
 NQYZnrmEQmjXR/Xbyzf70ML1qywaj1z8so/iZcfXS5h4q4iCZNw3Vwcn14tYQCWlpXg2
 qxDP0BvtAPy7jMpzYs3dKKnPnI6kvqrBbV/bmEBRuomcrVJBgRi7xXrCbhuYSJKpUCEN
 Qcqvo6Y0WF0Mp36pJt3HaeAAx/tl8qbbr80NfWKMMuIMCrd6sedwTa0ap+4V8V44Q0Mi tg== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3j15r4g1c7-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 17 Aug 2022 18:48:54 +0000
Received: from pps.filterd
 (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5)
 with ESMTP id 27HHAG3S021633; Wed, 17 Aug 2022 18:48:53 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com
 (mail-co1nam11lp2175.outbound.protection.outlook.com [104.47.56.175])
 by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 3j0c483c0f-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 17 Aug 2022 18:48:53 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=b5yh4ieSSNOFE/9IHHINLRuOLvC+2ftaX9/u7hvqGChj2ABcKquf0rkbwrjfdInyMfdUXtiZkc9UKiX80/fTkXj67Mv3fz21Ku7l0KcTAmR/0aRvlV+gy+bmADAuJHfkH+SAtJ/7vtF3BL8mdjzkxYVgcNZt5BdH8KGomn0LOnivcexdEeL3C4UAdkcOwQP+nxNLDV6ayD9xlqEktwhwB6gIJYyxu9/PU0124x+hstRfdyDsozUkf5fY+DBiBQFkC52KMiKBEpi/bdcu5z6ZUjvKTAonK7xak0BSrFGop4nCTx6+6f2NS9X6XifYEGve+h7yhKjxR3rArF9P4ALaXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Z3N/ScMJjziQ8o7G3wzpdYlPToH8Vi8ytaZY6JQn1Ms=;
 b=mGUNgltXb89Uy7JoupdC0Ld2hcPtfwEhdb1pfvZNJ1fANBoZ4VL8A2PG7YCd+j3apeOueDQTC8o4tnYpgIBpmRAIhWT6Esxb1B0GZq0wpUmAepm1zfyEoG7UnJYkCJqQHkPjRE4d8rRzVOAjMU4BgG9mzfzWmU0nO94W30NH9DuQExuwmuor90+Hpq0tLaZGk5x+RqR8baTHG3UOehplf/FCPmrXsXG/AuVpCAYtvwayUT4q4js5eW13YoVBC2pn5RB+Gg1p0ioNn0GASTFgbyjjPIEPbXVkkNi+aeu5lwxZW5+k/rJmKq2MCOuiAL4mWvc1rEpHE5JJ/48pqKZj4w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Z3N/ScMJjziQ8o7G3wzpdYlPToH8Vi8ytaZY6JQn1Ms=;
 b=YU2t+CFWkmekpI4EpRW4bvKy8mz4cL+znZh1Z8rthgrlBX6GEqB6mSJOWWnwYcrCvSpeSj6BKW1dtyzlP8ZQ58EFyKsRkMciVrDL1AONWbwLCA2lLvC8wMqJ7pewiB91bp4NQLZmJitB0E9bCWc+hH9KxBI4t00yyCCk10Elxwg=
Received: from BYAPR10MB3287.namprd10.prod.outlook.com (2603:10b6:a03:15c::11)
 by SJ0PR10MB4479.namprd10.prod.outlook.com (2603:10b6:a03:2af::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5525.19; Wed, 17 Aug
 2022 18:48:50 +0000
Received: from BYAPR10MB3287.namprd10.prod.outlook.com
 ([fe80::dcf7:95c3:9991:e649]) by BYAPR10MB3287.namprd10.prod.outlook.com
 ([fe80::dcf7:95c3:9991:e649%7]) with mapi id 15.20.5525.010; Wed, 17 Aug 2022
 18:48:50 +0000
Message-ID: <6325f067-3744-8952-e724-f22de35c8496@oracle.com>
Date: Wed, 17 Aug 2022 11:48:46 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [PATCH V5 4/6] vDPA: !FEATURES_OK should not block querying
 device config space
Content-Language: en-US
To: "Zhu, Lingshan" <lingshan.zhu@intel.com>,
 "Michael S. Tsirkin" <mst@redhat.com>
References: <20220812104500.163625-1-lingshan.zhu@intel.com>
 <20220812104500.163625-5-lingshan.zhu@intel.com>
 <e99e6d81-d7d5-e1ff-08e0-c22581c1329a@oracle.com>
 <f2864c96-cddd-129e-7dd8-a3743fe7e0d0@intel.com>
 <2cbec85b-58f6-626f-df4a-cb1bb418fec1@oracle.com>
 <a488a17a-b716-52aa-cc31-2e51f8f972d2@intel.com>
 <20220817021324-mutt-send-email-mst@kernel.org>
 <b489413e-e933-e9b6-a719-45090a4e922c@intel.com>
From: Si-Wei Liu <si-wei.liu@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <b489413e-e933-e9b6-a719-45090a4e922c@intel.com>
X-ClientProxiedBy: SJ0PR05CA0173.namprd05.prod.outlook.com
 (2603:10b6:a03:339::28) To BYAPR10MB3287.namprd10.prod.outlook.com
 (2603:10b6:a03:15c::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 35ad3559-ceb6-499f-8919-08da8081202d
X-MS-TrafficTypeDiagnostic: SJ0PR10MB4479:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: U0Ixexg9wgdTS2mTB/E6ndYeMLpZowEY4oQJtR8rWTlgmbCIwlLrB5agmUQb6adcZb4UG8/Y9fsrHYP7J92qhiuV0nYY1lslZWD0jzJyZbWxTae4/YEVcfn4MR+jzdxD+Vawa/vON68JXYZwjG5zA4Pxc5Z0hdZcBDf6tcZxNUap/aiZOSVoc1StYBo+hc8ob0T4b+z99f4MmAH0M92leO8Oj9mh/eKQUFQRUi/I4kVIbCUvQqGvwAVDYZODU12T96EsRQP4knMtFENg1eaa3Ym6gsVPd8K7V+6dbmY8ZJEC1YLExLj7XyW9daLs0r3e1edFprjCRuO/TNlcZcGoRo24AGqy73+o7FwLztUFH09NOGmS5ZpeU0e0H3XDhJIg9VlovJM5VHAG2p39ysGCD6hUYKUYGuH/6tkiPRtX7+83wNjp2w7et4QD/T/asMPb87/OQuW6UDALatafuJ7kZfr2pAIhFSS5HBCvUKsc1NB9hWclMq4WZEZiXhWi5jtCzOJ9BrrNe42JQFlvoHqPjkmsLtz/QphVh3rUUFcnapWaHg543GvcHConzcp77464ardDPoXgv5n6R4Epqvzwq37+IhALt/qyO4oitFE8Uqddx3y+JPe2pyCVri9OrXSqTrcF1n6rZ/9aNarlYtEGwMOmdUKCikUq6+f6Du2A5FbUr2MNeUPtaGnX+wQMMJ9jsiv0W3m13f38NJ1xbDjHZDqAy+CJ5D/cJDFQ4qDZ0ypqCfLJXadq1C1CtKH0BlMKv/p3CjS8R5DU5b70Qj1KJCic5hGoUzHt11Rw8T3NS8E=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR10MB3287.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230016)(346002)(136003)(39860400002)(366004)(396003)(376002)(6512007)(36916002)(33964004)(6506007)(86362001)(26005)(2616005)(31696002)(38100700002)(53546011)(186003)(83380400001)(30864003)(5660300002)(478600001)(36756003)(66946007)(6486002)(8936002)(8676002)(4326008)(66476007)(66556008)(31686004)(2906002)(110136005)(41300700001)(6666004)(316002)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eWxlSE1qbmRJSENDV05iUWtlUndvdGJrR05vNk81dllDWFFsSUtYa1lCeTBk?=
 =?utf-8?B?K1oxSmhBYnpIa1prc0V2YWkxTjVWdGFnbE9TZGZiRHF3N1lWMDY4NGJVbEc4?=
 =?utf-8?B?SGJwYy9ncWNOdGMzV2RVY05hcFlJRmc0Qm1HUUlmdjBsVTRkNzcvOFdCeHo0?=
 =?utf-8?B?bHBvczYxOWlYL3JpNXptcUZvWnFHbXhwRm1wNmZoZXFpa1RMaVl6MEN3UVY0?=
 =?utf-8?B?d2QyOThhd0w0eERuVjE0SGhIVFlhTFcyeWlqbldmejJqall1MC9OSWpPUTNB?=
 =?utf-8?B?MCtLYXFPL01LMzNIOFFiT2tlOVZEWmhxSnVFN3kwNHZJOVZveVRmcG05V1Vn?=
 =?utf-8?B?OGJYdDlSZjZKR2xkTXFHTkdXYW16TlduOWZWZjJHVjQ0cStlNHhISEJ4bFBR?=
 =?utf-8?B?a1NUQ0ZjOFBMUVl3dDdmWWhWR2FnVUZwSDNjb0NvSG85NlZsbHdQaW1wMXlL?=
 =?utf-8?B?UWl2cnFYbnd4WVp3L09FVWZFRnJyVVVJckYrNWtiRmI0Yi9kZ0F0UE83SDRR?=
 =?utf-8?B?clJ4L1pjOHRSRlFDVko2djQxSkpFMjZlY1A4alovRXJQQWgzR1lCRUREK3dR?=
 =?utf-8?B?VXJoTE1ES0xWZmpIdE5Vd3RnZ1FhSFhNbFBkM1Y3Wnl5UXBveGs1Ujg1Skwz?=
 =?utf-8?B?UnpaR3hKYzhFR2hGMkp2S1VkZEpjeDIzcEs3Qk15U1J4QmwrZHB2OEMxNkNF?=
 =?utf-8?B?dC9CL2srUjdVNDBiQmtIOGZwUTFQOGdpbVhzc3NJQlJ2MEhtWnZ4NmlWdU9X?=
 =?utf-8?B?aElxd0kwbjRKL1pOQXF5dDNXcWJHYUtaZlh3ZUoyTEFmQTdyS2laSXdXWnM4?=
 =?utf-8?B?clRabzJjaWNJWm1lZHBGNU5JdFN4aEI3VlN4dDlMME1GdTRVTkl2ZlhqZ3N3?=
 =?utf-8?B?M253bFl4SmYwVnVWRlkxdnBmdWU0VVVoUHJ6d3dDL0ZvM1c5L1VwakFDZjhU?=
 =?utf-8?B?TVQ0SVZzRDNKL3ByQ1lWK3hxOHNFU1FYYWJpZzZteVZkZzVFM29MVkQvN2Ns?=
 =?utf-8?B?WTFpeVV6WGUvMWJCQ1lMK0VvRzRzYXpPK2JucHd4c1lPTE1RYm5XR3ZNNlBH?=
 =?utf-8?B?NURQdlFOS21MNVM3MmZxdm9GSXRLaHc2NTk4Qmxua2dhWXZHdUFObDlzVTRT?=
 =?utf-8?B?eGp0UTlySEh4aTNQUjFBaGhHUnk1TzhJYyszTTRJYzEwT1hUZGZ3QjV6Q3Zk?=
 =?utf-8?B?NWZkY3lHWVVhb2hJMlM3NWxvdS8xZUw3OThiUEpmM0dLS2syVmJTTHBqWGlO?=
 =?utf-8?B?ODE1RnZwbnNPcHQzSzhsNFU2ekZzdE8vcGhoVnpCK2NSMElZYWFMelpPUU80?=
 =?utf-8?B?YmFKcjBQaGRUdFlCUzFSMjJVNXphRDZPVkpkSTQwUlFsQ3JEbFlpQmZjVmhE?=
 =?utf-8?B?Sm54UkliNHZMSkx0VFhmb1lxcWMwTndvYUlLQnphb3d2N0hoUDRTKzNRNEJI?=
 =?utf-8?B?VzVQNWxhSE9SLzY3OUlhK3JaNXpYM0VZY2tocE5jUTZPMUtpT0N6WGJka0F1?=
 =?utf-8?B?VmRlMVFLZlVBdVFnSjZZemc5UThiRG5JTFZ3TCtGN3V0STlZUkx0VXJiN09U?=
 =?utf-8?B?Q2lGaUtHNGhjQ0NERC9SbzBkb1BBdEhseE9YelhGNkp1VjhlYjIyUmV4V1Vz?=
 =?utf-8?B?SXQ4d2s3Q0NGUDFmQVdVTXlPZUlvcFdBcjl4eXFrZlNRQ0YvUlN4V1M2U2NT?=
 =?utf-8?B?THo3aDIzMi9oTTJ0eksvSGFuY01TRXk3ZTcyR0lpMEcvVzN2RnpoTE5FM0ky?=
 =?utf-8?B?ZUxab21FdlVDMnlsdHEvNmw1NVV3aU55NUIycU02Q1lIRkJXdVhWZm00RWZI?=
 =?utf-8?B?OUNnZkFXREdFbFpOb1REY0t4WnMxaGZZN1U1cnhnbUNXMWtaRlowTCtTbmo1?=
 =?utf-8?B?MDA4Mi9ERlJWcDhiTGM1YytLeEFvSGtIY1BkWkQxSFBteG1qWEEyQUVEU2tR?=
 =?utf-8?B?Sk9BYk50KzR5ajBQcXZFY0kvdlJQYlNSMER0RkRvU1lSRWZmSnFxNWx0cXNI?=
 =?utf-8?B?ZjExWHFrU1VGUTNCeTBsQVpLcFV4aUhOSmZrbnNnZGlhRUtrN2xreTJXdTdx?=
 =?utf-8?B?TWxzbnpPVDN4NGR1VEt0NkcvdldUdjg5QVE0NVdQMGYwM2tCdzNyWFJxNDBS?=
 =?utf-8?Q?lr5ejwWW9c115L5duzkaFKQnJ?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?QVlHYjdQQytNUUVoQS9nTXNxcndDTEJ4R3JnMHlwSVBuQ2VNQlR5ZWJySExv?=
 =?utf-8?B?eTcxY21Ub2tDeWVQR0JsbjhwWkF2Z3V4VytrVHZHR3VwSVN4MUdqZ3hORzhk?=
 =?utf-8?B?WFg0d09FaXYzRkdZbExXd1JONitSR0xRVlRhdW5YZVlqZS9laHpKSzVDY0FR?=
 =?utf-8?B?VHpIelN2dHEvQS9sTkJ5dFFYT043S1BnMk1GZlBRdVBHOGYvKzNDVjVHZDJH?=
 =?utf-8?B?ZDJrT214cDhlM3RTaGREbjRhejE4MldVRjl5UHRxQkQyK0FzS3dQVjhDUDdW?=
 =?utf-8?B?bGdCdHljSmNnZFB4aExic1cwOXZUb1ovbWNIVkk3UWZjZHhHWnh2RGszYy9S?=
 =?utf-8?B?SkcyTnFaUm44dFJmRmxSUXNLQUVxdUpLTE15V0VIOHd6NzdHTUdURzk5bi8x?=
 =?utf-8?B?Nks5czhWck02OCsxKzNBVjFCdDBxTHlmemFoR0tLOGRwY2d0RDVycXgvYkFU?=
 =?utf-8?B?MnBZWHNDN3B6SW9QdzVUMDNtTFVVcnRhYStaRk5tSnEvU2NTYnJIM1dIQ1No?=
 =?utf-8?B?STF1cm9lUTlpNDd3Qk5qR0JSeWg0dmt3eFNxUWtZZnZ4cHhXTnlUQ0tJaWhv?=
 =?utf-8?B?T21ibUdmV0FRNnRTSm9LQmxXMWozaTM0YXNFbS96WHFIYlRLQmJqb3VYbFgy?=
 =?utf-8?B?c2RmdEV1YXRHTy9KVUpFbWE5YWVZQ3kwLzUzRlEvQ2pyQU9TcTdEM2QyaXVF?=
 =?utf-8?B?RjFxOE5qekV6c0hqeTlUSllETkJWN2hETkZQY3A5MlBrWnBBbENlQXJIK1pD?=
 =?utf-8?B?RmVmZWNvdkRtTEkvYXVrUzJ3TWNNVEVwcUNEM3ZtWDgzcVkyQmg3aU50UTlY?=
 =?utf-8?B?bytFbjI1SC9aclpBMmhpWXFDcXdrbjQzK0gwZ1VXNkgwMHEvbGVORDJybVFZ?=
 =?utf-8?B?eUxtT0RHQVk0ZHVzVlhiTnJpUEordWNTTkdmeXN4czRUNG9RMlcxUkRTS1dX?=
 =?utf-8?B?WUloMGRKZC9ZeWRvUVF3NWd4bTl0TlV6My9tTzRmQ3JERklBaW04V0lybUpq?=
 =?utf-8?B?RG9XT0V3MUxHK0lnSm10aEJjbWpTcXlEVXdNbjN5c29PL3RWWW82YWtQL2Z1?=
 =?utf-8?B?ZHFFQlkrY2tnWHYycEFPNHZNYWFvUE9xV21BZ01iejFxQTd4WVI4aUd6VU14?=
 =?utf-8?B?YWplb3RINktWMSsyS2JrTkR2bVFYSzM0UlBKajdvMFBEMmRUWnZTb1dzVU5k?=
 =?utf-8?B?SHdFL2IvNUhoVDdaUjFVZVZZQTJZWmVuL0ZhUmRrZklmU0RJcTNubjhnd2Jk?=
 =?utf-8?B?eDhqcnh1cDFmZjlTRWYzODBLT2ltNXRLSHZpdHJCNko1UlREYWVPclU2V3A0?=
 =?utf-8?B?eGowZDlhQTJFd0h1d1pJTEw5ak42a3J3dHlwUUh0MmUwTjJyZDFyQi9XbFkz?=
 =?utf-8?B?R3ArVHJKK0F0VlJEdnJlZ0NpZitJVzdkaHE3UmhiejhlWEJ1b0NMRUNndmkr?=
 =?utf-8?B?YmkrTDk0c3lIZGVZdElTOWRVZGtZQmttNjdQZFBra2F2TzJiR3VNcHBpN255?=
 =?utf-8?B?K1Jyd25qNzBKWFZycXZJMWVkSDBTMTFlWXB5Y0xxUkpYdC9wUzc3b0FLYTJa?=
 =?utf-8?Q?wAzRBM1qcX+qchNIQEPm40YoRDKBg27C0yIn5EVkrV0v1p?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 35ad3559-ceb6-499f-8919-08da8081202d
X-MS-Exchange-CrossTenant-AuthSource: BYAPR10MB3287.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Aug 2022 18:48:50.7681 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: u5cOLQkblIpBSzM83et6Wk/T+SlgPpvaUJPPnlC84QFkEK5UgdwUQuXHc0lebQhXFQaI1VuFq2hKDB2KWY/hWA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB4479
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-17_13,2022-08-16_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0
 malwarescore=0
 adultscore=0 suspectscore=0 spamscore=0 mlxlogscore=999 bulkscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2207270000 definitions=main-2208170071
X-Proofpoint-GUID: zcfs3N0uUb1vOW4wlJv7eIAHhcHyd3uv
X-Proofpoint-ORIG-GUID: zcfs3N0uUb1vOW4wlJv7eIAHhcHyd3uv
Cc: kvm@vger.kernel.org, netdev@vger.kernel.org,
 virtualization@lists.linux-foundation.org, xieyongji@bytedance.com,
 gautam.dawar@amd.com
X-BeenThere: virtualization@lists.linux-foundation.org
X-Mailman-Version: 2.1.15
Precedence: list
List-Id: Linux virtualization <virtualization.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>, 
 <mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>, 
 <mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============4489619259119442077=="
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

--===============4489619259119442077==
Content-Type: multipart/alternative;
 boundary="------------SGZcTP26vnVMzv8ExEwr2eqz"
Content-Language: en-US

--------------SGZcTP26vnVMzv8ExEwr2eqz
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 8/16/2022 11:23 PM, Zhu, Lingshan wrote:
>
>
> On 8/17/2022 2:14 PM, Michael S. Tsirkin wrote:
>> On Wed, Aug 17, 2022 at 10:11:36AM +0800, Zhu, Lingshan wrote:
>>>
>>> On 8/17/2022 6:48 AM, Si-Wei Liu wrote:
>>>
>>>
>>>
>>>      On 8/16/2022 1:29 AM, Zhu, Lingshan wrote:
>>>
>>>
>>>
>>>          On 8/16/2022 3:41 PM, Si-Wei Liu wrote:
>>>
>>>              Hi Michael,
>>>
>>>              I just noticed this patch got pulled to linux-next 
>>> prematurely
>>>              without getting consensus on code review, am not sure 
>>> why. Hope it
>>>              was just an oversight.
>>>
>>>              Unfortunately this introduced functionality regression 
>>> to at least
>>>              two cases so far as I see:
>>>
>>>              1. (bogus) VDPA_ATTR_DEV_NEGOTIATED_FEATURES are 
>>> inadvertently
>>>              exposed and displayed in "vdpa dev config show" before 
>>> feature
>>>              negotiation is done. Noted the corresponding features 
>>> name shown in
>>>              vdpa tool is called "negotiated_features" rather than
>>>              "driver_features". I see in no way the intended change 
>>> of the patch
>>>              should break this user level expectation regardless of 
>>> any spec
>>>              requirement. Do you agree on this point?
>>>
>>>          I will post a patch for iptour2, doing:
>>>          1) if iprout2 does not get driver_features from the kernel, 
>>> then don't
>>>          show negotiated features in the command output
>>>
>>>      This won't work as the vdpa userspace tool won't know *when* 
>>> features are
>>>      negotiated. There's no guarantee in the kernel to assume 0 will 
>>> be returned
>>>      from vendor driver during negotiation. On the other hand, with 
>>> the supposed
>>>      change, userspace can't tell if there's really none of features 
>>> negotiated,
>>>      or the feature negotiation is over. Before the change the 
>>> userspace either
>>>      gets all the attributes when feature negotiation is over, or it 
>>> gets
>>>      nothing when it's ongoing, so there was a distinction.This 
>>> expectation of
>>>      what "negotiated_features" represents is established from day 
>>> one, I see no
>>>      reason the intended kernel change to show other attributes 
>>> should break
>>>      userspace behavior and user's expectation.
>>>
>>> User space can only read valid *driver_features* after the features 
>>> negotiation
>>> is done, *device_features* does not require the negotiation.
>>>
>>> If you want to prevent random values read from driver_features, here 
>>> I propose
>>> a fix: only read driver_features when the negotiation is done, this 
>>> means to
>>> check (status & VIRTIO_CONFIG_S_FEATURES_OK) before reading the
>>> driver_features.
>>> Sounds good?
>>>
>>> @MST, if this is OK, I can include this change in my next version 
>>> patch series.
>>>
>>> Thanks,
>>> Zhu Lingshan
>> Sorry I don't get it. Is there going to be a new version? Do you want me
>> to revert this one and then apply a new one? It's ok if yes.
> Not a new version, it is a new patch, though I still didn't get the 
> race condition, but I believe it
> is reasonable to block reading the *driver_features* before FEATURES_OK.
>
> So, I added code to check whether _FEATURES_OK is set:
>
>  861         /* only read driver features after the feature 
> negotiation is done */
>  862         status = vdev->config->get_status(vdev);
>  863         if (status & VIRTIO_CONFIG_S_FEATURES_OK) {
>  864                 features_driver = 
> vdev->config->get_driver_features(vdev);
>  865                 if (nla_put_u64_64bit(msg, 
> VDPA_ATTR_DEV_NEGOTIATED_FEATURES, features_driver,
>  866                                       VDPA_ATTR_PAD))
>  867                 return -EMSGSIZE;
>  868         }
>
> If this solution looks good, I will add this patch in my V2 series.
This solves the 1st issue in my report, but without a fix for the 2nd 
issue ( vdpa_dev_net_config_fill and vdpa_set_features race) addressed I 
don't think it covers all incurred regressions.

I've replied the way to reproduce the race. For me it's very obvious to 
see in my setup.
>
> > So what is the race?
> You'll see the race if you keep 'vdpa dev config show ...' running in 
> a tight loop while launching a VM with the vDPA device under query.
>
-Siwei

>
> Thanks
> Zhu Lingshan
>
>>
>>
>>>          2) process and decoding the device features.
>>>
>>>
>>>              2. There was also another implicit assumption that is 
>>> broken by
>>>              this patch. There could be a vdpa tool query of config via
>>> vdpa_dev_net_config_fill()->vdpa_get_config_unlocked() that races
>>>              with the first vdpa_set_features() call from VMM e.g. 
>>> QEMU. Since
>>>              the S_FEATURES_OK blocking condition is removed, if the 
>>> vdpa tool
>>>              query occurs earlier than the first 
>>> set_driver_features() call from
>>>              VMM, the following code will treat the guest as legacy 
>>> and then
>>>              trigger an erroneous vdpa_set_features_unlocked(... , 
>>> 0) call to
>>>              the vdpa driver:
>>>
>>>               374         /*
>>>               375          * Config accesses aren't supposed to 
>>> trigger before
>>>              features are set.
>>>               376          * If it does happen we assume a legacy 
>>> guest.
>>>               377          */
>>>               378         if (!vdev->features_valid)
>>>               379 vdpa_set_features_unlocked(vdev, 0);
>>>               380         ops->get_config(vdev, offset, buf, len);
>>>
>>>              Depending on vendor driver's implementation, L380 may 
>>> either return
>>>              invalid config data (or invalid endianness if on BE) or 
>>> only config
>>>              fields that are valid in legacy layout. What's more 
>>> severe is that,
>>>              vdpa tool query in theory shouldn't affect feature 
>>> negotiation at
>>>              all by making confusing calls to the device, but now it 
>>> is possible
>>>              with the patch. Fixing this would require more delicate 
>>> work on the
>>>              other paths involving the cf_lock reader/write semaphore.
>>>
>>>              Not sure what you plan to do next, post the fixes for 
>>> both issues
>>>              and get the community review? Or simply revert the 
>>> patch in
>>>              question? Let us know.
>>>
>>>          The spec says:
>>>          The device MUST allow reading of any device-specific 
>>> configuration
>>>          field before FEATURES_OK is set by
>>>          the driver. This includes fields which are conditional on 
>>> feature bits,
>>>          as long as those feature bits are offered
>>>          by the device.
>>>
>>>          so whether FEATURES_OK should not block reading the device 
>>> config
>>>          space. vdpa_get_config_unlocked() will read the features, I 
>>> don't know
>>>          why it has a comment:
>>>                  /*
>>>                   * Config accesses aren't supposed to trigger 
>>> before features
>>>          are set.
>>>                   * If it does happen we assume a legacy guest.
>>>                   */
>>>
>>>          This conflicts with the spec.
>>>
>>>          vdpa_get_config_unlocked() checks vdev->features_valid, if 
>>> not valid,
>>>          it will set the drivers_features 0, I think this intends to 
>>> prevent
>>>          reading random driver_features. This function does not hold 
>>> any locks,
>>>          and didn't change anything.
>>>
>>>          So what is the race?
>>>          You'll see the race if you keep 'vdpa dev config show ...' 
>>> running in a
>>>      tight loop while launching a VM with the vDPA device under query.
>>>
>>>      -Siwei
>>>
>>>
>>>
>>>                  Thanks
>>>
>>>
>>>              Thanks,
>>>              -Siwei
>>>
>>>
>>>              On 8/12/2022 3:44 AM, Zhu Lingshan wrote:
>>>
>>>                  Users may want to query the config space of a vDPA 
>>> device,
>>>                  to choose a appropriate one for a certain guest. 
>>> This means the
>>>                  users need to read the config space before 
>>> FEATURES_OK, and
>>>                  the existence of config space contents does not 
>>> depend on
>>>                  FEATURES_OK.
>>>
>>>                  The spec says:
>>>                  The device MUST allow reading of any device-specific
>>>                  configuration
>>>                  field before FEATURES_OK is set by the driver. This 
>>> includes
>>>                  fields which are conditional on feature bits, as 
>>> long as those
>>>                  feature bits are offered by the device.
>>>
>>>                  Signed-off-by: Zhu Lingshan <lingshan.zhu@intel.com>
>>>                  ---
>>>                    drivers/vdpa/vdpa.c | 8 --------
>>>                    1 file changed, 8 deletions(-)
>>>
>>>                  diff --git a/drivers/vdpa/vdpa.c b/drivers/vdpa/vdpa.c
>>>                  index 6eb3d972d802..bf312d9c59ab 100644
>>>                  --- a/drivers/vdpa/vdpa.c
>>>                  +++ b/drivers/vdpa/vdpa.c
>>>                  @@ -855,17 +855,9 @@ vdpa_dev_config_fill(struct 
>>> vdpa_device
>>>                  *vdev, struct sk_buff *msg, u32 portid,
>>>                    {
>>>                        u32 device_id;
>>>                        void *hdr;
>>>                  -    u8 status;
>>>                        int err;
>>>                          down_read(&vdev->cf_lock);
>>>                  -    status = vdev->config->get_status(vdev);
>>>                  -    if (!(status & VIRTIO_CONFIG_S_FEATURES_OK)) {
>>>                  -        NL_SET_ERR_MSG_MOD(extack, "Features 
>>> negotiation not
>>>                  completed");
>>>                  -        err = -EAGAIN;
>>>                  -        goto out;
>>>                  -    }
>>>                  -
>>>                        hdr = genlmsg_put(msg, portid, seq, 
>>> &vdpa_nl_family,
>>>                  flags,
>>>                                  VDPA_CMD_DEV_CONFIG_GET);
>>>                        if (!hdr) {
>>>
>>>
>>>
>>>
>>>
>>>
>>>
>>>
>

--------------SGZcTP26vnVMzv8ExEwr2eqz
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 8bit

<html><head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body>
    <br>
    <br>
    <div class="moz-cite-prefix">On 8/16/2022 11:23 PM, Zhu, Lingshan
      wrote:<br>
    </div>
    <blockquote type="cite" cite="mid:b489413e-e933-e9b6-a719-45090a4e922c@intel.com">
      <br>
      <br>
      On 8/17/2022 2:14 PM, Michael S. Tsirkin wrote:
      <br>
      <blockquote type="cite">On Wed, Aug 17, 2022 at 10:11:36AM +0800,
        Zhu, Lingshan wrote:
        <br>
        <blockquote type="cite">
          <br>
          On 8/17/2022 6:48 AM, Si-Wei Liu wrote:
          <br>
          <br>
          <br>
          <br>
          &nbsp;&nbsp;&nbsp;&nbsp; On 8/16/2022 1:29 AM, Zhu, Lingshan wrote:
          <br>
          <br>
          <br>
          <br>
          &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; On 8/16/2022 3:41 PM, Si-Wei Liu wrote:
          <br>
          <br>
          &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Hi Michael,
          <br>
          <br>
          &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; I just noticed this patch got pulled to
          linux-next prematurely
          <br>
          &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; without getting consensus on code review, am not
          sure why. Hope it
          <br>
          &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; was just an oversight.
          <br>
          <br>
          &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Unfortunately this introduced functionality
          regression to at least
          <br>
          &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; two cases so far as I see:
          <br>
          <br>
          &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 1. (bogus) VDPA_ATTR_DEV_NEGOTIATED_FEATURES are
          inadvertently
          <br>
          &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; exposed and displayed in &quot;vdpa dev config show&quot;
          before feature
          <br>
          &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; negotiation is done. Noted the corresponding
          features name shown in
          <br>
          &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; vdpa tool is called &quot;negotiated_features&quot; rather
          than
          <br>
          &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &quot;driver_features&quot;. I see in no way the intended
          change of the patch
          <br>
          &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; should break this user level expectation
          regardless of any spec
          <br>
          &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; requirement. Do you agree on this point?
          <br>
          <br>
          &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; I will post a patch for iptour2, doing:
          <br>
          &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 1) if iprout2 does not get driver_features from the
          kernel, then don't
          <br>
          &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; show negotiated features in the command output
          <br>
          <br>
          &nbsp;&nbsp;&nbsp;&nbsp; This won't work as the vdpa userspace tool won't know
          *when* features are
          <br>
          &nbsp;&nbsp;&nbsp;&nbsp; negotiated. There's no guarantee in the kernel to assume
          0 will be returned
          <br>
          &nbsp;&nbsp;&nbsp;&nbsp; from vendor driver during negotiation. On the other hand,
          with the supposed
          <br>
          &nbsp;&nbsp;&nbsp;&nbsp; change, userspace can't tell if there's really none of
          features negotiated,
          <br>
          &nbsp;&nbsp;&nbsp;&nbsp; or the feature negotiation is over. Before the change the
          userspace either
          <br>
          &nbsp;&nbsp;&nbsp;&nbsp; gets all the attributes when feature negotiation is over,
          or it gets
          <br>
          &nbsp;&nbsp;&nbsp;&nbsp; nothing when it's ongoing, so there was a
          distinction.This expectation of
          <br>
          &nbsp;&nbsp;&nbsp;&nbsp; what &quot;negotiated_features&quot; represents is established from
          day one, I see no
          <br>
          &nbsp;&nbsp;&nbsp;&nbsp; reason the intended kernel change to show other
          attributes should break
          <br>
          &nbsp;&nbsp;&nbsp;&nbsp; userspace behavior and user's expectation.
          <br>
          <br>
          User space can only read valid *driver_features* after the
          features negotiation
          <br>
          is done, *device_features* does not require the negotiation.
          <br>
          <br>
          If you want to prevent random values read from
          driver_features, here I propose
          <br>
          a fix: only read driver_features when the negotiation is done,
          this means to
          <br>
          check (status &amp; VIRTIO_CONFIG_S_FEATURES_OK) before
          reading the
          <br>
          driver_features.
          <br>
          Sounds good?
          <br>
          <br>
          @MST, if this is OK, I can include this change in my next
          version patch series.
          <br>
          <br>
          Thanks,
          <br>
          Zhu Lingshan
          <br>
        </blockquote>
        Sorry I don't get it. Is there going to be a new version? Do you
        want me
        <br>
        to revert this one and then apply a new one? It's ok if yes.
        <br>
      </blockquote>
      Not a new version, it is a new patch, though I still didn't get
      the race condition, but I believe it
      <br>
      is reasonable to block reading the *driver_features* before
      FEATURES_OK.
      <br>
      <br>
      So, I added code to check whether _FEATURES_OK is set:
      <br>
      <br>
      &nbsp;861&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* only read driver features after the feature
      negotiation is done */
      <br>
      &nbsp;862&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; status = vdev-&gt;config-&gt;get_status(vdev);
      <br>
      &nbsp;863&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (status &amp; VIRTIO_CONFIG_S_FEATURES_OK) {
      <br>
      &nbsp;864&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; features_driver =
      vdev-&gt;config-&gt;get_driver_features(vdev);
      <br>
      &nbsp;865&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (nla_put_u64_64bit(msg,
      VDPA_ATTR_DEV_NEGOTIATED_FEATURES, features_driver,
      <br>
      &nbsp;866&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; VDPA_ATTR_PAD))
      <br>
      &nbsp;867&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return -EMSGSIZE;
      <br>
      &nbsp;868&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }
      <br>
      <br>
      If this solution looks good, I will add this patch in my V2
      series.
      <br>
    </blockquote>
    This solves the 1st issue in my report, but without a fix for the
    2nd issue ( vdpa_dev_net_config_fill and vdpa_set_features race)
    addressed I don't think it covers all incurred regressions.<br>
    <br>
    I've replied the way to reproduce the race. For me it's very obvious
    to see in my setup.<br>
    <blockquote type="cite"><font face="monospace"><span class="fontstyle0"><br>
          &gt; So what is the race?<br>
        </span></font> <font face="monospace">You'll see the race if
        you keep 'vdpa dev config show ...' running in a tight loop
        while launching a VM with the vDPA device under query.<br>
      </font> <br>
    </blockquote>
    -Siwei<br>
    <br>
    <blockquote type="cite" cite="mid:b489413e-e933-e9b6-a719-45090a4e922c@intel.com">
      <br>
      Thanks
      <br>
      Zhu Lingshan
      <br>
      <br>
      <blockquote type="cite">
        <br>
        <br>
        <blockquote type="cite">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 2) process and decoding the
          device features.
          <br>
          <br>
          <br>
          &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 2. There was also another implicit assumption
          that is broken by
          <br>
          &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; this patch. There could be a vdpa tool query of
          config via
          <br>
          &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
          vdpa_dev_net_config_fill()-&gt;vdpa_get_config_unlocked() that
          races
          <br>
          &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; with the first vdpa_set_features() call from VMM
          e.g. QEMU. Since
          <br>
          &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; the S_FEATURES_OK blocking condition is removed,
          if the vdpa tool
          <br>
          &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; query occurs earlier than the first
          set_driver_features() call from
          <br>
          &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; VMM, the following code will treat the guest as
          legacy and then
          <br>
          &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; trigger an erroneous
          vdpa_set_features_unlocked(... , 0) call to
          <br>
          &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; the vdpa driver:
          <br>
          <br>
          &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;374&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /*
          <br>
          &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;375&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * Config accesses aren't supposed
          to trigger before
          <br>
          &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; features are set.
          <br>
          &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;376&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * If it does happen we assume a
          legacy guest.
          <br>
          &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;377&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; */
          <br>
          &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;378&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!vdev-&gt;features_valid)
          <br>
          &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;379&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
          vdpa_set_features_unlocked(vdev, 0);
          <br>
          &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;380&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ops-&gt;get_config(vdev, offset,
          buf, len);
          <br>
          <br>
          &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Depending on vendor driver's implementation, L380
          may either return
          <br>
          &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; invalid config data (or invalid endianness if on
          BE) or only config
          <br>
          &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; fields that are valid in legacy layout. What's
          more severe is that,
          <br>
          &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; vdpa tool query in theory shouldn't affect
          feature negotiation at
          <br>
          &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; all by making confusing calls to the device, but
          now it is possible
          <br>
          &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; with the patch. Fixing this would require more
          delicate work on the
          <br>
          &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; other paths involving the cf_lock reader/write
          semaphore.
          <br>
          <br>
          &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Not sure what you plan to do next, post the fixes
          for both issues
          <br>
          &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; and get the community review? Or simply revert
          the patch in
          <br>
          &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; question? Let us know.
          <br>
          <br>
          &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; The spec says:
          <br>
          &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; The device MUST allow reading of any device-specific
          configuration
          <br>
          &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; field before FEATURES_OK is set by
          <br>
          &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; the driver. This includes fields which are
          conditional on feature bits,
          <br>
          &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; as long as those feature bits are offered
          <br>
          &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; by the device.
          <br>
          <br>
          &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; so whether FEATURES_OK should not block reading the
          device config
          <br>
          &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; space. vdpa_get_config_unlocked() will read the
          features, I don't know
          <br>
          &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; why it has a comment:
          <br>
          &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /*
          <br>
          &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * Config accesses aren't supposed to trigger
          before features
          <br>
          &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; are set.
          <br>
          &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * If it does happen we assume a legacy
          guest.
          <br>
          &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; */
          <br>
          <br>
          &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; This conflicts with the spec.
          <br>
          <br>
          &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; vdpa_get_config_unlocked() checks
          vdev-&gt;features_valid, if not valid,
          <br>
          &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; it will set the drivers_features 0, I think this
          intends to prevent
          <br>
          &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; reading random driver_features. This function does
          not hold any locks,
          <br>
          &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; and didn't change anything.
          <br>
          <br>
          &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; So what is the race?
          <br>
          &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp; You'll see the race if you keep 'vdpa dev config show
          ...' running in a
          <br>
          &nbsp;&nbsp;&nbsp;&nbsp; tight loop while launching a VM with the vDPA device
          under query.
          <br>
          <br>
          &nbsp;&nbsp;&nbsp;&nbsp; -Siwei
          <br>
          <br>
          <br>
          <br>
          &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Thanks
          <br>
          <br>
          &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <br>
          &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Thanks,
          <br>
          &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; -Siwei
          <br>
          <br>
          <br>
          &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; On 8/12/2022 3:44 AM, Zhu Lingshan wrote:
          <br>
          <br>
          &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Users may want to query the config space of a
          vDPA device,
          <br>
          &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; to choose a appropriate one for a certain
          guest. This means the
          <br>
          &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; users need to read the config space before
          FEATURES_OK, and
          <br>
          &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; the existence of config space contents does
          not depend on
          <br>
          &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; FEATURES_OK.
          <br>
          <br>
          &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; The spec says:
          <br>
          &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; The device MUST allow reading of any
          device-specific
          <br>
          &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; configuration
          <br>
          &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; field before FEATURES_OK is set by the
          driver. This includes
          <br>
          &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; fields which are conditional on feature bits,
          as long as those
          <br>
          &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; feature bits are offered by the device.
          <br>
          <br>
          &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Signed-off-by: Zhu Lingshan
          <a class="moz-txt-link-rfc2396E" href="mailto:lingshan.zhu@intel.com">&lt;lingshan.zhu@intel.com&gt;</a>
          <br>
          &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ---
          <br>
          &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp; drivers/vdpa/vdpa.c | 8 --------
          <br>
          &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp; 1 file changed, 8 deletions(-)
          <br>
          <br>
          &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; diff --git a/drivers/vdpa/vdpa.c
          b/drivers/vdpa/vdpa.c
          <br>
          &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; index 6eb3d972d802..bf312d9c59ab 100644
          <br>
          &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; --- a/drivers/vdpa/vdpa.c
          <br>
          &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; +++ b/drivers/vdpa/vdpa.c
          <br>
          &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; @@ -855,17 +855,9 @@
          vdpa_dev_config_fill(struct vdpa_device
          <br>
          &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *vdev, struct sk_buff *msg, u32 portid,
          <br>
          &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp; {
          <br>
          &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; u32 device_id;
          <br>
          &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; void *hdr;
          <br>
          &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; -&nbsp;&nbsp;&nbsp; u8 status;
          <br>
          &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int err;
          <br>
          &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; down_read(&amp;vdev-&gt;cf_lock);
          <br>
          &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; -&nbsp;&nbsp;&nbsp; status =
          vdev-&gt;config-&gt;get_status(vdev);
          <br>
          &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; -&nbsp;&nbsp;&nbsp; if (!(status &amp;
          VIRTIO_CONFIG_S_FEATURES_OK)) {
          <br>
          &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; NL_SET_ERR_MSG_MOD(extack, &quot;Features
          negotiation not
          <br>
          &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; completed&quot;);
          <br>
          &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; err = -EAGAIN;
          <br>
          &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; goto out;
          <br>
          &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; -&nbsp;&nbsp;&nbsp; }
          <br>
          &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; -
          <br>
          &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; hdr = genlmsg_put(msg, portid, seq,
          &amp;vdpa_nl_family,
          <br>
          &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; flags,
          <br>
          &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; VDPA_CMD_DEV_CONFIG_GET);
          <br>
          &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!hdr) {
          <br>
          <br>
          <br>
          <br>
          <br>
          <br>
          <br>
          <br>
          <br>
        </blockquote>
      </blockquote>
      <br>
    </blockquote>
    <br>
  </body>
</html>

--------------SGZcTP26vnVMzv8ExEwr2eqz--

--===============4489619259119442077==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
--===============4489619259119442077==--
