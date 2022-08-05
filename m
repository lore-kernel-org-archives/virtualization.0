Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7FD8EC00140
	for <virtualization@archiver.kernel.org>; Fri,  5 Aug 2022 22:12:15 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id E39398340C;
	Fri,  5 Aug 2022 22:12:14 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org E39398340C
Authentication-Results: smtp1.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.a=rsa-sha256 header.s=corp-2022-7-12 header.b=RhviSYFu;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.a=rsa-sha256 header.s=selector2-oracle-onmicrosoft-com header.b=E6WsdfFq
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id TvOc5jblOhdi; Fri,  5 Aug 2022 22:12:13 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id CDF9983EBE;
	Fri,  5 Aug 2022 22:12:12 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org CDF9983EBE
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 7F904C0033;
	Fri,  5 Aug 2022 22:12:12 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 6163FC002D
 for <virtualization@lists.linux-foundation.org>;
 Fri,  5 Aug 2022 22:12:11 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 418E640BAF
 for <virtualization@lists.linux-foundation.org>;
 Fri,  5 Aug 2022 22:12:11 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 418E640BAF
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com
 header.a=rsa-sha256 header.s=corp-2022-7-12 header.b=RhviSYFu; 
 dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com
 header.i=@oracle.onmicrosoft.com header.a=rsa-sha256
 header.s=selector2-oracle-onmicrosoft-com header.b=E6WsdfFq
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id ejPSl_lloX5Z
 for <virtualization@lists.linux-foundation.org>;
 Fri,  5 Aug 2022 22:12:08 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org E33D3400BB
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com
 [205.220.177.32])
 by smtp2.osuosl.org (Postfix) with ESMTPS id E33D3400BB
 for <virtualization@lists.linux-foundation.org>;
 Fri,  5 Aug 2022 22:12:07 +0000 (UTC)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 275KnG0F026223;
 Fri, 5 Aug 2022 22:11:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=yfny6/RlTMHepR5sCz4d/d59aiquaYB1aoHcgoIWfmo=;
 b=RhviSYFu4uAw//i/DeT4giL9cYGm3SPkaxVfgiK8PXuy2hQbUVHQiw4q3k8NBd8apKkt
 S7bYv/7cGHyroT2sxUPXFwdweA3Vzt/r35aIycCFpGMBRKppfg1mw6g56oFi8kYeTzFG
 MpkHACxYUiCA7xUG82+JGoD2x6dPMZ6C5xpcKdHwnCZGd2QE9HWIVoe0FgJebQVDv0aP
 zJhBGgVbgMif7CdSc/oebKVLZZP/PpASImcJVKOvLLZ5sQTkNZ30N+35LLy8k7BHj2Vt
 GtcZFGViQYtwKpvrYEariEQZiaC9JHG2IJIKRdgz31wqTyd8awj9hdneBPb4eaPPksb4 Bw== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3hmv8sgx8j-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 05 Aug 2022 22:11:49 +0000
Received: from pps.filterd
 (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5)
 with ESMTP id 275Lgb8J002997; Fri, 5 Aug 2022 22:11:49 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com
 (mail-bn7nam10lp2100.outbound.protection.outlook.com [104.47.70.100])
 by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 3hmu35u0v1-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 05 Aug 2022 22:11:48 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IlsS3jdi0trDu3sEvS5af7r/SBqyxZeEjY0/N6py635NuvXVX2qD/UVnlry9LDv7vktBU/byMuP/i++HivJ5RU7/ugnyVbpOUOHxHdPhDxFFEhOA0oaG7vKksjHNLWLPywQaxn4Dog7N+dGEv2Yiw6uyvZE4oFo/h30FHi3Eo8J994drTRV00ABVSMpphK55F0YFzC5VZ/gN200L31A1h1gsjaCvF2PRz6QJuvgZjv7GMe/7YJNTmfcDgiDfRovK+1Gn+DbACcS6sNVhV4Ex6HJDh7aqqPq3kzIMtpPbYK6V/1X+gdNLRfqSYNTmXC8NqibONFZt+klDHcXl46Afog==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yfny6/RlTMHepR5sCz4d/d59aiquaYB1aoHcgoIWfmo=;
 b=axsCqaRbII0dUjLqBsSm7XylU+AifQywlRhrFP66Hj5qkVAh4HmBxj20vHDQt9tLyHsfXeKRumFh7uI/fuu6WzJ4bIS7DHN29l3OR/EUPyAW8wr28Og8hNHR4tMS80lsP0pxXhk/ieHJnPkOg7foKb0YCBPiG8wkaMdnJo6ISy51/eBQa+ZUanw8wR+3CrNd0E6set6Pes4ZsswFYY7HOEs0dF7Fgun2lo2zWQZoeGi92u5OE6QXWPLEKUx3jobU3jVBcnqERcWCOoWmT7S54jkzhFvQkfgZOHivdczq06TiBP4NvdttPKoGxsE4xob0jRpnh44Ms8HXdgMD0zP2yA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yfny6/RlTMHepR5sCz4d/d59aiquaYB1aoHcgoIWfmo=;
 b=E6WsdfFqx0+fqnPLBF2l6h5k73xffn9W8/pepYeVz0XT1A/s4qXOU0rlK7zBYYD9x9oLW9NF3YPAxQmOP5zhGjnhiay9WkT5YVl3ygjG+issvWP4rtJMtrJdLPCDzAc8My+gJH/DyHNWqzC2WtQfE/Q+mTDkORsBvU5RQhYGJ5U=
Received: from BYAPR10MB3287.namprd10.prod.outlook.com (2603:10b6:a03:15c::11)
 by BY5PR10MB4385.namprd10.prod.outlook.com (2603:10b6:a03:20a::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5504.14; Fri, 5 Aug
 2022 22:11:47 +0000
Received: from BYAPR10MB3287.namprd10.prod.outlook.com
 ([fe80::dcf7:95c3:9991:e649]) by BYAPR10MB3287.namprd10.prod.outlook.com
 ([fe80::dcf7:95c3:9991:e649%7]) with mapi id 15.20.5504.016; Fri, 5 Aug 2022
 22:11:46 +0000
Message-ID: <973632c6-3606-01fb-c584-a6d4774647d8@oracle.com>
Date: Fri, 5 Aug 2022 15:11:43 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [virtio-dev] [PATCH] virtio-net: use mtu size as buffer length
 for big packets
Content-Language: en-US
To: Gavin Li <gavinl@nvidia.com>, mst@redhat.com, stephen@networkplumber.org, 
 davem@davemloft.net, virtualization@lists.linux-foundation.org,
 virtio-dev@lists.oasis-open.org, jesse.brandeburg@intel.com,
 alexander.h.duyck@intel.com, kubakici@wp.pl,
 sridhar.samudrala@intel.com, jasowang@redhat.com, loseweigh@gmail.com
References: <20220802044548.9031-1-gavinl@nvidia.com>
From: Si-Wei Liu <si-wei.liu@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <20220802044548.9031-1-gavinl@nvidia.com>
X-ClientProxiedBy: SJ0PR03CA0270.namprd03.prod.outlook.com
 (2603:10b6:a03:3a0::35) To BYAPR10MB3287.namprd10.prod.outlook.com
 (2603:10b6:a03:15c::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e86f362f-8b47-490f-5d77-08da772f7c87
X-MS-TrafficTypeDiagnostic: BY5PR10MB4385:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: e3UjE9nT+OKnmt9OEaHSJ9y3dKP6oBR01HgEG2O8g+rEAeN1GV0U+2QBCfa19tTcbAJ9uiu+P245U5sV7o5WbfxRbGECzz+C/RDNylDZ6nvwwmwXudIBCLlHDjuoRasHBCw6w7DyTqYpzbl92UN6OB2Gq12g6CMw31h82M7U22vkIRDcP5nDcnOKw7Bgw98Z6br7wAieflJBGdHVbBoAVprLrIO/FcVQ1SNWEWBa89SDjDFS2+yphdTlx9MlKyZzSop0Zg3KB7DIoZdOu8FgFJAjfiNomUr+903MXqHNnYXsKy2s6fcYQIf2vOOfNXO3KzJwA2EVNAaye3hqltPG3S1EC8IOM7yx+JAGdSWLmibMdQolx7cwjta4RYGW1NnCeG1RGQNzdJX5LwjsplqHjrHS+itNPUloJs5/bZNbR8x4NCtbHNYJFwKQE/ORCKUUiRl0gwaeuL2Is73SXxovYb5kViuO3sYTmnG/dGpdFK98N3BzKu0E6s6c0utIqkUf9zc52o9kHEZJpvxIc3rwrilDzWnR/XfP/JMt9AN3MGYd02AIM4mhKWBXhptqsOJSESfxsjx7lm5XAjUbS6IvebQoVm70ysJN0JQtxvkgOkCA6MZ7XXKquJhzrXg3w6TJUZAvYrs/Kc9UsY2j7jEegie216DqCWyo3eBdc/v1MHSLaA0p6pZJh6hA3f+RRyKeUrLkKla+yWCycqpiZI5VwVue69JO4PDX5IcqFVfhiqMfLiP6hCoElQNGUj6umrVtyqekJx73gDMwBzLfxWr9DBlfSsu03KakSrT7UefnM3JBBvnoqgyCc9Ex5TjeawR+XoC8NRmgZ2vzXKAWJfKFoZ6RyiqfZdWz3eU2oNE/gH4=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR10MB3287.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230016)(346002)(396003)(366004)(39860400002)(376002)(136003)(83380400001)(7416002)(2616005)(8936002)(316002)(186003)(5660300002)(4326008)(8676002)(66476007)(38100700002)(66556008)(921005)(86362001)(31696002)(6486002)(66946007)(478600001)(36916002)(53546011)(36756003)(2906002)(31686004)(6506007)(41300700001)(26005)(6512007)(6666004)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TjhET01FWkZYUkhBaDZCN1pFTXJyd2UvLzVRcHE5bWFuV3ZhYmQrNGZjN01C?=
 =?utf-8?B?VlFmcDBEanNtd0haZjZLVTZZa1ZKN2R3T1B6SHZPTzRUWHBmRnlXUVlUQm9x?=
 =?utf-8?B?NDEwSE1uMHdiT01yMzZtM2piMVZxUmRwZ0M2S0NYSUxLbEJiZkJLSnRvUlhG?=
 =?utf-8?B?RTMxWUxGYUhLQ0ZldlMvQmRrdXpnUWhzVFpDMHhIaGlBcXBaSU9Za1hGaHdo?=
 =?utf-8?B?VWRudHRzSmtLUHVqYlFUNE5Fa2w5OFNaZ0FOSGdnQlJPZzRPbGhZb3B1RVFn?=
 =?utf-8?B?QVpyRmgwdkVOUmVpTmhaWm9PclVweHBXVS82blBLTEt3VDhHZTQ5Qjk5SFJR?=
 =?utf-8?B?eUNsamdub0NSS3Z6RjE5cXFTa0xVY1NSUzFqZVdLZnRPZGNmdXBZY3VQUmZ1?=
 =?utf-8?B?WXFlNGZrNENWREVZS1dDVmh3cTZHRVhzMzlyRWdDWVRMUkJEZ2Y0cFkrbXFx?=
 =?utf-8?B?eGF4R1ExNFMyWngzNVJqVzcydDhiSVA2SEYyRUJZMktBT3dWYUZqRmRBazhC?=
 =?utf-8?B?Sm5WaWNzelh5WHQ2Vi91MVBPU2VLdUVGUjIyRDVBQjcyb3RJcmVhVmsydHpL?=
 =?utf-8?B?N3A3cWh5eEhFQ0Q2ZjZtRTEwN3BtbVUrWXo2N1BZSExma2EyQnZ1N2x6blQy?=
 =?utf-8?B?aXg3L0FYcFREUTF1TXc1YWpGT0RBVUJpbU5lVzIrWXd2K0F3c0lZMWZ1QzlS?=
 =?utf-8?B?Y0J3TWtuWFVMaGIzOFc5TTdTckRxUkIzQ0crSUpkRG84blBTY2R5d2NrcUsv?=
 =?utf-8?B?ZXB1Skp2TitVQmgwRFNCVm9teEs5Y1FES0hveWJRbjNYSllaMXNYNTE5eGZa?=
 =?utf-8?B?OEYvUDRRcXBYZis0L0E2N3F3VG5rdURocDFJSzJKTDN2UmxxT2ZWUlVqOGFK?=
 =?utf-8?B?OGlHS3R0bDRlK0l6anpod3pUS2dCMWI5aXRxOXpkcHFqYkpTcEJpTzJiMm5O?=
 =?utf-8?B?QTM2aUdSQ2JNWEFWUitMUGowL1pPL3VKQkgzZUR5R1RobWZlQ01ubm1YbkRF?=
 =?utf-8?B?ZS9TaTAwdWZLZjYvUzREMHJMNW1Xem1Eb015eDNwTTRnNU42aWdNSlNNLzlU?=
 =?utf-8?B?Vi9LYzJRUGZzbEZkdE5IVUk1cUNxTXIyV01NYnlYcWZxakQxTStTUU9tQ0dF?=
 =?utf-8?B?cEVFVW9IT2g5MmNpdkdtWFNoOHk1Qk1KS2lTTEhuSzgvUTIrNGhOSnVFVnhv?=
 =?utf-8?B?djVUbld4NDRRTmdQaVp4a1d3SmZodkJoUE4wWnJBS2lkQStjbFpPV29nWGVG?=
 =?utf-8?B?QU8yb01IUVdRb2xEazFJenAyeUVvSlVSaENEMkZKdFl4WDFYVys2N1MzcmM5?=
 =?utf-8?B?SHlHZWpOMWdBellRaHdQU3JKajVZTUlBV3QyRitUUWxKc1d1L29uUEVBUmFv?=
 =?utf-8?B?cnhJQ3BHTkZYYkhVazRFdWlUeGlKakFDNVZESGdEZ1kyc2NJTEhxMThTNElV?=
 =?utf-8?B?VjREMGZJRmM3TzhHSHlhTVhVc1p5ZXhyR0lwVVhYWi9ybVVlbDVFNDcrUG1h?=
 =?utf-8?B?RiticEFpUS9JbU9XSld0WUhSQWRlOXlqQUNPellDVUp4L3pFQXF2MnVLSUpC?=
 =?utf-8?B?WEhCRnRGUmtyUFNZTmNmbXJqcllLUjBuaEp2WThKaHRlNUVnMmErcmVEQkVy?=
 =?utf-8?B?RXpHUURQcGVzODZnZklCelIybmtXZUZybFVXODdsL3cwMHRIVk5RZkZCeU5W?=
 =?utf-8?B?Vm9PVXRTVGV2OFh3ZkNYNy9XejhtM2c4eHpycFZuYnNnOXRsQk9GRGVTL3c5?=
 =?utf-8?B?NisxQmhSYTA2OXNrUWlCRTd0eURYRW9oVHRMcDEvaHhaMldoRVRoZSt5MXd0?=
 =?utf-8?B?Vms3MFJ0RForeER4a1NrS3o3K3ZyZ3lEVnhEbG4xeWRsdTdCYjRuTzB6T2cv?=
 =?utf-8?B?UUZ6SFlNOHlFaGg1VHNGK29BSmxnTG9LSFA4TFpQY3ljSktzWHNySWUxN1VZ?=
 =?utf-8?B?UDUvVWljTzhzVmw5cEtOZmdFYnI3T1JydjhFSENCWHZ6UFQyL1Y3UmhUeFNR?=
 =?utf-8?B?VGtGUFJYSmZ6ZGRJcDkxY0MxRG1mS3ZFMWdYejBGbnpLVk5kMGxjc05CQ2JV?=
 =?utf-8?B?aW1Lc3N3QVp0RlAzaExyNGd6RTVnVkxQWCtid2pwMGNlYUdNVnArY3V6NWxS?=
 =?utf-8?Q?twZB12LtM0fdG+jywNfh0etKN?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e86f362f-8b47-490f-5d77-08da772f7c87
X-MS-Exchange-CrossTenant-AuthSource: BYAPR10MB3287.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Aug 2022 22:11:46.4166 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: W7lSf2jkAobOYu73WBa5tKsu8pZsYnm3nPRxCRgbSR/syABjR5WEoNm+RXIKdnGRlkLaDZ2RSZ01lHcXiQ/gjQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR10MB4385
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-05_11,2022-08-05_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0
 suspectscore=0
 mlxlogscore=999 bulkscore=0 mlxscore=0 phishscore=0 spamscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2206140000 definitions=main-2208050098
X-Proofpoint-GUID: cwUnLSinMhEdWeCfdGzDjwtIMNcMJCk1
X-Proofpoint-ORIG-GUID: cwUnLSinMhEdWeCfdGzDjwtIMNcMJCk1
Cc: gavi@nvidia.com
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



On 8/1/2022 9:45 PM, Gavin Li wrote:
> Currently add_recvbuf_big() allocates MAX_SKB_FRAGS segments for big
> packets even when GUEST_* offloads are not present on the device.
> However, if GSO is not supported,
GUEST GSO (virtio term), or GRO HW (netdev core term) it should have 
been be called.

>   it would be sufficient to allocate
> segments to cover just up the MTU size and no further. Allocating the
> maximum amount of segments results in a large waste of buffer space in
> the queue, which limits the number of packets that can be buffered and
> can result in reduced performance.
>
> Therefore, if GSO is not supported,
Ditto.

> use the MTU to calculate the
> optimal amount of segments required.
>
> Below is the iperf TCP test results over a Mellanox NIC, using vDPA for
> 1 VQ, queue size 1024, before and after the change, with the iperf
> server running over the virtio-net interface.
>
> MTU(Bytes)/Bandwidth (Gbit/s)
>               Before   After
>    1500        22.5     22.4
>    9000        12.8     25.9
>
> Signed-off-by: Gavin Li <gavinl@nvidia.com>
> Reviewed-by: Gavi Teitz <gavi@nvidia.com>
> Reviewed-by: Parav Pandit <parav@nvidia.com>
> ---
>   drivers/net/virtio_net.c | 20 ++++++++++++++++----
>   1 file changed, 16 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> index ec8e1b3108c3..d36918c1809d 100644
> --- a/drivers/net/virtio_net.c
> +++ b/drivers/net/virtio_net.c
> @@ -222,6 +222,9 @@ struct virtnet_info {
>   	/* I like... big packets and I cannot lie! */
>   	bool big_packets;
>   
> +	/* Indicates GSO support */
> +	bool gso_is_supported;
> +
>   	/* Host will merge rx buffers for big packets (shake it! shake it!) */
>   	bool mergeable_rx_bufs;
>   
> @@ -1312,14 +1315,21 @@ static int add_recvbuf_small(struct virtnet_info *vi, struct receive_queue *rq,
>   static int add_recvbuf_big(struct virtnet_info *vi, struct receive_queue *rq,
>   			   gfp_t gfp)
>   {
> +	unsigned int sg_num = MAX_SKB_FRAGS;
>   	struct page *first, *list = NULL;
>   	char *p;
>   	int i, err, offset;
>   
> -	sg_init_table(rq->sg, MAX_SKB_FRAGS + 2);
> +	if (!vi->gso_is_supported) {
> +		unsigned int mtu = vi->dev->mtu;
> +
> +		sg_num = (mtu % PAGE_SIZE) ? mtu / PAGE_SIZE + 1 : mtu / PAGE_SIZE;
DIV_ROUND_UP() can be used?

Since this branch slightly adds up cost to the datapath, I wonder if 
this sg_num can be saved and set only once (generally in virtnet_probe 
time) in struct virtnet_info?
> +	}
> +
> +	sg_init_table(rq->sg, sg_num + 2);
>   
>   	/* page in rq->sg[MAX_SKB_FRAGS + 1] is list tail */
Comment doesn't match code.
> -	for (i = MAX_SKB_FRAGS + 1; i > 1; --i) {
> +	for (i = sg_num + 1; i > 1; --i) {
>   		first = get_a_page(rq, gfp);
>   		if (!first) {
>   			if (list)
> @@ -1350,7 +1360,7 @@ static int add_recvbuf_big(struct virtnet_info *vi, struct receive_queue *rq,
>   
>   	/* chain first in list head */
>   	first->private = (unsigned long)list;
> -	err = virtqueue_add_inbuf(rq->vq, rq->sg, MAX_SKB_FRAGS + 2,
> +	err = virtqueue_add_inbuf(rq->vq, rq->sg, sg_num + 2,
>   				  first, gfp);
>   	if (err < 0)
>   		give_pages(rq, first);
> @@ -3571,8 +3581,10 @@ static int virtnet_probe(struct virtio_device *vdev)
>   	if (virtio_has_feature(vdev, VIRTIO_NET_F_GUEST_TSO4) ||
>   	    virtio_has_feature(vdev, VIRTIO_NET_F_GUEST_TSO6) ||
>   	    virtio_has_feature(vdev, VIRTIO_NET_F_GUEST_ECN) ||
> -	    virtio_has_feature(vdev, VIRTIO_NET_F_GUEST_UFO))
> +	    virtio_has_feature(vdev, VIRTIO_NET_F_GUEST_UFO)) {
>   		vi->big_packets = true;
> +		vi->gso_is_supported = true;
Please do the same for virtnet_clear_guest_offloads(), and 
correspondingly virtnet_restore_guest_offloads() as well. Not sure why 
virtnet_clear_guest_offloads() or the caller doesn't unset big_packet on 
successful return, seems like a bug to me.


Thanks,
-Siwei
> +	}
>   
>   	if (virtio_has_feature(vdev, VIRTIO_NET_F_MRG_RXBUF))
>   		vi->mergeable_rx_bufs = true;

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
