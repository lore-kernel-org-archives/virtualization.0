Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DCF8AC433EF
	for <virtualization@archiver.kernel.org>; Thu,  9 Dec 2021 21:50:52 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 70C4085E7A;
	Thu,  9 Dec 2021 21:50:52 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id KA4pxCMT138Q; Thu,  9 Dec 2021 21:50:51 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id F418485E78;
	Thu,  9 Dec 2021 21:50:50 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id D2724C001E;
	Thu,  9 Dec 2021 21:50:50 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 9DCA3C0012
 for <virtualization@lists.linux-foundation.org>;
 Thu,  9 Dec 2021 21:50:49 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 7648C6F844
 for <virtualization@lists.linux-foundation.org>;
 Thu,  9 Dec 2021 21:50:49 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=oracle.com header.b="D+2tupNy";
 dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com
 header.b="dMExygWV"
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id JlKoNyEMmUMG
 for <virtualization@lists.linux-foundation.org>;
 Thu,  9 Dec 2021 21:50:48 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com
 [205.220.177.32])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 7C5B96F83E
 for <virtualization@lists.linux-foundation.org>;
 Thu,  9 Dec 2021 21:50:48 +0000 (UTC)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1B9K3tDj028726; 
 Thu, 9 Dec 2021 21:50:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=+pYgWM7Yi7ws0Dwc2rvqy2uALs5xxRJWEsACyaTXtVM=;
 b=D+2tupNyqfa5YCczdnTVvJaSzJb5EWIHyVl/kq2b5+1IvA0IlyovMIE7S0ctBZHdO5dl
 29iWajYK4/cKuNWSyGGOeg8gOOM1HfpXhbwciYWGlMrPjyNzS0beVYD2FEYXOYqlmNM6
 CcRmciwtO2ibq0DXCp4lYSiTwIUvf6SZG99VGsP30jrnXmzej6gOmsdqqpxgEFZ4krir
 VqaDPnG22ULOT2BsSdL2FakYY9g7PkcgDH/DwJPwRgEuULDd7WietHCbsBuYBcg+OOFY
 7FgzyZ4mMGyEgMDFyDbFNooNzyBieeh4HdqhGjn9hQi8BkBqZuS5cjR1u3XB1uQvtse0 rw== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
 by mx0b-00069f02.pphosted.com with ESMTP id 3ctu96ve0x-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 09 Dec 2021 21:50:47 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
 by aserp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 1B9LZVXU159312;
 Thu, 9 Dec 2021 21:50:46 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com
 (mail-dm6nam10lp2102.outbound.protection.outlook.com [104.47.58.102])
 by aserp3030.oracle.com with ESMTP id 3csc4wtbs0-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 09 Dec 2021 21:50:46 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DqneZPy8rlsLSE1MDocs8EzB4YVdjxn/W+A6v60j3NYZL6t6QNZUqBFdcEsDYP7vrcEu3y9e/cG21CqJtbQ8wmXKxYD5fXItiPpuQZHfSXaBmupgmufhGnRPY+IDRgGdsfmAHS7tTicN0GqxDc0BxNHbR5LQAzk9qB6f+F8VaEN/qk4NTvP8WLMLc/jE9SXxNEvO3FXffR+eROf3agBNXD/9zXGojE32e7wiZW5DMyhcZf4KVVOpZP2T8pC3YB8fKhbjrq4te7TnsNWEuqQC/ybYVzRKfMgGWvVq+C4NPCSQDjoykDabAarJQUuSOjJx/0E7sQtkqLYqwLZrPOVEBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+pYgWM7Yi7ws0Dwc2rvqy2uALs5xxRJWEsACyaTXtVM=;
 b=NgmvojgEqMjhrRhEIUkZIwnZgH2LZAx2QaoFYE3u30Ejn7NtKwr2EZYH4QQAVl1QOPdmpSk0aUkfoS3lEuQ0AnwF3NicmpCMJMt5C6jkzKJ7eYbPSoQ86LHFz5LCwKa2waDQjyyMT69Tm0G7dJC9q1A8Ktd/DyiSrAycGCXC5xufQow6e619ckURaH3phspk4DH1kVU7vgp2NtO4cvBYedegYu1sE7dlcuZgktTKvnWqO6ylfxkw/mDF0xnkDi4yqPf/McnqfP0SnwDBpDKVR8ak7vLV8TwtPfmLty8Uu9Pt8HTQBmQJ7eLaXKA52k0TTrI1AO82OCdgh6O/5TWunQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+pYgWM7Yi7ws0Dwc2rvqy2uALs5xxRJWEsACyaTXtVM=;
 b=dMExygWVM86TrivZF3D3Z0nGkDYHatLIXgXon4ST0Iw0wxxHwXP+Zo+hSDSEY9id008L6H+LboAIKL6MHaQ7Qm9/g7InTAnndv9HserOImYo+gjjdXyxbL/xLp9XfBZtD6Zja9LOVxErmN1tFJ39UCAgGG1vPpjTLVUBNVNbI1c=
Received: from BYAPR10MB3287.namprd10.prod.outlook.com (2603:10b6:a03:15c::11)
 by BYAPR10MB3063.namprd10.prod.outlook.com (2603:10b6:a03:89::26)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4734.22; Thu, 9 Dec
 2021 21:50:44 +0000
Received: from BYAPR10MB3287.namprd10.prod.outlook.com
 ([fe80::7c7e:4a5e:24e0:309d]) by BYAPR10MB3287.namprd10.prod.outlook.com
 ([fe80::7c7e:4a5e:24e0:309d%3]) with mapi id 15.20.4755.025; Thu, 9 Dec 2021
 21:50:44 +0000
Message-ID: <9978f096-b0d4-1926-839c-fcaab28f7e44@oracle.com>
Date: Thu, 9 Dec 2021 13:50:37 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.2
Subject: Re: [PATCH v1 3/7] vdpa: Allow to configure max data virtqueues
Content-Language: en-US
To: Jason Wang <jasowang@redhat.com>
References: <20211208201430.73720-1-elic@nvidia.com>
 <20211208201430.73720-4-elic@nvidia.com>
 <5a9d9d83-fbe2-000a-9084-456c2a0ac094@oracle.com>
 <CACGkMEs2jydoBY8xLqNy_Uvurxft7rGzPon542Gup9DDuAyE=Q@mail.gmail.com>
From: Si-Wei Liu <si-wei.liu@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <CACGkMEs2jydoBY8xLqNy_Uvurxft7rGzPon542Gup9DDuAyE=Q@mail.gmail.com>
X-ClientProxiedBy: SA9PR11CA0012.namprd11.prod.outlook.com
 (2603:10b6:806:6e::17) To BYAPR10MB3287.namprd10.prod.outlook.com
 (2603:10b6:a03:15c::11)
MIME-Version: 1.0
Received: from [10.159.153.254] (138.3.200.62) by
 SA9PR11CA0012.namprd11.prod.outlook.com (2603:10b6:806:6e::17) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4755.16 via Frontend Transport; Thu, 9 Dec 2021 21:50:41 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a294837f-e367-46aa-69b4-08d9bb5df356
X-MS-TrafficTypeDiagnostic: BYAPR10MB3063:EE_
X-Microsoft-Antispam-PRVS: <BYAPR10MB30630FBB9BDEA530E1B47AC4B1709@BYAPR10MB3063.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ZP67LHB1sBCSucxfLUbxkYs+363zJTieOpvTj3bUMJl0QBIRyuJQpTMuEDCTXy1NW0z4ObuCi2FAK0Wqa2ayfg9c3CLuZz5Qs45QW6e0WOuEL/Nk+Jv88QGRCXEitnnojKvauzIYu8OYVt3I74D18K16R7CKryRMuhDUaXPasrymUsx9Rimo7zCDpKzUpAVrL3D6WJDpp7QHs5vmUvAaNE0BiEcvfV2F2FAGuWhsqnGcEFLEyd1LTbiQWCIF/wYBZXlc4PgvUJnZGwszhqi5p4R+NgWgNl1x6K0KeVesZdkx43ScJidUj3/XukDKAP8rkypQRZ1udmxj4S4sop8ZkyIO5FKvjUczYu+k7ClkZVkFFiSSi6kbupSHnGOndz/JjexRCiu8tRWAl8VfGyKv+AN3UPN85uRBsoNDa9y9lbqjTG3Rr02hIf4nVt4GRgoc9/LtMd04Rs9LHTZNDN1FuN0fMDrZBURZuBZ/WedDEnORsX6sW0FUVRU8YXJ+F59rjl0Xx/r6/08AsCMojCemfOet7wcO6LTCl+YE7qb1egZ7IA276iHnc4p/UhFqWqk6Pw8qPpz6cXD0SMknVyMp/FWPbSeOCjnHNQQ2KQ2KhIC0/zEcyflUOnFNtzYDyPeE+d1WA8tl2oBVTElLX33RPd5hvnXE3gNtb2FpmFbvYAgGO3cnOLifeKWbrEKZil7XjSIw30aKTFYdxaHqtB8/mDx5W3AHwZjBQsn9/BcGSxM=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR10MB3287.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(366004)(186003)(66556008)(66946007)(86362001)(31696002)(54906003)(66476007)(956004)(36916002)(5660300002)(2616005)(83380400001)(53546011)(38100700002)(8936002)(4326008)(508600001)(16576012)(6916009)(36756003)(31686004)(6486002)(8676002)(26005)(316002)(6666004)(2906002)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MFFmNng4R2tEQzBTY0g0M1ZjakllTmpsLzhCdE1YWFRqWTdZa3V3MXFoL3dS?=
 =?utf-8?B?aU01MllrK25ZRTdzTkZENDBtb2xBSFdGNzFWK0tpNEp4eUtBbEJseVYzWHp6?=
 =?utf-8?B?dENxVjQyMzZRejVxTVNKTWhTdXM3NXFwQ3pSSUFvaGh4Z25IQ0IzMGtWOUZR?=
 =?utf-8?B?ckxJdWZqOWQzemtDenlDeTRjV0Zydm1nTDg4bVBwQUxmUS9sdE54WkcvcVVt?=
 =?utf-8?B?ZlpqaDRQZGJneUhaOUJnQmVwbnZiajhLWllzcjRZblFObmNSZ25tMkJHT296?=
 =?utf-8?B?QXh6dzVwMkczMnFjdE8rMm8wRWpjc1BCUGhsRWlHd3U3SjgrOElWY2VlMDh5?=
 =?utf-8?B?bkpsSk1PaGlraW9VQ1REYVNOLzk4ZXNGT0V6bGlRQVVNaTNXV1lqV0QvcW5y?=
 =?utf-8?B?MjBVYXlNd2JmSUNBdGphUjZ2dklEQ0tZRDlxWmc1UnB0Ty8reXdNZzcvRy9s?=
 =?utf-8?B?QnhxcWdNZllydUd3TDEzQmxSRnR4TGU1eHozMXhudGhEVEVEb1dwNXFMSXJX?=
 =?utf-8?B?eHJhZzdmYzhYVDQyQmh2bDczaGZ5eVRTcGExMjR5aWtET1RLU3NEdzhnTUp6?=
 =?utf-8?B?Wm4vcGMrbUNMTGFPSGhoUGt6aFVHOVBtMDlCWGYzNHJ4WEErcHNyaUVlWjdT?=
 =?utf-8?B?NFpCbkIwWEo5cUYwOVNLZTlUMkZVM1V1UEQ1STIwOGVDaWNQa2lFdkZUbmY1?=
 =?utf-8?B?MXpOUGFYNndVQVprYzdVc1FuS2IyRzUrZDhLT1dwQ2tDMnZpYVliV1RYVFFD?=
 =?utf-8?B?d1BEVFByK2lHUUp2a1VxUVVHaVR1OGxzQy9zOVZzUFdxS1cxdllkdUpyUlpF?=
 =?utf-8?B?ajRzY2dlb3JBQ3FhTEtQRFp1aTBpd0FFTVJFSk02aExKNEVZWDR6Q24yd0Nq?=
 =?utf-8?B?cy8xazEyald2T3JkRDdkZ2RKdW5Lbm9RSWUrdnVKOWUvL2JzZm5KamhNd0Yz?=
 =?utf-8?B?VmUzRWN5WHZJQmV0cVRkend3d2JqWXBHNW5yUFN4QlZZemZxRHY4OE9RWXZF?=
 =?utf-8?B?V1FjaEJiTlVjaWZwRUJTQVpNamM5WGIvelU2a1RHdkFGYjkxNE1CRXppN2RE?=
 =?utf-8?B?Q1lZY3MvL05ncHI0NTJ5TjlIRDhKdGdPaEVDbVcralhSV0FVVGhMNStIZFZi?=
 =?utf-8?B?ekhTdkJoSTFJOWNKdGw0T3hhc0Q3STZ3MkkyZzBoRXV0dFJmMkhyT0tHZnpL?=
 =?utf-8?B?L1ZHcjdTMUY1emdIOVdDUmRoM1FJVkp6dFFXSEtLU1VFSjlVYnc2YWQ1NjU4?=
 =?utf-8?B?TzR3aVZ6QVUwcHZwS2lYUksrZzRodmc0cGdEY2Yzd2NKTFQ2VkZTOVc2ei9Z?=
 =?utf-8?B?RVFCSTRHZFFQbUhrQUQxQnkxaEFYMUN1OHBjY2VkSFR5NlFzakY2dWtmbEZz?=
 =?utf-8?B?UkpCRDU4eWdscUtvT2Z1VlJHRlVQMmtsYmREUzFpaTNrQ1BqZTZsVWRVVjFS?=
 =?utf-8?B?WUFFdTVPSERmUHhsOTJ5T2hJWmViZ2dObDFHdXdoN0I4R3RhcWY4N3NCd3Zq?=
 =?utf-8?B?R1ovM3RxRW53L1EwdzlmdDZ6cG15cEIwNkpaT2xGc0Y5WGk5Z0FyVmFURWVG?=
 =?utf-8?B?YTdrSGRIM3NuYm13U2ZBZCtXdU9aOXVqRFpjRjdnZWZZS1Nsc2Q0RzhYcm5I?=
 =?utf-8?B?RVYwVk1GN2RaZ29Cd0YyWXgrVU4yQ09VS3VLMUtYSGZMbkpoOFQvVElFY0RP?=
 =?utf-8?B?c3BjVVdONkY0bkxCdVF0RWZMOTNGTnhLR084R2NONlpKbnprbTJkZFVOdzlF?=
 =?utf-8?B?UThzNWtEamxBcCsrcG1aSjdZUlNIRHdDSVlxYzBXSHJjais3VTRpZEFIQnFE?=
 =?utf-8?B?M3hZQ0pYNFRNNERmdFhJcTdaTXpyeHFlUEdhUWhGSmIwZHJkbXdwQ1ZKUkZT?=
 =?utf-8?B?b3BJOXBlTmd2VjNLMkhXdVNGdkhLZWtqMTB6WDNneHRzRDR1c3BhWVJCcTFa?=
 =?utf-8?B?TGVhVEsxTnhldnQ1Y1lyQ201Y0I0ZGdYWkVCd0JnNERwQ1hpNHI5YWc0bVNa?=
 =?utf-8?B?bGwzbFFheFk0UUVQQkNTSWt5VTNSUTFuVVdHVEJXQU9ZK0pXQUhBQXBjeVQy?=
 =?utf-8?B?bWhhU1VZN0w3YThaOEFGdENGckNGVklvUGpMSVRSeXVpK0tsKzlkNmV1cVR1?=
 =?utf-8?B?dyt2Rkh4RzV0RThaTjVPUzkvZjlZY2p1RjZYRXEyK1dZN0F1L3IwSWpnU2px?=
 =?utf-8?Q?JaWfUQvHn3lORRNAEiasDt0=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a294837f-e367-46aa-69b4-08d9bb5df356
X-MS-Exchange-CrossTenant-AuthSource: BYAPR10MB3287.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Dec 2021 21:50:44.2577 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nkR/RGmFVLkjyOl8SeX5fvH5ZF77ud9LVWiprqKpHeLtKFwxWrpTsDeOQwGGwoI4xEjHlnsI4XFbUYpdp+1b6A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR10MB3063
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10193
 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0
 mlxlogscore=999
 phishscore=0 bulkscore=0 malwarescore=0 spamscore=0 suspectscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2112090112
X-Proofpoint-GUID: hSFfDaR8jUnfphv_0RIiTooP_JBF2gWJ
X-Proofpoint-ORIG-GUID: hSFfDaR8jUnfphv_0RIiTooP_JBF2gWJ
Cc: Laurent Vivier <lvivier@redhat.com>, mst <mst@redhat.com>,
 virtualization <virtualization@lists.linux-foundation.org>,
 eperezma <eperezma@redhat.com>, Eli Cohen <elic@nvidia.com>
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
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

CgpPbiAxMi84LzIwMjEgOTozNiBQTSwgSmFzb24gV2FuZyB3cm90ZToKPiBPbiBUaHUsIERlYyA5
LCAyMDIxIGF0IDg6MjUgQU0gU2ktV2VpIExpdSA8c2ktd2VpLmxpdUBvcmFjbGUuY29tPiB3cm90
ZToKPj4KPj4KPj4gT24gMTIvOC8yMDIxIDEyOjE0IFBNLCBFbGkgQ29oZW4gd3JvdGU6Cj4+PiBB
ZGQgbmV0bGluayBzdXBwb3J0IHRvIGNvbmZpZ3VyZSB0aGUgbWF4IHZpcnRxdWV1ZSBwYWlycyBm
b3IgYSBkZXZpY2UuCj4+PiBBdCBsZWFzdCBvbmUgcGFpciBpcyByZXF1aXJlZC4gVGhlIG1heGlt
dW0gaXMgZGljdGF0ZWQgYnkgdGhlIGRldmljZS4KPj4+Cj4+PiBFeGFtcGxlOgo+Pj4KPj4+ICQg
dmRwYSBkZXYgYWRkIG5hbWUgdmRwYS1hIG1nbXRkZXYgYXV4aWxpYXJ5L21seDVfY29yZS5zZi4x
IG1heF92cXAgNQo+PiBOb3QgdGhpcyBwYXRjaCwgYnV0IEkgdGhpbmsgdGhlcmUgc2hvdWxkIGJl
IGEgbWVnYSBhdHRyaWJ1dGUgZGVmaW5lZAo+PiBhaGVhZCB0byBzcGVjaWZ5IHRoZSB2aXJ0aW8g
Y2xhc3MvdHlwZSB0byBjcmVhdGUgdmRwYSBpbnN0YW5jZSB3aXRoLgo+PiBMaWtlIHRoZSBleGlz
dGluZyBvbmVzIGUuZy4gbWFjX2FkZHIgYW5kIG10dSwgbWF4X3ZxcCBpcyBhbHNvIHZkcGEgbmV0
Cj4+IHNwZWNpZmljIGF0dHJpYnV0ZS4KPiBQcm9iYWJseSwgYnV0IHRoaXMgb25seSB3b3JrcyBm
b3IgdGhlIGNhc2Ugd2hlbiBhIHNpbmdsZSBwYXJlbnQgaXMKPiBhbGxvd2VkIHRvIGNyZWF0ZSBk
aWZmZXJlbnQgdHlwZXMgb2YgZGV2aWNlcy4gSXQgbG9va3MgdG8gbWUgdGhlCj4gY3VycmVudCBt
b2RlbCB0byBoYXZlIGEgcGVyIHR5cGUgcGFyZW50LgpZZXMsIHRoYXQgaXMgdGhlIGN1cnJlbnQg
c2l0dWF0aW9uIGFuZCBpbXBsZW1lbnRhdGlvbiwgYWx0aG91Z2ggdGhlIAptb2RlbCBkb2VzIGFs
bG93IG11bHRpLXR5cGUgcGFyZW50IHRocm91Z2ggClZEUEFfQVRUUl9NR01UREVWX1NVUFBPUlRF
RF9DTEFTU0VTLsKgIFJlZ2FyZGxlc3MsIGV2ZW4gdGhvdWdoIHdpdGggCnNpbmdsZS10eXBlIHBh
cmVudCwgc28gZmFyIG9uIHZkcGEgY3JlYXRpb24gdGhlcmUncyBubyB2YWxpZGF0aW9uIGRvbmUg
CnlldCBhZ2FpbnN0IHdoaWNoIGNsYXNzL3R5cGUgdGhlIHBhcmVudCBjYW4gc3VwcG9ydC4gVGhl
IG1heC12cXAgaXMgCmVzc2VudGlhbGx5IHZkcGEgbmV0d29yayBkZXZpY2Ugb25seSwgYnV0IGNv
bW1hbmQgbGluZSB1c2VycyBkb24ndCBoYXZlIAphIG1lYW5zIHRvIGluZmVyIGl0IGlzIHN0cnVj
dHVyZWQgdGhpcyB3YXksIGFuZC9vciB3aGljaCB2ZHBhIHBhcmVudCBtYXkgCnN1cHBvcnQgdGhp
cyBjb25maWcgYXR0cmlidXRlLiBUaGF0IHNhaWQsIHdlcmUgdGhlIGNvbW1hbmQgbGluZSB1c2Fn
ZSAKc3RydWN0dXJlZCBsaWtlIGJlbG93LCBJIHdvdWxkIGhhdmUgbGVzcyB3b3JyeS4KCiQgdmRw
YSBkZXYgYWRkIG5hbWUgdmRwYS1hIG1nbXRkZXYgYXV4aWxpYXJ5L21seDVfY29yZS5zZi4xIG5l
dC5tYXhfdnFwIDUKCkFsdGVybmF0aXZlbHksIGlmIHRoZSBnb2FsIGlzIHRvIGtlZXAgdGhlIGF0
dHJpYnV0ZSBmbGF0LCB3ZSBtYXkgc2hvdyAKdGhlIG1hcHBpbmcgZm9yIHRoZSBwYXJlbnQgY2Fw
YWJpbGl0eSBhbmQgdGhlIHN1cHBvcnRlZCBjbGFzczoKCiQgdmRwYSBtZ210ZGV2IGNhcGFiIHNo
b3cKcGNpLzAwMDA6NDE6MDAuMjoKIMKgIGNsYXNzOiBuZXQKIMKgwqDCoMKgIG1hYzogb2ZmCiDC
oMKgwqDCoCBtdHU6IG9uCiDCoMKgwqDCoCBtYXhfbXR1OiA5MDAwCiDCoMKgwqDCoCBtYXhfdnFw
OiAxCmF1eGlsaWFyeS9tbHg1X2NvcmUuc2YuMToKIMKgIGNsYXNzOiBuZXQKIMKgwqDCoMKgIG1h
Yzogb24KIMKgwqDCoMKgIG10dTogb2ZmCiDCoMKgwqDCoCBtYXhfbXR1OiAxNTAwCiDCoMKgwqDC
oCBtYXhfdnFwOiAyNTYKClRoYW5rcywKLVNpd2VpCgo+Cj4gVGhhbmtzCj4KPj4gLVNpd2VpCj4+
Cj4+PiBTaWduZWQtb2ZmLWJ5OiBFbGkgQ29oZW4gPGVsaWNAbnZpZGlhLmNvbT4KPj4+IC0tLQo+
Pj4gdjAgLT4gdjE6Cj4+PiAxLiBmaXggdHlwbwo+Pj4gMi4gbW92ZSBtYXhfdnFfcGFpcnMgdG8g
bmV0IHNwZWNpZmljIHN0cnVjdAo+Pj4KPj4+ICAgIGRyaXZlcnMvdmRwYS92ZHBhLmMgIHwgMTQg
KysrKysrKysrKysrKy0KPj4+ICAgIGluY2x1ZGUvbGludXgvdmRwYS5oIHwgIDEgKwo+Pj4gICAg
MiBmaWxlcyBjaGFuZ2VkLCAxNCBpbnNlcnRpb25zKCspLCAxIGRlbGV0aW9uKC0pCj4+Pgo+Pj4g
ZGlmZiAtLWdpdCBhL2RyaXZlcnMvdmRwYS92ZHBhLmMgYi9kcml2ZXJzL3ZkcGEvdmRwYS5jCj4+
PiBpbmRleCBjMzdkMzg0YzBmMzMuLjNiZjAxNmUwMzUxMiAxMDA2NDQKPj4+IC0tLSBhL2RyaXZl
cnMvdmRwYS92ZHBhLmMKPj4+ICsrKyBiL2RyaXZlcnMvdmRwYS92ZHBhLmMKPj4+IEBAIC00ODAs
NyArNDgwLDggQEAgdmRwYV9ubF9jbWRfbWdtdGRldl9nZXRfZHVtcGl0KHN0cnVjdCBza19idWZm
ICptc2csIHN0cnVjdCBuZXRsaW5rX2NhbGxiYWNrICpjYikKPj4+ICAgIH0KPj4+Cj4+PiAgICAj
ZGVmaW5lIFZEUEFfREVWX05FVF9BVFRSU19NQVNLICgoMSA8PCBWRFBBX0FUVFJfREVWX05FVF9D
RkdfTUFDQUREUikgfCBcCj4+PiAtICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgKDEgPDwg
VkRQQV9BVFRSX0RFVl9ORVRfQ0ZHX01UVSkpCj4+PiArICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgKDEgPDwgVkRQQV9BVFRSX0RFVl9ORVRfQ0ZHX01UVSkgfCBcCj4+PiArICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgKDEgPDwgVkRQQV9BVFRSX0RFVl9ORVRfQ0ZHX01BWF9WUVAp
KQo+Pj4KPj4+ICAgIHN0YXRpYyBpbnQgdmRwYV9ubF9jbWRfZGV2X2FkZF9zZXRfZG9pdChzdHJ1
Y3Qgc2tfYnVmZiAqc2tiLCBzdHJ1Y3QgZ2VubF9pbmZvICppbmZvKQo+Pj4gICAgewo+Pj4gQEAg
LTUwNiw2ICs1MDcsMTcgQEAgc3RhdGljIGludCB2ZHBhX25sX2NtZF9kZXZfYWRkX3NldF9kb2l0
KHN0cnVjdCBza19idWZmICpza2IsIHN0cnVjdCBnZW5sX2luZm8gKmkKPj4+ICAgICAgICAgICAg
ICAgICAgICAgICAgbmxhX2dldF91MTYobmxfYXR0cnNbVkRQQV9BVFRSX0RFVl9ORVRfQ0ZHX01U
VV0pOwo+Pj4gICAgICAgICAgICAgICAgY29uZmlnLm1hc2sgfD0gKDEgPDwgVkRQQV9BVFRSX0RF
Vl9ORVRfQ0ZHX01UVSk7Cj4+PiAgICAgICAgfQo+Pj4gKyAgICAgaWYgKG5sX2F0dHJzW1ZEUEFf
QVRUUl9ERVZfTkVUX0NGR19NQVhfVlFQXSkgewo+Pj4gKyAgICAgICAgICAgICBjb25maWcubmV0
Lm1heF92cV9wYWlycyA9Cj4+PiArICAgICAgICAgICAgICAgICAgICAgbmxhX2dldF91MTYobmxf
YXR0cnNbVkRQQV9BVFRSX0RFVl9ORVRfQ0ZHX01BWF9WUVBdKTsKPj4+ICsgICAgICAgICAgICAg
aWYgKCFjb25maWcubmV0Lm1heF92cV9wYWlycykgewo+Pj4gKyAgICAgICAgICAgICAgICAgICAg
IE5MX1NFVF9FUlJfTVNHX01PRChpbmZvLT5leHRhY2ssCj4+PiArICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICJBdCBsZWFzdCBvbmUgcGFpciBvZiBWUXMgaXMgcmVxdWly
ZWQiKTsKPj4+ICsgICAgICAgICAgICAgICAgICAgICBlcnIgPSAtRUlOVkFMOwo+Pj4gKyAgICAg
ICAgICAgICAgICAgICAgIGdvdG8gZXJyOwo+Pj4gKyAgICAgICAgICAgICB9Cj4+PiArICAgICAg
ICAgICAgIGNvbmZpZy5tYXNrIHw9IEJJVF9VTEwoVkRQQV9BVFRSX0RFVl9ORVRfQ0ZHX01BWF9W
UVApOwo+Pj4gKyAgICAgfQo+Pj4KPj4+ICAgICAgICAvKiBTa2lwIGNoZWNraW5nIGNhcGFiaWxp
dHkgaWYgdXNlciBkaWRuJ3QgcHJlZmVyIHRvIGNvbmZpZ3VyZSBhbnkKPj4+ICAgICAgICAgKiBk
ZXZpY2UgbmV0d29ya2luZyBhdHRyaWJ1dGVzLiBJdCBpcyBsaWtlbHkgdGhhdCB1c2VyIG1pZ2h0
IGhhdmUgdXNlZAo+Pj4gZGlmZiAtLWdpdCBhL2luY2x1ZGUvbGludXgvdmRwYS5oIGIvaW5jbHVk
ZS9saW51eC92ZHBhLmgKPj4+IGluZGV4IGRiMjQzMTdkNjFiNi4uYjYyMDMyNTczNzgwIDEwMDY0
NAo+Pj4gLS0tIGEvaW5jbHVkZS9saW51eC92ZHBhLmgKPj4+ICsrKyBiL2luY2x1ZGUvbGludXgv
dmRwYS5oCj4+PiBAQCAtOTksNiArOTksNyBAQCBzdHJ1Y3QgdmRwYV9kZXZfc2V0X2NvbmZpZyB7
Cj4+PiAgICAgICAgc3RydWN0IHsKPj4+ICAgICAgICAgICAgICAgIHU4IG1hY1tFVEhfQUxFTl07
Cj4+PiAgICAgICAgICAgICAgICB1MTYgbXR1Owo+Pj4gKyAgICAgICAgICAgICB1MTYgbWF4X3Zx
X3BhaXJzOwo+Pj4gICAgICAgIH0gbmV0Owo+Pj4gICAgICAgIHU2NCBtYXNrOwo+Pj4gICAgfTsK
Cl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fClZpcnR1YWxp
emF0aW9uIG1haWxpbmcgbGlzdApWaXJ0dWFsaXphdGlvbkBsaXN0cy5saW51eC1mb3VuZGF0aW9u
Lm9yZwpodHRwczovL2xpc3RzLmxpbnV4Zm91bmRhdGlvbi5vcmcvbWFpbG1hbi9saXN0aW5mby92
aXJ0dWFsaXphdGlvbg==
