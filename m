Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C8FAFC433EF
	for <virtualization@archiver.kernel.org>; Wed, 22 Dec 2021 07:29:55 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 60884415C7;
	Wed, 22 Dec 2021 07:29:55 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id zHdRJO9fulD1; Wed, 22 Dec 2021 07:29:54 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id CD997410D1;
	Wed, 22 Dec 2021 07:29:53 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 8CFBCC001E;
	Wed, 22 Dec 2021 07:29:53 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 17ED1C0012
 for <virtualization@lists.linux-foundation.org>;
 Wed, 22 Dec 2021 07:29:52 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id F2C5382D0F
 for <virtualization@lists.linux-foundation.org>;
 Wed, 22 Dec 2021 07:29:51 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=oracle.com header.b="JHnw1Dx7";
 dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com
 header.b="fsSBe++O"
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id p5x7cQj_j-Q8
 for <virtualization@lists.linux-foundation.org>;
 Wed, 22 Dec 2021 07:29:51 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com
 [205.220.165.32])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 2270E82C9C
 for <virtualization@lists.linux-foundation.org>;
 Wed, 22 Dec 2021 07:29:50 +0000 (UTC)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1BM7Nr4A004864; 
 Wed, 22 Dec 2021 07:29:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=W2SGgS375fBNGoDvX9Jk7+CfKFEtesxODLHF7F0gvwU=;
 b=JHnw1Dx7b4XknBTh9AwxyE6WvHHBiLCNR7ZFd92BNOzg3miqxJnCaIYjQWM7H/HQFnYH
 PmzHSu54akEQsLNT3TuPh/Dk5H/NeKEZvaQXOBOqA/S6L4aFzrSe3a9j9/102NxQdRcj
 YKLcAj+s3eh3Zu3zfP0XSp6GtYnEGcXmDPg5RZe61Qxqt3BAjNmxRB+GP2PpHFUWXo7T
 2oD1JecYztVcCAVxvbZELg4ltj15QjvGQSxxPC3nbyLsS7mSlL5nr23uBKckNR9F4toK
 v1mG1vSUMGNgGZbet89myWhY2Sgn/2A2iQtpWzxbx5dsO1RPh6hJrar09KAqHINOsDjj DA== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
 by mx0b-00069f02.pphosted.com with ESMTP id 3d2qbqwhda-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 22 Dec 2021 07:29:49 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
 by aserp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 1BM7AtoU031910;
 Wed, 22 Dec 2021 07:29:48 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com
 (mail-dm6nam12lp2177.outbound.protection.outlook.com [104.47.59.177])
 by aserp3020.oracle.com with ESMTP id 3d17f4ydb2-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 22 Dec 2021 07:29:48 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cXKUM8SQmGBCttp17WTLdTmqXHtKGV+MXR9pltklRfz+463Ect/3BvW5nfw0FQE9fSoinc4JonJPFGwwnZX6NBPeGzGbpBligy0UxfAf8vYsSMH16KT2tZ5lL5cF0xVR9YCi0dxNpgNmwPR0NlKSpsHcfnGbJj6WVXcOBOXfIbBtSBRPWtlOBuZ5SgYRn7YIWtPsqf6CX5iploKzY5bY+0hOF4okC1Hjbvc1DWqrH80do4Z3P6n7YXIuYKyjt28IHh7ug/8tL2UnxUq27w9JI+PKGqD29ECppqPVRwxyujqACp115tMHdue7+b7ZYwP3WTG4eYpfMAn78ZuSBR8hzg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=W2SGgS375fBNGoDvX9Jk7+CfKFEtesxODLHF7F0gvwU=;
 b=clqRYKxcbcYds74oByVKB8KOA3uGptUAe4aL01nEpo4ETCRTIK0HGpPhDaQwuPGkyQ6ao6kBW6UILx1xqvY+MAnNm2ZHAc4LfFbe/gKnn3IesrrMHR4VwZ7q5NxMpmVt5sgUcSjK3sgQXTSej1ekAgQ8AVufGWNSWjuvxRjuBzGoXOBsnVhtd2gR7vw4ZOJFfJV6erNzqu7umNDmhNiNJQUusM2qkhJmXpbKZE5n8awv9v+Toa0+/Hb2Xiydcu+Cv37GQSHvNtdVPun5FcZKzEWv9qT/4TfBKoUcy2YW9OMtTf+NLCcYMto0CVG7N2N51y/+zsteQzRhn3mpQDHpXw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=W2SGgS375fBNGoDvX9Jk7+CfKFEtesxODLHF7F0gvwU=;
 b=fsSBe++O2eaz1qRDhNWEwnma/UpmAYuVixdZ8KQrKv4h1qsOglfjWG+uaKRj30nscfKIhQuiGv0N7hqalJ+kOpRyyhxzo8mnRenoTeR99Sm5U6ius8BnUSLazPRJAT5F6j4BIAETUpDPefdttwc54P2FM2V3EO+aZkPaQxl/Gq8=
Received: from BYAPR10MB3287.namprd10.prod.outlook.com (2603:10b6:a03:15c::11)
 by SJ0PR10MB4752.namprd10.prod.outlook.com (2603:10b6:a03:2d7::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4801.14; Wed, 22 Dec
 2021 07:29:41 +0000
Received: from BYAPR10MB3287.namprd10.prod.outlook.com
 ([fe80::7c7e:4a5e:24e0:309d]) by BYAPR10MB3287.namprd10.prod.outlook.com
 ([fe80::7c7e:4a5e:24e0:309d%3]) with mapi id 15.20.4801.020; Wed, 22 Dec 2021
 07:29:41 +0000
Message-ID: <84292943-b4de-8162-1fde-fcfab479b629@oracle.com>
Date: Tue, 21 Dec 2021 23:29:36 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Subject: Re: [PATCH v5 10/13] vdpa: Support reporting max device virtqueues
Content-Language: en-US
To: Eli Cohen <elic@nvidia.com>, Parav Pandit <parav@nvidia.com>
References: <20211221172006.43784-1-elic@nvidia.com>
 <20211221172006.43784-11-elic@nvidia.com>
 <e98dfbaf-8a2d-4cd6-c875-b4780137b0f8@oracle.com>
 <PH0PR12MB54816A7E1D045997B797961BDC7D9@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20211222064728.GE210450@mtl-vdi-166.wap.labs.mlnx>
 <PH0PR12MB5481C33A91EAE3AADABA73E8DC7D9@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20211222071036.GA213382@mtl-vdi-166.wap.labs.mlnx>
From: Si-Wei Liu <si-wei.liu@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <20211222071036.GA213382@mtl-vdi-166.wap.labs.mlnx>
X-ClientProxiedBy: SN7PR04CA0083.namprd04.prod.outlook.com
 (2603:10b6:806:121::28) To BYAPR10MB3287.namprd10.prod.outlook.com
 (2603:10b6:a03:15c::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 36310ddf-4d74-4368-3a31-08d9c51cd16c
X-MS-TrafficTypeDiagnostic: SJ0PR10MB4752:EE_
X-Microsoft-Antispam-PRVS: <SJ0PR10MB4752765833A226740F79B0CFB17D9@SJ0PR10MB4752.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: G2WvR1OBNhQ1iWwNbNqTppt7KPWe6BAxwpqzLoXzyz1YXO7PscLq9kn5V7jbikNA/WkZuyO7bjoa8WYTMwZsJUmWM5pcynfEnEQBZabBqN3UcjV3aIyEkw2U+Xu6fwvPsgdCKHYbxt11DCm3/1vcn74HRluqai2VhJArkFGzNI/esKbh++fJOf8DhWLFIqMAlYsU5kI7J4VeILMP2MYo/paEZ96ij7Gwpf8Sucu3Kw9tWw1AuqzOfpPxtEhB1r21kDXbalWFw02lUkoJo5h4lzT2ylh5FW/apf2toKDK94w4848wo6O0MBVl//eWOriKfqEUqXXKFoh1i+jSDggkJWrkvsofgqKjDcvCtBIIPUXjoSYNYwq37S/hQsnrknOmbTM89ot8dKV/2bsQKpDhO2n1ITjTAwBQ4B/+xK/nv4pjh+BbIJ79NX4gheIvKJfi4QZC5yJiPfC9LMPeYz4HCB0QNrwERbH6SotwCSl3tOqFjthk6n8JgyDUWQvsFTF3jD/4MB24+SK/4f27zV3jYNAy/OLe/fG1zA1BBDYTtE1dcau/vPeiEi34zMp9rH5ik2+XJGGiNGAJfWR1jK1mnumjwcHwE07ehGZ/0Fa4PCD1QvMvt5exjpcAQBADcM6tQe1jdc0ZYyoJtlnLDf19Z9n2hTEVK/8hTyDpH0QU9o67q7cE94ROhA5ZFuFS0doz1CcyuqT0NMcWfSi+ZzkKWS728w+aMYZMDZTi8W46pes=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR10MB3287.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(366004)(2616005)(54906003)(2906002)(6486002)(110136005)(38100700002)(53546011)(31686004)(5660300002)(36916002)(4326008)(36756003)(86362001)(316002)(6512007)(31696002)(8936002)(83380400001)(26005)(186003)(66476007)(6666004)(8676002)(508600001)(66556008)(66946007)(6506007)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aEkxRlRyTXhGK0Jmai83aFBDdE8xQjNsN0RWSFpTSUc0NXlTaW9qWFdSM0k4?=
 =?utf-8?B?enhXVXRGZDNsV3gwb3pjbFNycDB5Vnl0T1ZScEMrVGExRElVZlphWGJFcjc4?=
 =?utf-8?B?Z3dPQ0FFckhITjAvVXU5VW9IVllNREc1ZkFOY1FnTSszaUZYQlVRY0V0ekhP?=
 =?utf-8?B?dVVma1YyMmN2WFVyZmduNThCdzN4NmFRMGtCSXBZdFpObmZSN2ZQeWQ1Mk9i?=
 =?utf-8?B?TTR2QmN2SG9xRjZuN0hqNHQzbGgycU9vVzJOQk5CbHBnNCs2blFydnVvYW44?=
 =?utf-8?B?VWJuYVZwUzNic0dtOHloUlhZWW1sblNrTmFxa2dSd3lKVzgzSnRlTlRGZDdU?=
 =?utf-8?B?TFNoN0pUNFVrL0NzV2ZkeWVGSlNNbktjYWFEVDhUN08xSXRPelNTUjdwWXlO?=
 =?utf-8?B?VXBIdzR4a2VoeGZkbmxGK1VMcElvRW5Jc2JqeEo3VW9GWmN1bEt0Y3k3OVZE?=
 =?utf-8?B?NWVKTkgzNmREWWhrWEJSS1RTdU1kRWtlbTAzbnZRZ29ZVTlNSWQ4VTZVckZN?=
 =?utf-8?B?eUVWdjRoaU8xMER3S29ER293L1dhT3JJM3RyQkR1OGRqTWZYbG1xeWtaZXJ1?=
 =?utf-8?B?OGhUaGhNT3dmd1NHcjBzYjFxYzlqZ0orR084WnBDTnZNSE00L2ZaVzc4bDV2?=
 =?utf-8?B?UVM0VHNZRWlwbFIwRFQxZjhkTk4rLzhKTFpkb1gzekEvUm84UlRQT2dIekhR?=
 =?utf-8?B?TU1kWG1XRWwzOHZoVnpGMHNzcEkvb0pNd0dUUlpoM2tXd1BFNFZ4OUdEOWI1?=
 =?utf-8?B?N1QyYW5wRi9rM29raDBjUHI3L3hCM1lBS0lkSU1nUWcxeFA2UVN5bElyRHR1?=
 =?utf-8?B?Z2hkbUV4bS9XbjBHSDVHWEFLSTdZWjlYSjhFQ0ZTMXNGNkRwTENwemdvNHQ2?=
 =?utf-8?B?ZFBJaDB1Y2JQdHhGTkNDUENXdmxmRjN5anpwamdIcnRjcERiWldjSGMvWStO?=
 =?utf-8?B?d05haTVRUVpjVkdRTzI4UEZSMVRmcjJoam50UTllczFhMEE4WkFCYlNlaEpj?=
 =?utf-8?B?Z1FidUtNUDNMcEowc1hBNHRzU05JYXBpWFBtUjRsYU9jYzdkbFJxR3JHZk44?=
 =?utf-8?B?Wlh2dGVhN1lWRFIxakxqdHlTYXZPWVkweXRWSEVHaXEzVWFYSUdwbmlSS0xt?=
 =?utf-8?B?NlNrMDRXcnpOUkdHencvNWpPRjlNUC9BelBpenhrdXRqTUhyTW0yb0NMcEJz?=
 =?utf-8?B?RGFHVElwdFRPUGZGaXZaSjNOR1R5eXN1VmpOZEd1eGlUNk9FVHoxUUFtbTVN?=
 =?utf-8?B?ekJpaEVpUlIrUGRKLzNpY0o5TlUrSkZKeERYcEpiQmZCTHQwVmxQMUpPKzg1?=
 =?utf-8?B?VDQ1a1ViTWZOdEwzZmpGWS9UVldMOG0rbi8rZENJR2h6a1BndEx4V05kZWZ3?=
 =?utf-8?B?ejBneFYyMVF5T09xZWpGZDcrcTkvVlpRUnhYVXV0ZFFoOVR6KzhjcGpNUW4r?=
 =?utf-8?B?RDRzYTZKNWRCb1I0dFVkTWlqMS82Q1F1VVNKQ1BuMG1jQXJFejlwMFFwNWs5?=
 =?utf-8?B?U2k2c1cxcmhSUE5yRFFPSGFrVlQ5d0hPSWxDa0ZqamhRM1B3eGV6b0ZwWENN?=
 =?utf-8?B?M2o3ZXh6WUNhcFl0OEVLMG9NU0dMNTlsdUp3blVyMk44WlRpckhEZUFUcXVG?=
 =?utf-8?B?bkpvNUJaVk0zME5NNTNIV1hrS3NLREl1RHFBNTlWNTl3Qzd4Q1R1RmFKTXpp?=
 =?utf-8?B?WVlJY1B4WjlXc1ZsNkZIUU93MUJFSE9EV1VDdWhXbkI0dGZZWE1adXFnb0xO?=
 =?utf-8?B?SXV1d1Vzck5NdVFTSDdBMXVyWkp4cWE4QkhjTEsrcXFXbVdKMlBOTEVsUDN3?=
 =?utf-8?B?emFpVTB3SjVJYjF6RWg5OUJtMFlyT0lyaFBGWHZGRXFMTWR3YTI3V011ZUJu?=
 =?utf-8?B?SWxDTG9RWjdRRVlTdk96alJ4NzFIMHFXSHUzaEhvUmpsUkwvNjFnNElzZ2xV?=
 =?utf-8?B?ZE1jVVV0cUJXOEdETEFqazBxVFJtWWhqcC9CeUxVbDFTRTFmSmFEakp0aldF?=
 =?utf-8?B?WXNWZUZvYjU5dHp6NnNlVkJkSWtzSjVyMEZVcVZ1MG5relBvZVNFdzhYbXRK?=
 =?utf-8?B?cEJiQXRCQWFKRk1zdU1qamJxeEpteDJ4NjRsR3Z6aFVYazVYNzhJakJaMkxX?=
 =?utf-8?B?VWMxbmpST0ZHOVYyZ3hWTzNUb3VaVUpLKzZxMnZqRGlIWUoxSHNTTTNQWWNx?=
 =?utf-8?Q?UYQNwWMNbyRxkMK0XIk+wrc=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 36310ddf-4d74-4368-3a31-08d9c51cd16c
X-MS-Exchange-CrossTenant-AuthSource: BYAPR10MB3287.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Dec 2021 07:29:41.5422 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NxfsHSE7fUKckSXETEuwiZA+FP0JzsTxMsms+5oHJI0DI1XpbZVm++JpfhcQgd1eYmfQxzXBfPqxrB5Zt74xwQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB4752
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10205
 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999
 malwarescore=0
 spamscore=0 phishscore=0 mlxscore=0 bulkscore=0 adultscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2112220042
X-Proofpoint-ORIG-GUID: XYP4X7WQIgosVfR-VpbKasF70ZimhRlL
X-Proofpoint-GUID: XYP4X7WQIgosVfR-VpbKasF70ZimhRlL
Cc: "lvivier@redhat.com" <lvivier@redhat.com>,
 "mst@redhat.com" <mst@redhat.com>,
 "virtualization@lists.linux-foundation.org"
 <virtualization@lists.linux-foundation.org>,
 "eperezma@redhat.com" <eperezma@redhat.com>
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



On 12/21/2021 11:10 PM, Eli Cohen wrote:
> On Wed, Dec 22, 2021 at 09:03:37AM +0200, Parav Pandit wrote:
>>
>>> From: Eli Cohen <elic@nvidia.com>
>>> Sent: Wednesday, December 22, 2021 12:17 PM
>>>
>>>>>> --- a/drivers/vdpa/vdpa.c
>>>>>> +++ b/drivers/vdpa/vdpa.c
>>>>>> @@ -507,6 +507,9 @@ static int vdpa_mgmtdev_fill(const struct
>>>>> vdpa_mgmt_dev *mdev, struct sk_buff *m
>>>>>>    		err = -EMSGSIZE;
>>>>>>    		goto msg_err;
>>>>>>    	}
>>>>>> +	if (nla_put_u16(msg, VDPA_ATTR_DEV_MGMTDEV_MAX_VQS,
>>>>>> +			mdev->max_supported_vqs))
>>>>> It still needs a default value when the field is not explicitly
>>>>> filled in by the driver.
>>>>>
>>>> Unlikely. This can be optional field to help user decide device max limit.
>>>> When max_supported_vqs is set to zero. Vdpa should omit exposing it to user
>>> space.
>>> This is not about what you expose to userspace. It's about the number of VQs
>>> you want to create for a specific instance of vdpa.
>> This value on mgmtdev indicates that a given mgmt device supports creating a vdpa device who can have maximum VQs of N.
>> User will choose to create VQ with VQs <= N depending on its vcpu and other factors.
> You're right.
> So each vendor needs to put there their value.
If I understand Parav correctly, he was suggesting not to expose 
VDPA_ATTR_DEV_MGMTDEV_MAX_VQS to userspace if seeing (max_supported_vqs 
== 0) from the driver.

But meanwhile, I do wonder how users tell apart multiqueue supporting 
parent from the single queue mgmtdev without getting the aid from this 
field. I hope the answer won't be to create a vdpa instance to try.

-Siwei

>
>> This is what is exposed to the user to decide the upper bound.
>>>> There has been some talk/patches of rdma virtio device.
>>>> I anticipate such device to support more than 64K queues by nature of rdma.
>>>> It is better to keep max_supported_vqs as u32.
>>> Why not add it when we have it?
>> Sure, with that approach we will end up adding two fields (current u16 and later another u32) due to smaller bit width of current one.
>> Either way is fine. Michael was suggesting similar higher bit-width in other patches, so bringing up here for this field on how he sees it.
> I can use u32 then.

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
