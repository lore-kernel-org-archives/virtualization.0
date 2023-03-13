Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3B21DC6FD19
	for <virtualization@archiver.kernel.org>; Mon, 13 Mar 2023 22:19:32 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id A3801417B7;
	Mon, 13 Mar 2023 22:19:31 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org A3801417B7
Authentication-Results: smtp4.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.a=rsa-sha256 header.s=corp-2022-7-12 header.b=19sl6k1U;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.a=rsa-sha256 header.s=selector2-oracle-onmicrosoft-com header.b=lTulxJLi
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id xr7ggmS_F9vu; Mon, 13 Mar 2023 22:19:30 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id B7198417B1;
	Mon, 13 Mar 2023 22:19:29 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org B7198417B1
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 8A6DDC0035;
	Mon, 13 Mar 2023 22:19:29 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 8FD0FC0032
 for <virtualization@lists.linux-foundation.org>;
 Mon, 13 Mar 2023 22:19:28 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 54FE060FEF
 for <virtualization@lists.linux-foundation.org>;
 Mon, 13 Mar 2023 22:19:28 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 54FE060FEF
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com
 header.a=rsa-sha256 header.s=corp-2022-7-12 header.b=19sl6k1U; 
 dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com
 header.i=@oracle.onmicrosoft.com header.a=rsa-sha256
 header.s=selector2-oracle-onmicrosoft-com header.b=lTulxJLi
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id bxAhmT8j56On
 for <virtualization@lists.linux-foundation.org>;
 Mon, 13 Mar 2023 22:19:27 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 2793960ABE
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com
 [205.220.165.32])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 2793960ABE
 for <virtualization@lists.linux-foundation.org>;
 Mon, 13 Mar 2023 22:19:26 +0000 (UTC)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 32DLtpS8022657; Mon, 13 Mar 2023 22:19:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=QeXy2Y2oWQlqQ8pcY//2ap4zdBXttn9ggR0jWkOy3dU=;
 b=19sl6k1UvTFowzI9azibEZKS46BwJjzo2eY9Fb+/G/CSDARWSR0b1tuL4eIy2+9fqwFH
 hAgGdQfDE1LFPq8cTVK1gqwgCxMbaOhqz831mKqCTK55PDpIZ/NKnnaQg//FUN5H4KI1
 O3Ac9aLXvMvAW6JLJXpkjY6RVmEkfMwAAoJIL3nIV435u1Z1TcLYguTXY+ierqX3THBm
 3hzZpx2YHEFszrYE6f5DszDTsOxRRBwypMqa4HAehOpQQNceoC6+4nnVIfYuDc/iUr7S
 Ojpsa6FTQk2o1eLXWyAoWRYdOGuUps0SPBcAse1gsXiR+OAF/2cXCUGLbbiLGBd/bIw4 dQ== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3p8hhad3cq-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 13 Mar 2023 22:19:26 +0000
Received: from pps.filterd
 (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5)
 with ESMTP id 32DKMXLq002307; Mon, 13 Mar 2023 22:19:24 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com
 (mail-bn8nam11lp2169.outbound.protection.outlook.com [104.47.58.169])
 by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 3p8g3btspb-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 13 Mar 2023 22:19:24 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GWcYKquk1oimnfNh4nJZpVmtvdKSCVTzr5+XLUCij0uCnSpNomHAv+ixktordmLFCww6Ny0hvQre1jShfewCLmwOFqa8T4Bsc08ZyKOsLws8iNGb1GPn5zv9/DqyYCHYeIDVq8tGOhg/QwSB8kDkG0RI/xs+Rwl9sl569hiKNfPOvQj+vRZJNsiTMPmyTNtPULHELbgeeOuu59FsF9QtocWhZWITt/YVwuRh0AXyg7DVI6KpOADixKmGPUJKB4VCBDjLv+zTrQaih1TMXU/FifJedd+44srlO0rFF4VIVG5ZwoFm84cJR5mcZfaNNF2krmvrujdX7AuJ1PObF4tSsA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QeXy2Y2oWQlqQ8pcY//2ap4zdBXttn9ggR0jWkOy3dU=;
 b=fRtXhWDoyXxRVejyccKhKpIc/CRrXFFBiIxN1xmVSegwhDIWJq1/VA6DTEMOICqzTIv6m55razh7BH81bstVV00Janl2N1/IuCGL9x6XMSTG7t69wlMOyMW5uOXquUi3QO6B0J4AIvsOwZ0nnLuKIltINm7J5Bwk6bKQD2Z3k4Do78+EyLC/sR3OnxyBEstaZBzWPp+kqCST73ssikAAgQfDGW63+ZepJosyettbTOZFaR3LAn290CuCgbWVCl2ZHwBJcm4TQ85NnJkaIOyFOUKFVqa0KprcWJymQxyUDu27VSA/vMVmMsYa+cyFQQY6JxyJHL7Ahl6AmprCvdvuig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QeXy2Y2oWQlqQ8pcY//2ap4zdBXttn9ggR0jWkOy3dU=;
 b=lTulxJLiGLOHiyhrS3JpxYGUXg/gVPskzoJz6sJQLWL59Uj3p/aq98NCOOxkIi9sPgy9V/i+MxH3R+uIprMVPOteGSFWkgZhVu8wVkMBLwYvYakIWI8aTx8Im3w9Gw+TdLvuE3XD1fpDmtgOI/76pX0lWuWW74Ufgsm2dprYeU0=
Received: from MW4PR10MB6535.namprd10.prod.outlook.com (2603:10b6:303:225::12)
 by BY5PR10MB4321.namprd10.prod.outlook.com (2603:10b6:a03:202::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.24; Mon, 13 Mar
 2023 22:19:23 +0000
Received: from MW4PR10MB6535.namprd10.prod.outlook.com
 ([fe80::25da:8594:cf75:8ef3]) by MW4PR10MB6535.namprd10.prod.outlook.com
 ([fe80::25da:8594:cf75:8ef3%7]) with mapi id 15.20.6178.024; Mon, 13 Mar 2023
 22:19:22 +0000
Message-ID: <f269688b-8392-406c-e070-369b25acc252@oracle.com>
Date: Mon, 13 Mar 2023 15:19:19 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH 1/2] vdpa/mlx5: Make VIRTIO_NET_F_MRG_RXBUF off by default
Content-Language: en-US
To: Parav Pandit <parav@mellanox.com>, "Michael S. Tsirkin" <mst@redhat.com>, 
 Eli Cohen <elic@nvidia.com>
References: <20230312083920.2300028-1-elic@nvidia.com>
 <20230312083920.2300028-2-elic@nvidia.com>
 <20230312045717-mutt-send-email-mst@kernel.org>
 <f01c7204-5629-297e-47b6-06e58bd3f543@nvidia.com>
 <20230312054559-mutt-send-email-mst@kernel.org>
 <PH0PR12MB54816C24BAA322567BED21A0DCB89@PH0PR12MB5481.namprd12.prod.outlook.com>
From: Si-Wei Liu <si-wei.liu@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <PH0PR12MB54816C24BAA322567BED21A0DCB89@PH0PR12MB5481.namprd12.prod.outlook.com>
X-ClientProxiedBy: BYAPR02CA0004.namprd02.prod.outlook.com
 (2603:10b6:a02:ee::17) To MW4PR10MB6535.namprd10.prod.outlook.com
 (2603:10b6:303:225::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR10MB6535:EE_|BY5PR10MB4321:EE_
X-MS-Office365-Filtering-Correlation-Id: 8780f10c-fa98-4c4a-21c3-08db2410ff63
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Ia67oKMaFgewm7oktE1RHh3CnZyCWpm/OOS2/OVyl3vXdMYELIhLov+XTdm2af3pNENpoxjiaAjCrEIRfLxFoow2z2s1FL+7njQDy+gQZ1HIRQ2b1PVIMPY20wYOz97pcEj0FbZO6RXrtY2aB2YDD0UH8b5z3ZxVnDF+CrPthZ4e3WaRZm7sJzI+22tUJhOjNbMOULxLRmWNrv7EUw0X9p5JQuvnuomqC6k6fjekvqXaBv/g0ji5Qx7Kct+ekK7ev+wv+eUzcQmzqDSgRpRNEVMpwIRPzVGcosH1BYRNioTVfIt/PkvCnrIpq4azsucnn5AXliepoFDUGWE+lP/9hMa6oRPMw6o3oubYcQDFy/54UVAyL6FhKg87cHKw98ziIelw5fc/bcTrqUk2X8sGqdRyFtwqmVjJbaLR2KEJ5qsqwOUWR00qcygR6AeiuHb1LSUtYDc0odlQS2Ae7NFJAAnItfTgibFL1nAaGJZDX4pwszVCpQnZRKK9kRhPK1mMbjeNCNeEOH6HOP/GaMYQ06ibpZacc0UT6vg8/2hJy/1zok6UCG8pKmNsn95BzeDxHz2FL/UTqNmXEdhFFzlia8U0NYNZUqqAf7Bvyz+MvoidbS8YelA4OB1xoscCFDWzacSRwBgSUSV9z+I8N+DBBhYVjqAjANLIMiAFekFZ4UpC8xqZfKt+tHAtcyk7LXv0pCRVok5DeZ4O+0wXCPpmpyvFi5MewLYxkXzWBfCvmYM=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW4PR10MB6535.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230025)(136003)(366004)(346002)(39860400002)(396003)(376002)(451199018)(31686004)(8936002)(478600001)(110136005)(54906003)(41300700001)(66556008)(66946007)(8676002)(66476007)(4326008)(36756003)(31696002)(86362001)(38100700002)(6506007)(6486002)(53546011)(6666004)(186003)(6512007)(36916002)(2906002)(316002)(26005)(83380400001)(2616005)(5660300002)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QVQyRWo4a3ZDQ2xkK3VKYm13QmJnUEZlOUlLOUJjTjU2clF2cFQzS0ZLQldx?=
 =?utf-8?B?U0JYS1NvU29rQ2hqVlF1M2dkQ0FoalpWYU9zcGVGcXZkV1hHaDl2MWNCY1ll?=
 =?utf-8?B?OGVNS1J0WXRWbHFoYjlnZkJuT3hpMWt2ZEUwR1lUa1hWcFlHM2Fvd3VISDVp?=
 =?utf-8?B?V1AyR1d2VDlUdDl0ZCtIQ0dOSWlWb0VSMWU2Y1dMNHRMbHRSZEZvMWtHZXJU?=
 =?utf-8?B?Z3dMaXl3aVBBRlNRbm04Y0k4K3FsR1p3eklRRG5VK1NHRWNkbGxHUGFjWlFO?=
 =?utf-8?B?TnBZbnNYM2dCR2tPZ1M2MDZ4QUZPdWtVTDdxa1pMd1kxZ2JZaUdUWkduL3Za?=
 =?utf-8?B?Zmo0NHFpTTFwVVd2cXVJdURqbkhzQjB3Q0doWm96QWptelRoaFdJOVNlbDdM?=
 =?utf-8?B?VVZLMndyUzRHOUpzQnJrdnpWYXduWDRQVVh4ZHpOOEpLL1Y0aEgvcHRJR1cr?=
 =?utf-8?B?T1VPYmgveVJRSHY4cUl6bFp1V3ovc0pwQkF5U2RNQVA2SDkwV1lwaXdpN0xk?=
 =?utf-8?B?dUZ3bEFXWnJtNlpoNkdKRFpqNFFZTXp5Ujdaekk2K29TNVFKeVVMd3pabkJB?=
 =?utf-8?B?N0k2V2UyMk9ETkkxSzNSSGN4L05YSm4ybEREMEpVS3F5UzgxeUFDd0RzTC9y?=
 =?utf-8?B?Z2k4MitmY2dqSzlDUXpDdHZSMnIvc2ZiUUhvMEplNVBlbGJUODhkK1phcFM2?=
 =?utf-8?B?dG0walZmT1B0aEpsQ0dxZ2dmVjRQSEFuSUJLUEp0aExFTGMvanJ2YnlRMkR5?=
 =?utf-8?B?MFRsdFBDMWs0SHE5cDFwb3Fybmo1M2gvZUpKSk40ZVhOV0tva2ZvNDhXZWFW?=
 =?utf-8?B?aVlpLzhKNG55dkR4Rmhxc3crMG5lNEpyclhRSjZseGJyeW9maDFHL0hpUit2?=
 =?utf-8?B?c0l2KytRaEI1NUw0OHZCd0lpakJXRU5IYWRhdFZhR2ptRnlOUENXbkhpN2lh?=
 =?utf-8?B?d1NPdnBLVTg4REdLanVZWVpkd0pXT0FXMHp6MG8yTWM0ZlRHMlY2NlpDbEMy?=
 =?utf-8?B?aFBHV0JyUlNtaDBtbXZaK3BjY04xcGM5QTVGM1lLeVFKNWFXaUhCZmNidnB4?=
 =?utf-8?B?dWhUS0IxZldkVXUrT09JeFpjQmRKdWVuT3JLTWpDNFlDMnlNMXBpemlNcldY?=
 =?utf-8?B?QXMvWU8zNEZwb1V1S0tCY0dBaHp2aFI2Vmg4SDY3dnFhY0FjQTBuWmJqOXFn?=
 =?utf-8?B?WGl2M2U1dXZSNm03WnJBb0NyR3NvdXczTFM5bXNJR3E1QXY1MmxmM0hVUjBG?=
 =?utf-8?B?REloRUtjVWhGbURmSGdEY1ZzM0M5WC80WWJ4QkF0b0JCalZDb1FQSkg5TktD?=
 =?utf-8?B?YnVBWjNyV2tiNWhhdjdaOGN5dklUQ1lXak9XdmQybEVPdnBlREozNzBNSnJH?=
 =?utf-8?B?TXVjZzdkdjJjM05kWkFReG9XbnUrRXhTRG94UXFRY3cxVHNwdVllbDNSUnhT?=
 =?utf-8?B?M2N3Y0ZBbmZtUjRDaFljTitDODByY2VnOEZMOUh4RUd2TjRtc00xQ2hBSjdL?=
 =?utf-8?B?OWJYL3h6My9UUEN5VkFKTmdqakgvQmlPTCtUWmQ2WU5FRkhiTUJWcnRLLzY5?=
 =?utf-8?B?cXRSelFNMmpERE14Vy8vYTJjMjl5VEhCU1hvRHVmazZ2STIwQW9tQnBGRmRM?=
 =?utf-8?B?MjZKWW9vSzB1amJwSnhUeFNPVVJobTR5MVBSTGZ5ZURLMTJ6aDdQU0djM3lv?=
 =?utf-8?B?c0lsMHk0V0s1Q2YxSEpoZUsxNVZDL3Blb3lnUXFGaEJITFZHeUtUYUhQUFFt?=
 =?utf-8?B?RC9nNnh5RmJTMDJSZ2xVamRra0MxOXlQb0EySlYzVUdKR1NmNFI5S0kwakZy?=
 =?utf-8?B?dWZGWEFUS1VyV3l4WTFhL1RySHgzVTFxNjVsTkFVdlE2MmhhaFdjQ2Y0R29o?=
 =?utf-8?B?cVdDYkxibzM3TlU3cE9FU2RIaU9WbS9WNmM3dWlZMWR6UHZMN0JUYjdpSmJC?=
 =?utf-8?B?VmVaMXlNTWZYUlVnSTNPSkgyUUdnUE4rdHdCMU5SZk0zaTJBVGtrWjJZbWU1?=
 =?utf-8?B?Qi84SGpoT1ZxTjlNY3NaeS9pdkdBc0Uzc1hHMi9FcGZ3ekpsWUpGTzcxQ1Uy?=
 =?utf-8?B?eW5vU01BQ2JXbXVhcGFiMlZYWU9McHZoeVZPcHZ1alVDU1J1VGVrRDBJQ3Ay?=
 =?utf-8?Q?NxfpYFacj31EUR3xtdb2D81ju?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: MUgEmDvHmniWapabfh8bscjD4rC3rXAoPmzaxf5tfulMLLGI7UYnp3IH3bAGGzw3IfsEdOemUDpx8MiV9IcbwmYYnAKasaRgzMeyYtbBVEWWrOkMDlBFoU6y4zinX7jNebJrJWS13meJUJJdf2u4LtvSLjtuPXjhWCXfLL/W3bLPEwns8UL+gJ7grQxlniLM4wV0UCzv59BuDSnghOeVSPrjO0AsTZ048a0+X7JeKUcBOVrAb2+Lskf+IOJQlVQ/kGV8ad1nm3iU5BB5sUUOeVwFhOgO/KVrQ9KuE2gRz3XasthEDIuyrl9NUDG1g0kBlsZGtoeyivnXfqG0iR1bHRaoBadt/0OEeFBLxgsJ89L3M19B+mFWsNDXcGd4T3vHWUqCZNCFACPkbLonvlZ64w1XNT3QjDoEBcixG36yOsGpj7lv2p9BlMdAT2JM6R1eM3dDnWheXQWA1EoiJnbfaT1tqB4nB4wCzcQBsnxJtnj7Y9K0LOp9Uh/gakiuwd3AQVPQeeanwTR+KXsY1pC2G+cZs01nPsrV6GybpImot05GuhX2rD7u1HABCZpzIdoVEA8vfWZY3m7hukMRv9RUN40cyuyZ6bTS7usOlxWmunuG42TH8bajPAQxo0lhTdq5F1YjrejnPKl/qt1Bd9AJXdgmP+Gdj9P/cR6Ut8PijM6qSJHxfWk8RaZ/ceMqmApT5NhWITW/qYTOoSIukXRInMAWd8MqBSLZM8JdB67OxE4Qe7CHDyL+Fvpr6WLfc8BtSEg8DpAJhCBiePWdptCXI/RMNDpgcBo4xduOZP6E1ndRrhX8bq2eBOPIYvOVvLhmDoiaJTZ+aehd0ov9z7GjIELDmF9QMhu8rH6sRqgyw27Tl3LijTNgNWrWSlR1/4dd
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8780f10c-fa98-4c4a-21c3-08db2410ff63
X-MS-Exchange-CrossTenant-AuthSource: MW4PR10MB6535.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Mar 2023 22:19:22.7551 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vncb5z6FgxuS+5WBo+wZjHkRH6sq0VjpMJ4SzN/89CDkQl9f8CzpIKucL4x+TY4nNgHKvpCqg2C1O9G8hbanaQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR10MB4321
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-13_11,2023-03-13_03,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0
 malwarescore=0 mlxscore=0
 mlxlogscore=839 suspectscore=0 adultscore=0 phishscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2212070000
 definitions=main-2303130175
X-Proofpoint-GUID: _QGPKZwDchT77uh7Wm_u7XUKxg6svHmk
X-Proofpoint-ORIG-GUID: _QGPKZwDchT77uh7Wm_u7XUKxg6svHmk
Cc: Eugenio Perez Martin <eperezma@redhat.com>,
 "perezma@redhat.com" <perezma@redhat.com>,
 "virtualization@lists.linux-foundation.org"
 <virtualization@lists.linux-foundation.org>
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>



On 3/12/2023 6:28 AM, Parav Pandit wrote:
>
>> From: Michael S. Tsirkin <mst@redhat.com>
>> Sent: Sunday, March 12, 2023 6:25 AM
>>
>> On Sun, Mar 12, 2023 at 11:10:25AM +0200, Eli Cohen wrote:
>>> On 12/03/2023 10:58, Michael S. Tsirkin wrote:
>>>> On Sun, Mar 12, 2023 at 10:39:19AM +0200, Eli Cohen wrote:
>>>>> One can still enable it when creating the vdpa device using vdpa
>>>>> tool by providing features that include it.
>>>>>
>>>>> For example:
>>>>> $ vdpa dev add name vdpa0 mgmtdev pci/0000:86:00.2 device_features
>>>>> 0x300cb982b
>>>>>
>>>>> Signed-off-by: Eli Cohen <elic@nvidia.com>
>>>> What's the reason to turn it off by default? It's generally a
>>>> performance win isn't it?
>>> It has negative impact on packet rate so we want to keep it off by default.
> The performance characteristics is very workload specific.
> It is less of interest given the primary reason is backward compatibility, more below.
Actually there's no such burden or requirement to maintain backward 
compatibility for the default 'vdpa dev add' behavior if dedicated 
device_features is not specified. Historically the default vdpa creation 
on mlx5 ever got changed from single queue to 8 queue pairs when 
VIRTIO_NET_F_MQ feature was first introduced to mlx5_vdpa, then the 
default switched back to 1 data queue pair again when max_vqp attribute 
was added to the vdpa tool. Essentially, every addition of new feature 
to mlx5_vdpa, e.g. CTRL_VQ, CTRL_VLAN, and et al, effectively changed 
the default "vdpa dev add" behavior not just only once: the backward 
compatibility guarantee is simply just not there and ever.

-Siwei

>
>> Interesting.  I feel this would benefit from a bit more analysis.
>> Packet rate with dpdk? With linux? Is there a chance this will regress some
>> workloads?
>> VIRTIO_NET_F_MRG_RXBUF was designed to save memory, which is good for
>> small tcp buffers.
> Eli,
> Please update the commit message.
> This change is to avoid regression in existing systems.
> The device previously didn't report MRG_RXBUF cap and it was not in use.
> Lately, certain devices are reporting this feature bit and it is breaking the backward compatibility.
> So the driver keeps it disabled by default.
> User should enable it when user prefers to.
>

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
