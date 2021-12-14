Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D7B65C433F5
	for <virtualization@archiver.kernel.org>; Tue, 14 Dec 2021 01:00:34 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 5E0318134E;
	Tue, 14 Dec 2021 01:00:34 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id cIj9dYNtPY8T; Tue, 14 Dec 2021 01:00:33 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id F269F81350;
	Tue, 14 Dec 2021 01:00:32 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id BEE32C002F;
	Tue, 14 Dec 2021 01:00:32 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 2AC60C0012
 for <virtualization@lists.linux-foundation.org>;
 Tue, 14 Dec 2021 01:00:32 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 100594012D
 for <virtualization@lists.linux-foundation.org>;
 Tue, 14 Dec 2021 01:00:32 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=oracle.com header.b="kIfTqc+D";
 dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com
 header.b="kii+voy6"
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Sj5BnAw3wxZe
 for <virtualization@lists.linux-foundation.org>;
 Tue, 14 Dec 2021 01:00:31 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com
 [205.220.165.32])
 by smtp2.osuosl.org (Postfix) with ESMTPS id CC6CB400E9
 for <virtualization@lists.linux-foundation.org>;
 Tue, 14 Dec 2021 01:00:30 +0000 (UTC)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1BDLL7Ki004133; 
 Tue, 14 Dec 2021 01:00:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=e9rYMAgdW+rX+OUJhCUPrDyPEED4XwbCK2128bJCT4Q=;
 b=kIfTqc+DSqUzuHtNL2PMOxxROpPuxsk4UiRYQrNh2D4P1jspM9Tc1Hp0ytZT9OlhjJ63
 hhTvmSiEa6QF9N9Iiv6iO4De0d/tVdfNyMOYQBGZH6N0PgvnVYAy+/uIlT+fitxqBZ4x
 nA2l8WFyeV1hs9gCYu054bzKZFl7Sgux8oGc6VgMUpjHALdlngVJtWHuaYmIKX+dUZHJ
 AF4GXV5KkCVq70Z7GO81bwfMwVH4a/jn+Q9mAuwrzJVRKJImm98L8IE8XpjkkysGBkYr
 OXxGgo0aOLy6z7qxnSDy409jwUy1ixj4VHEeOKbaGdbLifDrd8pq8ujQCWypy2NwGz6m pw== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
 by mx0b-00069f02.pphosted.com with ESMTP id 3cx3py2bnv-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 14 Dec 2021 01:00:29 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
 by userp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 1BE0f3FB133143;
 Tue, 14 Dec 2021 01:00:28 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com
 (mail-bn7nam10lp2104.outbound.protection.outlook.com [104.47.70.104])
 by userp3020.oracle.com with ESMTP id 3cvnep1d7x-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 14 Dec 2021 01:00:27 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oRV3kwNUvbkN6BfS0kMRJxlI2u33IDtwA1AyckfV5cWG92m3E8pZj5h7+eZfP0wbTz0PqraLJQNM6UM5nNZaGaMoqkO65wJGST6VjPqGYSQb/ch5i8QCc9G76Gg5KOtdyO4BUW4IFUzwUlN6PZ637JMcCiS8vV36IgbtWtNNz8Up35SXfkkf5J4gynvEv+h/Yp2fjzS52OBgbbu+BE5UZfDEgSH2KirWJX6ONJXJClkd4bw3aAbaLVGXrS7vjYPtUpLt+fBjN9cS5hUBQwRyBY215ouxMlTxw7ddBPwygFyEN+650eiKjkX6bKc0oCyvrL5jK2ayYQaF8gZA+Nnukw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=e9rYMAgdW+rX+OUJhCUPrDyPEED4XwbCK2128bJCT4Q=;
 b=HTFM3EiKq+IssiVueKKUC7A8HuYBOMetPXhmXtY/BiMzZ/6IsYUvgAoJ9RKISXRQBsZlt8dLj9O7XxgbpmP5Zoo/h0cjx1u71nAr4V3gpU+Cr9CZi1DgQVOHJ95gjkUqW/d5iDyUM8U6r/K6LtUvlSwXcny8x5aJh8XHIY0QgLYrZP/v+0iUIKPcstuQKFB9kWmVYUYvhCsM49hbMMMP/6SXDjaF3efnhGxYoknSPStw6TnAcvHk21X9cet1oMdi8qGA6yGrJ13sRTyP2EFsorY5+Y28MIlWZXfR7SKHNzwDoFgF1Y6XhjNIZL6dt7mfl5OeIUhV1jO/5wB+JCaqpQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=e9rYMAgdW+rX+OUJhCUPrDyPEED4XwbCK2128bJCT4Q=;
 b=kii+voy6ngOY44LW3zHfa4Qm7WDJHDm4WE3uRMadbxu2t0t+hmba+t8sMcQdtPje9ZswcVVBxCnZGUezEF+rCbRtosg+VhE0trnPdGglDoc51Tp9KjH7a6Rr7ki3DBixf11Iyh00h5ywYFyxMg0ipwFzA9r0VaFkiANqPtUxDYw=
Received: from BYAPR10MB3287.namprd10.prod.outlook.com (2603:10b6:a03:15c::11)
 by SJ0PR10MB4622.namprd10.prod.outlook.com (2603:10b6:a03:2d6::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4778.15; Tue, 14 Dec
 2021 01:00:25 +0000
Received: from BYAPR10MB3287.namprd10.prod.outlook.com
 ([fe80::7c7e:4a5e:24e0:309d]) by BYAPR10MB3287.namprd10.prod.outlook.com
 ([fe80::7c7e:4a5e:24e0:309d%3]) with mapi id 15.20.4778.017; Tue, 14 Dec 2021
 01:00:25 +0000
Message-ID: <3c04815d-1ecc-f8e2-08b2-7f21d5149d91@oracle.com>
Date: Mon, 13 Dec 2021 17:00:18 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.2
Subject: Re: [PATCH v2 09/10] vdpa: Support reporting max device virtqueues
Content-Language: en-US
To: Eli Cohen <elic@nvidia.com>, mst@redhat.com, jasowang@redhat.com,
 virtualization@lists.linux-foundation.org
References: <20211213144258.179984-1-elic@nvidia.com>
 <20211213144258.179984-10-elic@nvidia.com>
From: Si-Wei Liu <si-wei.liu@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <20211213144258.179984-10-elic@nvidia.com>
X-ClientProxiedBy: SN1PR12CA0075.namprd12.prod.outlook.com
 (2603:10b6:802:20::46) To BYAPR10MB3287.namprd10.prod.outlook.com
 (2603:10b6:a03:15c::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 12935317-25c4-4f0d-5847-08d9be9d1d03
X-MS-TrafficTypeDiagnostic: SJ0PR10MB4622:EE_
X-Microsoft-Antispam-PRVS: <SJ0PR10MB4622F1CFEC5C4AFF19CC6E52B1759@SJ0PR10MB4622.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2803;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 7i4YXc+Jo6mXlh4F7tRydTQkvVQlDBqgdiQ3vcngTENsVuooslGdkC4PuqjwqpPjcR5uxRCOilmdEx0lbGuT27EnIVrKfMhSaESWDvE9ONOwiDiiH1XbOBDqYUbII8abYAkEJ2EA5bKtGKTlYwVjGkFdnxC/1/yCCQOYuUbFGbm/lYWjjEKLTqlCxXoUQsDvgCIPflyqaJOjsyYf8qkjPK6AV59SoukdkRqLpew1bwV+mzpktNlyDSoWnqBX7SSaTK9j8RvJV4RgcWKT4cOMKrUj8CRh3xtyVqyOZ6yDY3jilk9Hqn9e40f1T5Sv/Jb49VswcwY2uy1U+DgAQ1wh4Rmf89GurHWv6EpSXHs3Yi9s42obxPdGFpMnqhP0fqyrwaftjg6Lso4qe+lKnjWPSZUag6Y8YHBDq0DwsXn7tmou2nseHLPiwbNvh8z2zybpdZk7tTOKfgPVnq8EoOX1QICtTq4km/sCBj9WQberQNomRFHg1v6WHwBEaDwMa48T+UV/9yhazZ37brcy2Jq2Bl3VLrMt4PMvBpi8S6APFWNql5O77rOaTIAgnaykoMOjvor0f981+vIW4EfIXtXspteY7jgPi5LD++Z+Z0kxQsYd9CtceHbjcvvt76lWsHZMGI1zLQtQGrSnbiZwakBrClq2ZXm+iWYTz3RhJ2xS/x8p6BRr4YBA1kMQy40e/3wHzhuh7XrKMHI1eti7kyPxT0vS6SmB2E4kaXqRtf1Ay6I=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR10MB3287.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(366004)(83380400001)(186003)(8936002)(316002)(31686004)(86362001)(31696002)(36756003)(26005)(2906002)(66556008)(66476007)(8676002)(38100700002)(66946007)(5660300002)(6506007)(2616005)(6486002)(4326008)(6666004)(53546011)(36916002)(6512007)(508600001)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?T2pUSmxGeGVmU3FjMGQ5RG1HQ09hVlQ5SHY0akZPMG4yTk04SVBwbktvOFNP?=
 =?utf-8?B?Q2M3dUhMNVNoSkp4Ukgrb3hoUU1RV24zNzVjOXdaa1JYQzNkQS9jakxOSzYy?=
 =?utf-8?B?RTZZV3FaQm1adDRoZEtZMExTRjJqaVJoWTdxNi9oalVtc3BhSGdLcnZzUVd2?=
 =?utf-8?B?MG03ZDNuTHY0TGJIS2JneWZ4VUFJVEhQY0diM3BvOC9rTjk4WGhWYTYvSE5n?=
 =?utf-8?B?SE4rd1ZoOWN5Vjc1L0pIVGFSN0loMmRKM2k0ZjVsNU0wVU9mTitGNW9EM0Ni?=
 =?utf-8?B?a2FHM3hPbXozcVAveHhmb3dSbWxDV0diSDd4cjU0c0JGRVhVbEZ1OE1CRkdN?=
 =?utf-8?B?SWF2dy9Cc1RJdjBKdEdjQ2c0Zlo3TE1xU3lhNi9LRmtKYmJRbzNkbUdtbWc3?=
 =?utf-8?B?VGRzM0lNbDZCdTFsSGdFaHRGdERLVUpaKzlwY3FsQzB4R2daSHFmQ1QrS3Nt?=
 =?utf-8?B?NlozN1RWYjg3bnlkQk9JRllYN2hMWkFNZGFiSHVxdGFLRmt3ME5PQ3o3bWty?=
 =?utf-8?B?bHZ0WnVGT01RenBBZi8wdkJwTDh0VG1nUWhIY3BVRW01eWxuNXovNmNhai9r?=
 =?utf-8?B?d29iMUFaaFdDZFNXbjE3UVpxSEdCMUt6eCs2d0c4MzAyOWd4cjlWWjZyeERo?=
 =?utf-8?B?NFVITG11UzRaT0hVUFlMVmprRlFDTnJsWlVyMFJaWEtYcVd4Ylg3Wnpob2Z4?=
 =?utf-8?B?UU0wcE9QdTBrNEV1ZmVmUVVhb0t6VWF3QndVek01S25OZXUzNGVZNnRVd0Yw?=
 =?utf-8?B?c2JaYUcyNjJKc1daK0JCemFiSlJIU0RRQnJwaFRsdy8xbjVnWFN3dyt3UEpn?=
 =?utf-8?B?dmFCc20xckRzQldNQlQvQ09yYUlmbWt4MTZmc2NvQ0UzdnhFY1o4RTV4MXVK?=
 =?utf-8?B?Qm1mMGtwTXhid2p4TUszUzd6NjBsTzZxUEpURVAyb2tUdWhCRXdFKy9YemRZ?=
 =?utf-8?B?cFpBK21TdDZuWDk2VkJWZjBTakN6Zjg2OXpzRXRHSS90SGlmbkhlMS9KUmpI?=
 =?utf-8?B?QTFSZ1FJOWRtcFZsNjZNYndwZzM0a3hYbVRtUlU0cDB5RFE2c2pseEFGb1lM?=
 =?utf-8?B?d3l2UG96RFhpNEoyenFISVRxZFd4a2l3bmJmS21sL3UzMW9peGwvT25zQU9x?=
 =?utf-8?B?bzMxZ05WTm5UZ0duSXZrLzd2NTQyMDZzZHcraTMxMTN6UlhMMjFMc09ZN1NR?=
 =?utf-8?B?aEFKd2tGL2YxSktxdk1yOUFBSXhicXk1VTkzTnM1ZUo4S2hGbkhXejQwdmdk?=
 =?utf-8?B?dDBKT256R0l4UHhUdk1XSXBwZ2tja2p4b1FMWHlvcERZNVp4VGNOLzVscGN3?=
 =?utf-8?B?NUdNaTdnS0tIRUhUQ25hUWhLY3ZuRmx5ZkZ6b2wybXRYM2lGRnlUbytxUk95?=
 =?utf-8?B?UTI0cEFSMlRMZzNQcjBvTTAxM0Z4L1JmQmpZUExRTHdKK2tJK2RsWWNHYXhN?=
 =?utf-8?B?T0tGK0QxY1FiZW12V255LzFka1NHcFhhR2ovMVhMZEs0VDdXYy9XMjhKZzR5?=
 =?utf-8?B?TG54R0JsRTBiZnhPSmxrQUlVMmVuVDNyUDVJK2VWQXoydWJ3UENBeUhIK3dP?=
 =?utf-8?B?Vmg0cUhDb0h4d05NMTZhUmZ3cWFjMU8xVTBzaTR6MEZ3M2NwVnFnVUVkNS94?=
 =?utf-8?B?S3JtZWVic29Ha1l0bE1PV1NENWVTcW5lckJOUGIxeE1VcWRlMmpqSXN0aUZx?=
 =?utf-8?B?eWowUUNVdXBXai8zVWlScW9GcmVTdjNxOVMra1d4U2NnWUF4Vk1rWjJhQTFx?=
 =?utf-8?B?V0M3cjFyOG80SzkrVWw3K1lpZnVDRlBqWUQraDBkaWxFTEpaTFpNbHFMTlB2?=
 =?utf-8?B?T1JqWnlraDkvTW9wRmVtT0FsLzFtYnBwQ25vbHJRaEwxRU5VcWVXRG1pUHdL?=
 =?utf-8?B?Y2IvbGdmUUpvcXlJZ1pKTDlrcXhWVjFVc3UxakNTWGEwc08rRHU4S2k2SjdP?=
 =?utf-8?B?dnB0Z0YwdlllaVB5VTdQUjVRMjFadEowRzVDZ0taNnpiZkUzUWlRL2NXM0p5?=
 =?utf-8?B?QlJnT1RBR2d0NldKbWJCM0dyblN4aEF0Q2tJZXI3TzVsMnlKb1F3bE9mbWY0?=
 =?utf-8?B?cW1iYU1KRVVESVdNU2tqaGFDOVkrNEp3czhiZVF6eEFBUWJSbG9FamZvZHBn?=
 =?utf-8?B?amkxcDFhSFd2V3ovamFWdE5JcGpOYVhxam9HUjMrN01laWZDdWt2STJuKy9q?=
 =?utf-8?Q?0tRXcDY5C0UwWz1dZ6Hry58=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 12935317-25c4-4f0d-5847-08d9be9d1d03
X-MS-Exchange-CrossTenant-AuthSource: BYAPR10MB3287.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Dec 2021 01:00:25.6787 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qyrmLPb1pe7vYpNWe1s2YmYVtoOPRWQBtSICvd4PqHAQmfmaDh4X88X6sbC/scOTmqagTBFMOa0UUq8H7YX5sA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB4622
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10197
 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0
 adultscore=0
 malwarescore=0 bulkscore=0 spamscore=0 mlxlogscore=999 mlxscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2112140001
X-Proofpoint-ORIG-GUID: nQxsOMtkt9LgxQgE27yYE_NVocJtPjcf
X-Proofpoint-GUID: nQxsOMtkt9LgxQgE27yYE_NVocJtPjcf
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



On 12/13/2021 6:42 AM, Eli Cohen wrote:
> Add max_supported_vqs field to struct vdpa_mgmt_dev. Upstream drivers
> need to feel this value according to the device capabilities.
>
> This value is reported back in a netlink message when showing a device.
>
> Example:
>
> $ vdpa dev show
> vdpa-a: type network mgmtdev auxiliary/mlx5_core.sf.1 vendor_id 5555 \
> 	max_vqp 3 max_vq_size 256 max_supported_vqs 256
>
> Signed-off-by: Eli Cohen <elic@nvidia.com>
> ---
>   drivers/vdpa/vdpa.c       | 2 ++
>   include/linux/vdpa.h      | 1 +
>   include/uapi/linux/vdpa.h | 1 +
>   3 files changed, 4 insertions(+)
>
> diff --git a/drivers/vdpa/vdpa.c b/drivers/vdpa/vdpa.c
> index 130a8d4aeaed..b9dd693146be 100644
> --- a/drivers/vdpa/vdpa.c
> +++ b/drivers/vdpa/vdpa.c
> @@ -695,6 +695,8 @@ vdpa_dev_fill(struct vdpa_device *vdev, struct sk_buff *msg, u32 portid, u32 seq
>   		goto msg_err;
>   	if (nla_put_u16(msg, VDPA_ATTR_DEV_MIN_VQ_SIZE, min_vq_size))
>   		goto msg_err;
> +	if (nla_put_u16(msg, VDPA_ATTR_DEV_MAX_DEV_VQS, vdev->mdev->max_supported_vqs))
> +		goto msg_err;
What is the default value if vendor driver doesn't expose this value? 
And it doesn't seem this is something to stash on struct vdpa_mgmt_dev, 
only some vdpa vendor for network drive may need to expose it; if 
otherwise not exposed we can assume it's 32767 by the spec. A generic 
vdpa op (get_device_capability?) to query device capability might be 
better I guess (define a VDPA_CAPAB_NET_MAX_VQS subtype to get it).

-Siwei

>   
>   	genlmsg_end(msg, hdr);
>   	return 0;
> diff --git a/include/linux/vdpa.h b/include/linux/vdpa.h
> index 9245dfbf1b08..72ea8ad7ba21 100644
> --- a/include/linux/vdpa.h
> +++ b/include/linux/vdpa.h
> @@ -444,6 +444,7 @@ struct vdpa_mgmt_dev {
>   	const struct vdpa_mgmtdev_ops *ops;
>   	const struct virtio_device_id *id_table;
>   	u64 config_attr_mask;
> +	u16 max_supported_vqs;
>   	struct list_head list;
>   };
>   
> diff --git a/include/uapi/linux/vdpa.h b/include/uapi/linux/vdpa.h
> index 23b854e3e5e2..1b758d77e228 100644
> --- a/include/uapi/linux/vdpa.h
> +++ b/include/uapi/linux/vdpa.h
> @@ -42,6 +42,7 @@ enum vdpa_attr {
>   	VDPA_ATTR_DEV_MAX_VQ_SIZE,		/* u16 */
>   	VDPA_ATTR_DEV_MIN_VQ_SIZE,		/* u16 */
>   	VDPA_ATTR_DEV_FLAGS,			/* u64 */
> +	VDPA_ATTR_DEV_MAX_DEV_VQS,		/* u16 */
>   
>   	VDPA_ATTR_DEV_NET_CFG_MACADDR,		/* binary */
>   	VDPA_ATTR_DEV_NET_STATUS,		/* u8 */

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
