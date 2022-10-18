Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B3957C433FE
	for <virtualization@archiver.kernel.org>; Tue, 18 Oct 2022 19:27:27 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 37F9D41B45;
	Tue, 18 Oct 2022 19:27:27 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 37F9D41B45
Authentication-Results: smtp4.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.a=rsa-sha256 header.s=corp-2022-7-12 header.b=kknmIXih;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.a=rsa-sha256 header.s=selector2-oracle-onmicrosoft-com header.b=VuG56OpJ
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id vfNopvTxGYQr; Tue, 18 Oct 2022 19:27:25 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id E872141B2E;
	Tue, 18 Oct 2022 19:27:24 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org E872141B2E
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 9B600C0033;
	Tue, 18 Oct 2022 19:27:24 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id C9FD0C002D
 for <virtualization@lists.linux-foundation.org>;
 Tue, 18 Oct 2022 19:27:23 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 85D9683F05
 for <virtualization@lists.linux-foundation.org>;
 Tue, 18 Oct 2022 19:27:23 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 85D9683F05
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com
 header.a=rsa-sha256 header.s=corp-2022-7-12 header.b=kknmIXih; 
 dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com
 header.i=@oracle.onmicrosoft.com header.a=rsa-sha256
 header.s=selector2-oracle-onmicrosoft-com header.b=VuG56OpJ
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 1ob4ug33UQcj
 for <virtualization@lists.linux-foundation.org>;
 Tue, 18 Oct 2022 19:27:22 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 3867783F03
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com
 [205.220.177.32])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 3867783F03
 for <virtualization@lists.linux-foundation.org>;
 Tue, 18 Oct 2022 19:27:21 +0000 (UTC)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 29IIDvNT000845;
 Tue, 18 Oct 2022 19:27:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=content-type :
 message-id : date : subject : to : cc : references : from : in-reply-to :
 mime-version; s=corp-2022-7-12;
 bh=TF7fOc3X4Fd5A0RjgDQG7kxniwM5BOv/76MaBL3+NcY=;
 b=kknmIXihqi8l5n+lExTxTn5wEwcnqexuXAkuPIqEu/0eH4kiC88GE4lbReXurPCsbRiB
 e4MsSIIhTU17lq54vBhsF3etwzfwpSRUpDX1VmPQUrOe8S4z9IYegF2hbDsVqLCNvn7G
 xgcKf6mtAazGlH1q6Pp7zGknx/VtAN4/YUzv5pcv5qUXtMD8d/k7axGb1GQpbs5SV4SX
 8BWoN3iJLioBneTqDpse0cETk87opk/FYH+D9nWx177kNYTMlXOIlP7K9l2Ea86H5E5v
 T8I7F9zys87vvHStgnZg7HzStVWfoZd3O0gWMUtajbtrErcJZreqysqaVJvJXx2BtTPa 3A== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3k9b7skcq4-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 18 Oct 2022 19:27:20 +0000
Received: from pps.filterd
 (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5)
 with ESMTP id 29IHacgt035625; Tue, 18 Oct 2022 19:27:19 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com
 (mail-dm6nam12lp2169.outbound.protection.outlook.com [104.47.59.169])
 by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 3k8hu7rb23-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 18 Oct 2022 19:27:19 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=l/g8OjqmjvYx5mtA725jjof52LXBFRXLH7gSn0sV114Yi96jK+zdBKA7z/gMei7niVhBFarCJUclubxyBTULHUfo1+R55fdClHAFEkeCFfNqf5w5hTJ/q9xJhsMkG0Ne3vGb11xdsWybDMwPwoMzkT8Cxd2qVCeLlV+qIh5OBInNXezUYyCLE7wWZI+HetN73mRWYqT3plZEMuQg7h7I95lr5Rk+GUyfuZz/wVhtTtW1qXdGPIv800raUO+hosXB6R4cBjPeTbqWRTfrSmTy0LocftePQ7BaaA5tnovznjr4lvfYnSV2HlEOi6HinNp/ipWaCX70333Am2QpTXl97Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TF7fOc3X4Fd5A0RjgDQG7kxniwM5BOv/76MaBL3+NcY=;
 b=a+9cX98uJpCCS7+l3UXhItyXRLCxsj3Sl9a/GBtCjT/XssM7HTqXvq8N1B5KFguKomz5cKmwcOGtjNbF78NQBHfhhJsge+DgxtlVsvoa96lSbyySflh6smnla5IJ/QusWQDUp/x0H5v1AzTtSSfrkM2Aj4UGS39MkP19tUHj8sdD7Jt1a+p8X0c5fMg+nW2/U2sS+sC2KQSwz5rbZ3Tj1t+4/9edH70uITDEup6VICmna1TT8ze/ALtbAN8aKCHtnbpafH9IUAdnHfNqPqQ9dyIKL2r3Z+UGV51KhAFbnlrdvLNq9WdHSlnDcLGxvcAF1kf4+G7731gHtYmvCtyQJw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TF7fOc3X4Fd5A0RjgDQG7kxniwM5BOv/76MaBL3+NcY=;
 b=VuG56OpJbFx53rS7l/2svkG2zNvNFkykU8CiaQcO6KjXpFQVTdfZPNQZrX5MFIFRd2USd6hF3EjmeFgJJclSTFHeugLoEXdvn9iGQBqjNJcv+6n6HP45S+jkWbcWZhYNmp8Gv9qLawJ8W2pzCpf4PSJDY9RtW4Li7+E1GKkWiTw=
Received: from MW4PR10MB6535.namprd10.prod.outlook.com (2603:10b6:303:225::12)
 by CH2PR10MB4165.namprd10.prod.outlook.com (2603:10b6:610:a5::24)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.34; Tue, 18 Oct
 2022 19:27:17 +0000
Received: from MW4PR10MB6535.namprd10.prod.outlook.com
 ([fe80::9830:ae4d:f10c:c30a]) by MW4PR10MB6535.namprd10.prod.outlook.com
 ([fe80::9830:ae4d:f10c:c30a%5]) with mapi id 15.20.5723.032; Tue, 18 Oct 2022
 19:27:17 +0000
Message-ID: <5eca75d1-afdb-29f9-f728-6559379c06a3@oracle.com>
Date: Tue, 18 Oct 2022 12:27:14 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.3
Subject: Re: [PATCH 2/4] vdpa/mlx5: Move some definitions to a new header file
Content-Language: en-US
To: Eli Cohen <elic@nvidia.com>, mst@redhat.com, jasowang@redhat.com,
 linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org
References: <20221018111232.4021-1-elic@nvidia.com>
 <20221018111232.4021-3-elic@nvidia.com>
From: Si-Wei Liu <si-wei.liu@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <20221018111232.4021-3-elic@nvidia.com>
X-ClientProxiedBy: SJ0PR03CA0219.namprd03.prod.outlook.com
 (2603:10b6:a03:39f::14) To MW4PR10MB6535.namprd10.prod.outlook.com
 (2603:10b6:303:225::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR10MB6535:EE_|CH2PR10MB4165:EE_
X-MS-Office365-Filtering-Correlation-Id: 02ebedad-ad30-4905-ed8d-08dab13ec49b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 3BCGUwNWNuA1s/oOQKvqppNue1Sdc+SuRmj2cS0mpmgo06FzlBbmWJFpOADKkIbymNPXiSlsKgVRfowtiV+mtedYHHZX4ft1op9AqmXTgqoBfVHY+Kz79OEq2dv1XNxPD0ujF50Al2j6nV7u2nL+Lq3PGQI5yMwNfLwuNvbnqORIJ6pzlg2gi4yS77K77qdONKX++CsDS0MJbXko2Fdsyvoozcp37isDUb8mIfCTpMhMp0wi6QKdDnGAHrt5tq16HloIKKxwMRcxUWxrlAjYpHGSXffRZgUt1NrREFmImZ1q8nZ2AnYJXxC1rtPVqKRjbbcnek4Dz5XhQlQPnLtKfT5E+4nSpuluS5tMlTTtQrE2Gq582YqRKeBn8gHyFcjSbHK2JWQuJzi02Rurm6/4KITyFN5E1lModHVwePQQBnPA1NcSKN00lDw5WhVrqOIm11V7cMo47HbePZ7Ur8e0CmYauK0Bu+KJ5NKCarNl86YU1QCE2IvJsouRJZAQRvK5wFlmhU10ONHnQNc04iIykSxfkdJU2OEUhg+F1LJoeHgMv2bHsUN26oz/muPqNaOuqPA8Ahm5kQiW81uZUERiXtf3QfRiZWOOg5Jl4Zsfdlp8Jp0/fiGjWPkG2nYv1cRqrS8p6+hdY+dN7LC+YA9Rck5vqctxiSDFCK4XQ1YQNKy28+gN4HuD4Xm3v8onwBAXraTPz4aFFlu2Mkr+cs0QvzXolmMSvRwxG4ThD6ZY9jXYKSZ3DmNnyxrjwc8kbdO9aV4pCfbtFnrd2dAMW/R1ql3/l5aRvsiPSyTE9RlCsEM=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW4PR10MB6535.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230022)(376002)(366004)(136003)(396003)(39860400002)(346002)(451199015)(6506007)(6666004)(186003)(33964004)(6512007)(2616005)(36916002)(26005)(53546011)(83380400001)(2906002)(5660300002)(66946007)(316002)(6486002)(478600001)(41300700001)(8936002)(4326008)(8676002)(66476007)(66556008)(31696002)(36756003)(86362001)(38100700002)(31686004)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SEtLQUZEY0xIQTlTSWg3OE0rVjhzWWFVRzhUbHhYWXhOWVBPWUc2aDlJV1Ex?=
 =?utf-8?B?dXo0aWNLSm9BekV4RG1BQjFtN2RWc1o3aU5wZ2pJL1FoanpMMEt5Qk5nSlRE?=
 =?utf-8?B?TGNPZFQ1U1RJUFdlN0hFMDlnd1c1OVlZVDhGS3NkcEpqeXNUYkt1aU1uRjFZ?=
 =?utf-8?B?bUZqYUJRTUFLYzlIdUt0amovQ0xDWEVxbWVyRHZxa2p5bXlieGZseW1VUkZj?=
 =?utf-8?B?NzFXb1BQNUZtekJUY2QycE5OME1PRlZDbjJzYTFOME83Uk1KcGdFc0xUeFg1?=
 =?utf-8?B?akpIRmxtSDBrdkVCaGhzdVFVbmkwVWpzVFJDRVhPU2NQOUMrUWh5azRYOUNw?=
 =?utf-8?B?eU1LZHhtaVdPYXZITi84Ny9kVVQxejRPL2JzMGhSd3hXUFJLbHhaRnBXYm10?=
 =?utf-8?B?NURGQTNkbkc1R3RCSk5Hd0l2RFpNeHRnTko0VVdNMWo1NzlsTTBYZWEwQWxz?=
 =?utf-8?B?Ukp5UDNMalBzQXRUUnllenlYOFgyTU1JQkV1TktpVkdqRTdmMGdOM21INnMr?=
 =?utf-8?B?WHNYZVMxTGVrdDQ0UStZVDliUnpITmNCdktoaG02elptZEo0dFVRT3A1ZkYw?=
 =?utf-8?B?VENnZ1hMbm9NOTM3dlNTazViSzEwZmdMZFl1YnYvdGRPQlI2R0ZZMUZHWmhl?=
 =?utf-8?B?TUMvUWFpTjk3SnRENG5zMXIvOEpEaFBFaFBTNmtwaDFvODNRV3l3cVNaZDdU?=
 =?utf-8?B?cktTRll5QWFKV3ZEcE1HVC81WDlNaGJXR0Y2bTJUay9mUkt2UzlhdFJ6czZz?=
 =?utf-8?B?cmNLYzZVOUV1NEgxVGN2Tm5kOGN1c1pRQ0hmZ3V0dytXSm5ONTROQ1dubXVa?=
 =?utf-8?B?ZUZJS08vMzdFeGdwb3I2cGl3dUs1Z2V4WTVjMUx4Wkt6cldyanByb0pIT3F6?=
 =?utf-8?B?Z3M1Uzk3WGJZeVdnTktoSmpZS2cxalZlbXhqOGQ3QW8vYlE3ZDZuSEVRM2NM?=
 =?utf-8?B?K2IxSzZyb2tnOUhlVHM4S2tHQTdKYjN6VGxqUUhJRDhTemJSVk1lSE94dUxy?=
 =?utf-8?B?aVpJUVBHbzRic1EyS3NuemV3NzBkdWlIcDRsaDNnMHc1OGs5aDB1V0NDaTZW?=
 =?utf-8?B?SzUrdzNHL2V2dG80d0E1UHQ4MEkyZUMyZXpoWjBhOGU3UityNGozSTFkY3VH?=
 =?utf-8?B?eEUzbXppOGVtTG9uSnZTSzlqajFLb3p6YjhPdXcxNXNkc2twc3pHbkoxcWxL?=
 =?utf-8?B?WGdzK24zUGp6T1RnTVZIZkt2cWFZZyt2UW9mc0l5WUxxeU4yaTllSkZWeEVi?=
 =?utf-8?B?bkZkdGN0c3dzdzd2UTZrUWhaekk2WnZKb0VOQWpNcFYwbDRjZkQ2d2pJbHR2?=
 =?utf-8?B?eVNYZWxOczM3cUVleTM0Y1lWaTJGbFF0ODFlcjVvOGVLbHJPUUlESWRnaXhM?=
 =?utf-8?B?QkM3NklrNTUra2RmaTh1dXBjSE5mS0JEallyQndGdFhPaXQ3Q3ZDVVlQSEwz?=
 =?utf-8?B?TEdTNzIwdndXYUxuZFg2TDRPbzNwMzUvYzJvKy9UOERZYTBEWVdMTGhVQlFM?=
 =?utf-8?B?NjRLc1ZzNUtka3dsK0hHa05aYVVwNWZsb1NXanFIZ2FMWW9PZ3dHdVFOcDNo?=
 =?utf-8?B?ZC82MDBSZERjUElxV0wvUmppR0xpZjFxaXh0MGVaV01iV1A4L1ZYc3BnU3JE?=
 =?utf-8?B?TTdFdTFIQlpKOGNCVEdDTG1jUTdQWDhEbWZxRzFGTkw1aTJ1QVhrTmh3T2Ew?=
 =?utf-8?B?Y3lsVmZCa0tkVzgydjYrVEp2NnE1RVFLZVZ5SnUrUWRoZnB2RjVpNmVicDdS?=
 =?utf-8?B?ZUg1cnVQYzBsVnlEbElleHZPcmpPcU0rK3p2dUhmYWt3VWt1SGh0S1BMQkM5?=
 =?utf-8?B?R0QxbHkwL0FUVm1IRXpsZzE0d2twTWxmYjJUS3Y4Vzd2Sk9GUm1YVy9wSERs?=
 =?utf-8?B?aVNJVGhiSTZrT1hpZVc2ejRWbUtsT3FJbmVqRVBqL1Rwb3lWMDM0ME00TXZw?=
 =?utf-8?B?TUtDUGlWQlFCVURlRlZlLzg2UHVNYXFzRFFpQU9IcFdTSXh3N1FheFdnMVNJ?=
 =?utf-8?B?N21WSHQzd1ZuU2NxSUFGOUkrMVRtL2JwWWJVZDJ3SjFSeVUyT2VsZ0YyQktZ?=
 =?utf-8?B?ZmhWWkJWZDFRUWtLTUxYQi9nMnZpNGo0R0VpUG82cVdOajQ2OUtCeVV1Yklm?=
 =?utf-8?Q?ub+6l3nBDpvEgnYVfmpYVKY90?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 02ebedad-ad30-4905-ed8d-08dab13ec49b
X-MS-Exchange-CrossTenant-AuthSource: MW4PR10MB6535.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Oct 2022 19:27:17.2863 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qX8OdjE83Gs2zhvlkIAAO6BEpxlzLKS9IziwoG0bYnIPeCtXBGiwBIzLZ/zqgcRD///jf9B9tj8PFdiJazgH6w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR10MB4165
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-10-18_07,2022-10-18_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0
 adultscore=0 mlxscore=0
 spamscore=0 bulkscore=0 malwarescore=0 mlxlogscore=999 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2209130000
 definitions=main-2210180109
X-Proofpoint-GUID: cPImB0GO0wPKaOTFdDtJ75p8Wc2IR4C8
X-Proofpoint-ORIG-GUID: cPImB0GO0wPKaOTFdDtJ75p8Wc2IR4C8
Cc: eperezma@redhat.com, lulu@redhat.com
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
Content-Type: multipart/mixed; boundary="===============1442082883980996414=="
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

--===============1442082883980996414==
Content-Type: multipart/alternative;
 boundary="------------q9dWo4iTMm9Oafix0Ix73r4h"
Content-Language: en-US

--------------q9dWo4iTMm9Oafix0Ix73r4h
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 10/18/2022 4:12 AM, Eli Cohen wrote:
> Move some definitions from mlx5_vnet.c to newly added header file
> mlx5_vnet.h. We need these definitions for the following patches that
> add debugfs tree to expose information vital for debug.
>
> Signed-off-by: Eli Cohen<elic@nvidia.com>
Reviewed-by: Si-Wei Liu <si-wei.liu@oracle.com>
> ---
>   drivers/vdpa/mlx5/net/mlx5_vnet.c | 45 +------------------------
>   drivers/vdpa/mlx5/net/mlx5_vnet.h | 55 +++++++++++++++++++++++++++++++
>   2 files changed, 56 insertions(+), 44 deletions(-)
>   create mode 100644 drivers/vdpa/mlx5/net/mlx5_vnet.h
>
> diff --git a/drivers/vdpa/mlx5/net/mlx5_vnet.c b/drivers/vdpa/mlx5/net/mlx5_vnet.c
> index dd29fdfc24ed..64fdb940380f 100644
> --- a/drivers/vdpa/mlx5/net/mlx5_vnet.c
> +++ b/drivers/vdpa/mlx5/net/mlx5_vnet.c
> @@ -18,15 +18,12 @@
>   #include <linux/mlx5/mlx5_ifc_vdpa.h>
>   #include <linux/mlx5/mpfs.h>
>   #include "mlx5_vdpa.h"
> +#include "mlx5_vnet.h"
>   
>   MODULE_AUTHOR("Eli Cohen<eli@mellanox.com>");
>   MODULE_DESCRIPTION("Mellanox VDPA driver");
>   MODULE_LICENSE("Dual BSD/GPL");
>   
> -#define to_mlx5_vdpa_ndev(__mvdev)                                             \
> -	container_of(__mvdev, struct mlx5_vdpa_net, mvdev)
> -#define to_mvdev(__vdev) container_of((__vdev), struct mlx5_vdpa_dev, vdev)
> -
>   #define VALID_FEATURES_MASK                                                                        \
>   	(BIT_ULL(VIRTIO_NET_F_CSUM) | BIT_ULL(VIRTIO_NET_F_GUEST_CSUM) |                                   \
>   	 BIT_ULL(VIRTIO_NET_F_CTRL_GUEST_OFFLOADS) | BIT_ULL(VIRTIO_NET_F_MTU) | BIT_ULL(VIRTIO_NET_F_MAC) |   \
> @@ -50,14 +47,6 @@ MODULE_LICENSE("Dual BSD/GPL");
>   
>   #define MLX5V_UNTAGGED 0x1000
>   
> -struct mlx5_vdpa_net_resources {
> -	u32 tisn;
> -	u32 tdn;
> -	u32 tirn;
> -	u32 rqtn;
> -	bool valid;
> -};
> -
>   struct mlx5_vdpa_cq_buf {
>   	struct mlx5_frag_buf_ctrl fbc;
>   	struct mlx5_frag_buf frag_buf;
> @@ -146,38 +135,6 @@ static bool is_index_valid(struct mlx5_vdpa_dev *mvdev, u16 idx)
>   	return idx <= mvdev->max_idx;
>   }
>   
> -#define MLX5V_MACVLAN_SIZE 256
> -
> -struct mlx5_vdpa_net {
> -	struct mlx5_vdpa_dev mvdev;
> -	struct mlx5_vdpa_net_resources res;
> -	struct virtio_net_config config;
> -	struct mlx5_vdpa_virtqueue *vqs;
> -	struct vdpa_callback *event_cbs;
> -
> -	/* Serialize vq resources creation and destruction. This is required
> -	 * since memory map might change and we need to destroy and create
> -	 * resources while driver in operational.
> -	 */
> -	struct rw_semaphore reslock;
> -	struct mlx5_flow_table *rxft;
> -	bool setup;
> -	u32 cur_num_vqs;
> -	u32 rqt_size;
> -	bool nb_registered;
> -	struct notifier_block nb;
> -	struct vdpa_callback config_cb;
> -	struct mlx5_vdpa_wq_ent cvq_ent;
> -	struct hlist_head macvlan_hash[MLX5V_MACVLAN_SIZE];
> -};
> -
> -struct macvlan_node {
> -	struct hlist_node hlist;
> -	struct mlx5_flow_handle *ucast_rule;
> -	struct mlx5_flow_handle *mcast_rule;
> -	u64 macvlan;
> -};
> -
>   static void free_resources(struct mlx5_vdpa_net *ndev);
>   static void init_mvqs(struct mlx5_vdpa_net *ndev);
>   static int setup_driver(struct mlx5_vdpa_dev *mvdev);
> diff --git a/drivers/vdpa/mlx5/net/mlx5_vnet.h b/drivers/vdpa/mlx5/net/mlx5_vnet.h
> new file mode 100644
> index 000000000000..6691c879a6ca
> --- /dev/null
> +++ b/drivers/vdpa/mlx5/net/mlx5_vnet.h
> @@ -0,0 +1,55 @@
> +/* SPDX-License-Identifier: GPL-2.0 OR Linux-OpenIB */
> +/* Copyright (c) 2022, NVIDIA CORPORATION & AFFILIATES. All rights reserved. */
> +
> +#ifndef __MLX5_VNET_H__
> +#define __MLX5_VNET_H__
> +
> +#include "mlx5_vdpa.h"
> +
> +#define to_mlx5_vdpa_ndev(__mvdev)                                             \
> +	container_of(__mvdev, struct mlx5_vdpa_net, mvdev)
> +#define to_mvdev(__vdev) container_of((__vdev), struct mlx5_vdpa_dev, vdev)
> +
> +struct mlx5_vdpa_net_resources {
> +	u32 tisn;
> +	u32 tdn;
> +	u32 tirn;
> +	u32 rqtn;
> +	bool valid;
> +};
> +
> +#define MLX5V_MACVLAN_SIZE 256
> +
> +struct mlx5_vdpa_net {
> +	struct mlx5_vdpa_dev mvdev;
> +	struct mlx5_vdpa_net_resources res;
> +	struct virtio_net_config config;
> +	struct mlx5_vdpa_virtqueue *vqs;
> +	struct vdpa_callback *event_cbs;
> +
> +	/* Serialize vq resources creation and destruction. This is required
> +	 * since memory map might change and we need to destroy and create
> +	 * resources while driver in operational.
> +	 */
> +	struct rw_semaphore reslock;
> +	struct mlx5_flow_table *rxft;
> +	struct dentry *rx_dent;
> +	struct dentry *rx_table_dent;
> +	bool setup;
> +	u32 cur_num_vqs;
> +	u32 rqt_size;
> +	bool nb_registered;
> +	struct notifier_block nb;
> +	struct vdpa_callback config_cb;
> +	struct mlx5_vdpa_wq_ent cvq_ent;
> +	struct hlist_head macvlan_hash[MLX5V_MACVLAN_SIZE];
> +};
> +
> +struct macvlan_node {
> +	struct hlist_node hlist;
> +	struct mlx5_flow_handle *ucast_rule;
> +	struct mlx5_flow_handle *mcast_rule;
> +	u64 macvlan;
> +};
> +
> +#endif /* __MLX5_VNET_H__ */

--------------q9dWo4iTMm9Oafix0Ix73r4h
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 7bit

<html><head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body>
    <br>
    <br>
    <div class="moz-cite-prefix">On 10/18/2022 4:12 AM, Eli Cohen wrote:<br>
    </div>
    <blockquote type="cite" cite="mid:20221018111232.4021-3-elic@nvidia.com">
      <pre class="moz-quote-pre" wrap="">Move some definitions from mlx5_vnet.c to newly added header file
mlx5_vnet.h. We need these definitions for the following patches that
add debugfs tree to expose information vital for debug.

Signed-off-by: Eli Cohen <a class="moz-txt-link-rfc2396E" href="mailto:elic@nvidia.com">&lt;elic@nvidia.com&gt;</a></pre>
    </blockquote>
    Reviewed-by: Si-Wei Liu <a class="moz-txt-link-rfc2396E" href="mailto:si-wei.liu@oracle.com">&lt;si-wei.liu@oracle.com&gt;</a>
    <br>
    <blockquote type="cite" cite="mid:20221018111232.4021-3-elic@nvidia.com">
      <pre class="moz-quote-pre" wrap="">
---
 drivers/vdpa/mlx5/net/mlx5_vnet.c | 45 +------------------------
 drivers/vdpa/mlx5/net/mlx5_vnet.h | 55 +++++++++++++++++++++++++++++++
 2 files changed, 56 insertions(+), 44 deletions(-)
 create mode 100644 drivers/vdpa/mlx5/net/mlx5_vnet.h

diff --git a/drivers/vdpa/mlx5/net/mlx5_vnet.c b/drivers/vdpa/mlx5/net/mlx5_vnet.c
index dd29fdfc24ed..64fdb940380f 100644
--- a/drivers/vdpa/mlx5/net/mlx5_vnet.c
+++ b/drivers/vdpa/mlx5/net/mlx5_vnet.c
@@ -18,15 +18,12 @@
 #include &lt;linux/mlx5/mlx5_ifc_vdpa.h&gt;
 #include &lt;linux/mlx5/mpfs.h&gt;
 #include &quot;mlx5_vdpa.h&quot;
+#include &quot;mlx5_vnet.h&quot;
 
 MODULE_AUTHOR(&quot;Eli Cohen <a class="moz-txt-link-rfc2396E" href="mailto:eli@mellanox.com">&lt;eli@mellanox.com&gt;</a>&quot;);
 MODULE_DESCRIPTION(&quot;Mellanox VDPA driver&quot;);
 MODULE_LICENSE(&quot;Dual BSD/GPL&quot;);
 
-#define to_mlx5_vdpa_ndev(__mvdev)                                             \
-	container_of(__mvdev, struct mlx5_vdpa_net, mvdev)
-#define to_mvdev(__vdev) container_of((__vdev), struct mlx5_vdpa_dev, vdev)
-
 #define VALID_FEATURES_MASK                                                                        \
 	(BIT_ULL(VIRTIO_NET_F_CSUM) | BIT_ULL(VIRTIO_NET_F_GUEST_CSUM) |                                   \
 	 BIT_ULL(VIRTIO_NET_F_CTRL_GUEST_OFFLOADS) | BIT_ULL(VIRTIO_NET_F_MTU) | BIT_ULL(VIRTIO_NET_F_MAC) |   \
@@ -50,14 +47,6 @@ MODULE_LICENSE(&quot;Dual BSD/GPL&quot;);
 
 #define MLX5V_UNTAGGED 0x1000
 
-struct mlx5_vdpa_net_resources {
-	u32 tisn;
-	u32 tdn;
-	u32 tirn;
-	u32 rqtn;
-	bool valid;
-};
-
 struct mlx5_vdpa_cq_buf {
 	struct mlx5_frag_buf_ctrl fbc;
 	struct mlx5_frag_buf frag_buf;
@@ -146,38 +135,6 @@ static bool is_index_valid(struct mlx5_vdpa_dev *mvdev, u16 idx)
 	return idx &lt;= mvdev-&gt;max_idx;
 }
 
-#define MLX5V_MACVLAN_SIZE 256
-
-struct mlx5_vdpa_net {
-	struct mlx5_vdpa_dev mvdev;
-	struct mlx5_vdpa_net_resources res;
-	struct virtio_net_config config;
-	struct mlx5_vdpa_virtqueue *vqs;
-	struct vdpa_callback *event_cbs;
-
-	/* Serialize vq resources creation and destruction. This is required
-	 * since memory map might change and we need to destroy and create
-	 * resources while driver in operational.
-	 */
-	struct rw_semaphore reslock;
-	struct mlx5_flow_table *rxft;
-	bool setup;
-	u32 cur_num_vqs;
-	u32 rqt_size;
-	bool nb_registered;
-	struct notifier_block nb;
-	struct vdpa_callback config_cb;
-	struct mlx5_vdpa_wq_ent cvq_ent;
-	struct hlist_head macvlan_hash[MLX5V_MACVLAN_SIZE];
-};
-
-struct macvlan_node {
-	struct hlist_node hlist;
-	struct mlx5_flow_handle *ucast_rule;
-	struct mlx5_flow_handle *mcast_rule;
-	u64 macvlan;
-};
-
 static void free_resources(struct mlx5_vdpa_net *ndev);
 static void init_mvqs(struct mlx5_vdpa_net *ndev);
 static int setup_driver(struct mlx5_vdpa_dev *mvdev);
diff --git a/drivers/vdpa/mlx5/net/mlx5_vnet.h b/drivers/vdpa/mlx5/net/mlx5_vnet.h
new file mode 100644
index 000000000000..6691c879a6ca
--- /dev/null
+++ b/drivers/vdpa/mlx5/net/mlx5_vnet.h
@@ -0,0 +1,55 @@
+/* SPDX-License-Identifier: GPL-2.0 OR Linux-OpenIB */
+/* Copyright (c) 2022, NVIDIA CORPORATION &amp; AFFILIATES. All rights reserved. */
+
+#ifndef __MLX5_VNET_H__
+#define __MLX5_VNET_H__
+
+#include &quot;mlx5_vdpa.h&quot;
+
+#define to_mlx5_vdpa_ndev(__mvdev)                                             \
+	container_of(__mvdev, struct mlx5_vdpa_net, mvdev)
+#define to_mvdev(__vdev) container_of((__vdev), struct mlx5_vdpa_dev, vdev)
+
+struct mlx5_vdpa_net_resources {
+	u32 tisn;
+	u32 tdn;
+	u32 tirn;
+	u32 rqtn;
+	bool valid;
+};
+
+#define MLX5V_MACVLAN_SIZE 256
+
+struct mlx5_vdpa_net {
+	struct mlx5_vdpa_dev mvdev;
+	struct mlx5_vdpa_net_resources res;
+	struct virtio_net_config config;
+	struct mlx5_vdpa_virtqueue *vqs;
+	struct vdpa_callback *event_cbs;
+
+	/* Serialize vq resources creation and destruction. This is required
+	 * since memory map might change and we need to destroy and create
+	 * resources while driver in operational.
+	 */
+	struct rw_semaphore reslock;
+	struct mlx5_flow_table *rxft;
+	struct dentry *rx_dent;
+	struct dentry *rx_table_dent;
+	bool setup;
+	u32 cur_num_vqs;
+	u32 rqt_size;
+	bool nb_registered;
+	struct notifier_block nb;
+	struct vdpa_callback config_cb;
+	struct mlx5_vdpa_wq_ent cvq_ent;
+	struct hlist_head macvlan_hash[MLX5V_MACVLAN_SIZE];
+};
+
+struct macvlan_node {
+	struct hlist_node hlist;
+	struct mlx5_flow_handle *ucast_rule;
+	struct mlx5_flow_handle *mcast_rule;
+	u64 macvlan;
+};
+
+#endif /* __MLX5_VNET_H__ */
</pre>
    </blockquote>
    <br>
  </body>
</html>

--------------q9dWo4iTMm9Oafix0Ix73r4h--

--===============1442082883980996414==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
--===============1442082883980996414==--
