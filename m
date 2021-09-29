Return-Path: <SRS0=D/KU=OT=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91CF4C433F5
	for <virtualization@archiver.kernel.org>; Wed, 29 Sep 2021 01:17:01 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3D0CA6135D
	for <virtualization@archiver.kernel.org>; Wed, 29 Sep 2021 01:17:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 3D0CA6135D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id EE094401EC;
	Wed, 29 Sep 2021 01:17:00 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id SYTQoWfrH-UZ; Wed, 29 Sep 2021 01:16:59 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 3E43840022;
	Wed, 29 Sep 2021 01:16:59 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 16B0EC000F;
	Wed, 29 Sep 2021 01:16:59 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 4E741C000D
 for <virtualization@lists.linux-foundation.org>;
 Wed, 29 Sep 2021 01:16:57 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 3DD4681C6E
 for <virtualization@lists.linux-foundation.org>;
 Wed, 29 Sep 2021 01:16:57 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=oracle.com header.b="S5mM7ni+";
 dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com
 header.b="yPcgJj8v"
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id DfVEWk-nHAe5
 for <virtualization@lists.linux-foundation.org>;
 Wed, 29 Sep 2021 01:16:56 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com
 [205.220.177.32])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 7807281A34
 for <virtualization@lists.linux-foundation.org>;
 Wed, 29 Sep 2021 01:16:56 +0000 (UTC)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 18SNwmnt008676; 
 Wed, 29 Sep 2021 01:16:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=29kxuht8FBylVu7vhTw9VNiUY7i0G7ocmqZ4RJmM6eM=;
 b=S5mM7ni+vydjM1PAgwgSB5ZZAQMuxsvs2j1wRGIAOwvN9jgBXNYnV32olK27P6Q7I3Lp
 NANOz66tM9WvJHQUqnjh47LxH+ziNzsocR0mTQgB73n4yE1ZFjySFVjJvboNhg2K/shZ
 wL5Mk5XK8rt9jO8BLXNf3Y7/5OLT/Wuak1vm1mifQ21QPfviSiEa/x6ur8+TwpoP7rCT
 tcu+iZj1cRA6SvO1IrHrU4t4K2VAM3LMyGUwawTqtboGbPeL4UjAWtrlTq2P7H3NuRaP
 jtoznPRwLfqdcjQCHXWA9hMhZUYfhLQMRF/adtHQAn5XXuoHMfTNaWk0WWUBMgCLGBAZ Xg== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
 by mx0b-00069f02.pphosted.com with ESMTP id 3bbh6nutf0-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 29 Sep 2021 01:16:33 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
 by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 18T1APhx096729;
 Wed, 29 Sep 2021 01:16:32 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com
 (mail-bn7nam10lp2104.outbound.protection.outlook.com [104.47.70.104])
 by userp3030.oracle.com with ESMTP id 3bc3bj69f0-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 29 Sep 2021 01:16:31 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QxP5g7WRfn+x3DGjt5jJz1wfvQDGyxRlxAoXlhe1F4CpRph+eVJ+pcINkYPguHUcvS8P2gcGWwWyV30ImlAig7DnFdlYBqzbcU3Bx4ypLqV+RW8yi11TBpMdPj7CY7YiLqYoC+LwYXNWvrADU40gZl5RNNr12sLyhbsslgB8ZtVGTxxaRYl/I4l6P7Z0fjNX04hENQreKqbO4djBVFY2yTWxjLYT8kfkhldw25OCVVdYKoe0r2MBkIzMc5hvgTwBuYQ9lXXeiIr0SN5KiU3MtaydR9RHT4ACMbtGYSLvt8bhCEcZhfM/7lxUXIr7aJsiiJ0lg3HI/ZAHssgETUqMaw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version; 
 bh=29kxuht8FBylVu7vhTw9VNiUY7i0G7ocmqZ4RJmM6eM=;
 b=JSHWHz+r+EV4ZU7ruWc4ZPcGs3F/b1CyaSaMflhS5qpNc9SmZ2bEB/GDmtTsGpnuEaQpzZARSGkCYDbdzVrkz9731Ji3bw8CDkNfecI2xFqtzOxol+wN//o/V/bzZ0Vgs3PREv0pRlEOD9SIVX28E/9xgjFiVAmSsWd0/tswiM4ZkVdsxNwY9C/kvLmy9LNq8PZupgYbOrUKXJjFFf0ThqGYo9mvS6jijuXkKborgiZouGaX+R0IcqUmFphgCAQKQKxx6mEuqXxpnUPytQNRAr5vzUMgYzB603cnrG+rGEwkKIt47rcQzrhejgAWkGOGtwPJZFzvkDMnIfioYb+1bw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=29kxuht8FBylVu7vhTw9VNiUY7i0G7ocmqZ4RJmM6eM=;
 b=yPcgJj8v/tWyp5G+0Dzl9NhxjnfVKdHY6Rb8fl7e9kyGERyo1nw2PO1eOLoLtQGKDZ+mS0WkDie6wyz9vo6kzyHBWiazwcRlKS2tgW5TAYVUODkd2UUjvVgPj//V69i0mkOP2hrlHLq1QGtxDEV/TmHVzKxVopan2GsdJ/m1IvU=
Authentication-Results: kvack.org; dkim=none (message not signed)
 header.d=none;kvack.org; dmarc=none action=none header.from=oracle.com;
Received: from CH0PR10MB5020.namprd10.prod.outlook.com (2603:10b6:610:c0::22)
 by CH0PR10MB5050.namprd10.prod.outlook.com (2603:10b6:610:c3::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4544.15; Wed, 29 Sep
 2021 01:16:29 +0000
Received: from CH0PR10MB5020.namprd10.prod.outlook.com
 ([fe80::f44b:db92:7a0:782b]) by CH0PR10MB5020.namprd10.prod.outlook.com
 ([fe80::f44b:db92:7a0:782b%7]) with mapi id 15.20.4544.021; Wed, 29 Sep 2021
 01:16:29 +0000
Subject: Re: [PATCH v1 1/8] x86/xen: update xen_oldmem_pfn_is_ram()
 documentation
To: David Hildenbrand <david@redhat.com>, linux-kernel@vger.kernel.org
References: <20210928182258.12451-1-david@redhat.com>
 <20210928182258.12451-2-david@redhat.com>
From: Boris Ostrovsky <boris.ostrovsky@oracle.com>
Message-ID: <69da3297-d4ab-54b2-3a43-d536e6dee888@oracle.com>
Date: Tue, 28 Sep 2021 21:16:21 -0400
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.14.0
In-Reply-To: <20210928182258.12451-2-david@redhat.com>
Content-Language: en-US
X-ClientProxiedBy: BY3PR03CA0012.namprd03.prod.outlook.com
 (2603:10b6:a03:39a::17) To CH0PR10MB5020.namprd10.prod.outlook.com
 (2603:10b6:610:c0::22)
MIME-Version: 1.0
Received: from [10.74.101.163] (160.34.89.163) by
 BY3PR03CA0012.namprd03.prod.outlook.com (2603:10b6:a03:39a::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4566.13 via Frontend
 Transport; Wed, 29 Sep 2021 01:16:25 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a616770d-cbad-4270-d866-08d982e6c3e4
X-MS-TrafficTypeDiagnostic: CH0PR10MB5050:
X-Microsoft-Antispam-PRVS: <CH0PR10MB50503EF6FB495FB1375400738AA99@CH0PR10MB5050.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3383;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 16H6WlWiCX4aJmp+b7S6ufcVG9yGpz0+NqmjE3IISJ6YJ9aYwFWS4mSIZlenZ5+6dwLGjfoCmnD0a1pUdSPFraSkFTFhzkBove1xExAbDCE4DVtJQI0Xy8gw9Vx/IPiwQMrGjgwac7YBKNdIybqfc0kPxH0j2YVKk4P860oj18APLrGQt7ZA9RhwLUvbCl7If3Jt1wUXEDou2eYLlltsWY2WlOslw3SXItGWWZ26ct9Pei5/oPKmGpTSC8Ue0LDQmAxdpg8KWrC+xyvgFUpYKYfd7OQmgyzGUz4G8XBPhy9UpB95XnVvtedshuFsh5a9aBO9P33PIPjUKCe8UDXtPlsFy3Ivhosc/oNKbyDct0yBIhEFbZY0k2FoScM9+BrmecfnJzddc8xLM9LeTkbm/rc8dNGZAWTeUOmpWk+V9nKVz1OHLmPUyCQR6oCvWvCSd/qvbwopbNeqpyFu2Bdxl9yxY57+E+NIByFjEqhFW1n5/n9X7SMVrWNWurwqYWHx2zF0i5pNXoJMCmZWshel85WGmx+v0eYItuV1V4WaG6F/GJkTD97xljzFYdWiJW39nx5YtdL8oJtxdb8jsPRT35ewOuPPsp3NybBW5pLfrsdX/P9Iu75mlDH6GIOALoM9FTRw/9u7x0VRULOqDjg1f00Lr5vH21sVLje+g5FU3YHkDmBe+dH53fE79ghQT6MwbgJ66C/LofczwBL7up4PPb573NYWsZ1ZfjpsINZcyes=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH0PR10MB5020.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(366004)(2906002)(5660300002)(36756003)(186003)(26005)(8676002)(6486002)(16576012)(86362001)(53546011)(54906003)(8936002)(316002)(66476007)(508600001)(31696002)(956004)(38100700002)(31686004)(44832011)(2616005)(558084003)(4326008)(83380400001)(66556008)(6666004)(66946007)(7416002)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZFVPZHl0SUp6cWlFMWt5NENlZDY2UmZIODVFcFBobUwxa1RMRDZheTBKNWVR?=
 =?utf-8?B?cEhrMXY2MnFrZmw5Y3BPWU9wcTVpYlYrYnV1eHJVaHM5SzhVNE9IUjcxR3JD?=
 =?utf-8?B?TEVFMG9aL1UreWk0NUFubWQrWEVKZEo2V0Zvci9uSWZUSTl1ZHFha096blV4?=
 =?utf-8?B?aC9rTFVsajVwQ0M5MmxOQkluNG5SM1dRbEhYY0FpZnQ1L1FMbGNpTjZwMlIr?=
 =?utf-8?B?OEUzdmJHN1RJZHYxTUFRMnVPRExjdHJXTFA1dGM3S0V3UVhjR1dZdEVrSDBN?=
 =?utf-8?B?TWZRckxVNnJXSSs1NmZ4YmlVM0Z6RHlLZTVTTFdpaEVINE12R0creTRPWVJ0?=
 =?utf-8?B?OFJMdE5FR2lIb3RDTVNXWnMvNHdPVVVCcUxnendON1Noa2h3NC9JWGhrSU9t?=
 =?utf-8?B?eC94eHQ1dDJUV2h6WFkreGwzRWRYRkZrcDZ3MFBaOWRCWUlVNW4rNkt2WC9p?=
 =?utf-8?B?OEhQSWhkeUpMeURxcCtpY1c5WVZ0TTBjdElhbmY4U0NPS1V0UGVpY0NsNEtR?=
 =?utf-8?B?cHhQUUROckEvVVVzK3VhL3VtZ092ZCs1VWJGOXk4OVBMUGR3c0h3QkhTaUFC?=
 =?utf-8?B?Y0tJdUdkRVFsMksrd05XdVdhSHpVcE9sSW5RQS9nWjZzS3lsSG9KaXlkVWJa?=
 =?utf-8?B?aTVoTXpveExUMUJKTFpmUXYwTEhucExOY1NlSm1ZV1MzMmNUa0wxYVpsaHZD?=
 =?utf-8?B?ZEx4VW1LMnphVUZLd2lGdVZkTlRoVmI2WHNqbkFwOVVneVA0TTZSREs4L2Rn?=
 =?utf-8?B?WWZCN2lzdUZjVytaVVA4NHB2RTBvbktZSkdJc0ZYU01YbWd6L0pVYWRMVS9G?=
 =?utf-8?B?OGoyNGhKMGpQQ3EvaWxkUzVuVlpxV1YwOThwakx6YWZhdGZkVG92K3dHdkxv?=
 =?utf-8?B?dW4yeVY2OTRZN1JXTEdvTHM4VWhGSmpVRUZjOUxiNWRvNndaV2VsSHllSFZN?=
 =?utf-8?B?YWpJbTN3emNzdTlZWU83WUNlYVdxbXVvMlRXYnVpR0FBbXpnY2paY2ZWR0w0?=
 =?utf-8?B?Z09CWS8rZm15emJUQzB0bkFBK0xma0pZbXpmRm1Ldmt3d0srcnFLQzVBSmZP?=
 =?utf-8?B?dnpVYnBmV05SemljeGhCVGg2VXo1V3pWcUZZQWRhQ3dJdEVlOGtmUUpwaWZJ?=
 =?utf-8?B?Slk2MmpvTlRtOUZjek5yWWJScy9TbjJxUnpJSTdXb0tpSmZ1cE1TTFpkNnAz?=
 =?utf-8?B?cUV3WFlaNVhnbW9KYWhucXpqQjFKdjJyZWk3SFgyVHlRK2orOVJVKzVEeDZF?=
 =?utf-8?B?MkVUeTVRUFFxNkNDS0hCdzNOMWJkVUxsbG9nZThEQnIyUVliSWk1THl6b3Nr?=
 =?utf-8?B?L2NwVFpMRFhTR1F2VnVyOFVJTGM4Qktoa2krSXM0Z2U0dFZUeFpjWTU5WTBs?=
 =?utf-8?B?TUhlR2ZpM0hHeE8yMHMzU2MwNkMrYjBVN0ZNTU9OMk82UDhETzdNcGhTaVU5?=
 =?utf-8?B?Uml5ckhvWThTNUhBNTNqN3E5SlArdERWb0R3dUVFS0NFNzFiMEtvc2o5Kys5?=
 =?utf-8?B?L2hDemw3Zmt0NUlybDdyZEN1YktDZHV0U09pelVsZnNEb1lmbzZxRDRMR2Ju?=
 =?utf-8?B?cDEyNG42U2VWM2NDblJDK3RiQ2VaNVMwUkpOeEhleFpzVTQ5amtjRHlXQzNw?=
 =?utf-8?B?UXZ3UFZOUWtrWVlMUE1ubjVYTmRjRTltOGZtK2hPdmkzUlNmY2FNWG9RRG02?=
 =?utf-8?B?eG1SM2p0Q2ZCTnhrL2dIb1FXSlNNSlpMbnZ3MlAzaXo3U095K0lvODRRVVlE?=
 =?utf-8?Q?lJIzvyWsXoohpGXi/HRQWiAVc8VLhlwRN+ObALT?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a616770d-cbad-4270-d866-08d982e6c3e4
X-MS-Exchange-CrossTenant-AuthSource: CH0PR10MB5020.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Sep 2021 01:16:29.2698 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jhJNUDbPq9E7buvUhHDySSAnSBj4fRjvG9y5fnk+MaoBLDtX27618HkrnWHdJK3xpzGy+yEmdFGArONk3O23keonihVfIN3TJZZKU5DmGr4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR10MB5050
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10121
 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999
 suspectscore=0
 mlxscore=0 spamscore=0 adultscore=0 bulkscore=0 phishscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2109230001 definitions=main-2109290004
X-Proofpoint-ORIG-GUID: 5V-l9q6ebGhxpzbciIoppgWmMIrUUE-Z
X-Proofpoint-GUID: 5V-l9q6ebGhxpzbciIoppgWmMIrUUE-Z
Cc: Michal Hocko <mhocko@suse.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 x86@kernel.org, virtualization@lists.linux-foundation.org, linux-mm@kvack.org,
 "H. Peter Anvin" <hpa@zytor.com>, Stefano Stabellini <sstabellini@kernel.org>,
 Baoquan He <bhe@redhat.com>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
 Ingo Molnar <mingo@redhat.com>, xen-devel@lists.xenproject.org,
 Dave Young <dyoung@redhat.com>, Vivek Goyal <vgoyal@redhat.com>,
 Borislav Petkov <bp@alien8.de>, Thomas Gleixner <tglx@linutronix.de>,
 Oscar Salvador <osalvador@suse.de>, Juergen Gross <jgross@suse.com>,
 kexec@lists.infradead.org, linux-fsdevel@vger.kernel.org,
 Andrew Morton <akpm@linux-foundation.org>, Mike Rapoport <rppt@kernel.org>
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>


On 9/28/21 2:22 PM, David Hildenbrand wrote:
> The callback is only used for the vmcore nowadays.
>
> Signed-off-by: David Hildenbrand <david@redhat.com>


Reviewed-by: Boris Ostrovsky <boris.ostrvsky@oracle.com>


_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
