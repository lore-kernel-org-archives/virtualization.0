Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 936A1C433FE
	for <virtualization@archiver.kernel.org>; Tue, 18 Oct 2022 19:53:01 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 2825541B57;
	Tue, 18 Oct 2022 19:53:01 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 2825541B57
Authentication-Results: smtp4.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.a=rsa-sha256 header.s=corp-2022-7-12 header.b=mSWdwuF/;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.a=rsa-sha256 header.s=selector2-oracle-onmicrosoft-com header.b=Hq1xu5aO
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id OJ_ORXgQ7c7V; Tue, 18 Oct 2022 19:52:58 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id E7CC341B58;
	Tue, 18 Oct 2022 19:52:57 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org E7CC341B58
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id C1D7CC0033;
	Tue, 18 Oct 2022 19:52:57 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id D9F4CC002D
 for <virtualization@lists.linux-foundation.org>;
 Tue, 18 Oct 2022 19:52:56 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id A603083F05
 for <virtualization@lists.linux-foundation.org>;
 Tue, 18 Oct 2022 19:52:56 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org A603083F05
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com
 header.a=rsa-sha256 header.s=corp-2022-7-12 header.b=mSWdwuF/; 
 dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com
 header.i=@oracle.onmicrosoft.com header.a=rsa-sha256
 header.s=selector2-oracle-onmicrosoft-com header.b=Hq1xu5aO
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id JlUVWQXdWxlD
 for <virtualization@lists.linux-foundation.org>;
 Tue, 18 Oct 2022 19:52:55 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org B086983EE0
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com
 [205.220.177.32])
 by smtp1.osuosl.org (Postfix) with ESMTPS id B086983EE0
 for <virtualization@lists.linux-foundation.org>;
 Tue, 18 Oct 2022 19:52:54 +0000 (UTC)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 29IJTBVj017148;
 Tue, 18 Oct 2022 19:52:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=content-type :
 message-id : date : subject : to : cc : references : from : in-reply-to :
 mime-version; s=corp-2022-7-12;
 bh=zsqen8yxYBcEcxZDn97ktLNbeAWKEi2Ysn7UfNTeGxM=;
 b=mSWdwuF/Tkh9V3RO6WW2rVGc6PxRpG+50acVDtKFHBwJEEzpmxrugFzHw8mRoWFwrKRP
 +jH8RRmE3VyVie3IyqaHcpc5VA3/YS9CJajPyAolAzELOcTPI4BonaJy+5KZZQXTwh2/
 g0scYnRk6HpAm1eRfBKQEdUlE3bC3818scSFQ2uCpUFIXmcO3Tx7lyC0ky6+2buNK9nX
 29USQAsQ13HpfBSLniMrLLsum20pbOd5BwIa+rNbhmp+8fZEuPO1JtYrJ4pLt3S1/tHr
 6s8Sd1ciC5f477KahOUxPn/gUKoIEpC1hl9bkQXf1N0iKEIkR5psnoeXpEH5b+uSe5ko Bg== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3k9b7skesb-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 18 Oct 2022 19:52:52 +0000
Received: from pps.filterd
 (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5)
 with ESMTP id 29IHLT0a024303; Tue, 18 Oct 2022 19:52:52 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com
 (mail-co1nam11lp2169.outbound.protection.outlook.com [104.47.56.169])
 by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 3k8hu6r0uy-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 18 Oct 2022 19:52:51 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YxZuzQFwLJGyKfauMl1TiOK2I2pXx6k8RU5IGf3ig+QsYIg7WFzIAsPZgQmSPsLviPJ9Thd7VQ1l/EcrYhxU2jtfjywySsLXdsREVDfcW26zcyjKG4jGMaWmegNKwxFBjZqKg34FoSpOQS+bzSpkLy2GdvNazYMyskssxQpyI+v1+G1F+kAqC5PYw+cArv2uzcbXzRo/1kDne1PFHF1b9h17e8NEF6qFptMCt2J17xBx8eR71MOnwFWG6aY6OicDiPAMiYYY4oE4QR9tO4ApleicC5f8aSNf8I42mPB3Fm35IeSyzBxjUAgn0ECyq2dYmq6UOL75O2tCP2+546c/OA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zsqen8yxYBcEcxZDn97ktLNbeAWKEi2Ysn7UfNTeGxM=;
 b=bXdej1XRjqLxdD1q6Wr7z0n4LUtzROeRLOt+Ol7GnblljPwmWwIeK1e5WbQ6kZUZMoGsGCO9F5eD1QXPLemXSlMie2OUFmEQ60vOIJgqBgjfgvSW8diOrgvHpOTpl9LDdhWmTNRTmHVkVRWBntYv8RTHHefRCYJrXplSOjOnpLzpcOHFc6IvljrRYezj6+R6mFZPxiR7hoIC0k7sdBhAVnXxhCdQX6p8baQaeY4WJ0F5tzHTYvsWTDFpAlcSKoqyvDCqL9cuWVYAfA4ZE+f/Dn4pkuQDOg9R27J5xyy6MWV5+/C7fk5jJzA8yjTdwUT+CWde+NDUjNq+tu2RXejxYw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zsqen8yxYBcEcxZDn97ktLNbeAWKEi2Ysn7UfNTeGxM=;
 b=Hq1xu5aOeiZE+hCRwZWlaV7CIOZ91a2n3akPlRQ/SPCqGKF+pidMLGVEt8iPeTkQIbPhKSqRtaZWiDXxpLbIq70V0LDRD7+tHC48fxJKYrdj7ggucX6YboAGbvM6TV+3a7W+97blge4wO5pmHitABTor3pBSdP/zBlqhZsXKGc4=
Received: from MW4PR10MB6535.namprd10.prod.outlook.com (2603:10b6:303:225::12)
 by MN2PR10MB4336.namprd10.prod.outlook.com (2603:10b6:208:15f::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.34; Tue, 18 Oct
 2022 19:52:49 +0000
Received: from MW4PR10MB6535.namprd10.prod.outlook.com
 ([fe80::9830:ae4d:f10c:c30a]) by MW4PR10MB6535.namprd10.prod.outlook.com
 ([fe80::9830:ae4d:f10c:c30a%5]) with mapi id 15.20.5723.032; Tue, 18 Oct 2022
 19:52:48 +0000
Message-ID: <19c4c2bb-c94f-aef6-f7a6-1d4663fab1f7@oracle.com>
Date: Tue, 18 Oct 2022 12:52:45 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.3
Subject: Re: [PATCH 4/4] vdpa/mlx5: Add RX counters to debugfs
Content-Language: en-US
To: Eli Cohen <elic@nvidia.com>, mst@redhat.com, jasowang@redhat.com,
 linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org
References: <20221018111232.4021-1-elic@nvidia.com>
 <20221018111232.4021-5-elic@nvidia.com>
From: Si-Wei Liu <si-wei.liu@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <20221018111232.4021-5-elic@nvidia.com>
X-ClientProxiedBy: SN1PR12CA0113.namprd12.prod.outlook.com
 (2603:10b6:802:21::48) To MW4PR10MB6535.namprd10.prod.outlook.com
 (2603:10b6:303:225::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR10MB6535:EE_|MN2PR10MB4336:EE_
X-MS-Office365-Filtering-Correlation-Id: 2744f2f6-0862-4fb2-0f4b-08dab1425565
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: t7i5PgJZUMDUrEIzEarML/QJ9SF+4DayI4djBsmannjSOKCpzDZxx4+4MFaTk1Af7bke3EtcRFZ8V213x2ID2w7XXpHSCNf1dpnZXyPkAZYsKhxzYjCWtXO2iiysL4rZBXd2/0R1It445fyDbimGpmHjrIt89lwfvosEa4Zgp5K7YPlpVJ9gqYnb5D1vuQHss8/nv+/RLsBzQSvnSgSP5PdEZSEiVRAXnpCxFbm9ttFtictShYV26ZRhNT/Bsqtz3mqk+ZlF7xZynqmOBiKvCpT48kDUrZMc02KAOij5p/einX5vNIrS6Bof9AFgheUyx5ubPcNqdBxcWC7HZMxD0N2DQYYVTGXxgMP7FutKMyQVE3C+tqOUZhIB7zOLvSCcnCYg+i0FFO0mgsUDQ/h7JEa5WlW7wceILdb0nqt3zH0Kyq7nKSGpjcABsHxHYltJLnDUp1MBa2SFE7s2q1veqZynAeuvw6MwDO/hBK5Eh/VL21ni8J0DI3axOmsSU0dkH/0tQY8EwlM2PkEQK7YoQgGZAGBXRvvttv6GqdFKcue/buQ/swir9qn7fx6i3MTDBwYhb4LwjYj+OHw6C1yVEnUNsaAa8kMfH67Df+35oUlf1lvqWDX9Xv+PcYA09omb0t9gh/JaXp/fnVmeM09NIMMLOZNbGpT9agD0BaLdavP+4D3LDl1BAsCQEgtWgr8DLq0uXUyyRpww0ZzShaCuIki8Lt6LLkvl+tBSqLUcbdYwVp5vMF0LD/cS5h0PxEGaXezW3Wl9Bl8IUTnPepmK0TvBN9iRkV1iNDNp6IJtxp2StawywX8scrQZmO3Mi76k
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW4PR10MB6535.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230022)(39860400002)(376002)(366004)(396003)(346002)(136003)(451199015)(36756003)(31696002)(86362001)(31686004)(38100700002)(2906002)(83380400001)(5660300002)(30864003)(33964004)(36916002)(26005)(6666004)(53546011)(6506007)(2616005)(186003)(6512007)(6486002)(478600001)(316002)(4326008)(8676002)(66946007)(66556008)(66476007)(41300700001)(8936002)(290074003)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SlRYMDAzZ2JtbE9jNHF4RmNtTkpXajZ6OTdsSnFoUXo3SXRSTkU5OUNRV25Q?=
 =?utf-8?B?TEd2ZjBsQ3RNUmhhZXg2bFNaZmlQOCs1eEZLcm5mbGp5M0RpbnJCU2twRkhL?=
 =?utf-8?B?RDhzL2dKaVlPTk9QUHZvY0pvV1lhSFRxUmZ0WGNtbnVrZmk3U2hJMWRMSVgy?=
 =?utf-8?B?ckNoQTBIM3hpWGYyMHZNZlR0MU5sd1FuQ3pLMW1lcVZ4WUNuTlVBZExGcmE2?=
 =?utf-8?B?Ykd1NDV2Y2FMbGVRd1BEdG5ua29PSWUvZFhiNXJaVWZIbTlyajFGRHJmUWNk?=
 =?utf-8?B?ZnJ1L0dRbTg3ZnFSMVlITWlvRGNXOTZiNkpBYlBnZkRwdkFrVktCT0RsaEww?=
 =?utf-8?B?Qi9OR1piYnA1MXRaZVg2TmJ4aFJucFhoaDJ2bHJsVkQyV3hnWGZrWlhyamVt?=
 =?utf-8?B?NldnV2RaazFtTmlDTXJqVGxzMmFkV0JsRldHUE5TVVR3cnhkY1JJTkQ0bGlr?=
 =?utf-8?B?T3NxVGVHRzZzK3ZPeGQ1NkZSMko0Z2piWkpaVlNWdW5iQWNQVkNPeVBwcXNo?=
 =?utf-8?B?THh5M005RjV3RmhTZHZXalVWTVg0QUFWOGVYSGxIdHRYMGFOTUtDdG5vZ1Rn?=
 =?utf-8?B?WVpQK2V6SFZ6aE5wNGtldEgyb3VtcFEwbzFRcFh1SXNYV2NSaGVNdlp6THFZ?=
 =?utf-8?B?SVF2WFFzZmhIOEFvVDhjem80WmZFc25aMUt2NVFJT0NncEJ0VlFTMjQ3MnRt?=
 =?utf-8?B?VHBybFVHcy9RL0ZYTThYK0tYdWp2cUJubnNrcGFGUnhPSklEdHErVVV1TGpG?=
 =?utf-8?B?T09QL1c1NGxRb0hkREN6bDFUOGZDRnpTU0F0U1JKQUJVSlRuWlltbUxUYk1W?=
 =?utf-8?B?S0tiSE1LazMxN2JMYnp1dkl2dEVvVW9nZXdCZ2lyMVJvM2pmbENBNndCREFv?=
 =?utf-8?B?K29qSkxTZkh1UUlaQWR6RnYrOVg5ZWU3MUtyZjlJZTNtRXRkZlYwYTNVcFAz?=
 =?utf-8?B?T2lZajdVMFlWZUl6dHQyRnJCalFMbWlpQ1lGazRVbkpHK3lVOVU3T2pJMkU4?=
 =?utf-8?B?dEJSV3ZJQ2dWbGpodTE1TlBybkNjNmVDUE1yMlQ1bDN3elgxRXY0V1krWktR?=
 =?utf-8?B?eDlvOEZEeDNqTHVCZTBYMzQ0MGJoVFVEeEVqWDduUkFFbGJxMERLTjE5Rklz?=
 =?utf-8?B?MXB2UmdqclREUkxiTWJRZDQybWxEcjUwOHVzMlRtamhLWjlPaG9adVdMcng2?=
 =?utf-8?B?SU41bjZMOVlZaGUyYkFyb0Nrbmo3eGhpcml5SmlYbVVrWWVvRFRKL0NKL254?=
 =?utf-8?B?TFRIZG5HcTBRQXc0S2ZqM3ZNSkZud2xYTVBNWFBlcmhTK2FpVGhMVmZ5c2pE?=
 =?utf-8?B?K0UzZ0U5RFRYSm03UUtUUEcvaUpTaEhsSStoalcrNmdVZG9SaDY4Z29rYnZT?=
 =?utf-8?B?T0RtV3RWakMyOU9TNFNOSUhBbEY1ZlBrWUM3MmlMTDhyZlFEdHMwMGlrTzBH?=
 =?utf-8?B?M3l6WHRPMzZJUzFGR0hWWVF4dUdTWXhsT0xRSi9CM2xZUHJ4V1NHK0lOMmtk?=
 =?utf-8?B?SmROOWNEL29uTTVmMGtob09Oa3NHNHM1bnFjY1pLWWwyREd1b2ZITVVTT2pW?=
 =?utf-8?B?c25Lb1BOcU1yL1RNQkZnY3h2SW5hNS9uMjZYQTlDdkoxKys3U3p1c0Mwd2Nv?=
 =?utf-8?B?K0pTd3hua2E0VE5FMW5PeWt2eWFuNzE0NHVjN0I2bTZUamJ2QjNrSHBWR1Bq?=
 =?utf-8?B?NjFXNElVc0RIeXVZM3dlSHkxQmttUk1iSjB4Q29RNEV5VGZ6cDNWS2J0OWhK?=
 =?utf-8?B?K0x3LzRYV0NTQ3AwSk9zSS9xekJQQU51WlBFV2dNc1hTOS84UGJhNU4vS1Fn?=
 =?utf-8?B?UnpzZlRoeVF0OCtuMEdaYnVhSkJOOTNYLzBBQXVVZEtlRU1mdG9HRENhMFg4?=
 =?utf-8?B?ZnhYVHR1NUVwNkl3RDdWc3U1aERnTUtZalNBbFJ4M1EvQnRxblgzZldKdFlj?=
 =?utf-8?B?cXlKYWUrUXJQeEI3V2Z3ZEpmSVBzQmpFa1VRaUt0N3REbFo4dEZXSVJTRG95?=
 =?utf-8?B?VTNtd2J1SmtrWGs5ejN3eEJlandUb3hvdVJjSnh2a25keE95dHRKT2UyVG5z?=
 =?utf-8?B?L3dZNE5sTkVia0pnOTBEMC80SU5YblBYVUovWUZNN2lnM2UvZDM4TUlOQ2dU?=
 =?utf-8?Q?fsqZkI3c2gWqU+TMNG7MnXWYi?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2744f2f6-0862-4fb2-0f4b-08dab1425565
X-MS-Exchange-CrossTenant-AuthSource: MW4PR10MB6535.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Oct 2022 19:52:48.6865 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: R05A5VIk7IWtwGuNCfyc0MhAF8vhmxQRasH0fvrS1Q7SInqZYUX24ccYx0DBRVHL8U0vtAeU6shTv2e6trPIyw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR10MB4336
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-10-18_07,2022-10-18_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0
 mlxlogscore=999
 malwarescore=0 spamscore=0 suspectscore=0 phishscore=0 adultscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2209130000 definitions=main-2210180112
X-Proofpoint-GUID: RlixERbY5gNTN9FTM1t95L_27F3SAucT
X-Proofpoint-ORIG-GUID: RlixERbY5gNTN9FTM1t95L_27F3SAucT
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
Content-Type: multipart/mixed; boundary="===============1899012867502148376=="
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

--===============1899012867502148376==
Content-Type: multipart/alternative;
 boundary="------------bjWbVqBqLUyTEAA71qJOM04u"
Content-Language: en-US

--------------bjWbVqBqLUyTEAA71qJOM04u
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 10/18/2022 4:12 AM, Eli Cohen wrote:
> For each interface, either VLAN tagged or untagged, add two hardware
> counters: one for unicast and another for multicast. The counters count
> RX packets and bytes and can be read through debugfs:
>
> $ cat /sys/kernel/debug/mlx5/mlx5_core.sf.1/vdpa-0/rx/untagged/mcast/packets
> $ cat /sys/kernel/debug/mlx5/mlx5_core.sf.1/vdpa-0/rx/untagged/ucast/bytes
>
> This feature is controlled via the config option
> MLX5_VDPA_STEERING_DEBUG. It is off by default as it may have some
> impact on performance.
>
> Signed-off-by: Eli Cohen<elic@nvidia.com>
> ---
>   drivers/vdpa/Kconfig              | 12 ++++
>   drivers/vdpa/mlx5/net/debug.c     | 82 +++++++++++++++++++++++++++
>   drivers/vdpa/mlx5/net/mlx5_vnet.c | 94 +++++++++++++++++++++++--------
>   drivers/vdpa/mlx5/net/mlx5_vnet.h | 30 ++++++++++
>   4 files changed, 195 insertions(+), 23 deletions(-)
>
> diff --git a/drivers/vdpa/Kconfig b/drivers/vdpa/Kconfig
> index 50f45d037611..43b716ec2d18 100644
> --- a/drivers/vdpa/Kconfig
> +++ b/drivers/vdpa/Kconfig
> @@ -71,6 +71,18 @@ config MLX5_VDPA_NET
>   	  be executed by the hardware. It also supports a variety of stateless
>   	  offloads depending on the actual device used and firmware version.
>   
> +config MLX5_VDPA_STEERING_DEBUG
> +	bool "expose steering counters on debugfs"
> +	select MLX5_VDPA
> +	help
> +	  Expose RX steering counters in debugfs to aid in debugging. For each VLAN
> +	  or non VLAN interface, two hardware counters are added to the RX flow
> +	  table: one for unicast and one for multicast.
> +	  The counters counts the number of packets and bytes and exposes them in
> +	  debugfs. Once can read the counters using, e.g.:
> +	  cat /sys/kernel/debug/mlx5/mlx5_core.sf.1/vdpa-0/rx/untagged/ucast/packets
> +	  cat /sys/kernel/debug/mlx5/mlx5_core.sf.1/vdpa-0/rx/untagged/mcast/bytes
> +
>   config VP_VDPA
>   	tristate "Virtio PCI bridge vDPA driver"
>   	select VIRTIO_PCI_LIB
> diff --git a/drivers/vdpa/mlx5/net/debug.c b/drivers/vdpa/mlx5/net/debug.c
> index 95e4801df211..35137a36433a 100644
> --- a/drivers/vdpa/mlx5/net/debug.c
> +++ b/drivers/vdpa/mlx5/net/debug.c
> @@ -49,6 +49,88 @@ void mlx5_vdpa_add_rx_flow_table(struct mlx5_vdpa_net *ndev)
>   						  ndev, &rx_flow_table_fops);
>   }
>   
> +#if defined(CONFIG_MLX5_VDPA_STEERING_DEBUG)
> +static int packets_show(struct seq_file *file, void *priv)
> +{
> +	struct mlx5_vdpa_counter *counter = file->private;
> +	u64 packets;
> +	u64 bytes;
> +	int err;
> +
> +	err = mlx5_fc_query(counter->mdev, counter->counter, &packets, &bytes);
> +	if (err)
> +		return err;
> +
> +	seq_printf(file, "0x%llx\n", packets);
> +	return 0;
> +}
> +
> +static int bytes_show(struct seq_file *file, void *priv)
> +{
> +	struct mlx5_vdpa_counter *counter = file->private;
> +	u64 packets;
> +	u64 bytes;
> +	int err;
> +
> +	err = mlx5_fc_query(counter->mdev, counter->counter, &packets, &bytes);
> +	if (err)
> +		return err;
> +
> +	seq_printf(file, "0x%llx\n", bytes);
> +	return 0;
> +}
> +
> +DEFINE_SHOW_ATTRIBUTE(packets);
> +DEFINE_SHOW_ATTRIBUTE(bytes);
> +
> +static void add_counter_node(struct mlx5_vdpa_counter *counter,
> +			     struct dentry *parent)
> +{
> +	debugfs_create_file("packets", 0444, parent, counter,
> +			    &packets_fops);
> +	debugfs_create_file("bytes", 0444, parent, counter,
> +			    &bytes_fops);
> +}
> +
> +void mlx5_vdpa_add_rx_counters(struct mlx5_vdpa_net *ndev,
> +			       struct macvlan_node *node)
> +{
> +	static const char *ut = "untagged";
> +	char vidstr[9];
> +	u16 vid;
> +
> +	if (node->tagged) {
> +		vid = key2vid(node->macvlan);
> +		snprintf(vidstr, sizeof(vidstr), "0x%x", vid);
> +	} else {
> +		strcpy(vidstr, ut);
> +	}
> +
> +	node->dent = debugfs_create_dir(vidstr, ndev->rx_dent);
> +	if (IS_ERR(node->dent))
> +		return;
> +
> +	node->ucast_counter.dent = debugfs_create_dir("ucast", node->dent);
> +	if (IS_ERR(node->ucast_counter.dent))
> +		return;
> +
> +	add_counter_node(&node->ucast_counter, node->ucast_counter.dent);
> +
> +	node->mcast_counter.dent = debugfs_create_dir("mcast", node->dent);
> +	if (IS_ERR(node->mcast_counter.dent))
> +		return;
> +
> +	add_counter_node(&node->mcast_counter, node->mcast_counter.dent);
> +}
> +
> +void mlx5_vdpa_remove_rx_counters(struct mlx5_vdpa_net *ndev,
> +				  struct macvlan_node *node)
> +{
> +	if (ndev->debugfs)
> +		debugfs_remove_recursive(node->dent);
> +}
> +#endif
> +
>   void mlx5_vdpa_add_debugfs(struct mlx5_vdpa_net *ndev)
>   {
>   	struct mlx5_core_dev *mdev;
> diff --git a/drivers/vdpa/mlx5/net/mlx5_vnet.c b/drivers/vdpa/mlx5/net/mlx5_vnet.c
> index ee50da33e25b..1b850d0aee99 100644
> --- a/drivers/vdpa/mlx5/net/mlx5_vnet.c
> +++ b/drivers/vdpa/mlx5/net/mlx5_vnet.c
> @@ -1404,12 +1404,16 @@ static void destroy_tir(struct mlx5_vdpa_net *ndev)
>   #define MAX_STEERING_ENT 0x8000
>   #define MAX_STEERING_GROUPS 2
>   
> +#if defined(CONFIG_MLX5_VDPA_STEERING_DEBUG)
> +       #define NUM_DESTS 2
> +#else
> +       #define NUM_DESTS 1
> +#endif
> +
>   static int mlx5_vdpa_add_mac_vlan_rules(struct mlx5_vdpa_net *ndev, u8 *mac,
> -					u16 vid, bool tagged,
> -					struct mlx5_flow_handle **ucast,
> -					struct mlx5_flow_handle **mcast)
> +					struct macvlan_node *node)
>   {
> -	struct mlx5_flow_destination dest = {};
> +	struct mlx5_flow_destination dests[NUM_DESTS] = {};
>   	struct mlx5_flow_act flow_act = {};
>   	struct mlx5_flow_handle *rule;
>   	struct mlx5_flow_spec *spec;
> @@ -1418,11 +1422,13 @@ static int mlx5_vdpa_add_mac_vlan_rules(struct mlx5_vdpa_net *ndev, u8 *mac,
>   	u8 *dmac_c;
>   	u8 *dmac_v;
>   	int err;
> +	u16 vid;
>   
>   	spec = kvzalloc(sizeof(*spec), GFP_KERNEL);
>   	if (!spec)
>   		return -ENOMEM;
>   
> +	vid = key2vid(node->macvlan);
>   	spec->match_criteria_enable = MLX5_MATCH_OUTER_HEADERS;
>   	headers_c = MLX5_ADDR_OF(fte_match_param, spec->match_criteria, outer_headers);
>   	headers_v = MLX5_ADDR_OF(fte_match_param, spec->match_value, outer_headers);
> @@ -1431,45 +1437,78 @@ static int mlx5_vdpa_add_mac_vlan_rules(struct mlx5_vdpa_net *ndev, u8 *mac,
>   	eth_broadcast_addr(dmac_c);
>   	ether_addr_copy(dmac_v, mac);
>   	MLX5_SET(fte_match_set_lyr_2_4, headers_c, cvlan_tag, 1);
> -	if (tagged) {
> +	if (node->tagged) {
>   		MLX5_SET(fte_match_set_lyr_2_4, headers_v, cvlan_tag, 1);
>   		MLX5_SET_TO_ONES(fte_match_set_lyr_2_4, headers_c, first_vid);
>   		MLX5_SET(fte_match_set_lyr_2_4, headers_v, first_vid, vid);
>   	}
>   	flow_act.action = MLX5_FLOW_CONTEXT_ACTION_FWD_DEST;
> -	dest.type = MLX5_FLOW_DESTINATION_TYPE_TIR;
> -	dest.tir_num = ndev->res.tirn;
> -	rule = mlx5_add_flow_rules(ndev->rxft, spec, &flow_act, &dest, 1);
> +	dests[0].type = MLX5_FLOW_DESTINATION_TYPE_TIR;
> +	dests[0].tir_num = ndev->res.tirn;
> +#if defined(CONFIG_MLX5_VDPA_STEERING_DEBUG)
> +	node->ucast_counter.counter = mlx5_fc_create(ndev->mvdev.mdev, false);
> +	if (IS_ERR(node->ucast_counter.counter)) {
> +		err = PTR_ERR(node->ucast_counter.counter);
> +		goto err_ucast_counter;
> +	}
> +	node->mcast_counter.counter = mlx5_fc_create(ndev->mvdev.mdev, false);
> +	if (IS_ERR(node->mcast_counter.counter)) {
> +		err = PTR_ERR(node->mcast_counter.counter);
> +		goto err_mcast_counter;
> +	}
> +
> +	dests[1].type = MLX5_FLOW_DESTINATION_TYPE_COUNTER;
> +	dests[1].counter_id = mlx5_fc_id(node->ucast_counter.counter);
> +	flow_act.action |= MLX5_FLOW_CONTEXT_ACTION_COUNT;
> +#endif
> +	node->ucast_rule = mlx5_add_flow_rules(ndev->rxft, spec, &flow_act, dests, NUM_DESTS);
>   	if (IS_ERR(rule))
>   		return PTR_ERR(rule);
There'll be leakage on counters and flow spec if using direct return.

>   
> -	*ucast = rule;
> +#if defined(CONFIG_MLX5_VDPA_STEERING_DEBUG)
> +	dests[1].counter_id = mlx5_fc_id(node->mcast_counter.counter);
> +#endif
>   
>   	memset(dmac_c, 0, ETH_ALEN);
>   	memset(dmac_v, 0, ETH_ALEN);
>   	dmac_c[0] = 1;
>   	dmac_v[0] = 1;
> -	rule = mlx5_add_flow_rules(ndev->rxft, spec, &flow_act, &dest, 1);
> +	node->mcast_rule = mlx5_add_flow_rules(ndev->rxft, spec, &flow_act, dests, NUM_DESTS);
>   	kvfree(spec);
Move kvfree a couple of lines under (after the IS_ERR check).
>   	if (IS_ERR(rule)) {
>   		err = PTR_ERR(rule);
>   		goto err_mcast;
>   	}
>   
> -	*mcast = rule;
> +#if defined(CONFIG_MLX5_VDPA_STEERING_DEBUG)
> +	node->ucast_counter.mdev = ndev->mvdev.mdev;
> +	node->mcast_counter.mdev = ndev->mvdev.mdev;
> +#endif
> +	mlx5_vdpa_add_rx_counters(ndev, node);
> +
>   	return 0;
>   
>   err_mcast:
> -	mlx5_del_flow_rules(*ucast);
> +	mlx5_del_flow_rules(node->ucast_rule);
> +#if defined(CONFIG_MLX5_VDPA_STEERING_DEBUG)
No corresponding mlx5_fc_destroy() for mcast_counter.
> +err_mcast_counter:
> +	mlx5_fc_destroy(ndev->mvdev.mdev, node->ucast_counter.counter);
> +err_ucast_counter:
> +	kfree(spec);
kvfree?

Regards,
-Siwei
> +#endif
>   	return err;
>   }
>   
>   static void mlx5_vdpa_del_mac_vlan_rules(struct mlx5_vdpa_net *ndev,
> -					 struct mlx5_flow_handle *ucast,
> -					 struct mlx5_flow_handle *mcast)
> +					 struct macvlan_node *node)
>   {
> -	mlx5_del_flow_rules(ucast);
> -	mlx5_del_flow_rules(mcast);
> +#if defined(CONFIG_MLX5_VDPA_STEERING_DEBUG)
> +	if (node->dent && !IS_ERR(node->dent))
> +		mlx5_vdpa_remove_rx_counters(ndev, node);
> +#endif
> +
> +	mlx5_del_flow_rules(node->ucast_rule);
> +	mlx5_del_flow_rules(node->mcast_rule);
>   }
>   
>   static u64 search_val(u8 *mac, u16 vlan, bool tagged)
> @@ -1503,14 +1542,14 @@ static struct macvlan_node *mac_vlan_lookup(struct mlx5_vdpa_net *ndev, u64 valu
>   	return NULL;
>   }
>   
> -static int mac_vlan_add(struct mlx5_vdpa_net *ndev, u8 *mac, u16 vlan, bool tagged) // vlan -> vid
> +static int mac_vlan_add(struct mlx5_vdpa_net *ndev, u8 *mac, u16 vid, bool tagged)
>   {
>   	struct macvlan_node *ptr;
>   	u64 val;
>   	u32 idx;
>   	int err;
>   
> -	val = search_val(mac, vlan, tagged);
> +	val = search_val(mac, vid, tagged);
>   	if (mac_vlan_lookup(ndev, val))
>   		return -EEXIST;
>   
> @@ -1518,12 +1557,13 @@ static int mac_vlan_add(struct mlx5_vdpa_net *ndev, u8 *mac, u16 vlan, bool tagg
>   	if (!ptr)
>   		return -ENOMEM;
>   
> -	err = mlx5_vdpa_add_mac_vlan_rules(ndev, ndev->config.mac, vlan, tagged,
> -					   &ptr->ucast_rule, &ptr->mcast_rule);
> +	ptr->tagged = tagged;
> +	ptr->macvlan = val;
> +	ptr->ndev = ndev;
> +	err = mlx5_vdpa_add_mac_vlan_rules(ndev, ndev->config.mac, ptr);
>   	if (err)
>   		goto err_add;
>   
> -	ptr->macvlan = val;
>   	idx = hash_64(val, 8);
>   	hlist_add_head(&ptr->hlist, &ndev->macvlan_hash[idx]);
>   	return 0;
> @@ -1542,7 +1582,11 @@ static void mac_vlan_del(struct mlx5_vdpa_net *ndev, u8 *mac, u16 vlan, bool tag
>   		return;
>   
>   	hlist_del(&ptr->hlist);
> -	mlx5_vdpa_del_mac_vlan_rules(ndev, ptr->ucast_rule, ptr->mcast_rule);
> +	mlx5_vdpa_del_mac_vlan_rules(ndev, ptr);
> +#if defined(CONFIG_MLX5_VDPA_STEERING_DEBUG)
> +			mlx5_fc_destroy(ndev->mvdev.mdev, ptr->mcast_counter.counter);
> +			mlx5_fc_destroy(ndev->mvdev.mdev, ptr->ucast_counter.counter);
> +#endif
>   	kfree(ptr);
>   }
>   
> @@ -1555,7 +1599,11 @@ static void clear_mac_vlan_table(struct mlx5_vdpa_net *ndev)
>   	for (i = 0; i < MLX5V_MACVLAN_SIZE; i++) {
>   		hlist_for_each_entry_safe(pos, n, &ndev->macvlan_hash[i], hlist) {
>   			hlist_del(&pos->hlist);
> -			mlx5_vdpa_del_mac_vlan_rules(ndev, pos->ucast_rule, pos->mcast_rule);
> +			mlx5_vdpa_del_mac_vlan_rules(ndev, pos);
> +#if defined(CONFIG_MLX5_VDPA_STEERING_DEBUG)
> +			mlx5_fc_destroy(ndev->mvdev.mdev, pos->mcast_counter.counter);
> +			mlx5_fc_destroy(ndev->mvdev.mdev, pos->ucast_counter.counter);
> +#endif
>   			kfree(pos);
>   		}
>   	}
> diff --git a/drivers/vdpa/mlx5/net/mlx5_vnet.h b/drivers/vdpa/mlx5/net/mlx5_vnet.h
> index f2cef3925e5b..706c83016b71 100644
> --- a/drivers/vdpa/mlx5/net/mlx5_vnet.h
> +++ b/drivers/vdpa/mlx5/net/mlx5_vnet.h
> @@ -21,6 +21,11 @@ struct mlx5_vdpa_net_resources {
>   
>   #define MLX5V_MACVLAN_SIZE 256
>   
> +static inline u16 key2vid(u64 key)
> +{
> +	return (u16)(key >> 48);
> +}
> +
>   struct mlx5_vdpa_net {
>   	struct mlx5_vdpa_dev mvdev;
>   	struct mlx5_vdpa_net_resources res;
> @@ -47,11 +52,24 @@ struct mlx5_vdpa_net {
>   	struct dentry *debugfs;
>   };
>   
> +struct mlx5_vdpa_counter {
> +	struct mlx5_fc *counter;
> +	struct dentry *dent;
> +	struct mlx5_core_dev *mdev;
> +};
> +
>   struct macvlan_node {
>   	struct hlist_node hlist;
>   	struct mlx5_flow_handle *ucast_rule;
>   	struct mlx5_flow_handle *mcast_rule;
>   	u64 macvlan;
> +	struct mlx5_vdpa_net *ndev;
> +	bool tagged;
> +#if defined(CONFIG_MLX5_VDPA_STEERING_DEBUG)
> +	struct dentry *dent;
> +	struct mlx5_vdpa_counter ucast_counter;
> +	struct mlx5_vdpa_counter mcast_counter;
> +#endif
>   };
>   
>   void mlx5_vdpa_add_debugfs(struct mlx5_vdpa_net *ndev);
> @@ -60,5 +78,17 @@ void mlx5_vdpa_add_rx_flow_table(struct mlx5_vdpa_net *ndev);
>   void mlx5_vdpa_remove_rx_flow_table(struct mlx5_vdpa_net *ndev);
>   void mlx5_vdpa_add_tirn(struct mlx5_vdpa_net *ndev);
>   void mlx5_vdpa_remove_tirn(struct mlx5_vdpa_net *ndev);
> +#if defined(CONFIG_MLX5_VDPA_STEERING_DEBUG)
> +void mlx5_vdpa_add_rx_counters(struct mlx5_vdpa_net *ndev,
> +			       struct macvlan_node *node);
> +void mlx5_vdpa_remove_rx_counters(struct mlx5_vdpa_net *ndev,
> +				  struct macvlan_node *node);
> +#else
> +static inline void mlx5_vdpa_add_rx_counters(struct mlx5_vdpa_net *ndev,
> +					     struct macvlan_node *node) {}
> +static inline void mlx5_vdpa_remove_rx_counters(struct mlx5_vdpa_net *ndev,
> +						struct macvlan_node *node) {}
> +#endif
> +
>   
>   #endif /* __MLX5_VNET_H__ */

--------------bjWbVqBqLUyTEAA71qJOM04u
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
    <blockquote type="cite" cite="mid:20221018111232.4021-5-elic@nvidia.com">
      <pre class="moz-quote-pre" wrap="">For each interface, either VLAN tagged or untagged, add two hardware
counters: one for unicast and another for multicast. The counters count
RX packets and bytes and can be read through debugfs:

$ cat /sys/kernel/debug/mlx5/mlx5_core.sf.1/vdpa-0/rx/untagged/mcast/packets
$ cat /sys/kernel/debug/mlx5/mlx5_core.sf.1/vdpa-0/rx/untagged/ucast/bytes

This feature is controlled via the config option
MLX5_VDPA_STEERING_DEBUG. It is off by default as it may have some
impact on performance.

Signed-off-by: Eli Cohen <a class="moz-txt-link-rfc2396E" href="mailto:elic@nvidia.com">&lt;elic@nvidia.com&gt;</a>
---
 drivers/vdpa/Kconfig              | 12 ++++
 drivers/vdpa/mlx5/net/debug.c     | 82 +++++++++++++++++++++++++++
 drivers/vdpa/mlx5/net/mlx5_vnet.c | 94 +++++++++++++++++++++++--------
 drivers/vdpa/mlx5/net/mlx5_vnet.h | 30 ++++++++++
 4 files changed, 195 insertions(+), 23 deletions(-)

diff --git a/drivers/vdpa/Kconfig b/drivers/vdpa/Kconfig
index 50f45d037611..43b716ec2d18 100644
--- a/drivers/vdpa/Kconfig
+++ b/drivers/vdpa/Kconfig
@@ -71,6 +71,18 @@ config MLX5_VDPA_NET
 	  be executed by the hardware. It also supports a variety of stateless
 	  offloads depending on the actual device used and firmware version.
 
+config MLX5_VDPA_STEERING_DEBUG
+	bool &quot;expose steering counters on debugfs&quot;
+	select MLX5_VDPA
+	help
+	  Expose RX steering counters in debugfs to aid in debugging. For each VLAN
+	  or non VLAN interface, two hardware counters are added to the RX flow
+	  table: one for unicast and one for multicast.
+	  The counters counts the number of packets and bytes and exposes them in
+	  debugfs. Once can read the counters using, e.g.:
+	  cat /sys/kernel/debug/mlx5/mlx5_core.sf.1/vdpa-0/rx/untagged/ucast/packets
+	  cat /sys/kernel/debug/mlx5/mlx5_core.sf.1/vdpa-0/rx/untagged/mcast/bytes
+
 config VP_VDPA
 	tristate &quot;Virtio PCI bridge vDPA driver&quot;
 	select VIRTIO_PCI_LIB
diff --git a/drivers/vdpa/mlx5/net/debug.c b/drivers/vdpa/mlx5/net/debug.c
index 95e4801df211..35137a36433a 100644
--- a/drivers/vdpa/mlx5/net/debug.c
+++ b/drivers/vdpa/mlx5/net/debug.c
@@ -49,6 +49,88 @@ void mlx5_vdpa_add_rx_flow_table(struct mlx5_vdpa_net *ndev)
 						  ndev, &amp;rx_flow_table_fops);
 }
 
+#if defined(CONFIG_MLX5_VDPA_STEERING_DEBUG)
+static int packets_show(struct seq_file *file, void *priv)
+{
+	struct mlx5_vdpa_counter *counter = file-&gt;private;
+	u64 packets;
+	u64 bytes;
+	int err;
+
+	err = mlx5_fc_query(counter-&gt;mdev, counter-&gt;counter, &amp;packets, &amp;bytes);
+	if (err)
+		return err;
+
+	seq_printf(file, &quot;0x%llx\n&quot;, packets);
+	return 0;
+}
+
+static int bytes_show(struct seq_file *file, void *priv)
+{
+	struct mlx5_vdpa_counter *counter = file-&gt;private;
+	u64 packets;
+	u64 bytes;
+	int err;
+
+	err = mlx5_fc_query(counter-&gt;mdev, counter-&gt;counter, &amp;packets, &amp;bytes);
+	if (err)
+		return err;
+
+	seq_printf(file, &quot;0x%llx\n&quot;, bytes);
+	return 0;
+}
+
+DEFINE_SHOW_ATTRIBUTE(packets);
+DEFINE_SHOW_ATTRIBUTE(bytes);
+
+static void add_counter_node(struct mlx5_vdpa_counter *counter,
+			     struct dentry *parent)
+{
+	debugfs_create_file(&quot;packets&quot;, 0444, parent, counter,
+			    &amp;packets_fops);
+	debugfs_create_file(&quot;bytes&quot;, 0444, parent, counter,
+			    &amp;bytes_fops);
+}
+
+void mlx5_vdpa_add_rx_counters(struct mlx5_vdpa_net *ndev,
+			       struct macvlan_node *node)
+{
+	static const char *ut = &quot;untagged&quot;;
+	char vidstr[9];
+	u16 vid;
+
+	if (node-&gt;tagged) {
+		vid = key2vid(node-&gt;macvlan);
+		snprintf(vidstr, sizeof(vidstr), &quot;0x%x&quot;, vid);
+	} else {
+		strcpy(vidstr, ut);
+	}
+
+	node-&gt;dent = debugfs_create_dir(vidstr, ndev-&gt;rx_dent);
+	if (IS_ERR(node-&gt;dent))
+		return;
+
+	node-&gt;ucast_counter.dent = debugfs_create_dir(&quot;ucast&quot;, node-&gt;dent);
+	if (IS_ERR(node-&gt;ucast_counter.dent))
+		return;
+
+	add_counter_node(&amp;node-&gt;ucast_counter, node-&gt;ucast_counter.dent);
+
+	node-&gt;mcast_counter.dent = debugfs_create_dir(&quot;mcast&quot;, node-&gt;dent);
+	if (IS_ERR(node-&gt;mcast_counter.dent))
+		return;
+
+	add_counter_node(&amp;node-&gt;mcast_counter, node-&gt;mcast_counter.dent);
+}
+
+void mlx5_vdpa_remove_rx_counters(struct mlx5_vdpa_net *ndev,
+				  struct macvlan_node *node)
+{
+	if (ndev-&gt;debugfs)
+		debugfs_remove_recursive(node-&gt;dent);
+}
+#endif
+
 void mlx5_vdpa_add_debugfs(struct mlx5_vdpa_net *ndev)
 {
 	struct mlx5_core_dev *mdev;
diff --git a/drivers/vdpa/mlx5/net/mlx5_vnet.c b/drivers/vdpa/mlx5/net/mlx5_vnet.c
index ee50da33e25b..1b850d0aee99 100644
--- a/drivers/vdpa/mlx5/net/mlx5_vnet.c
+++ b/drivers/vdpa/mlx5/net/mlx5_vnet.c
@@ -1404,12 +1404,16 @@ static void destroy_tir(struct mlx5_vdpa_net *ndev)
 #define MAX_STEERING_ENT 0x8000
 #define MAX_STEERING_GROUPS 2
 
+#if defined(CONFIG_MLX5_VDPA_STEERING_DEBUG)
+       #define NUM_DESTS 2
+#else
+       #define NUM_DESTS 1
+#endif
+
 static int mlx5_vdpa_add_mac_vlan_rules(struct mlx5_vdpa_net *ndev, u8 *mac,
-					u16 vid, bool tagged,
-					struct mlx5_flow_handle **ucast,
-					struct mlx5_flow_handle **mcast)
+					struct macvlan_node *node)
 {
-	struct mlx5_flow_destination dest = {};
+	struct mlx5_flow_destination dests[NUM_DESTS] = {};
 	struct mlx5_flow_act flow_act = {};
 	struct mlx5_flow_handle *rule;
 	struct mlx5_flow_spec *spec;
@@ -1418,11 +1422,13 @@ static int mlx5_vdpa_add_mac_vlan_rules(struct mlx5_vdpa_net *ndev, u8 *mac,
 	u8 *dmac_c;
 	u8 *dmac_v;
 	int err;
+	u16 vid;
 
 	spec = kvzalloc(sizeof(*spec), GFP_KERNEL);
 	if (!spec)
 		return -ENOMEM;
 
+	vid = key2vid(node-&gt;macvlan);
 	spec-&gt;match_criteria_enable = MLX5_MATCH_OUTER_HEADERS;
 	headers_c = MLX5_ADDR_OF(fte_match_param, spec-&gt;match_criteria, outer_headers);
 	headers_v = MLX5_ADDR_OF(fte_match_param, spec-&gt;match_value, outer_headers);
@@ -1431,45 +1437,78 @@ static int mlx5_vdpa_add_mac_vlan_rules(struct mlx5_vdpa_net *ndev, u8 *mac,
 	eth_broadcast_addr(dmac_c);
 	ether_addr_copy(dmac_v, mac);
 	MLX5_SET(fte_match_set_lyr_2_4, headers_c, cvlan_tag, 1);
-	if (tagged) {
+	if (node-&gt;tagged) {
 		MLX5_SET(fte_match_set_lyr_2_4, headers_v, cvlan_tag, 1);
 		MLX5_SET_TO_ONES(fte_match_set_lyr_2_4, headers_c, first_vid);
 		MLX5_SET(fte_match_set_lyr_2_4, headers_v, first_vid, vid);
 	}
 	flow_act.action = MLX5_FLOW_CONTEXT_ACTION_FWD_DEST;
-	dest.type = MLX5_FLOW_DESTINATION_TYPE_TIR;
-	dest.tir_num = ndev-&gt;res.tirn;
-	rule = mlx5_add_flow_rules(ndev-&gt;rxft, spec, &amp;flow_act, &amp;dest, 1);
+	dests[0].type = MLX5_FLOW_DESTINATION_TYPE_TIR;
+	dests[0].tir_num = ndev-&gt;res.tirn;
+#if defined(CONFIG_MLX5_VDPA_STEERING_DEBUG)
+	node-&gt;ucast_counter.counter = mlx5_fc_create(ndev-&gt;mvdev.mdev, false);
+	if (IS_ERR(node-&gt;ucast_counter.counter)) {
+		err = PTR_ERR(node-&gt;ucast_counter.counter);
+		goto err_ucast_counter;
+	}
+	node-&gt;mcast_counter.counter = mlx5_fc_create(ndev-&gt;mvdev.mdev, false);
+	if (IS_ERR(node-&gt;mcast_counter.counter)) {
+		err = PTR_ERR(node-&gt;mcast_counter.counter);
+		goto err_mcast_counter;
+	}
+
+	dests[1].type = MLX5_FLOW_DESTINATION_TYPE_COUNTER;
+	dests[1].counter_id = mlx5_fc_id(node-&gt;ucast_counter.counter);
+	flow_act.action |= MLX5_FLOW_CONTEXT_ACTION_COUNT;
+#endif
+	node-&gt;ucast_rule = mlx5_add_flow_rules(ndev-&gt;rxft, spec, &amp;flow_act, dests, NUM_DESTS);
 	if (IS_ERR(rule))
 		return PTR_ERR(rule);</pre>
    </blockquote>
    There'll be leakage on counters and flow spec if using direct
    return.<br>
    <br>
    <blockquote type="cite" cite="mid:20221018111232.4021-5-elic@nvidia.com">
      <pre class="moz-quote-pre" wrap="">
 
-	*ucast = rule;
+#if defined(CONFIG_MLX5_VDPA_STEERING_DEBUG)
+	dests[1].counter_id = mlx5_fc_id(node-&gt;mcast_counter.counter);
+#endif
 
 	memset(dmac_c, 0, ETH_ALEN);
 	memset(dmac_v, 0, ETH_ALEN);
 	dmac_c[0] = 1;
 	dmac_v[0] = 1;
-	rule = mlx5_add_flow_rules(ndev-&gt;rxft, spec, &amp;flow_act, &amp;dest, 1);
+	node-&gt;mcast_rule = mlx5_add_flow_rules(ndev-&gt;rxft, spec, &amp;flow_act, dests, NUM_DESTS);
 	kvfree(spec);</pre>
    </blockquote>
    Move kvfree a couple of lines under (after the IS_ERR check).<br>
    <blockquote type="cite" cite="mid:20221018111232.4021-5-elic@nvidia.com">
      <pre class="moz-quote-pre" wrap="">
 	if (IS_ERR(rule)) {
 		err = PTR_ERR(rule);
 		goto err_mcast;
 	}
 
-	*mcast = rule;
+#if defined(CONFIG_MLX5_VDPA_STEERING_DEBUG)
+	node-&gt;ucast_counter.mdev = ndev-&gt;mvdev.mdev;
+	node-&gt;mcast_counter.mdev = ndev-&gt;mvdev.mdev;
+#endif
+	mlx5_vdpa_add_rx_counters(ndev, node);
+
 	return 0;
 
 err_mcast:
-	mlx5_del_flow_rules(*ucast);
+	mlx5_del_flow_rules(node-&gt;ucast_rule);
+#if defined(CONFIG_MLX5_VDPA_STEERING_DEBUG)</pre>
    </blockquote>
    No corresponding mlx5_fc_destroy() for mcast_counter.<br>
    <blockquote type="cite" cite="mid:20221018111232.4021-5-elic@nvidia.com">
      <pre class="moz-quote-pre" wrap="">
+err_mcast_counter:
+	mlx5_fc_destroy(ndev-&gt;mvdev.mdev, node-&gt;ucast_counter.counter);
+err_ucast_counter:
+	kfree(spec);</pre>
    </blockquote>
    kvfree?<br>
    <br>
    Regards,<br>
    -Siwei<br>
    <blockquote type="cite" cite="mid:20221018111232.4021-5-elic@nvidia.com">
      <pre class="moz-quote-pre" wrap="">
+#endif
 	return err;
 }
 
 static void mlx5_vdpa_del_mac_vlan_rules(struct mlx5_vdpa_net *ndev,
-					 struct mlx5_flow_handle *ucast,
-					 struct mlx5_flow_handle *mcast)
+					 struct macvlan_node *node)
 {
-	mlx5_del_flow_rules(ucast);
-	mlx5_del_flow_rules(mcast);
+#if defined(CONFIG_MLX5_VDPA_STEERING_DEBUG)
+	if (node-&gt;dent &amp;&amp; !IS_ERR(node-&gt;dent))
+		mlx5_vdpa_remove_rx_counters(ndev, node);
+#endif
+
+	mlx5_del_flow_rules(node-&gt;ucast_rule);
+	mlx5_del_flow_rules(node-&gt;mcast_rule);
 }
 
 static u64 search_val(u8 *mac, u16 vlan, bool tagged)
@@ -1503,14 +1542,14 @@ static struct macvlan_node *mac_vlan_lookup(struct mlx5_vdpa_net *ndev, u64 valu
 	return NULL;
 }
 
-static int mac_vlan_add(struct mlx5_vdpa_net *ndev, u8 *mac, u16 vlan, bool tagged) // vlan -&gt; vid
+static int mac_vlan_add(struct mlx5_vdpa_net *ndev, u8 *mac, u16 vid, bool tagged)
 {
 	struct macvlan_node *ptr;
 	u64 val;
 	u32 idx;
 	int err;
 
-	val = search_val(mac, vlan, tagged);
+	val = search_val(mac, vid, tagged);
 	if (mac_vlan_lookup(ndev, val))
 		return -EEXIST;
 
@@ -1518,12 +1557,13 @@ static int mac_vlan_add(struct mlx5_vdpa_net *ndev, u8 *mac, u16 vlan, bool tagg
 	if (!ptr)
 		return -ENOMEM;
 
-	err = mlx5_vdpa_add_mac_vlan_rules(ndev, ndev-&gt;config.mac, vlan, tagged,
-					   &amp;ptr-&gt;ucast_rule, &amp;ptr-&gt;mcast_rule);
+	ptr-&gt;tagged = tagged;
+	ptr-&gt;macvlan = val;
+	ptr-&gt;ndev = ndev;
+	err = mlx5_vdpa_add_mac_vlan_rules(ndev, ndev-&gt;config.mac, ptr);
 	if (err)
 		goto err_add;
 
-	ptr-&gt;macvlan = val;
 	idx = hash_64(val, 8);
 	hlist_add_head(&amp;ptr-&gt;hlist, &amp;ndev-&gt;macvlan_hash[idx]);
 	return 0;
@@ -1542,7 +1582,11 @@ static void mac_vlan_del(struct mlx5_vdpa_net *ndev, u8 *mac, u16 vlan, bool tag
 		return;
 
 	hlist_del(&amp;ptr-&gt;hlist);
-	mlx5_vdpa_del_mac_vlan_rules(ndev, ptr-&gt;ucast_rule, ptr-&gt;mcast_rule);
+	mlx5_vdpa_del_mac_vlan_rules(ndev, ptr);
+#if defined(CONFIG_MLX5_VDPA_STEERING_DEBUG)
+			mlx5_fc_destroy(ndev-&gt;mvdev.mdev, ptr-&gt;mcast_counter.counter);
+			mlx5_fc_destroy(ndev-&gt;mvdev.mdev, ptr-&gt;ucast_counter.counter);
+#endif
 	kfree(ptr);
 }
 
@@ -1555,7 +1599,11 @@ static void clear_mac_vlan_table(struct mlx5_vdpa_net *ndev)
 	for (i = 0; i &lt; MLX5V_MACVLAN_SIZE; i++) {
 		hlist_for_each_entry_safe(pos, n, &amp;ndev-&gt;macvlan_hash[i], hlist) {
 			hlist_del(&amp;pos-&gt;hlist);
-			mlx5_vdpa_del_mac_vlan_rules(ndev, pos-&gt;ucast_rule, pos-&gt;mcast_rule);
+			mlx5_vdpa_del_mac_vlan_rules(ndev, pos);
+#if defined(CONFIG_MLX5_VDPA_STEERING_DEBUG)
+			mlx5_fc_destroy(ndev-&gt;mvdev.mdev, pos-&gt;mcast_counter.counter);
+			mlx5_fc_destroy(ndev-&gt;mvdev.mdev, pos-&gt;ucast_counter.counter);
+#endif
 			kfree(pos);
 		}
 	}
diff --git a/drivers/vdpa/mlx5/net/mlx5_vnet.h b/drivers/vdpa/mlx5/net/mlx5_vnet.h
index f2cef3925e5b..706c83016b71 100644
--- a/drivers/vdpa/mlx5/net/mlx5_vnet.h
+++ b/drivers/vdpa/mlx5/net/mlx5_vnet.h
@@ -21,6 +21,11 @@ struct mlx5_vdpa_net_resources {
 
 #define MLX5V_MACVLAN_SIZE 256
 
+static inline u16 key2vid(u64 key)
+{
+	return (u16)(key &gt;&gt; 48);
+}
+
 struct mlx5_vdpa_net {
 	struct mlx5_vdpa_dev mvdev;
 	struct mlx5_vdpa_net_resources res;
@@ -47,11 +52,24 @@ struct mlx5_vdpa_net {
 	struct dentry *debugfs;
 };
 
+struct mlx5_vdpa_counter {
+	struct mlx5_fc *counter;
+	struct dentry *dent;
+	struct mlx5_core_dev *mdev;
+};
+
 struct macvlan_node {
 	struct hlist_node hlist;
 	struct mlx5_flow_handle *ucast_rule;
 	struct mlx5_flow_handle *mcast_rule;
 	u64 macvlan;
+	struct mlx5_vdpa_net *ndev;
+	bool tagged;
+#if defined(CONFIG_MLX5_VDPA_STEERING_DEBUG)
+	struct dentry *dent;
+	struct mlx5_vdpa_counter ucast_counter;
+	struct mlx5_vdpa_counter mcast_counter;
+#endif
 };
 
 void mlx5_vdpa_add_debugfs(struct mlx5_vdpa_net *ndev);
@@ -60,5 +78,17 @@ void mlx5_vdpa_add_rx_flow_table(struct mlx5_vdpa_net *ndev);
 void mlx5_vdpa_remove_rx_flow_table(struct mlx5_vdpa_net *ndev);
 void mlx5_vdpa_add_tirn(struct mlx5_vdpa_net *ndev);
 void mlx5_vdpa_remove_tirn(struct mlx5_vdpa_net *ndev);
+#if defined(CONFIG_MLX5_VDPA_STEERING_DEBUG)
+void mlx5_vdpa_add_rx_counters(struct mlx5_vdpa_net *ndev,
+			       struct macvlan_node *node);
+void mlx5_vdpa_remove_rx_counters(struct mlx5_vdpa_net *ndev,
+				  struct macvlan_node *node);
+#else
+static inline void mlx5_vdpa_add_rx_counters(struct mlx5_vdpa_net *ndev,
+					     struct macvlan_node *node) {}
+static inline void mlx5_vdpa_remove_rx_counters(struct mlx5_vdpa_net *ndev,
+						struct macvlan_node *node) {}
+#endif
+
 
 #endif /* __MLX5_VNET_H__ */
</pre>
    </blockquote>
    <br>
  </body>
</html>

--------------bjWbVqBqLUyTEAA71qJOM04u--


--===============1899012867502148376==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
--===============1899012867502148376==--


