Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AF874EE3F01
	for <virtualization@archiver.kernel.org>; Fri, 15 Sep 2023 05:56:01 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 36C22612E0;
	Fri, 15 Sep 2023 05:56:01 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 36C22612E0
Authentication-Results: smtp3.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.a=rsa-sha256 header.s=corp-2023-03-30 header.b=iliddHMy;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.a=rsa-sha256 header.s=selector2-oracle-onmicrosoft-com header.b=odNpSFga
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id KAIintob95cg; Fri, 15 Sep 2023 05:56:00 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 7AD4460BDE;
	Fri, 15 Sep 2023 05:55:59 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 7AD4460BDE
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 45E14C0071;
	Fri, 15 Sep 2023 05:55:59 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id B7B53C0032
 for <virtualization@lists.linux-foundation.org>;
 Fri, 15 Sep 2023 05:55:58 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 8940541EC3
 for <virtualization@lists.linux-foundation.org>;
 Fri, 15 Sep 2023 05:55:58 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 8940541EC3
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com
 header.a=rsa-sha256 header.s=corp-2023-03-30 header.b=iliddHMy; 
 dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com
 header.i=@oracle.onmicrosoft.com header.a=rsa-sha256
 header.s=selector2-oracle-onmicrosoft-com header.b=odNpSFga
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Ff3Ta65yzsra
 for <virtualization@lists.linux-foundation.org>;
 Fri, 15 Sep 2023 05:55:55 +0000 (UTC)
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com
 [205.220.177.32])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 16C5541E79
 for <virtualization@lists.linux-foundation.org>;
 Fri, 15 Sep 2023 05:55:54 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 16C5541E79
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 38EKxa3M017707; Fri, 15 Sep 2023 05:55:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=z4aoLBeONGPcckgdq3nLCjmNGykDYnKUb2tHT6q9wVQ=;
 b=iliddHMyVy3hEYgxZtmxolqplP05nvqqCI86ndHJw90PI1/iG3lJk3My6ss8obwyc0Fv
 EDnIob8/qTjtld9EqmSTFRRxrm4hEWMyR4hxwsA0lC8uU5jtZriBrpGVehW/81RhTm64
 j2YkOiuBp47SnzCuch10PmX2IXUpWeK77TLmmh+u+MiYyvFz+fhMXDJokesrlpBJdm0o
 9SNucJDC5JDfOsctZKmrjjVXcB4WcsM31N4P/Vc2LeFQL+wCoT2PANjrtD9pIRfMOd/o
 /hWK819NeXxbVx9j3XjEWoRJbXbuCQw9EW+0Lo9gHkhHiD2cqGg31T7XUDxxS1b1ckIt cQ== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3t2y7kf0y2-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 15 Sep 2023 05:55:50 +0000
Received: from pps.filterd
 (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19)
 with ESMTP id 38F4BPqc007382; Fri, 15 Sep 2023 05:55:49 GMT
Received: from nam02-sn1-obe.outbound.protection.outlook.com
 (mail-sn1nam02lp2048.outbound.protection.outlook.com [104.47.57.48])
 by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 3t0f5ad669-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 15 Sep 2023 05:55:49 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AbfxARNvjyuNbostmcz4XTomPZuZnqLN/Likaj9U99TJuwos5+PFBfwtbw8Cb6N+uSSm76eRv6zSQAgdfwb2nuQiSp6WAOK20idwJVxQ1tsn0B0cowRvJke4Re6zHgYzZDfQhkhL8OyNhrr0PwbAiuERtwMtqQZm+HgIZVpd3giomB1As39+BmSIIu8HMd427wP0luelAc9mor9ihs9jVvwst61zZrBgAiUJ7osKFd8OBk4BYzqZNbkGdJcrT418UpmxlvE58LcINZKhzwQTFXpqutINn21izDDDbpjjKwD/N8h1bj5O7/o58BE+z11HAUH5OjqbgqO4iHqVubotFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=z4aoLBeONGPcckgdq3nLCjmNGykDYnKUb2tHT6q9wVQ=;
 b=S9fDO5JpNv4WBv6IePlF2vbBl/VF7eHzLKRglp6+u2bNtHePzj8Iff8jUZlrZw7EAyYHsxQa8lwkS4q0KkTUwbwN+UuzSH/76AF9A6Tbt2aKqu22Vg8GpGBqyju5wmj4pmgJwzCAMaKsv72p2iYF5NvDRWWzlOMXejXulc3g2Jh5PWcHt3FkwQ6oCv2TSikDYlZb8gz+wVqEt8+oKERlj5OktJ5GB4VNNntW0t7jeGFm5/8+ZgWjL8z9clfFLKVCZeLLDKAYvG9JP4Gj7ufyh4tX0TmjMnI9SgnVmIvVbUeDFEJxLjm0u3PsylA0155R3gzbvamNmvVSCvxaZZLeSg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=z4aoLBeONGPcckgdq3nLCjmNGykDYnKUb2tHT6q9wVQ=;
 b=odNpSFga/n+t9Y/7Jz1LdiiddhscuVg3GIRkrt593lWutSGpSujaZhTZYXB2+S9AN4WLdTOz0SKB2FsziFyyo3elG3hg4ZZQC9h9b8WFL2KqZnD/699u9MpnkIKGHPdIYW9ImnJkOw8vPFH13VoRu3Kp36NwH01Ato/XPqh6MI0=
Received: from MW4PR10MB6535.namprd10.prod.outlook.com (2603:10b6:303:225::12)
 by PH7PR10MB5813.namprd10.prod.outlook.com (2603:10b6:510:132::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.36; Fri, 15 Sep
 2023 05:55:45 +0000
Received: from MW4PR10MB6535.namprd10.prod.outlook.com
 ([fe80::9971:d29e:d131:cdc8]) by MW4PR10MB6535.namprd10.prod.outlook.com
 ([fe80::9971:d29e:d131:cdc8%3]) with mapi id 15.20.6792.021; Fri, 15 Sep 2023
 05:55:45 +0000
Message-ID: <8c870ced-aef4-5342-351e-35ca8c1d8bdf@oracle.com>
Date: Thu, 14 Sep 2023 22:55:43 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Subject: Re: [PATCH RFC v3 4/4] vhost-vdpa: introduce IOTLB_PERSIST backend
 feature bit
Content-Language: en-US
To: Jason Wang <jasowang@redhat.com>
References: <1694267039-718-1-git-send-email-si-wei.liu@oracle.com>
 <1694267039-718-5-git-send-email-si-wei.liu@oracle.com>
 <CACGkMEu5ey0c-541=ECv7pW7Uj68Pv1Z7TG7Cci1tHfyA4bRqg@mail.gmail.com>
 <edb0415d-efa3-5d5b-bffd-b3ccfc64faa6@oracle.com>
 <CACGkMEuKpzO0kTLZgir-JrDVpZFSE75Jm6zhUyrPLNNEzP0sgw@mail.gmail.com>
From: Si-Wei Liu <si-wei.liu@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <CACGkMEuKpzO0kTLZgir-JrDVpZFSE75Jm6zhUyrPLNNEzP0sgw@mail.gmail.com>
X-ClientProxiedBy: BYAPR11CA0054.namprd11.prod.outlook.com
 (2603:10b6:a03:80::31) To MW4PR10MB6535.namprd10.prod.outlook.com
 (2603:10b6:303:225::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR10MB6535:EE_|PH7PR10MB5813:EE_
X-MS-Office365-Filtering-Correlation-Id: f98fe619-eab0-4779-041a-08dbb5b0675e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: NBcZmF9Dzkg1bKG4CIlPnL3dtm10LR2IQIoFIxr/3NYFSCTH6KgSx4F/K6zBghB1LfIKfNhxiJN1g9w9j1OeNEr/ObsYnyh2bBLKQxPIhplxUl0k3fbThcBxBtDxvrM9T3e31/bwIZzve6Vg2WYeEV/QvcnmiPUZPA2z41GZE13dP1+6V2bJwOzh/fsUDo3rNvR5rMEs8r9u8p7E2slFhV7mbrZKVJCc/rZa8vS7cQUAbLxATAJbxTICebUhWjVElmjd1Q1/p0V8ZhBthRJyrVFyu94DxYu6TfCPdzaR4xSj0vm4R1IkovjBD8RhWmgiAyeUfaxRKcaftolXg0iy8hNMaOxVNUiqXiCXfQ+TjSeiHsrzJYdxqgA8j7Go6yx0NDOhD4ZgLYFSRFYq9FNh3J42xTN1gkKGoudvC8hulRrZcGY+k3lskt/UW/kRvOmSB6KPO/aN62jkN57zOnyStHN+6u+WXuZY48QeOqe+PjfUCByW2buwx4pr5vYB8WM2hMEUhuPFd8PF3J2XTVs3EtOsIrZ2K5MJIbVv+xWN0O1X9h2Pqpgsklv1s1JhLm1DyPkanw6JNM56kxSHlQJ5eR+cnrdkH+ca7uD+po5pXu31EniWt5/8klP2JdDpOZ6jPS9I3saY8tXV4e0S38KHmQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW4PR10MB6535.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(366004)(39860400002)(376002)(396003)(346002)(136003)(1800799009)(186009)(451199024)(316002)(4326008)(8936002)(8676002)(5660300002)(41300700001)(66476007)(31686004)(66556008)(6916009)(66946007)(2906002)(38100700002)(83380400001)(6512007)(26005)(31696002)(53546011)(2616005)(36916002)(966005)(36756003)(86362001)(6506007)(6486002)(478600001)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WWJ1VkZGSWZoTTQ4TXh5aExEV0diR0EwUGZTUi9xL0d0RXN3Nk1GbHNZMG5M?=
 =?utf-8?B?ZDVDdVBpRGNkWUM4bnpWQzRmRDdwdFZRcFpDd0ltYnR3a0FKdGYvOVQ3Z3Zs?=
 =?utf-8?B?eXlZWFlhbnMzd3lpTkFsNzI5NUhac25nbXYyTlgzTWpWZTd3dHhaMjFZbEly?=
 =?utf-8?B?T3Z1MGJqbXQ5N2I1bjY2SUFUMVNkY3VIdDlnbE1WMjVKM3kyLzN3blJ0RGVj?=
 =?utf-8?B?WlNDRDczejFXVCtTaEZDWTZmS1F0dlI0d1ZyelgrN2hCMmYyRFY2SWNoSDFi?=
 =?utf-8?B?T0N4ZTJUMTZ6NWUyTTQ4ZjNBdGVSc0RTN0NmckZIUGVDb3kxSDRmUlpMbW8r?=
 =?utf-8?B?T1JEMm9ZTFZVZkwvSTl6K052b3BVbkQzWnJlL1hLSllIcHNYbm5YeEw2d2I5?=
 =?utf-8?B?RlM1Uzk0emppd0lNYjNXRHg5ZUN2U1gvS3JYV0gzRnF1T3ozK0txNEpRWUR6?=
 =?utf-8?B?WXlKZkJXcDNjeGRPSldjdWdMYTh1TzVaTDJzbHhJTldXY3RNaldEZFFGdmhD?=
 =?utf-8?B?Zk4rWmNtSzFOaGIvV3pzWkZnd0tUV3N3MkdicWhmdnk1b0ZHUHVBekZRZEp3?=
 =?utf-8?B?emNFa1lYUGVpMUhHOXBGK0d5NHd0ODBIYlQ1YldlaVZ4WGZLck1ESGh5M1VP?=
 =?utf-8?B?WjRHLzBjRng4KzFVLzY4N1owUEh0WXM1Z3Y2MDhJOEdKVzlyOFZ4cSs5MVhW?=
 =?utf-8?B?TVF0bTlEZXdQdXFLcnUxRVQ3WVZwT2tXcUVxLzE2eDNQVWFMZS9zTkt3ZDNT?=
 =?utf-8?B?c3lWblE0ME5BQUhHT0t6ODhjdWxGZ3hNdGtzNVkvUTNNajhkYmhhcGw1eG56?=
 =?utf-8?B?ck9JUndON28yRndLSFNwNTFacU1ySFpTUGNHL3VtTWRtRzBMeXFReG40emlG?=
 =?utf-8?B?aTFjMDhpSnJ1algwVXNvZUU1TG1RcER0NWVjbGhzeHdXdkR1VXAyQ1RyWmV5?=
 =?utf-8?B?SzJpN3VSekI1eW82K1FLM1hkL1djei9FdlpqY1JLdlhtVEd5QUpwYzhqaFRL?=
 =?utf-8?B?dDRJWm9SYnhrM1N3VUFMQTZqRElBVFBmWjhJbUp2YkVTbUs2T2RaR3JwbVhQ?=
 =?utf-8?B?SmxzYWxDVHo0L1lvNjdERk5HVXpnaFJDYkcvRWNDbWRGRHpzbmE2MEVLUlg2?=
 =?utf-8?B?SW9Ib1RjZVpqMTRmVEd0L2pHazh4N3UwNEFEME1pNjhJYVgySldES0JOemJ6?=
 =?utf-8?B?Tm5Oajk1cGpmVWpySysvMGQwRHEwTzNSQThkQ3hRWXI0YlJ1MXl4MHUxTjBQ?=
 =?utf-8?B?QWxtUVVySlQ0eHU5RUc3b0QvZ2tlUmtFeEduT1VWa0ZrdVA4aEh5MzFCeC9D?=
 =?utf-8?B?OG9CN0MwTFZuNFRpVWVSNHJxSGVwSDZOWjM0ZkFVMTFEVld6RGo4SmJESWtM?=
 =?utf-8?B?dnhTZWdJak9BYnF5Sy9WTzluQzl5NTJPWmZHZGhlSWtXZ3daRjBEeEsvSUx6?=
 =?utf-8?B?YmJFcWlNNXA0VjZWTDNHRm1DNjFjdVdiNitRdzJmSjlNK2FxWEN5QTZzYTJO?=
 =?utf-8?B?NkFGTDBwbXFWbHQ4STBPT0pYaDhtMGcwdS9oSHF0ejlvZ3lWYVlCUy9qU0JN?=
 =?utf-8?B?c0t3Z0ozWktLMW1kTWRHcWZrQlArUVR4SlJTQ3I3R1B2cEJKRUhjb1ZtNWxR?=
 =?utf-8?B?REJsWFBaUTlDdDJyVVpJM042RzNucUg2dERCeUx3SDMzOXlVM0xxWFJHdE0x?=
 =?utf-8?B?dmt3WXNDOTl4NnZSZ2wwazc0aEpGT1dTdlN3dVBWT3VRK3pTcUZUVzhrSUNl?=
 =?utf-8?B?bUtQL3BPQVlNSXBhSEFGdmRtY2dlUEVpRFBYR1ovS2IvT1lWY0pDN2hsUXlw?=
 =?utf-8?B?TVBhTFJTeVZxZkhrN0tGeDlrelJkVmIzaWJ6cEN2alNoeHlOOEtiZ2VXQVIw?=
 =?utf-8?B?dml0Y0U1MEtNbC9ROGY5cGg0YVF4a2JqRE5JREhmVDhVOXAvZHltamdHSkNG?=
 =?utf-8?B?QVJiMHBnRGJXYWUwcWNENUhZN1NyMGRhcnJRTm1YRjZPb0FkRG1vY0x5RCtP?=
 =?utf-8?B?LzhsaHM4ckk4NzlqOWErM1NubDZKMlRFRHM0K1dtZDNBMjVXbkVyYUJ4TFZE?=
 =?utf-8?B?ZERub2wyZGF1VDQ2enBETVlLTUpjRHBYdnZSVEhheThzNTNHSU5VWWtHTHow?=
 =?utf-8?Q?ODQJfUjb7MC8r0gtFw0noAacP?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: LpWTjPTqB/1x7+qR+oJtCF/Vrm6zvSCOsQ4N48VR3wQM2BnFgg+iInM+vLY0oghVW02vZBBst3FfgZY8BcT+UH5jExl3O2BiNTLm+poTDZPos6kAKgjvoGv6pnGEzXKbq3c6MvMLEjQ1aefol98nFZyhQbYVam+1+CSEWEj7N6G8hD8DuSeiCwcQbuYcuugegqxMyE0TjkeycwY7cT5qUBYQt24qi8E8Tit1VuPIjEmdwOpUEDzMotibHsuQegUlWIJZs7S0OzQSffFXFiCxvxzs7eXEJnHprACG9UIMsy1k4Ip7GmeQnL6MnUR089OaQi/zFdvzPT78KnlXJgpQDJPJ96D4+Rz+PMgbR+Uq4P7HR+44m+TU3RORElQk2bGtkhffR+HqMu111z8MRrNxInBlcHjoiDjDfIjg++d9UTMoEgk9eieAm6wgR6cRJT6n/VhCWOWB+qdyC0K/DheUnrZd8wKExT6a6JPAhhuSRifI3gbWp5Bj2Y4lrhgsNUqXKlh0BomOOgM1Y0wgmKMM9DgvbMCte+90SSqFoGxaT9Xt98vupwUm0K4JcizN+qdK+xJii1jqm8w3DoN0b2DANfh9+9qLYdJHh9kVe1ewA+TRRTsu42PtbjtcN/ReOY98zrbCXEGx3lk8lQFP4uyDEIISyEDvbDnNUNVN6A/WDZ6M0pLae6yETr5BtyJTs4d9Yp1bXgfB40fUfZ3dN6BZ0jO8WXqyM4/Lgj64Tv44u107Rw9ztHnQjsPAnWW/EVfIQrIfxkUUpDuFsm80a4p2c/+6QDAwx75R/8U5EDVit2Y3JcbwXUtA7UWGsINLBe1D4sgOum1Lsd0UsZ2sXoQllBPI4/i1st6kagp5fqbjaZSQ1IINIpIyZQap160WF3Ql5MztwBlv1sEeOnOaty06Rw==
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f98fe619-eab0-4779-041a-08dbb5b0675e
X-MS-Exchange-CrossTenant-AuthSource: MW4PR10MB6535.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Sep 2023 05:55:45.7262 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: B0Ob/FlCnGWY+hl400bIlvUP9CFOFf0NPM4lbIUn2etI7YlWYWCVThbLyYbpFoUDtUqmE/X3lPqnX2oWDc0g6A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR10MB5813
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-09-15_05,2023-09-14_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999
 mlxscore=0 adultscore=0
 phishscore=0 spamscore=0 suspectscore=0 malwarescore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2308100000
 definitions=main-2309150051
X-Proofpoint-GUID: WNiaZyog39DioIqRs5DJur1JcoLhccN9
X-Proofpoint-ORIG-GUID: WNiaZyog39DioIqRs5DJur1JcoLhccN9
Cc: eperezma@redhat.com, virtualization@lists.linux-foundation.org,
 xuanzhuo@linux.alibaba.com, mst@redhat.com
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

CgpPbiA5LzEyLzIwMjMgMTI6MDEgQU0sIEphc29uIFdhbmcgd3JvdGU6Cj4gT24gVHVlLCBTZXAg
MTIsIDIwMjMgYXQgODoyOOKAr0FNIFNpLVdlaSBMaXUgPHNpLXdlaS5saXVAb3JhY2xlLmNvbT4g
d3JvdGU6Cj4+Cj4+Cj4+IE9uIDkvMTAvMjAyMyA4OjUyIFBNLCBKYXNvbiBXYW5nIHdyb3RlOgo+
Pj4gT24gU2F0LCBTZXAgOSwgMjAyMyBhdCA5OjQ24oCvUE0gU2ktV2VpIExpdSA8c2ktd2VpLmxp
dUBvcmFjbGUuY29tPiB3cm90ZToKPj4+PiBVc2Vyc3BhY2UgbmVlZHMgdGhpcyBmZWF0dXJlIGZs
YWcgdG8gZGlzdGluZ3Vpc2ggaWYgdmhvc3QtdmRwYQo+Pj4+IGlvdGxiIGluIHRoZSBrZXJuZWwg
c3VwcG9ydHMgcGVyc2lzdGVudCBJT1RMQiBtYXBwaW5nIGFjcm9zcwo+Pj4+IGRldmljZSByZXNl
dC4KPj4+IEFzIGRpc2N1c3NlZCwgdGhlIElPVExCIHBlcnNpc3RzIGZvciBkZXZpY2VzIHdpdGgg
cGxhdGZvcm0gSU9NTVUgYXQKPj4+IGxlYXN0LiBZb3UndmUgbWVudGlvbmVkIHRoYXQgdGhpcyBi
ZWhhdmlvdXIgaXMgY292ZXJlZCBieSBRZW11IHNpbmNlCj4+PiBpdCByZXNldCBJT1RMQiBvbiBy
ZXNldC4gSSB3b25kZXIgd2hhdCBoYXBwZW5zIGlmIHdlIHNpbXBseSBkZWNvdXBsZQo+Pj4gdGhl
IElPVExCIHJlc2V0IGZyb20gdkRQQSByZXNldCBpbiBRZW11LiBDb3VsZCB3ZSBtZWV0IGJ1Z3Mg
dGhlcmU/Cj4+IE5vdCBzdXJlIEkgdW5kZXJzdGFuZC4gU2ltcGxlIGRlY291cGxlIG1lYW5pbmcg
dG8gcmVtb3ZlIG1lbW9yeV9saXN0ZW5lcgo+PiByZWdpc3RyYXRpb24vdW5yZWdpc3RyYXRpb24g
Y2FsbHMgKnVuY29uZGl0aW9uYWxseSogZnJvbSB0aGUgdkRQQSBkZXYKPj4gc3RhcnQvc3RvcCBw
YXRoIGluIFFFTVUsIG9yIG1ha2UgaXQgY29uZGl0aW9uYWwgYXJvdW5kIHRoZSBleGlzdGVuY2Ug
b2YKPj4gUEVSU0lTVF9JT1RMQj8KPiBJZiBteSBtZW1vcnkgaXMgY29ycmVjdCwgY3VycmVudGx5
IHRoZSBsaXN0ZW5lcnMgd2VyZQo+IHJlZ2lzdGVyZWQvdW5yZWdpc3RlcmVkIGR1cmluZyBzdGFy
dC9zdG9wLiBJIG1lYW4gd2hhdCBpZiB3ZQo+IHJlZ2lzdGVyL3VucmVnaXN0ZXIgZHVyaW5nIGlu
aXQvZnJlZT8KWWVzLCB0aGUgbW92ZSB0byBpbml0L2NsZWFudXAgd2FzIGFzc3VtZWQgaW4gYmVs
b3cgcmVzcG9uc2UuCgo+Cj4+IElmIHVuY29uZGl0aW9uYWwsIGl0IGJyZWFrcyBvbGRlciBob3N0
IGtlcm5lbCwgYXMgdGhlCj4+IG9sZGVyIGtlcm5lbCBzdGlsbCBzaWxlbnRseSBkcm9wcyBhbGwg
bWFwcGluZyBhY3Jvc3MgdkRQQSByZXNldCAoVk0KPj4gcmVib290KSwKPiBPaywgcmlnaHQuCj4K
Pj4gZW5kaW5nIHVwIHdpdGggbmV0d29yayBsb3NzIGFmdGVyd2FyZHM7IGlmIG1ha2UgdGhlIFFF
TVUgY2hhbmdlCj4+IGNvbmRpdGlvbmFsIG9uIFBFUlNJU1RfSU9UTEIgd2l0aG91dCB0aGUgLnJl
c2V0X21hcCBBUEksIGl0IGNhbid0IGNvdmVyCj4+IHRoZSB2aXJ0aW8tdmRwYSAxOjEgaWRlbnRp
dHkgbWFwcGluZyBjYXNlLgo+IE9rLCBJIHNlZS4gTGV0J3MgYWRkIHRoZSBhYm92ZSBhbmQgZXhw
bGFpbiB3aHkgaXQgY2FuJ3QgY292ZXIgdGhlIDE6MQo+IG1hcHBpbmcgc29tZXdoZXJlIChwcm9i
YWJseSB0aGUgY29tbWl0IGxvZykgaW4gdGhlIG5leHQgdmVyc2lvbi4KT0suIFdpbGwgZG8uCgo+
Cj4gU28gSSB0aGluayB3ZSBjYW4gcHJvYmFibHkgaW50cm9kdWNlIHJlc2V0X21hcCgpIGJ1dCBu
b3Qgc2F5IGl0J3MgZm9yCj4gb24tY2hpcCBJT01NVS4gV2UgY2FuIHByb2JhYmx5IHNheSwgaXQn
cyBmb3IgcmVzZXR0aW5nIHRoZSB2ZW5kb3IKPiBzcGVjaWZpYyBtYXBwaW5nIGludG8gaW5pdGlh
bGl6YXRpb24gc3RhdGU/CkZvciBzdXJlLiBUaGF0J3MgZXhhY3RseSB0aGUgaW50ZW50LCB0aG91
Z2ggSSBkaWRuJ3Qgc3BlY2lmaWNhbGx5IHRpZSAKb24tY2hpcCB0byB0d28tZGltZW5zaW9uIG9y
IGVudGl0eSBtYXBwaW5nLiBZZXMgSSBjYW4gcmV3b3JkIHRvICJ2ZW5kb3IgCnNwZWNpZmljIiBp
biB0aGUgbmV4dCByZXYgdG8gYXZvaWQgY29uZnVzaW9ucyBhbmQgYW1iaWd1aXR5LgoKVGhhbmtz
LAotU2l3ZWkKPgo+Pj4gQnR3LCBpcyB0aGVyZSBhIFFlbXUgcGF0Y2ggZm9yIHJlZmVyZW5jZSBm
b3IgdGhpcyBuZXcgZmVhdHVyZT8KPj4gVGhlcmUncyBhIFdJUCB2ZXJzaW9uLCBub3QgcmVhZHkg
eWV0IGZvciByZXZpZXc6Cj4+Cj4+IGh0dHBzOi8vZ2l0aHViLmNvbS9zaXdsaXUta2VybmVsL3Fl
bXUKPj4gYnJhbmNoOiB2ZHBhLXN2cS1hc2lkLXBvYwo+Pgo+PiBXaWxsIG5lZWQgdG8gY2xlYW4g
dXAgY29kZSBhbmQgc3BsaXQgdG8gc21hbGxlciBwYXRjaGVzIGJlZm9yZSBJIGNhbgo+PiBwb3N0
IGl0LCBpZiB0aGUga2VybmVsIHBhcnQgY2FuIGJlIHNldHRsZWQuCj4gT2suCj4KPiBUaGFua3MK
Pgo+PiBUaGFua3MsCj4+IC1TaXdlaQo+Pgo+Pj4gVGhhbmtzCj4+Pgo+Pj4+IFRoZXJlIGFyZSB0
d28gY2FzZXMgdGhhdCBiYWNrZW5kIG1heSBjbGFpbQo+Pj4+IHRoaXMgZmVhdHVyZSBiaXQgb246
Cj4+Pj4KPj4+PiAtIHBhcmVudCBkZXZpY2UgdGhhdCBoYXMgdG8gd29yayB3aXRoIHBsYXRmb3Jt
IElPTU1VCj4+Pj4gLSBwYXJlbnQgZGV2aWNlIHdpdGggb24tY2hpcCBJT01NVSB0aGF0IGhhcyB0
aGUgZXhwZWN0ZWQKPj4+PiAgICAgLnJlc2V0X21hcCBzdXBwb3J0IGluIGRyaXZlcgo+Pj4+Cj4+
Pj4gU2lnbmVkLW9mZi1ieTogU2ktV2VpIExpdSA8c2ktd2VpLmxpdUBvcmFjbGUuY29tPgo+Pj4+
IC0tLQo+Pj4+IFJGQyB2MiAtPiB2MzoKPj4+PiAgICAgLSBmaXggbWlzc2luZyByZXR1cm4gZHVl
IHRvIG1lcmdlIGVycm9yCj4+Pj4KPj4+PiAtLS0KPj4+PiAgICBkcml2ZXJzL3Zob3N0L3ZkcGEu
YyAgICAgICAgICAgICB8IDE2ICsrKysrKysrKysrKysrKy0KPj4+PiAgICBpbmNsdWRlL3VhcGkv
bGludXgvdmhvc3RfdHlwZXMuaCB8ICAyICsrCj4+Pj4gICAgMiBmaWxlcyBjaGFuZ2VkLCAxNyBp
bnNlcnRpb25zKCspLCAxIGRlbGV0aW9uKC0pCj4+Pj4KPj4+PiBkaWZmIC0tZ2l0IGEvZHJpdmVy
cy92aG9zdC92ZHBhLmMgYi9kcml2ZXJzL3Zob3N0L3ZkcGEuYwo+Pj4+IGluZGV4IDcxZmJkNTU5
Li5iNDA0NTA0IDEwMDY0NAo+Pj4+IC0tLSBhL2RyaXZlcnMvdmhvc3QvdmRwYS5jCj4+Pj4gKysr
IGIvZHJpdmVycy92aG9zdC92ZHBhLmMKPj4+PiBAQCAtNDE0LDYgKzQxNCwxNCBAQCBzdGF0aWMg
Ym9vbCB2aG9zdF92ZHBhX2hhc19kZXNjX2dyb3VwKGNvbnN0IHN0cnVjdCB2aG9zdF92ZHBhICp2
KQo+Pj4+ICAgICAgICAgICByZXR1cm4gb3BzLT5nZXRfdnFfZGVzY19ncm91cDsKPj4+PiAgICB9
Cj4+Pj4KPj4+PiArc3RhdGljIGJvb2wgdmhvc3RfdmRwYV9oYXNfcGVyc2lzdGVudF9tYXAoY29u
c3Qgc3RydWN0IHZob3N0X3ZkcGEgKnYpCj4+Pj4gK3sKPj4+PiArICAgICAgIHN0cnVjdCB2ZHBh
X2RldmljZSAqdmRwYSA9IHYtPnZkcGE7Cj4+Pj4gKyAgICAgICBjb25zdCBzdHJ1Y3QgdmRwYV9j
b25maWdfb3BzICpvcHMgPSB2ZHBhLT5jb25maWc7Cj4+Pj4gKwo+Pj4+ICsgICAgICAgcmV0dXJu
ICghb3BzLT5zZXRfbWFwICYmICFvcHMtPmRtYV9tYXApIHx8IG9wcy0+cmVzZXRfbWFwOwo+Pj4+
ICt9Cj4+Pj4gKwo+Pj4+ICAgIHN0YXRpYyBsb25nIHZob3N0X3ZkcGFfZ2V0X2ZlYXR1cmVzKHN0
cnVjdCB2aG9zdF92ZHBhICp2LCB1NjQgX191c2VyICpmZWF0dXJlcCkKPj4+PiAgICB7Cj4+Pj4g
ICAgICAgICAgIHN0cnVjdCB2ZHBhX2RldmljZSAqdmRwYSA9IHYtPnZkcGE7Cj4+Pj4gQEAgLTcx
Niw3ICs3MjQsOCBAQCBzdGF0aWMgbG9uZyB2aG9zdF92ZHBhX3VubG9ja2VkX2lvY3RsKHN0cnVj
dCBmaWxlICpmaWxlcCwKPj4+PiAgICAgICAgICAgICAgICAgICBpZiAoZmVhdHVyZXMgJiB+KFZI
T1NUX1ZEUEFfQkFDS0VORF9GRUFUVVJFUyB8Cj4+Pj4gICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICBCSVRfVUxMKFZIT1NUX0JBQ0tFTkRfRl9ERVNDX0FTSUQpIHwKPj4+PiAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIEJJVF9VTEwoVkhPU1RfQkFDS0VORF9GX1NV
U1BFTkQpIHwKPj4+PiAtICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBCSVRfVUxMKFZI
T1NUX0JBQ0tFTkRfRl9SRVNVTUUpKSkKPj4+PiArICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICBCSVRfVUxMKFZIT1NUX0JBQ0tFTkRfRl9SRVNVTUUpIHwKPj4+PiArICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICBCSVRfVUxMKFZIT1NUX0JBQ0tFTkRfRl9JT1RMQl9QRVJTSVNU
KSkpCj4+Pj4gICAgICAgICAgICAgICAgICAgICAgICAgICByZXR1cm4gLUVPUE5PVFNVUFA7Cj4+
Pj4gICAgICAgICAgICAgICAgICAgaWYgKChmZWF0dXJlcyAmIEJJVF9VTEwoVkhPU1RfQkFDS0VO
RF9GX1NVU1BFTkQpKSAmJgo+Pj4+ICAgICAgICAgICAgICAgICAgICAgICAgIXZob3N0X3ZkcGFf
Y2FuX3N1c3BlbmQodikpCj4+Pj4gQEAgLTczMCw2ICs3MzksOSBAQCBzdGF0aWMgbG9uZyB2aG9z
dF92ZHBhX3VubG9ja2VkX2lvY3RsKHN0cnVjdCBmaWxlICpmaWxlcCwKPj4+PiAgICAgICAgICAg
ICAgICAgICBpZiAoKGZlYXR1cmVzICYgQklUX1VMTChWSE9TVF9CQUNLRU5EX0ZfREVTQ19BU0lE
KSkgJiYKPj4+PiAgICAgICAgICAgICAgICAgICAgICAgICF2aG9zdF92ZHBhX2hhc19kZXNjX2dy
b3VwKHYpKQo+Pj4+ICAgICAgICAgICAgICAgICAgICAgICAgICAgcmV0dXJuIC1FT1BOT1RTVVBQ
Owo+Pj4+ICsgICAgICAgICAgICAgICBpZiAoKGZlYXR1cmVzICYgQklUX1VMTChWSE9TVF9CQUNL
RU5EX0ZfSU9UTEJfUEVSU0lTVCkpICYmCj4+Pj4gKyAgICAgICAgICAgICAgICAgICAgIXZob3N0
X3ZkcGFfaGFzX3BlcnNpc3RlbnRfbWFwKHYpKQo+Pj4+ICsgICAgICAgICAgICAgICAgICAgICAg
IHJldHVybiAtRU9QTk9UU1VQUDsKPj4+PiAgICAgICAgICAgICAgICAgICB2aG9zdF9zZXRfYmFj
a2VuZF9mZWF0dXJlcygmdi0+dmRldiwgZmVhdHVyZXMpOwo+Pj4+ICAgICAgICAgICAgICAgICAg
IHJldHVybiAwOwo+Pj4+ICAgICAgICAgICB9Cj4+Pj4gQEAgLTc4NSw2ICs3OTcsOCBAQCBzdGF0
aWMgbG9uZyB2aG9zdF92ZHBhX3VubG9ja2VkX2lvY3RsKHN0cnVjdCBmaWxlICpmaWxlcCwKPj4+
PiAgICAgICAgICAgICAgICAgICAgICAgICAgIGZlYXR1cmVzIHw9IEJJVF9VTEwoVkhPU1RfQkFD
S0VORF9GX1JFU1VNRSk7Cj4+Pj4gICAgICAgICAgICAgICAgICAgaWYgKHZob3N0X3ZkcGFfaGFz
X2Rlc2NfZ3JvdXAodikpCj4+Pj4gICAgICAgICAgICAgICAgICAgICAgICAgICBmZWF0dXJlcyB8
PSBCSVRfVUxMKFZIT1NUX0JBQ0tFTkRfRl9ERVNDX0FTSUQpOwo+Pj4+ICsgICAgICAgICAgICAg
ICBpZiAodmhvc3RfdmRwYV9oYXNfcGVyc2lzdGVudF9tYXAodikpCj4+Pj4gKyAgICAgICAgICAg
ICAgICAgICAgICAgZmVhdHVyZXMgfD0gQklUX1VMTChWSE9TVF9CQUNLRU5EX0ZfSU9UTEJfUEVS
U0lTVCk7Cj4+Pj4gICAgICAgICAgICAgICAgICAgaWYgKGNvcHlfdG9fdXNlcihmZWF0dXJlcCwg
JmZlYXR1cmVzLCBzaXplb2YoZmVhdHVyZXMpKSkKPj4+PiAgICAgICAgICAgICAgICAgICAgICAg
ICAgIHIgPSAtRUZBVUxUOwo+Pj4+ICAgICAgICAgICAgICAgICAgIGJyZWFrOwo+Pj4+IGRpZmYg
LS1naXQgYS9pbmNsdWRlL3VhcGkvbGludXgvdmhvc3RfdHlwZXMuaCBiL2luY2x1ZGUvdWFwaS9s
aW51eC92aG9zdF90eXBlcy5oCj4+Pj4gaW5kZXggNmFjYzYwNC4uMGZkYjZmMCAxMDA2NDQKPj4+
PiAtLS0gYS9pbmNsdWRlL3VhcGkvbGludXgvdmhvc3RfdHlwZXMuaAo+Pj4+ICsrKyBiL2luY2x1
ZGUvdWFwaS9saW51eC92aG9zdF90eXBlcy5oCj4+Pj4gQEAgLTE4Niw1ICsxODYsNyBAQCBzdHJ1
Y3Qgdmhvc3RfdmRwYV9pb3ZhX3JhbmdlIHsKPj4+PiAgICAgKiBidWZmZXJzIG1heSByZXNpZGUu
IFJlcXVpcmVzIFZIT1NUX0JBQ0tFTkRfRl9JT1RMQl9BU0lELgo+Pj4+ICAgICAqLwo+Pj4+ICAg
ICNkZWZpbmUgVkhPU1RfQkFDS0VORF9GX0RFU0NfQVNJRCAgICAweDYKPj4+PiArLyogSU9UTEIg
ZG9uJ3QgZmx1c2ggbWVtb3J5IG1hcHBpbmcgYWNyb3NzIGRldmljZSByZXNldCAqLwo+Pj4+ICsj
ZGVmaW5lIFZIT1NUX0JBQ0tFTkRfRl9JT1RMQl9QRVJTSVNUICAweDcKPj4+Pgo+Pj4+ICAgICNl
bmRpZgo+Pj4+IC0tCj4+Pj4gMS44LjMuMQo+Pj4+CgpfX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fXwpWaXJ0dWFsaXphdGlvbiBtYWlsaW5nIGxpc3QKVmlydHVh
bGl6YXRpb25AbGlzdHMubGludXgtZm91bmRhdGlvbi5vcmcKaHR0cHM6Ly9saXN0cy5saW51eGZv
dW5kYXRpb24ub3JnL21haWxtYW4vbGlzdGluZm8vdmlydHVhbGl6YXRpb24=
