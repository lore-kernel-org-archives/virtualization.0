Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5D517C433EF
	for <virtualization@archiver.kernel.org>; Wed, 24 Nov 2021 23:55:45 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id C984B4053D;
	Wed, 24 Nov 2021 23:55:44 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id BMTW1qnSLtRD; Wed, 24 Nov 2021 23:55:43 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 40D38400BA;
	Wed, 24 Nov 2021 23:55:43 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 16939C002F;
	Wed, 24 Nov 2021 23:55:43 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id AD342C000A
 for <virtualization@lists.linux-foundation.org>;
 Wed, 24 Nov 2021 23:55:41 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 95387825DC
 for <virtualization@lists.linux-foundation.org>;
 Wed, 24 Nov 2021 23:55:41 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=oracle.com header.b="z99/Rd/N";
 dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com
 header.b="FVriNbvl"
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id HgCX6J91wJ5W
 for <virtualization@lists.linux-foundation.org>;
 Wed, 24 Nov 2021 23:55:40 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com
 [205.220.177.32])
 by smtp1.osuosl.org (Postfix) with ESMTPS id A460F82591
 for <virtualization@lists.linux-foundation.org>;
 Wed, 24 Nov 2021 23:55:40 +0000 (UTC)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1AONhSCW026924; 
 Wed, 24 Nov 2021 23:55:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=Wl0eipoH9VOGnK7u8uq2i+TrYCyPGPtVfm4hImPSjfA=;
 b=z99/Rd/NRyhKebPcEy0LMEzaidr2MrrxpJo5uuFn2aIswAPjbWc4z4lpjhk8Cj3KIMQV
 uxphpFSRqybMwSYx8NBNg3rzt6m6m4r08jAserY/MMT/pSEFrSVY0ec/T5xo9W23r1A2
 sASdGp7QkjDFqEyD3lNWLyPKmaZGboQCs0HVE4xvGVEBZJAlBoUbvP8XoYPbc/jY1tlc
 MNU7KmT5X7aL2yUpCJH/BC4azn+s+y0LgocxuhiPrZ8XbAcfQ7m7kI31kVB5Zf7ojy8a
 XpYIdPMyLPJVCOb9WxHBriYnZUoLW1Qw4deaI5qxpSX55VOfCYgcJjRjH+VEsXa7/b1U 2Q== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
 by mx0b-00069f02.pphosted.com with ESMTP id 3chk0042fa-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 24 Nov 2021 23:55:39 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
 by aserp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 1AONtOoC171657;
 Wed, 24 Nov 2021 23:55:38 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com
 (mail-co1nam11lp2174.outbound.protection.outlook.com [104.47.56.174])
 by aserp3020.oracle.com with ESMTP id 3ceru7ua3k-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 24 Nov 2021 23:55:38 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Omml4IOfUHIWeZMWk55bj6l412dAJZFH6CmkK+qd4idDuziBfYUVqKrLNid7wxgfiREm3uZ/gDdn3cN9WkWTlroav0OnzK3jZDerrIKbFZDLtp9xu4sqWdG4LXIOVfr0w190C60/9IJyIU79eyAdYS7MNknTy0ZK1UBHQMfYWT/u1IL/tcbXDpuQRHW6aou74PsXi1OwofraM0TbdzZkl2NQGYskbuRwYWnT/QGaI9ocdQBNVh43yMHy0bn54Ugq3JBx8qjWJikAkMWR4ROI2mmRylQS8MulehIAU1aw7Me2j7KxVxtLykenRHvQC/w4zFv2SeqmK/VIP+XHk3CimA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Wl0eipoH9VOGnK7u8uq2i+TrYCyPGPtVfm4hImPSjfA=;
 b=b6R2FK+TdyxFp3jl9fIIsW8+8+vwJ6osbZweiAcJH/4XLxN8NgCtdRDwd8XLF8AwuOzHEHcFfpqoI/MT2bZObK4fq1X/pHkM7j1N94v/uRJPCCSJu6Ym3+Zf6nwXN8av0Cki33v7KcCaN0jJS7eG+M3nsK4clI1XuAO7Zw6uCpnDt1wrRhIGfbJATsnGoyx48FdR+pUlVfzRSzmpm85YEWU4BobEuPTeI6OAnSAYVpHV+j+LSNwOWMkAkxP9gTAvo5Dqd7EZQXPlEdGFtaSq9Cw0qXZmdKR5x3wCall1GB+kGOY80UyVuiWdPDCAZ8plnNsifnkxhNG8mmA55udACQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Wl0eipoH9VOGnK7u8uq2i+TrYCyPGPtVfm4hImPSjfA=;
 b=FVriNbvlviAvnnC0DVhSc4j8MAa5lamNqLVFgqyeDkw+g3WPoIwtNNWUfJywTyON8sSo/vDGM13UTmjjtYzFe14UDMffndUEc/5I2rBOFGobcR8pUOzRgewA7r0laXjuvYbwhwvpaXF+Nzdu6wFOortNTeDfqQPpWPyQ11agrew=
Received: from BYAPR10MB3287.namprd10.prod.outlook.com (2603:10b6:a03:15c::11)
 by BYAPR10MB2981.namprd10.prod.outlook.com (2603:10b6:a03:8d::31)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4734.20; Wed, 24 Nov
 2021 23:55:36 +0000
Received: from BYAPR10MB3287.namprd10.prod.outlook.com
 ([fe80::89e7:42b2:b226:2182]) by BYAPR10MB3287.namprd10.prod.outlook.com
 ([fe80::89e7:42b2:b226:2182%7]) with mapi id 15.20.4713.025; Wed, 24 Nov 2021
 23:55:36 +0000
Message-ID: <1b98e4ad-ed83-7410-6381-a973ddc3912a@oracle.com>
Date: Wed, 24 Nov 2021 15:55:34 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.2
Subject: Re: [PATCH] net/mlx5_vdpa: Increase the limit on the number of
 virtuques
Content-Language: en-US
To: Eli Cohen <elic@nvidia.com>, mst@redhat.com, jasowang@redhat.com,
 virtualization@lists.linux-foundation.org
References: <20211124171953.57858-1-elic@nvidia.com>
From: Si-Wei Liu <si-wei.liu@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <20211124171953.57858-1-elic@nvidia.com>
X-ClientProxiedBy: SJ0PR05CA0103.namprd05.prod.outlook.com
 (2603:10b6:a03:334::18) To BYAPR10MB3287.namprd10.prod.outlook.com
 (2603:10b6:a03:15c::11)
MIME-Version: 1.0
Received: from [10.159.239.30] (138.3.200.30) by
 SJ0PR05CA0103.namprd05.prod.outlook.com (2603:10b6:a03:334::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4734.13 via Frontend
 Transport; Wed, 24 Nov 2021 23:55:36 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7baf472a-3e6e-42c5-ba24-08d9afa5e90c
X-MS-TrafficTypeDiagnostic: BYAPR10MB2981:
X-Microsoft-Antispam-PRVS: <BYAPR10MB2981C38139F6682F25F866B6B1619@BYAPR10MB2981.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2958;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: BEUMla09hIrjQV1PDJb7fGOon3GaosMaxYybdMsohiL9BnLaCledlAzNEI0jFXcEfeq1QmGcQH9r0nIUNw3oeXsgZsxfGMn58x2c02NEJPalvB8e8mTAoILV1x8Fdc4YUE5wsZQY9XhHf01/Hu0ESNObDuVw3wR/qUiEmMv5wOSKrL5CM3W9020aN8pGhsfSvkJUeOTYsdlocSvHYVmFXLl3Rzxv2jOtxfs7OV8LIZMiPkyoKVyrO/vtT1KLtG0ClZMhwXa9WGBDn+x3PXCJBK1JETlAAdNn3Ur8XiIiODIrQCCiiUGkVdLJEKZer12SXRk+uffTtnOYNIXmLL7vVUdDcLKF1snuvCBdLWuNx1vCooLSRm27fEj0q0ifyFo1r4PD0/dsP5UUafagWRNggpX19FsfivAY22xpxvr0APW4JAblcnwKN7jJfJm/v8LHACCr6Z/kAe2X0n453wtlW+ak1Wa7/wx3Sr/CoH7fyb7gVH0fZHx74mqk4pL2c4OkBqsH6sKhz26N4rzHmYr6Q4+z7MORhSrdJhTfj+BDbcB4XaUDhpWCLf1jJtW4nVHdWNKLDAxDZP1wzK0oVR/xC9GP/Sbt6fwWh976+gVuzEOXBEUZmMN1WsVRqqWz4MIuDEqKzoBV3eh8GcQlKdmJzJxTCncV07u8CBf9v8qmiFg1v0TJ2V4jksG45StSOft5wGs+a0DM60W35J5hn5rRczNf+PUx3K+E9jeyu/IXVDM=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR10MB3287.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(366004)(186003)(508600001)(2906002)(53546011)(26005)(31686004)(4326008)(6486002)(38100700002)(66946007)(86362001)(66556008)(66476007)(956004)(36756003)(8676002)(8936002)(16576012)(31696002)(316002)(83380400001)(2616005)(5660300002)(36916002)(4744005)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NktiZHhuRzQwUmt4QU5udlY1OGsxcFlMdWJyUWR3NW03N0JQZis3aVN3UlJQ?=
 =?utf-8?B?ZTM2UDJWa2NYRGY4RE9lM1FCWVdTS1NDeGVnNlFNMS90Qk9qVjRUcnBNZDUx?=
 =?utf-8?B?TW16Ty9qV1RIRHlndnEwQkFET29NMHp1K1hrMEcvZzk0THQzY2xDdXMzK2NF?=
 =?utf-8?B?eW9vYUxza2JiY2tjem00Y2xYd3Y3RGFhaHd6RGF2VnZiWmd0TmllTFVOSmhq?=
 =?utf-8?B?aU13OG96Y0VOcEtLdXpET3RpZE1kbzY5a1ovWXRDaWwwTVlVV0hLUTVpTWlr?=
 =?utf-8?B?Yy9GTTVLbWtEZG5rTURxWVU2cFRqYVJFZEw2V0hVMGsveU16K3BiTmFpemdN?=
 =?utf-8?B?WE55RVhmYUJ1d1I0eVlXbEdqTzlydndwejRTWVp6ZmdiNlVmTktBNk5hcDBH?=
 =?utf-8?B?MkwyWGZrVS9FTWovUjhUVVVxd2VRRlVGcjh6UGJHT1IyM2NsU2hqNEVYUDBo?=
 =?utf-8?B?QjdFcnoySnVlSnJxWG5hODVuZWxwMVV3RmltM2NJMjBqTHh5Z3BGa0U4QW1u?=
 =?utf-8?B?RmpBZW9SdTJlVkl3d0NRU09vYlJzTTlYeXVmWjFwTFNJNmx6ejg5VGVzbXlt?=
 =?utf-8?B?RmozbEEvYy81UmZLbWI1aGZsZGM4RG5yaWMxbWdZanlBdlF2NmdoanQzbXFi?=
 =?utf-8?B?MVY3Z1Y0dGx4RUNRN2xKTUNZeFZSOFJkRW94SG5aQXZjRlFuNElxNXlFd3lQ?=
 =?utf-8?B?cHJqTEJ1WnkzS0cwOTNIeGNaZm9ZQS9nK1lyUk56aWhnd3NsZmxweWVkN3Fx?=
 =?utf-8?B?WHFBZjltTDBXejBqc0R5Rm5Pelc1d0REU3ZHVzJtUk1hdjN2eC9sZ2pKUUgv?=
 =?utf-8?B?OENHUStMdTJ2aDBWLzN5UmtBRlBldEU5cU1oNDhMY0xsLzFGWGtSUk50NGRB?=
 =?utf-8?B?WkFRdk9RV2Z1MXFxVWxRb0wrSzYrUkp0aUwzQ1VwM3FIMlg4RlpBcnRxaFA4?=
 =?utf-8?B?aWtLMDNGWFFpTFBmYkhLUk1nRVROVjFESUpiU2xCZEhnQS9tUzBFbWo4Kzlv?=
 =?utf-8?B?bWlISmZNYU13bTZsZFNmU0V0dzhtYTl4OUNmMVliMllTa3ZETFFKWExuUlJn?=
 =?utf-8?B?WVdLYzU4ZCtWUVNLOUIrSVFCQVpnem0vK0pXamk1QWUxUkVQNG5sclU5SjAz?=
 =?utf-8?B?TEMrQU54YkFzNTZWdjdMZVZGNS9OUWpoZmUyTm5kQWNWa1J3N29ENzFBeGxD?=
 =?utf-8?B?bHRUN24zL1AvNVV4MVJxZFNMUjM2N1R5MVV4ekFwb01wcHpiQ2xUSUlrekFl?=
 =?utf-8?B?RWIwWUhJa2Y2UzlHL1RBbTIwMXBiankzelAwYkN0eEloSHgrODlwaldiNUJo?=
 =?utf-8?B?RTRvSVFxZEtuWUpHRkw5N3RmRjRyemZzQzUxY1pWQi9rT0RRbUdaeUYvS3VQ?=
 =?utf-8?B?bXpOaHIrdytBcG1KaE9Ea2xxekgzcm8xTkVBSUFHU29LZ0RnSmxxV0p1anNZ?=
 =?utf-8?B?QzQzK0ZXcGpacGVVN29JNldlN25Ebyt3QTBOTmhoT2Z4a3ZrUWhydzhkZ09D?=
 =?utf-8?B?YitEQmYreW4ySzk0aTNkL1o4aWIwdWNJT0Q0TUFWUWxVN2pDOFNNOC91ZGh3?=
 =?utf-8?B?c21JVzN2eFV6U0o0bktQU3o0TUpsUlY3eGZaS0Q3U2twcUFrbHk4Q1ZOVnBx?=
 =?utf-8?B?YTV5YmtQR0Yyd3p5UnFJOHY1bnIxclZFWFd1SFo0V0NUQm85VUZCc0VNME16?=
 =?utf-8?B?enljMDBVYkJuQXQ5T0xNc3BVRHZZb0xJakVOSXc4OHNqU2hUNnQ5VkxhTDQx?=
 =?utf-8?B?ZjYvcGZLU1VjRjNxbHA4Y24zOVZ0aVM1VnV6ZGh6WitZYm9PT0hQRXNESk5o?=
 =?utf-8?B?dlVrdDhyMVNPSjk4clJHMkdFWWtDQTVqZ0k5NVdxWUQ5aGNJSGErU3JQaXJB?=
 =?utf-8?B?SDJUQXlIU3E5TENEMHlkQjFYTjB6YnAyN0FKSHZkYmlFNm1aRFpIRzA4MXJq?=
 =?utf-8?B?SGtLZTE1RUZxVGFqc2ozMit5Z3g5VWlVZWtuY0RNNHAxa3ZIcE5pVFVzUXNW?=
 =?utf-8?B?N3VUSHRqYTlpSkIvdC9hT1FJR2RHcEFjYUYvK0llcmdmU0E5c2UxbjM4VmFl?=
 =?utf-8?B?cWxQSEY5QUlSNEcvVTExUFNqZFhvU0hLMlBzdFl4SVJZOXZ0ZGxrMkVNS0FH?=
 =?utf-8?B?VkowZnF5SU5oVjJCVXl6NURnNE1iWTcvUTQ5ckd3Q2hqT2N5cWVzUCtPdll6?=
 =?utf-8?Q?v9F7MfO+zEYLfzJywGn1nys=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7baf472a-3e6e-42c5-ba24-08d9afa5e90c
X-MS-Exchange-CrossTenant-AuthSource: BYAPR10MB3287.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Nov 2021 23:55:36.5025 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8dHhJFPcDX3O37ZhD3xuTs0P6luEUFULSD1pMnvasvSB4dFBB50hVHKmYVT4+y86xxiXCZ6Apvk5Vo2KDO1EvA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR10MB2981
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10178
 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0
 mlxscore=0 spamscore=0
 mlxlogscore=999 malwarescore=0 phishscore=0 adultscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2110150000
 definitions=main-2111240116
X-Proofpoint-ORIG-GUID: 48ISWwktgnj3Tiq71QjV7r1FEzlxQVJg
X-Proofpoint-GUID: 48ISWwktgnj3Tiq71QjV7r1FEzlxQVJg
Cc: lvivier@redhat.com, eperezma@redhat.com
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



On 11/24/2021 9:19 AM, Eli Cohen wrote:
> Increase the limit on the maximum number of supported virtqueues to 256
> to match hardware capabilities.
>
> Signed-off-by: Eli Cohen <elic@nvidia.com>
Acked-by: Si-Wei Liu <si-wei.liu@oracle.com>
> ---
>   drivers/vdpa/mlx5/net/mlx5_vnet.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/vdpa/mlx5/net/mlx5_vnet.c b/drivers/vdpa/mlx5/net/mlx5_vnet.c
> index ed7a63e48335..8f2918a8efc6 100644
> --- a/drivers/vdpa/mlx5/net/mlx5_vnet.c
> +++ b/drivers/vdpa/mlx5/net/mlx5_vnet.c
> @@ -135,7 +135,7 @@ struct mlx5_vdpa_virtqueue {
>   /* We will remove this limitation once mlx5_vdpa_alloc_resources()
>    * provides for driver space allocation
>    */
> -#define MLX5_MAX_SUPPORTED_VQS 16
> +#define MLX5_MAX_SUPPORTED_VQS 256
Did we check how much increase of memory footprint ended up with on 
struct mlx5_vdpa_net?

-Siwei

>   
>   static bool is_index_valid(struct mlx5_vdpa_dev *mvdev, u16 idx)
>   {

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
