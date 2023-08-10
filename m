Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C1E28C001B0
	for <virtualization@archiver.kernel.org>; Thu, 10 Aug 2023 22:21:12 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 5BA2B83BE2;
	Thu, 10 Aug 2023 22:21:12 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 5BA2B83BE2
Authentication-Results: smtp1.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.a=rsa-sha256 header.s=corp-2023-03-30 header.b=0EsOwNzb;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.a=rsa-sha256 header.s=selector2-oracle-onmicrosoft-com header.b=HTRh26tI
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id uWfWuwyURpov; Thu, 10 Aug 2023 22:21:11 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 5DA7683BA5;
	Thu, 10 Aug 2023 22:21:10 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 5DA7683BA5
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 35964C0072;
	Thu, 10 Aug 2023 22:21:10 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 55FC8C0032
 for <virtualization@lists.linux-foundation.org>;
 Thu, 10 Aug 2023 22:21:09 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 2856C408D7
 for <virtualization@lists.linux-foundation.org>;
 Thu, 10 Aug 2023 22:21:09 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 2856C408D7
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com
 header.a=rsa-sha256 header.s=corp-2023-03-30 header.b=0EsOwNzb; 
 dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com
 header.i=@oracle.onmicrosoft.com header.a=rsa-sha256
 header.s=selector2-oracle-onmicrosoft-com header.b=HTRh26tI
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id rpovLPwB9_bj
 for <virtualization@lists.linux-foundation.org>;
 Thu, 10 Aug 2023 22:21:06 +0000 (UTC)
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com
 [205.220.177.32])
 by smtp2.osuosl.org (Postfix) with ESMTPS id DBFBF400DC
 for <virtualization@lists.linux-foundation.org>;
 Thu, 10 Aug 2023 22:21:05 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org DBFBF400DC
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 37AL4bLA022015; Thu, 10 Aug 2023 22:21:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=GUA/xRZq6/TNE4CYphAyuu4hOheItbEwCBO8hkxfq0s=;
 b=0EsOwNzbmMQ+ixhyPeBs19bNUjmhm4gn+OwQJpuqZYY6eSiAVXa/ETTJptczqwZrqjlZ
 n1jfRBWKggUL9LDUW7nJbIUlCOfvOm3uls1U5rjmTsT2sHjm9Lw7hh2qn7y/rSRjybRc
 526Q/wmFq3ZaevZLcy29/oOQjphMYH9YCAClAnuqECSFXdsFLoM136iYn6Kjt4tXKr/p
 aRTvtf9qMhHBSoo36uYPf1FbmPPklO7MDIaczhACLV9Vxr1v63z/yMVql6emig3uBcjt
 l32Af865Nk8CZSmETd8PKmYTvAWCqZ8Jm+pQsK01NMeGaJmJcetXc4RzAf7AFy5Cm51c nQ== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3s9efdccxv-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 10 Aug 2023 22:21:00 +0000
Received: from pps.filterd
 (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19)
 with ESMTP id 37ALrI9L007688; Thu, 10 Aug 2023 22:20:59 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com
 (mail-bn8nam12lp2175.outbound.protection.outlook.com [104.47.55.175])
 by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 3s9cvg3usk-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 10 Aug 2023 22:20:59 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kPwogHaqHpCLrEKUFQNaXX8fWgD63xtuIpITj5B4hK1IDwETN6AUlSq6dS/GlHp1F3kvJNnYCe80s4KpnxdSCgrxgv3n4nOKBfSwD8e400jRIB8mKj4qrkqM4sQGlEfUM1yLDF2mqRrOo0w9St2per/4X2NQ9mwwU8VMTF+vchiP7MZzTGwmPDDBiCJwvc7hDevcOkQTTo4DDofVZkxGHwej2IYwspnB0SUytsxD057HJ/AlWrV05RQKkdlXtwMrWeMUkN4Wr3K+euTH5vaGjPCge93Pm9GXLr/olvVHk9tntV9GQKHk/w64lXuii8OdO++E0ZlpA6AeDir/YZ43Sg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GUA/xRZq6/TNE4CYphAyuu4hOheItbEwCBO8hkxfq0s=;
 b=WLGZRSHcGrinvR+9pHKYZijqTBHQKAkjhmpYF74n3yHQhu1AK9riHu8PoL/xEXdJzcMXUoIaeEQJgo7+wpu6H1IurFIWCpQcFT8UZtpPCwzxHHdxm+vsWWLyipJm9vL+WRKRKyaXs2an21PiTcST8Q0C0SPOlgRVjSDplJiktSc0bxk06dcxXJrRZlpcUH2qgpHUqJ619VHKtC1FpJfdH9Re08UWbL2Q89E12ycxWW3U59d0ne/eFPqRojAJvJW30C6OLyD0Ywq/x99vDkkhb99jCPKe8v+HnK75iR7V4qR6nMp1Ykc3eudU08AdlxsNsVGcXiLhPziwpE0zwgaPWA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GUA/xRZq6/TNE4CYphAyuu4hOheItbEwCBO8hkxfq0s=;
 b=HTRh26tIb6i7bp7J9vXESJXM65ShLXVI8drqGL/pdp62XB24vRrTzpGXgDs7LEY66RLsO2JbcV9f2vZ1TXcnDaQVI43KfmuGmMlI98Pk4haiajHgcYY3nGHo/SV5K5aIE32jhj/sHpXGhrMaO4QIQhd2q1W8a4VTkwZkBKHMmCU=
Received: from MW4PR10MB6535.namprd10.prod.outlook.com (2603:10b6:303:225::12)
 by IA1PR10MB7336.namprd10.prod.outlook.com (2603:10b6:208:3ff::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.30; Thu, 10 Aug
 2023 22:20:56 +0000
Received: from MW4PR10MB6535.namprd10.prod.outlook.com
 ([fe80::afcc:c8ba:7c2e:350b]) by MW4PR10MB6535.namprd10.prod.outlook.com
 ([fe80::afcc:c8ba:7c2e:350b%6]) with mapi id 15.20.6652.029; Thu, 10 Aug 2023
 22:20:56 +0000
Message-ID: <325aaca0-ccdf-1843-4ab8-03bc94d3ea98@oracle.com>
Date: Thu, 10 Aug 2023 15:20:51 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [PATCH 1/2] vdpa/mlx5: Fix mr->initialized semantics
Content-Language: en-US
To: Jason Wang <jasowang@redhat.com>
References: <20230802171231.11001-1-dtatulea@nvidia.com>
 <20230802171231.11001-3-dtatulea@nvidia.com>
 <CACGkMEsE45k+fqv-biYfOX5VbqZLo_drQV5rPYByuLJZK03hWQ@mail.gmail.com>
 <741645a0-c576-e504-8ebc-6b716099d730@oracle.com>
 <CACGkMEuAUBa=ZWi2Y48KDABsyAsQFNc4AAPmkHZyXHCQ8Vv89A@mail.gmail.com>
 <3472a482-dc1d-1994-e2d7-c2bd740bbd27@oracle.com>
 <CACGkMEsj=Bg3GvsErWQqe0Ov8CqT9un0nTFeDYW6EzzowJm9rQ@mail.gmail.com>
 <e5a853f1-d83b-ffe5-b96a-b3c0d9c6f528@oracle.com>
 <CACGkMEtWsBRtW3DNQudcWJEtRb7isG-yRvvL3kL2L7k_=TgkZQ@mail.gmail.com>
From: Si-Wei Liu <si-wei.liu@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <CACGkMEtWsBRtW3DNQudcWJEtRb7isG-yRvvL3kL2L7k_=TgkZQ@mail.gmail.com>
X-ClientProxiedBy: SA9PR13CA0073.namprd13.prod.outlook.com
 (2603:10b6:806:23::18) To MW4PR10MB6535.namprd10.prod.outlook.com
 (2603:10b6:303:225::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR10MB6535:EE_|IA1PR10MB7336:EE_
X-MS-Office365-Filtering-Correlation-Id: 906112e0-604b-45a4-80ec-08db99f010fb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Bm+/e/PIRpv56kEKuAKgYp4zzV6uZ9/afKJ54lTQsQJVCX58XLcqtqEOQu07ymvSTyQc+EiIqK92OOc5udhlHuldFCEaXr3e35C9nhS+nbSbxvkXHSXO0Kg3PIB6qVv2Ls4oa7pPpyQxNNeVvy/tDuyNs+G995VagLfa4cslQ2EXKfSJyZtHKI3pzuaNMf4ZAHPfZephEt6Xjaj5IocO901qCWKk9uypQ9SEgKRIuaLoo+6GYeyzZb6wC3dyOH9zl5khnHgftTVSJ+DnlFVuU9nEZeJB9oiR0I7vxzwJ5zh8VZjwg8a2+q6jB7LpfoOSn/Tptw2g2/Vamg0Y3sv3aFGxmSrLnFiXAl0H5hvRBINYKWfD6EcEk6viqhiJmCUxfayxeZGmpOaZdeYfHqCG1X64WqWAHJedinanwTm0FS6bmv9p93aY0WRZd07ZKYb9BXnIX99JMkm2KUb9qTuebWrWqvnE/7Hm5GT+GOiGY25Jhifs+/DUjcy+54eh0RhScpJ59DJcx/7E3rtJa0fZqlIotogPMOGlW2hMG+lT6ia3eroaK9u4nYDyaKDlgpynfMDEWSWZ3y5b7cYVSdrQPGdRgcRGARJO31+ccd0mmmEiJrKddcbPQrhNK+B1wkjakhpaAi2Xh3GqmHDCfdhxpR6+BxrfvoI2NgdH8+Up1Dg=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW4PR10MB6535.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(376002)(346002)(39860400002)(136003)(366004)(396003)(186006)(1800799006)(451199021)(31686004)(54906003)(26005)(38100700002)(53546011)(6506007)(6486002)(2616005)(8936002)(36916002)(8676002)(66574015)(478600001)(86362001)(31696002)(66946007)(66476007)(4326008)(66556008)(6916009)(6512007)(966005)(41300700001)(316002)(2906002)(30864003)(36756003)(5660300002)(83380400001)(6666004)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dWxHVWhQVEx6NmUvaW1JMWpCMzdSRWcrQjRyR3EwNDhZSmpqcEtYUHZaNTBs?=
 =?utf-8?B?ZXQ3czZyQXpSdThJSTVCdy9RNjVQUmR2L2tod3Z5Mk42VHdyV0tkOXhSYTRa?=
 =?utf-8?B?Q0Jzc2kzbng0U2VsZlU2K0tzWG5sakU3WTBIa1lXbzMwdHBMVkhRV1pzWTQ3?=
 =?utf-8?B?bXNzVjVUckNONWRONW01Q3JiYnRWUGVoYkZBOEFoMnloS2gwblBPWFdzT2dI?=
 =?utf-8?B?NEJWV0h2NTNSbkcvZVlpbE1qb2cweTlYaXJ1N1FheXQ4MG01azNXZSt4SlV6?=
 =?utf-8?B?emR1RmF2MUpaZWYvTTBOUTBDcG5IeGhCek9CVjI4ZjZGOWUzVEdrcldYbFJu?=
 =?utf-8?B?WnVHdmJDUGF2NHpmUlVyMXFQR3RsUmh6MTNXejVVV3Jhbjc2NldWUW1LcVor?=
 =?utf-8?B?RjVjZVZTcXFldjN6NGdsZlczQTJ2MGIzV0JRanhqVVMzcmtXOWNFazlGRTJW?=
 =?utf-8?B?d0tSZ1dqbEJkcElBK3JaeklGYzB0MTc3QjJ6TXpZUXZNMHAvNDdKV1U3VEhI?=
 =?utf-8?B?RU56NHo2WGlUcUtCcWNlQmNadGxydjhaK3E4ODQ5bGJ4TjlvWk5TNGxlTWUz?=
 =?utf-8?B?WEVZOXNxOXFwd2RVNmllQndGQVI4Qm92YU8xeVFVZHpwdTBIaUdMdWtYdTBq?=
 =?utf-8?B?ZG1XZzdnelBmWm1wMStKZ2Z2VjNqNHJiWDgrcitKdjRNQk1wYWJEM0tycDQ5?=
 =?utf-8?B?TmRYN2RtdFQzVTJ5VVc5YjREa0psdE5OWTRKeTBhSWJBdVZzd1RoektkVlc1?=
 =?utf-8?B?YjdvRHZSOVhjdjlaMjA5V1hLbTNLaTh6S09UaWh1bU41ZHdCaW9XMXhwZ0Uw?=
 =?utf-8?B?UlpzcHBod2dDMzVoSmhsa0JJQ2NQblJWMTNCNTRoLzFtQkVrZ2VsamhyYlZO?=
 =?utf-8?B?L2ZkdE80S05NeWJZWnZFT013ODlEMGc3UVROQXA4NHowUTRZV04rRkM2Unl1?=
 =?utf-8?B?akp0Q3JDcnl2UW1Ddk1TTkYzbmxMTUtHaTdUYXpZTzY0MFhXQTRkQ2RucWpl?=
 =?utf-8?B?Z2JmOTd2bnhQUHN3d0RJS3ZpNVVXUmxETUw5SXZRRENBMWEzaS9YR1l3SmNh?=
 =?utf-8?B?a0cyOVF3NHB5OHhGMG5PYVBkbU5UYVhzMGltemlDY3B1QlFHT3hFTWl1dm82?=
 =?utf-8?B?REFJQmxvZ0VUYk1hYTFHdmtjTHUvSXJ0VW9iUGU3UXhqYnVXaFJvWml2RFZs?=
 =?utf-8?B?UnArVWEvV2l1QmgzMTlSbEtSejBtd1dXLy9xUS8xNkRmSURpRjMvRU1nNUYx?=
 =?utf-8?B?elB6YUlmZ3g2OHNjS2ZxOGN6NEdnWDFwWmJxL2xDdy84VmVheit3WGNoTUs4?=
 =?utf-8?B?L3pDcHFuYWdGeFdrbmozU0N4d3Y1LzZ2ZWZWUVFLTU03ZGpobE8wWnNZN2ZJ?=
 =?utf-8?B?RUNwYStiTkdBOUZieWdsdkVUK2cyWXdGWnhqeEowWSs0d2R5NnlWUG5Wem9n?=
 =?utf-8?B?VW9oNlY2bXpEUDNyV0tPVjk0Y1JuUlNiaXZEajRSWlQ1RUlVdHp3M2VzV1lI?=
 =?utf-8?B?RUV5VnIxS2pWSHRrRGNxb0U4YjM1bHlrdkNqaHVMK3dDdGtoTjNPdjduRXBT?=
 =?utf-8?B?RVVuc0FkUUFqL2NNdzFnb09SdTlpeVJVa21yQ3U0bTVIclE0eFNXRU1IT3BF?=
 =?utf-8?B?RzZTMHdiQmdmUWhlbmlSaTJPb3lOZXBXNXFHaHpqOS9IQTh4NWFsT1IrdWVC?=
 =?utf-8?B?akI2a211Qnc3VEd2UGJpWmFWWndVeHU0OGxmZ00wKzluNEllU3VrVmNTM0Fh?=
 =?utf-8?B?QTVKS21Qd0tNbE9henVnMUpHZlkxeGttdG9FS3NtdkhnRGNkKzJzbTU2NE9w?=
 =?utf-8?B?SERrSDd4bkozRHV5dEZ5VkhkWlhJQzhhcWRHY0d5VWorVVlVZzlGVUY4c2dI?=
 =?utf-8?B?Mm9QRGxXNFZ5TEt3REt5Q2NFRUtyY2ZnTElLdDY0VFNKWmQwY3ZjMHRPNDds?=
 =?utf-8?B?Q0E5NGw4YzdRR1hNSjhtb1NlVXR0ampERCtDeUNrdTVSV0hnZm5EaXFIM29J?=
 =?utf-8?B?MDU1OTJOdzlOWXVMTnNvZnJBcXViVGluRUpSZStGWnZpbFJKdFpoRnhNR3hv?=
 =?utf-8?B?NjRaK0Y3bnBxcWRsL0MwNWpsZ3gzWWRxT200MGJHR2IxOXNnVHA5Q3hEU3pk?=
 =?utf-8?Q?c1YaWUXY6jtqNpeUyyzd7N0y2?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?dWRxdGl0RmVRMitpT3crMHBBa3Qrd3JMZVRXWGxjVC9xNjB4blhaTVdNeStp?=
 =?utf-8?B?c3JPTjg1cHJQZ0RzYjE3dCtnUHRpM1BySmovNjErYUxtSDBhOHZJRVhNQVpT?=
 =?utf-8?B?S0RjVnRXNytSakczNnFxaUVkSlAramNhcFYzdVlyZTFKTndLRWFsaHdaaHBD?=
 =?utf-8?B?ZCtDVjA5QkU1UFNudEd6VjR1aC9ldjduc2M0UFRDeWMrRklseWloTGNJdEgy?=
 =?utf-8?B?NWNTcmQ0djVtU1Y4c1lWbmNqQUxkUzhiY2Z1NVdDenh2YnpYTUlXRVlYWEtt?=
 =?utf-8?B?ZzZSeXJFbEplSWE5MEJhcGx3WkZsTFJMbVpLU0lJbkFtVUR0OFFubk9uL2Z4?=
 =?utf-8?B?T1dtbW1MZlg5ekUwQThSREpZN3dhTk1vcVNydnM4empaUy9VVE5ONlFhdUdQ?=
 =?utf-8?B?eFFSeThxRzkxS1FsZDUwb3FYZm5KRFNZMk93QThXc01WY1R5V3plTTNBaVhN?=
 =?utf-8?B?WEFHZXFTSXF3SWhOQmdkMitqRE91dWZMUDI3OERkVUszNmx5N01kalMySzlk?=
 =?utf-8?B?VDFMMjJVVTE0VVJyRmVSU080L0wzdDZFV3FDRjljYU9LNGtFSUJ5MHUvL3dq?=
 =?utf-8?B?NnFvdVpObzBjNHZpVlRYUnByZURiRU9KQUhWZEpuSGhlTWZSSWF5OThtTmx1?=
 =?utf-8?B?R1FwTDlOeU9NaHFPSEdvT2QzejY0ZkI5b01BNHJIWkNwVnorUURELzVPMnhP?=
 =?utf-8?B?ZVU2SjVkZktwZXpFbldSWVpINGhVWGRTdDZhbzN1eUpubnpUQUFqQ2tNK0hy?=
 =?utf-8?B?aVVQbC9yN2tVRHZmVmd4RVlOYlMxVjNYRVdyN0ZlLzFkRC9RYm1IaXRqMG0w?=
 =?utf-8?B?bjk1UmZrVzV4UnRveDI4akdtRkpwWWhxR0dCdHJwWjBUdWdvdTJUYm9WQXF1?=
 =?utf-8?B?eVJha3I2RDBuSFUwZ3RvdVFVZnI3aHNNYmVnMEtYTmNYbmFDb1VXVHhJcTBR?=
 =?utf-8?B?Q2t5djVPT1UySTlFVkxkSnVyMlF0WTRPaTQ4RHpmRWo0RVRWRzdkVEc2L0xZ?=
 =?utf-8?B?cFhxY0xkZWYvVzM0TTV5NWVQRFA1MEkwaWJjbFFtY05wakJDdzJvaTFZTzlz?=
 =?utf-8?B?bTVVT1VFWHhLZTdaQjhNSjNMUWhsRW1OT0crOC9sZWdpUXdQMUkzSzlqSHN2?=
 =?utf-8?B?K0dnQkxObW1SeTMvdUtPaXhobjgrdG13SXN4K1A4a1VJUUlRNmlpdnJIcE9N?=
 =?utf-8?B?ZktKcllQamVKdWt6T3BicjkrWVpxZWJBcXBud2ZHQXoxSGFJVUE2ZVFYb3By?=
 =?utf-8?Q?jdEiFJtUO+/XV8+?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 906112e0-604b-45a4-80ec-08db99f010fb
X-MS-Exchange-CrossTenant-AuthSource: MW4PR10MB6535.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Aug 2023 22:20:56.3985 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JLoUmlHhlHScgdwX5ZfLoQEr1YjotSvA6bJQPEeD2vk+4vmbokglak6nxIWtC/QpspF8aLSCyqnEL2vJZNwkDQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR10MB7336
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-08-10_16,2023-08-10_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0
 malwarescore=0 spamscore=0
 adultscore=0 mlxlogscore=999 bulkscore=0 phishscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2306200000
 definitions=main-2308100192
X-Proofpoint-GUID: jutxMMzJbqRzwEKcICQtzwifD5GErJGh
X-Proofpoint-ORIG-GUID: jutxMMzJbqRzwEKcICQtzwifD5GErJGh
Cc: Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, linux-kernel@vger.kernel.org,
 Gal Pressman <gal@nvidia.com>, virtualization@lists.linux-foundation.org,
 =?UTF-8?Q?Eugenio_P=c3=a9rez?= <eperezma@redhat.com>
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

CgpPbiA4LzkvMjAyMyA4OjEwIFBNLCBKYXNvbiBXYW5nIHdyb3RlOgo+IE9uIFRodSwgQXVnIDEw
LCAyMDIzIGF0IDg6NDDigK9BTSBTaS1XZWkgTGl1IDxzaS13ZWkubGl1QG9yYWNsZS5jb20+IHdy
b3RlOgo+Pgo+Pgo+PiBPbiA4LzgvMjAyMyAxMTo1MiBQTSwgSmFzb24gV2FuZyB3cm90ZToKPj4+
IE9uIFdlZCwgQXVnIDksIDIwMjMgYXQgNjo1OOKAr0FNIFNpLVdlaSBMaXUgPHNpLXdlaS5saXVA
b3JhY2xlLmNvbT4gd3JvdGU6Cj4+Pj4KPj4+PiBPbiA4LzcvMjAyMyA4OjAwIFBNLCBKYXNvbiBX
YW5nIHdyb3RlOgo+Pj4+PiBPbiBGcmksIEF1ZyA0LCAyMDIzIGF0IDE6NTjigK9BTSBTaS1XZWkg
TGl1IDxzaS13ZWkubGl1QG9yYWNsZS5jb20+IHdyb3RlOgo+Pj4+Pj4gT24gOC8zLzIwMjMgMTow
MyBBTSwgSmFzb24gV2FuZyB3cm90ZToKPj4+Pj4+PiBPbiBUaHUsIEF1ZyAzLCAyMDIzIGF0IDE6
MTPigK9BTSBEcmFnb3MgVGF0dWxlYSA8ZHRhdHVsZWFAbnZpZGlhLmNvbT4gd3JvdGU6Cj4+Pj4+
Pj4+IFRoZSBtci0+aW5pdGlhbGl6ZWQgZmxhZyBpcyBzaGFyZWQgYmV0d2VlbiB0aGUgY29udHJv
bCB2cSBhbmQgZGF0YSB2cQo+Pj4+Pj4+PiBwYXJ0IG9mIHRoZSBtciBpbml0L3VuaW5pdC4gQnV0
IGlmIHRoZSBjb250cm9sIHZxIGFuZCBkYXRhIHZxIGdldCBwbGFjZWQKPj4+Pj4+Pj4gaW4gZGlm
ZmVyZW50IEFTSURzLCBpdCBjYW4gaGFwcGVuIHRoYXQgaW5pdGlhbGl6aW5nIHRoZSBjb250cm9s
IHZxIHdpbGwKPj4+Pj4+Pj4gcHJldmVudCB0aGUgZGF0YSB2cSBtciBmcm9tIGJlaW5nIGluaXRp
YWxpemVkLgo+Pj4+Pj4+Pgo+Pj4+Pj4+PiBUaGlzIHBhdGNoIGNvbnNvbGlkYXRlcyB0aGUgY29u
dHJvbCBhbmQgZGF0YSB2cSBpbml0IHBhcnRzIGludG8gdGhlaXIKPj4+Pj4+Pj4gb3duIGluaXQg
ZnVuY3Rpb25zLiBUaGUgbXItPmluaXRpYWxpemVkIHdpbGwgbm93IGJlIHVzZWQgZm9yIHRoZSBk
YXRhIHZxCj4+Pj4+Pj4+IG9ubHkuIFRoZSBjb250cm9sIHZxIGN1cnJlbnRseSBkb2Vzbid0IG5l
ZWQgYSBmbGFnLgo+Pj4+Pj4+Pgo+Pj4+Pj4+PiBUaGUgdW5pbml0aWFsaXppbmcgcGFydCBpcyBh
bHNvIHRha2VuIGNhcmUgb2Y6IG1seDVfdmRwYV9kZXN0cm95X21yIGdvdAo+Pj4+Pj4+PiBzcGxp
dCBpbnRvIGRhdGEgYW5kIGNvbnRyb2wgdnEgZnVuY3Rpb25zIHdoaWNoIGFyZSBub3cgYWxzbyBB
U0lEIGF3YXJlLgo+Pj4+Pj4+Pgo+Pj4+Pj4+PiBGaXhlczogOGZjZDIwYzMwNzA0ICgidmRwYS9t
bHg1OiBTdXBwb3J0IGRpZmZlcmVudCBhZGRyZXNzIHNwYWNlcyBmb3IgY29udHJvbCBhbmQgZGF0
YSIpCj4+Pj4+Pj4+IFNpZ25lZC1vZmYtYnk6IERyYWdvcyBUYXR1bGVhIDxkdGF0dWxlYUBudmlk
aWEuY29tPgo+Pj4+Pj4+PiBSZXZpZXdlZC1ieTogRXVnZW5pbyBQw6lyZXogPGVwZXJlem1hQHJl
ZGhhdC5jb20+Cj4+Pj4+Pj4+IFJldmlld2VkLWJ5OiBHYWwgUHJlc3NtYW4gPGdhbEBudmlkaWEu
Y29tPgo+Pj4+Pj4+PiAtLS0KPj4+Pj4+Pj4gICAgICBkcml2ZXJzL3ZkcGEvbWx4NS9jb3JlL21s
eDVfdmRwYS5oIHwgIDEgKwo+Pj4+Pj4+PiAgICAgIGRyaXZlcnMvdmRwYS9tbHg1L2NvcmUvbXIu
YyAgICAgICAgfCA5NyArKysrKysrKysrKysrKysrKysrKystLS0tLS0tLS0KPj4+Pj4+Pj4gICAg
ICAyIGZpbGVzIGNoYW5nZWQsIDcxIGluc2VydGlvbnMoKyksIDI3IGRlbGV0aW9ucygtKQo+Pj4+
Pj4+Pgo+Pj4+Pj4+PiBkaWZmIC0tZ2l0IGEvZHJpdmVycy92ZHBhL21seDUvY29yZS9tbHg1X3Zk
cGEuaCBiL2RyaXZlcnMvdmRwYS9tbHg1L2NvcmUvbWx4NV92ZHBhLmgKPj4+Pj4+Pj4gaW5kZXgg
MjVmYzQxMjBiNjE4Li5hMDQyMGJlNTA1OWYgMTAwNjQ0Cj4+Pj4+Pj4+IC0tLSBhL2RyaXZlcnMv
dmRwYS9tbHg1L2NvcmUvbWx4NV92ZHBhLmgKPj4+Pj4+Pj4gKysrIGIvZHJpdmVycy92ZHBhL21s
eDUvY29yZS9tbHg1X3ZkcGEuaAo+Pj4+Pj4+PiBAQCAtMzEsNiArMzEsNyBAQCBzdHJ1Y3QgbWx4
NV92ZHBhX21yIHsKPj4+Pj4+Pj4gICAgICAgICAgICAgc3RydWN0IGxpc3RfaGVhZCBoZWFkOwo+
Pj4+Pj4+PiAgICAgICAgICAgICB1bnNpZ25lZCBsb25nIG51bV9kaXJlY3RzOwo+Pj4+Pj4+PiAg
ICAgICAgICAgICB1bnNpZ25lZCBsb25nIG51bV9rbG1zOwo+Pj4+Pj4+PiArICAgICAgIC8qIHN0
YXRlIG9mIGR2cSBtciAqLwo+Pj4+Pj4+PiAgICAgICAgICAgICBib29sIGluaXRpYWxpemVkOwo+
Pj4+Pj4+Pgo+Pj4+Pj4+PiAgICAgICAgICAgICAvKiBzZXJpYWxpemUgbWtleSBjcmVhdGlvbiBh
bmQgZGVzdHJ1Y3Rpb24gKi8KPj4+Pj4+Pj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvdmRwYS9tbHg1
L2NvcmUvbXIuYyBiL2RyaXZlcnMvdmRwYS9tbHg1L2NvcmUvbXIuYwo+Pj4+Pj4+PiBpbmRleCAw
M2U1NDMyMjk3OTEuLjRhZTE0YTI0OGE0YiAxMDA2NDQKPj4+Pj4+Pj4gLS0tIGEvZHJpdmVycy92
ZHBhL21seDUvY29yZS9tci5jCj4+Pj4+Pj4+ICsrKyBiL2RyaXZlcnMvdmRwYS9tbHg1L2NvcmUv
bXIuYwo+Pj4+Pj4+PiBAQCAtNDg5LDYwICs0ODksMTAzIEBAIHN0YXRpYyB2b2lkIGRlc3Ryb3lf
dXNlcl9tcihzdHJ1Y3QgbWx4NV92ZHBhX2RldiAqbXZkZXYsIHN0cnVjdCBtbHg1X3ZkcGFfbXIg
Km1yCj4+Pj4+Pj4+ICAgICAgICAgICAgIH0KPj4+Pj4+Pj4gICAgICB9Cj4+Pj4+Pj4+Cj4+Pj4+
Pj4+IC12b2lkIG1seDVfdmRwYV9kZXN0cm95X21yKHN0cnVjdCBtbHg1X3ZkcGFfZGV2ICptdmRl
dikKPj4+Pj4+Pj4gK3N0YXRpYyB2b2lkIF9tbHg1X3ZkcGFfZGVzdHJveV9jdnFfbXIoc3RydWN0
IG1seDVfdmRwYV9kZXYgKm12ZGV2LCB1bnNpZ25lZCBpbnQgYXNpZCkKPj4+Pj4+Pj4gK3sKPj4+
Pj4+Pj4gKyAgICAgICBpZiAobXZkZXYtPmdyb3VwMmFzaWRbTUxYNV9WRFBBX0NWUV9HUk9VUF0g
IT0gYXNpZCkKPj4+Pj4+Pj4gKyAgICAgICAgICAgICAgIHJldHVybjsKPj4+Pj4+Pj4gKwo+Pj4+
Pj4+PiArICAgICAgIHBydW5lX2lvdGxiKG12ZGV2KTsKPj4+Pj4+Pj4gK30KPj4+Pj4+Pj4gKwo+
Pj4+Pj4+PiArc3RhdGljIHZvaWQgX21seDVfdmRwYV9kZXN0cm95X2R2cV9tcihzdHJ1Y3QgbWx4
NV92ZHBhX2RldiAqbXZkZXYsIHVuc2lnbmVkIGludCBhc2lkKQo+Pj4+Pj4+PiAgICAgIHsKPj4+
Pj4+Pj4gICAgICAgICAgICAgc3RydWN0IG1seDVfdmRwYV9tciAqbXIgPSAmbXZkZXYtPm1yOwo+
Pj4+Pj4+Pgo+Pj4+Pj4+PiAtICAgICAgIG11dGV4X2xvY2soJm1yLT5ta2V5X210eCk7Cj4+Pj4+
Pj4+ICsgICAgICAgaWYgKG12ZGV2LT5ncm91cDJhc2lkW01MWDVfVkRQQV9EQVRBVlFfR1JPVVBd
ICE9IGFzaWQpCj4+Pj4+Pj4+ICsgICAgICAgICAgICAgICByZXR1cm47Cj4+Pj4+Pj4+ICsKPj4+
Pj4+Pj4gICAgICAgICAgICAgaWYgKCFtci0+aW5pdGlhbGl6ZWQpCj4+Pj4+Pj4+IC0gICAgICAg
ICAgICAgICBnb3RvIG91dDsKPj4+Pj4+Pj4gKyAgICAgICAgICAgICAgIHJldHVybjsKPj4+Pj4+
Pj4KPj4+Pj4+Pj4gLSAgICAgICBwcnVuZV9pb3RsYihtdmRldik7Cj4+Pj4+Pj4+ICAgICAgICAg
ICAgIGlmIChtci0+dXNlcl9tcikKPj4+Pj4+Pj4gICAgICAgICAgICAgICAgICAgICBkZXN0cm95
X3VzZXJfbXIobXZkZXYsIG1yKTsKPj4+Pj4+Pj4gICAgICAgICAgICAgZWxzZQo+Pj4+Pj4+PiAg
ICAgICAgICAgICAgICAgICAgIGRlc3Ryb3lfZG1hX21yKG12ZGV2LCBtcik7Cj4+Pj4+Pj4+Cj4+
Pj4+Pj4+ICAgICAgICAgICAgIG1yLT5pbml0aWFsaXplZCA9IGZhbHNlOwo+Pj4+Pj4+PiAtb3V0
Ogo+Pj4+Pj4+PiArfQo+Pj4+Pj4+PiArCj4+Pj4+Pj4+ICtzdGF0aWMgdm9pZCBtbHg1X3ZkcGFf
ZGVzdHJveV9tcl9hc2lkKHN0cnVjdCBtbHg1X3ZkcGFfZGV2ICptdmRldiwgdW5zaWduZWQgaW50
IGFzaWQpCj4+Pj4+Pj4+ICt7Cj4+Pj4+Pj4+ICsgICAgICAgc3RydWN0IG1seDVfdmRwYV9tciAq
bXIgPSAmbXZkZXYtPm1yOwo+Pj4+Pj4+PiArCj4+Pj4+Pj4+ICsgICAgICAgbXV0ZXhfbG9jaygm
bXItPm1rZXlfbXR4KTsKPj4+Pj4+Pj4gKwo+Pj4+Pj4+PiArICAgICAgIF9tbHg1X3ZkcGFfZGVz
dHJveV9kdnFfbXIobXZkZXYsIGFzaWQpOwo+Pj4+Pj4+PiArICAgICAgIF9tbHg1X3ZkcGFfZGVz
dHJveV9jdnFfbXIobXZkZXYsIGFzaWQpOwo+Pj4+Pj4+PiArCj4+Pj4+Pj4+ICAgICAgICAgICAg
IG11dGV4X3VubG9jaygmbXItPm1rZXlfbXR4KTsKPj4+Pj4+Pj4gICAgICB9Cj4+Pj4+Pj4+Cj4+
Pj4+Pj4+IC1zdGF0aWMgaW50IF9tbHg1X3ZkcGFfY3JlYXRlX21yKHN0cnVjdCBtbHg1X3ZkcGFf
ZGV2ICptdmRldiwKPj4+Pj4+Pj4gLSAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBzdHJ1
Y3Qgdmhvc3RfaW90bGIgKmlvdGxiLCB1bnNpZ25lZCBpbnQgYXNpZCkKPj4+Pj4+Pj4gK3ZvaWQg
bWx4NV92ZHBhX2Rlc3Ryb3lfbXIoc3RydWN0IG1seDVfdmRwYV9kZXYgKm12ZGV2KQo+Pj4+Pj4+
PiArewo+Pj4+Pj4+PiArICAgICAgIG1seDVfdmRwYV9kZXN0cm95X21yX2FzaWQobXZkZXYsIG12
ZGV2LT5ncm91cDJhc2lkW01MWDVfVkRQQV9DVlFfR1JPVVBdKTsKPj4+Pj4+Pj4gKyAgICAgICBt
bHg1X3ZkcGFfZGVzdHJveV9tcl9hc2lkKG12ZGV2LCBtdmRldi0+Z3JvdXAyYXNpZFtNTFg1X1ZE
UEFfREFUQVZRX0dST1VQXSk7Cj4+Pj4+Pj4+ICt9Cj4+Pj4+Pj4+ICsKPj4+Pj4+Pj4gK3N0YXRp
YyBpbnQgX21seDVfdmRwYV9jcmVhdGVfY3ZxX21yKHN0cnVjdCBtbHg1X3ZkcGFfZGV2ICptdmRl
diwKPj4+Pj4+Pj4gKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgc3RydWN0IHZo
b3N0X2lvdGxiICppb3RsYiwKPj4+Pj4+Pj4gKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgdW5zaWduZWQgaW50IGFzaWQpCj4+Pj4+Pj4+ICt7Cj4+Pj4+Pj4+ICsgICAgICAgaWYg
KG12ZGV2LT5ncm91cDJhc2lkW01MWDVfVkRQQV9DVlFfR1JPVVBdICE9IGFzaWQpCj4+Pj4+Pj4+
ICsgICAgICAgICAgICAgICByZXR1cm4gMDsKPj4+Pj4+Pj4gKwo+Pj4+Pj4+PiArICAgICAgIHJl
dHVybiBkdXBfaW90bGIobXZkZXYsIGlvdGxiKTsKPj4+Pj4+PiBUaGlzIHdvcnJpZXMgbWUgYXMg
Y29uY2VwdHVhbGx5LCB0aGVyZSBzaG91bGQgYmUgbm8gZGlmZmVyZW5jZSBiZXR3ZWVuCj4+Pj4+
Pj4gZHZxIG1yIGFuZCBjdnEgbXIuIFRoZSB2aXJ0cXVldWUgc2hvdWxkIGJlIGxvb3NlbHkgY291
cGxlZCB3aXRoIG1yLgo+Pj4+Pj4+Cj4+Pj4+Pj4gT25lIGV4YW1wbGUgaXMgdGhhdCwgaWYgd2Ug
b25seSBkbyBkdXBfaW90bGIoKSBidXQgbm90IHRyeSB0byBjcmVhdGUKPj4+Pj4+PiBkbWEgbXIg
aGVyZSwgd2Ugd2lsbCBicmVhayB2aXJ0aW8tdmRwYToKPj4+Pj4+IEZvciB0aGlzIGNhc2UsIEkg
Z3Vlc3Mgd2UgbWF5IG5lZWQgYW5vdGhlciB3YXkgdG8gc3VwcG9ydCB2aXJ0aW8tdmRwYQo+Pj4+
Pj4gMToxIG1hcHBpbmcgcmF0aGVyIHRoYW4gb3ZlcmxvYWRpbmcgdmlydGlvIGRldmljZSByZXNl
dCBzZW1hbnRpY3MsIHNlZToKPj4+Pj4+Cj4+Pj4+PiBodHRwczovL3d3dy5tYWlsLWFyY2hpdmUu
Y29tL3FlbXUtZGV2ZWxAbm9uZ251Lm9yZy9tc2c5NTM3NTUuaHRtbAo+Pj4+Pj4KPj4+Pj4+ICAg
ICA+IENvbmNlcHR1YWxseSwgdGhlIGFkZHJlc3MgbWFwcGluZyBpcyBub3QgYSBwYXJ0IG9mIHRo
ZSBhYnN0cmFjdGlvbiBmb3IKPj4+Pj4+ICAgICA+IGEgdmlydGlvIGRldmljZSBub3cuIFNvIHJl
c2V0dGluZyB0aGUgbWVtb3J5IG1hcHBpbmcgZHVyaW5nIHZpcnRpbwo+Pj4+Pj4gICAgID4gZGV2
aWNlIHJlc2V0IHNlZW1zIHdyb25nLgo+Pj4+Pj4KPj4+Pj4+IHdoZXJlIHdlIHdhbnQgdG8ga2Vl
cCBtZW1vcnkgbWFwcGluZyBpbnRhY3QgYWNyb3NzIHZpcnRpbyBkZXZpY2UgcmVzZXQKPj4+Pj4+
IGZvciBiZXN0IGxpdmUgbWlncmF0aW9uIGxhdGVuY3kvZG93bnRpbWUuIEkgd29uZGVyIHdvdWxk
IGl0IHdvcmsgdG8KPj4+Pj4+IHJlc2V0IHRoZSBtYXBwaW5nIGluIHZob3N0LXZkcGEgbGlmZSBj
eWNsZSBvdXQgb2YgdmlydGlvIHJlc2V0LCBzYXkKPj4+Pj4+IGludHJvZHVjZSBhIC5yZXNldF9t
YXAoKSBvcCB0byByZXN0b3JlIDE6MSBtYXBwaW5nIHdpdGhpbgo+Pj4+Pj4gdmhvc3RfdmRwYV9y
ZW1vdmVfYXMoKSByaWdodCBhZnRlciB2aG9zdF92ZHBhX2lvdGxiX3VubWFwKCk/IFRoZW4gd2Ug
Y2FuCj4+Pj4+PiBtb3ZlIHRoZSBpb3RsYiByZXNldCBsb2dpYyB0byB0aGVyZSB3aXRob3V0IHdv
cnJ5IGJyZWFraW5nIHZpcnRpby12ZHBhLgo+Pj4+PiBJdCBsb29rcyB0byBtZSB3ZSBkb24ndCBu
ZWVkIGEgbmV3IG9wcy4gV2UgY2FuIHNpbXBseSBkbyBzZXRfbWFwKCkKPj4+Pj4gdHdpY2UKPj4+
PiBXaGF0IGRvZXMgaXQgbWVhbiwgZmlyc3Qgc2V0X21hcCgwLCAtMVVMTCkgd2l0aCB6ZXJvIGlv
dGxiIGVudHJ5IHBhc3NlZAo+Pj4+IGluIHRvIGRlc3Ryb3kgYWxsIGlvdGxiIG1hcHBpbmdzIHBy
ZXZpb3VzbHkgYWRkZWQsIGFuZCBzZWNvbmQgc2V0X21hcCgwLAo+Pj4+IC0xVUxMKSB0byByZXN0
b3JlIDE6MSBETUEgTVI/IEJ1dCB1c2Vyc3BhY2UgKG1heWJlIGEgYnVnZ3kgb25lIGJ1dAo+Pj4+
IGRvZXNuJ3QgZG8gaGFybSkgYXBhcnQgZnJvbSB2aG9zdC12ZHBhIGl0c2VsZiBjYW4gZG8gdW5t
YXAgdHdpY2UgYW55d2F5LAo+Pj4+IHRoaXMgaXMgc3VwcG9ydGVkIHRvZGF5IEkgdGhpbmsuIFdo
eSB0aGVyZSdsbCBiZSBzdWNoIG9ic2N1cmUKPj4+PiBkaXN0aW5jdGlvbiwgb3Igd2hhdCdzIHRo
ZSBiZW5lZml0IHRvIHRyZWF0IHNlY29uZCAuc2V0X21hcCgpIGFzCj4+Pj4gcmVjcmVhdGluZyAx
OjEgbWFwcGluZz8KPj4+IE9rLCBJIHRoaW5rIEkgbWlzcyBzb21lIGNvbnRleHQuIEkgYWdyZWUg
dGhhdCBpdCdzIGJldHRlciB0byBkZWNvdXBsZQo+Pj4gbWVtb3J5IG1hcHBpbmdzIGZyb20gdGhl
IHZpcnRpbyByZXNldC4gSXQgaGVscHMgdG8gcmVkdWNlIHRoZQo+Pj4gdW5uZWNlc3NhcnkgbWVt
b3J5IHRyYW5zYWN0aW9ucy4gSXQgbWlnaHQgcmVxdWlyZSBhIG5ldyBmZWF0dXJlIGZsYWcuCj4+
IFRoaXMgSSBhZ3JlZWQuIEFGQUlDVCBRRU1VIHdvdWxkIG5lZWQgdG8gY2hlY2sgdGhpcyBuZXcg
ZmVhdHVyZSBmbGFnIHRvCj4+IG1ha2Ugc3VyZSBtZW1vcnkgbWFwcGluZ3MgYXJlIGtlcHQgaW50
YWN0IGFjcm9zcyByZXNldCwgb3RoZXJ3aXNlIGZvcgo+PiB0aGUgc2FrZSBvZiBhdm9pZCBicmVh
a2luZyBvbGRlciBrZXJuZWxzIGl0IGhhcyB0byByZWNyZWF0ZSBhbGwgdGhlCj4+IG1hcHBpbmdz
IGFmdGVyIHJlc2V0IGxpa2UgaG93IGl0IGlzIGRvbmUgdG9kYXkuCj4+Cj4+PiBSZWdhcmRpbmcg
dGhlIG1ldGhvZCBvZiByZXN0b3JpbmcgdG8gMToxIERNQSBNUiwgaXQgbWlnaHQgYmUgZGFuZ2Vy
b3VzCj4+PiBmb3IgKGJ1Z2d5KSB2aG9zdC12RFBBIGRldmljZXMuIFNpbmNlIGl0cyB1c2Vyc3Bh
Y2UgZG9lc24ndCBzZXQgdXAgYW55Cj4+PiBtYXBwaW5nIGl0IGNhbiBleHBsb3JlIHRoZSBrZXJu
ZWwgd2l0aCB0aGF0IHZpYSBDVlE/Cj4+IE5vdCBzdXJlIEkgdW5kZXJzdGFuZCB0aGlzIHByb3Bv
c2FsLiBUaGUgMToxIERNQSBNUiBpcyBmaXJzdCBjcmVhdGVkIGF0Cj4+IHZkcGEgZGV2aWNlIGFk
ZCwgYW5kIGdldHMgZGVzdHJveWVkIGltcGxpY2l0bHkgd2hlbiB0aGUgZmlyc3QgLnNldF9tYXAK
Pj4gb3IgLmRtYV9tYXAgY2FsbCBpcyBtYWRlLCB3aGljaCBpcyBvbmx5IHBvc3NpYmxlIGFmdGVy
IHRoZSB2aG9zdC12ZHBhCj4+IG1vZHVsZSBpcyBsb2FkZWQgYW5kIGJvdW5kIHRvIHZkcGEgZGV2
aWNlcy4KPiBTbyB3aGF0IGhhcHBlbnMgaWYgdGhlcmUncyBhIGJ1Z2d5IHVzZXJzcGFjZSB0aGF0
IGRvZXNuJ3QgZG8gYW55IElPVExCIHNldHVwPwpUaGVuIHBhcmVudCBkcml2ZXIgZG9lc24ndCBk
byBhbnl0aGluZyBpbiAucmVzZXRfbWFwKCkgLSBhcyB0aGUgRE1BIE1SIAppcyBzdGlsbCB0aGVy
ZS4gUGFyZW50IGRyaXZlciBzaG91bGQgYmUgYWJsZSB0byB0ZWxsIGFwYXJ0IGlmIERNQSBNUiBo
YXMgCmJlZW4gZGVzdHJveWVkIG9yIG5vdCBieSBjaGVja2luZyB0aGUgaW50ZXJuYWwgc3RhdGUu
CgotU2l3ZWkKCj4KPiBUaGFua3MKPgo+PiBOYXR1cmFsbHkgdGhlIERNQSBNUiBzaG91bGQKPj4g
YmUgcmVzdG9yZWQgdG8gaG93IGl0IHdhcyBiZWZvcmUgd2hlbiB2aG9zdC12ZHBhIG1vZHVsZSBp
cyB1bmxvYWRlZCwgb3IKPj4gaWYgYW55dGhpbmcgdGhlIDE6MSBETUEgTVIgY3JlYXRpb24gY2Fu
IGJlIGRlZmVycmVkIHRvIHVudGlsIHZpcnRpby12ZHBhCj4+IGlzIHByb2JlZCBhbmQgYm91bmQg
dG8gZGV2aWNlcy4gVG9kYXkgdmhvc3RfdmRwYV9yZW1vdmVfYXMoKSBhcyBwYXJ0IG9mCj4+IHRo
ZSB2aG9zdC12ZHBhIHVubG9hZCBjb2RlIHBhdGggYWxyZWFkeSBnZXRzIGFsbCBtYXBwaW5ncyBw
dXJnZWQgdGhyb3VnaAo+PiB2aG9zdF92ZHBhX2lvdGxiX3VubWFwKDAsIC0xVUxMKSwgYW5kIGl0
IHNob3VsZCBiZSBwcmV0dHkgc2FmZSB0bwo+PiByZXN0b3JlIERNQSBNUiB2aWEgLnJlc2V0X21h
cCgpIHJpZ2h0IGFmdGVyLiBOb3Qgc3VyZSB3aGF0J3MgdGhlIGNvbmNlcm4KPj4gaGVyZSB3aXRo
IGJ1Z2d5IHZob3N0LXZkcGEgZGV2aWNlPwo+Pgo+PiBOb3RlZCB3aGVuIHZob3N0LXZkcGEgaXMg
YmVpbmcgdW5sb2FkZWQgdGhlcmUncyBldmVuIG5vIGNoYW5jZSB0byBwcm9iZQo+PiBrZXJuZWwg
dGhyb3VnaCBDVlEsIGFzIHRoZSB2aXJ0aW8gZmVhdHVyZSBpcyBub3QgZXZlbiBuZWdvdGlhdGVk
IGF0IHRoYXQKPj4gcG9pbnQuIEFuZCBpdCBpcyBldmVuIHRyaWNraWVyIHRvIHdhaXQgZm9yIENW
USByZXNwb25zZSBmcm9tIGRldmljZQo+PiBpbmRlZmluaXRlbHkgd2hlbiB0cnlpbmcgdG8gdW5s
b2FkIGEgbW9kdWxlLgo+Pgo+PiBSZWdhcmRzLAo+PiAtU2l3ZWkKPj4+IFRoYW5rcwo+Pj4KPj4+
Pj4gICAgIG9yIGRvIHlvdSBtZWFuIGl0IHdvdWxkIGJlIGZhc3Rlcj8KPj4+PiBJIHRoaW5rIHdp
dGggLnJlc2V0X21hcCgpIHdlIGF0IGxlYXN0IGNhbiBhdm9pZCBpbmRlZmluaXRlIGxhdGVuY3kK
Pj4+PiBoaWNjdXAgZnJvbSBkZXN0cm95aW5nIGFuZCByZWNyZWF0aW5nIDE6MSBtYXBwaW5nIHdp
dGggdGhlIHVud2FycmFudGVkCj4+Pj4gMnJkIHVubWFwIGNhbGwuIEFuZCAucmVzZXRfbWFwKCkg
c2hvdWxkIHdvcmsgd2l0aCBib3RoIC5kbWFfbWFwKCkgYW5kCj4+Pj4gLnNldF9tYXAoKSBBUElz
IHdpdGggY2xlYXIgc2VtYW50aWNzLgo+Pj4+Cj4+Pj4gUmVnYXJkcywKPj4+PiAtU2l3ZWkKPj4+
Pj4gVGhhbmtzCj4+Pj4+Cj4+Pj4+PiBUaGFua3MsCj4+Pj4+PiAtU2l3ZWkKPj4+Pj4+Cj4+Pj4+
Pj4gY29tbWl0IDZmNTMxMmY4MDE4MzZlNmFmOWJjYmIwYmRiNDRkYzQyM2UxMjkyMDYKPj4+Pj4+
PiBBdXRob3I6IEVsaSBDb2hlbiA8ZWxpY0BudmlkaWEuY29tPgo+Pj4+Pj4+IERhdGU6ICAgV2Vk
IEp1biAyIDExOjU4OjU0IDIwMjEgKzAzMDAKPj4+Pj4+Pgo+Pj4+Pj4+ICAgICAgICAgdmRwYS9t
bHg1OiBBZGQgc3VwcG9ydCBmb3IgcnVubmluZyB3aXRoIHZpcnRpb192ZHBhCj4+Pj4+Pj4KPj4+
Pj4+PiAgICAgICAgIEluIG9yZGVyIHRvIHN1cHBvcnQgcnVubmluZyB2ZHBhIHVzaW5nIHZyaXRp
b192ZHBhIGRyaXZlciwgd2UgbmVlZCAgdG8KPj4+Pj4+PiAgICAgICAgIGNyZWF0ZSBhIGRpZmZl
cmVudCBraW5kIG9mIE1SLCBvbmUgdGhhdCBoYXMgMToxIG1hcHBpbmcsIHNpbmNlIHRoZQo+Pj4+
Pj4+ICAgICAgICAgYWRkcmVzc2VzIHJlZmVycmluZyB0byB2aXJ0cXVldWVzIGFyZSBkbWEgYWRk
cmVzc2VzLgo+Pj4+Pj4+Cj4+Pj4+Pj4gICAgICAgICBXZSBjcmVhdGUgdGhlIDE6MSBNUiBpbiBt
bHg1X3ZkcGFfZGV2X2FkZCgpIG9ubHkgaW4gY2FzZSBmaXJtd2FyZQo+Pj4+Pj4+ICAgICAgICAg
c3VwcG9ydHMgdGhlIGdlbmVyYWwgY2FwYWJpbGl0eSB1bWVtX3VpZF8wLiBUaGUgcmVhc29uIGZv
ciB0aGF0IGlzIHRoYXQKPj4+Pj4+PiAgICAgICAgIDE6MSBNUnMgbXVzdCBiZSBjcmVhdGVkIHdp
dGggdWlkID09IDAgd2hpbGUgdmlydHF1ZXVlIG9iamVjdHMgY2FuIGJlCj4+Pj4+Pj4gICAgICAg
ICBjcmVhdGVkIHdpdGggdWlkID09IDAgb25seSB3aGVuIHRoZSBmaXJtd2FyZSBjYXBhYmlsaXR5
IGlzIG9uLgo+Pj4+Pj4+Cj4+Pj4+Pj4gICAgICAgICBJZiB0aGUgc2V0X21hcCgpIGNhbGxiYWNr
IGlzIGNhbGxlZCB3aXRoIG5ldyB0cmFuc2xhdGlvbnMgcHJvdmlkZWQKPj4+Pj4+PiAgICAgICAg
IHRocm91Z2ggaW90bGIsIHRoZSBkcml2ZXIgd2lsbCBkZXN0cm95IHRoZSAxOjEgTVIgYW5kIGNy
ZWF0ZSBhIHJlZ3VsYXIKPj4+Pj4+PiAgICAgICAgIG9uZS4KPj4+Pj4+Pgo+Pj4+Pj4+ICAgICAg
ICAgU2lnbmVkLW9mZi1ieTogRWxpIENvaGVuIDxlbGljQG52aWRpYS5jb20+Cj4+Pj4+Pj4gICAg
ICAgICBMaW5rOiBodHRwczovL2xvcmUua2VybmVsLm9yZy9yLzIwMjEwNjAyMDg1ODU0LjYyNjkw
LTEtZWxpY0BudmlkaWEuY29tCj4+Pj4+Pj4gICAgICAgICBTaWduZWQtb2ZmLWJ5OiBNaWNoYWVs
IFMuIFRzaXJraW4gPG1zdEByZWRoYXQuY29tPgo+Pj4+Pj4+ICAgICAgICAgQWNrZWQtYnk6IEph
c29uIFdhbmcgPGphc293YW5nQHJlZGhhdC5jb20+Cj4+Pj4+Pj4KPj4+Pj4+PiBUaGFua3MKPj4+
Pj4+Pgo+Pj4+Pj4+Cj4+Pj4+Pj4+ICt9Cj4+Pj4+Pj4+ICsKPj4+Pj4+Pj4gK3N0YXRpYyBpbnQg
X21seDVfdmRwYV9jcmVhdGVfZHZxX21yKHN0cnVjdCBtbHg1X3ZkcGFfZGV2ICptdmRldiwKPj4+
Pj4+Pj4gKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgc3RydWN0IHZob3N0X2lv
dGxiICppb3RsYiwKPj4+Pj4+Pj4gKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
dW5zaWduZWQgaW50IGFzaWQpCj4+Pj4+Pj4+ICAgICAgewo+Pj4+Pj4+PiAgICAgICAgICAgICBz
dHJ1Y3QgbWx4NV92ZHBhX21yICptciA9ICZtdmRldi0+bXI7Cj4+Pj4+Pj4+ICAgICAgICAgICAg
IGludCBlcnI7Cj4+Pj4+Pj4+Cj4+Pj4+Pj4+IC0gICAgICAgaWYgKG1yLT5pbml0aWFsaXplZCkK
Pj4+Pj4+Pj4gKyAgICAgICBpZiAobXZkZXYtPmdyb3VwMmFzaWRbTUxYNV9WRFBBX0RBVEFWUV9H
Uk9VUF0gIT0gYXNpZCkKPj4+Pj4+Pj4gICAgICAgICAgICAgICAgICAgICByZXR1cm4gMDsKPj4+
Pj4+Pj4KPj4+Pj4+Pj4gLSAgICAgICBpZiAobXZkZXYtPmdyb3VwMmFzaWRbTUxYNV9WRFBBX0RB
VEFWUV9HUk9VUF0gPT0gYXNpZCkgewo+Pj4+Pj4+PiAtICAgICAgICAgICAgICAgaWYgKGlvdGxi
KQo+Pj4+Pj4+PiAtICAgICAgICAgICAgICAgICAgICAgICBlcnIgPSBjcmVhdGVfdXNlcl9tciht
dmRldiwgaW90bGIpOwo+Pj4+Pj4+PiAtICAgICAgICAgICAgICAgZWxzZQo+Pj4+Pj4+PiAtICAg
ICAgICAgICAgICAgICAgICAgICBlcnIgPSBjcmVhdGVfZG1hX21yKG12ZGV2LCBtcik7Cj4+Pj4+
Pj4+ICsgICAgICAgaWYgKG1yLT5pbml0aWFsaXplZCkKPj4+Pj4+Pj4gKyAgICAgICAgICAgICAg
IHJldHVybiAwOwo+Pj4+Pj4+Pgo+Pj4+Pj4+PiAtICAgICAgICAgICAgICAgaWYgKGVycikKPj4+
Pj4+Pj4gLSAgICAgICAgICAgICAgICAgICAgICAgcmV0dXJuIGVycjsKPj4+Pj4+Pj4gLSAgICAg
ICB9Cj4+Pj4+Pj4+ICsgICAgICAgaWYgKGlvdGxiKQo+Pj4+Pj4+PiArICAgICAgICAgICAgICAg
ZXJyID0gY3JlYXRlX3VzZXJfbXIobXZkZXYsIGlvdGxiKTsKPj4+Pj4+Pj4gKyAgICAgICBlbHNl
Cj4+Pj4+Pj4+ICsgICAgICAgICAgICAgICBlcnIgPSBjcmVhdGVfZG1hX21yKG12ZGV2LCBtcik7
Cj4+Pj4+Pj4+Cj4+Pj4+Pj4+IC0gICAgICAgaWYgKG12ZGV2LT5ncm91cDJhc2lkW01MWDVfVkRQ
QV9DVlFfR1JPVVBdID09IGFzaWQpIHsKPj4+Pj4+Pj4gLSAgICAgICAgICAgICAgIGVyciA9IGR1
cF9pb3RsYihtdmRldiwgaW90bGIpOwo+Pj4+Pj4+PiAtICAgICAgICAgICAgICAgaWYgKGVycikK
Pj4+Pj4+Pj4gLSAgICAgICAgICAgICAgICAgICAgICAgZ290byBvdXRfZXJyOwo+Pj4+Pj4+PiAt
ICAgICAgIH0KPj4+Pj4+Pj4gKyAgICAgICBpZiAoZXJyKQo+Pj4+Pj4+PiArICAgICAgICAgICAg
ICAgcmV0dXJuIGVycjsKPj4+Pj4+Pj4KPj4+Pj4+Pj4gICAgICAgICAgICAgbXItPmluaXRpYWxp
emVkID0gdHJ1ZTsKPj4+Pj4+Pj4gKwo+Pj4+Pj4+PiArICAgICAgIHJldHVybiAwOwo+Pj4+Pj4+
PiArfQo+Pj4+Pj4+PiArCj4+Pj4+Pj4+ICtzdGF0aWMgaW50IF9tbHg1X3ZkcGFfY3JlYXRlX21y
KHN0cnVjdCBtbHg1X3ZkcGFfZGV2ICptdmRldiwKPj4+Pj4+Pj4gKyAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICBzdHJ1Y3Qgdmhvc3RfaW90bGIgKmlvdGxiLCB1bnNpZ25lZCBpbnQgYXNp
ZCkKPj4+Pj4+Pj4gK3sKPj4+Pj4+Pj4gKyAgICAgICBpbnQgZXJyOwo+Pj4+Pj4+PiArCj4+Pj4+
Pj4+ICsgICAgICAgZXJyID0gX21seDVfdmRwYV9jcmVhdGVfZHZxX21yKG12ZGV2LCBpb3RsYiwg
YXNpZCk7Cj4+Pj4+Pj4+ICsgICAgICAgaWYgKGVycikKPj4+Pj4+Pj4gKyAgICAgICAgICAgICAg
IHJldHVybiBlcnI7Cj4+Pj4+Pj4+ICsKPj4+Pj4+Pj4gKyAgICAgICBlcnIgPSBfbWx4NV92ZHBh
X2NyZWF0ZV9jdnFfbXIobXZkZXYsIGlvdGxiLCBhc2lkKTsKPj4+Pj4+Pj4gKyAgICAgICBpZiAo
ZXJyKQo+Pj4+Pj4+PiArICAgICAgICAgICAgICAgZ290byBvdXRfZXJyOwo+Pj4+Pj4+PiArCj4+
Pj4+Pj4+ICAgICAgICAgICAgIHJldHVybiAwOwo+Pj4+Pj4+Pgo+Pj4+Pj4+PiAgICAgIG91dF9l
cnI6Cj4+Pj4+Pj4+IC0gICAgICAgaWYgKG12ZGV2LT5ncm91cDJhc2lkW01MWDVfVkRQQV9EQVRB
VlFfR1JPVVBdID09IGFzaWQpIHsKPj4+Pj4+Pj4gLSAgICAgICAgICAgICAgIGlmIChpb3RsYikK
Pj4+Pj4+Pj4gLSAgICAgICAgICAgICAgICAgICAgICAgZGVzdHJveV91c2VyX21yKG12ZGV2LCBt
cik7Cj4+Pj4+Pj4+IC0gICAgICAgICAgICAgICBlbHNlCj4+Pj4+Pj4+IC0gICAgICAgICAgICAg
ICAgICAgICAgIGRlc3Ryb3lfZG1hX21yKG12ZGV2LCBtcik7Cj4+Pj4+Pj4+IC0gICAgICAgfQo+
Pj4+Pj4+PiArICAgICAgIF9tbHg1X3ZkcGFfZGVzdHJveV9kdnFfbXIobXZkZXYsIGFzaWQpOwo+
Pj4+Pj4+Pgo+Pj4+Pj4+PiAgICAgICAgICAgICByZXR1cm4gZXJyOwo+Pj4+Pj4+PiAgICAgIH0K
Pj4+Pj4+Pj4gLS0KPj4+Pj4+Pj4gMi40MS4wCj4+Pj4+Pj4+Cj4+Pj4+Pj4gX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KPj4+Pj4+PiBWaXJ0dWFsaXphdGlv
biBtYWlsaW5nIGxpc3QKPj4+Pj4+PiBWaXJ0dWFsaXphdGlvbkBsaXN0cy5saW51eC1mb3VuZGF0
aW9uLm9yZwo+Pj4+Pj4+IGh0dHBzOi8vbGlzdHMubGludXhmb3VuZGF0aW9uLm9yZy9tYWlsbWFu
L2xpc3RpbmZvL3ZpcnR1YWxpemF0aW9uCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fXwpWaXJ0dWFsaXphdGlvbiBtYWlsaW5nIGxpc3QKVmlydHVhbGl6YXRp
b25AbGlzdHMubGludXgtZm91bmRhdGlvbi5vcmcKaHR0cHM6Ly9saXN0cy5saW51eGZvdW5kYXRp
b24ub3JnL21haWxtYW4vbGlzdGluZm8vdmlydHVhbGl6YXRpb24=
