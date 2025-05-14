Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on2068.outbound.protection.outlook.com [40.107.212.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B37C427A137
	for <virtualization@lists.linux.dev>; Wed, 14 May 2025 17:43:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.212.68
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747244637; cv=fail; b=MANt0+MDQnVdfLQ5bxnN1OOwDw/3iE3MWprSpUKuvEZXyWPPDfpG88yhyjvJbnJQn6zbkIon+J+vB+QzfRJCy4v5ptimuwkGpZ1gxTHfPpIve/JA88U7JVctnGrCx7CZ/k/6tHyyxi8xdJfN6u0b6wG6cnonvNxe/HwgDwSDHBY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747244637; c=relaxed/simple;
	bh=VvM/Nw4dpMDlFIv5mLjroBlfazPuPYKIndUMSJUYcbg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=U9S1MlO4cIviDaMg+CII43eN47TVwhwYcv6no4qdYyjSOBrKBBueqV4/ptyiqasWSlnRUil/fZH9xlstDZhIG7/RNf0M3+JHKsx/sW0Sielcz7ftoKOURxQCn1c+H+uoOeOGBkWXx0W4u1oVKqsz8Nw7D90Lvexqkhf98terSCI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Xtgx7qax; arc=fail smtp.client-ip=40.107.212.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Xtgx7qax"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MUQqO92VN9Bp3NO96j47IiUIS63+Y1ysqVM0JP3bMEzBnNtA7RA2yQr6oSWgi/cgRBM1TRFmG6UUGJY5o9YloD9Lnfob5R8m+/qy/2lw3hGux39GhLnXSIrN8Gzqb+xdtDGvjH87/LHPg3NE6HE3a0riOWFSdLYPbwFAhiJKL3FN142P/IH2Dw0vKOugqHqZzfBk588zopBEddwLbq9lr4xHxNuCjZLF+bL2OCYpWPEaEfM0bftutQjW3WOpnZRbwF0syGUdDQDEX7rftK4UXKiiNMU4aRVx4AInunFu/MaU99K9gijWfRnYbOMp4pg+R7I2B91n4ubcEPqbhUfc3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VJ6Rk0C19CTSMv8tnGGeCJ0w5QD9P/Hj7ls9PP9Ve/U=;
 b=aNj9bfAttrEpJuw2A2FUWCW8smzqGO1qVu/sBB48A7AHr9G5t7Gbq9qCZw6d81c5T5HNlf50KWGItQ4Jgiq4o8J3HSyLT8RHB2d1BTAdArQNfpzNgLgTF0uDBP3lRDoTt/YjzRKq7+STurTz9JX0cev8f467Fv2eSLy1BSMddGOygng9FWGZ25FKGul5hfYDviTZjQNAr46IIwRRuFEq+299xTaStaO6uVmO2ulPvo0S10v4boobFbjk3zEOy8OOcI9AFJzKaQXA/5mwhJ0lcbmvGqmaC9sDOsMhuSRLeONLR9ir6s9K7XQZG/cfQ2LY4k6KZi/wCJMY3jrJNOkVdw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VJ6Rk0C19CTSMv8tnGGeCJ0w5QD9P/Hj7ls9PP9Ve/U=;
 b=Xtgx7qax7qDj4r/KnmOcXSuyton/tRXLSh28/fRdCB4Y7nMPnSg51eNuAxEtjb1zxEzccVCraHBPhovDtVZTMC2WrKanM3FeoFm91Ps/M1q3X/6uHxpuaV8eukxu4RmUf4dXnobP8QgGTRNtSDp9BqbVYtawuKfQQI/PnPhilPXacB67Vt1oM/1G1UjVlgY4CCZ67CP4F4+8SdASRe06GVrWauDgqjw5UH33inyLAuSA/XQW6OFBbk8mmWtnqKHEWv5q6u8xEc8ax/XMskhMBelT9nuqichRgaj2zREcviWPvqjPwF0Ayc2VpixkqpZEjMdFo7WPXdX6HNF3FPA9Eg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS7PR12MB9473.namprd12.prod.outlook.com (2603:10b6:8:252::5) by
 CY1PR12MB9583.namprd12.prod.outlook.com (2603:10b6:930:fe::18) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8722.31; Wed, 14 May 2025 17:43:51 +0000
Received: from DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::5189:ecec:d84a:133a]) by DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::5189:ecec:d84a:133a%5]) with mapi id 15.20.8722.027; Wed, 14 May 2025
 17:43:51 +0000
From: Zi Yan <ziy@nvidia.com>
To: David Hildenbrand <david@redhat.com>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org,
 virtualization@lists.linux.dev, "Michael S. Tsirkin" <mst@redhat.com>,
 Jason Wang <jasowang@redhat.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
 =?utf-8?q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Oscar Salvador <osalvador@suse.de>, Vlastimil Babka <vbabka@suse.cz>,
 Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>,
 Brendan Jackman <jackmanb@google.com>, Johannes Weiner <hannes@cmpxchg.org>,
 "Matthew Wilcox (Oracle)" <willy@infradead.org>
Subject: Re: [PATCH v1 0/2] mm/memory_hotplug: introduce and use
 PG_offline_skippable
Date: Wed, 14 May 2025 13:43:49 -0400
X-Mailer: MailMate (2.0r6255)
Message-ID: <B0D9F799-481A-48E2-8AD7-DC193618869A@nvidia.com>
In-Reply-To: <d0e94a6e-6296-495a-b10a-569d41a65adb@redhat.com>
References: <20250514111544.1012399-1-david@redhat.com>
 <4B7FCC74-EAB2-426B-AFE0-4250FE4F7480@nvidia.com>
 <8ce464e2-1447-4e60-8abe-f4ddd511d7a7@redhat.com>
 <1662085A-4536-4020-957D-90FB262C6014@nvidia.com>
 <d0e94a6e-6296-495a-b10a-569d41a65adb@redhat.com>
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: MN2PR15CA0066.namprd15.prod.outlook.com
 (2603:10b6:208:237::35) To DS7PR12MB9473.namprd12.prod.outlook.com
 (2603:10b6:8:252::5)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB9473:EE_|CY1PR12MB9583:EE_
X-MS-Office365-Filtering-Correlation-Id: 9a242f86-9b59-45ab-17d8-08dd930ee3b5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?bdrqifqcL8u0h1bQxJvx6ch9fke9AvpEy7N2NHJTiQF7mtAlAZMTmSL5P9ZN?=
 =?us-ascii?Q?dshsUeDRK7UxOxKcmGvEylqaZeTHtjrVxmJ4ux7gEJRqizfoWS7JM7Z0gS5F?=
 =?us-ascii?Q?ilC4lAdaIr+MMDmwUUCuEkflQ0m/JTdhTQtmU6TwturCI0zthjIOGFMPZaW5?=
 =?us-ascii?Q?Q4DChzTBKIkOWxd/rF+1Qh44ry5ZvPj9d6VAcAbIX90voEsTSfRNc4D6Moil?=
 =?us-ascii?Q?6yTNKVLwjOZsBwICEk8GgBD83fj2dQ60OvUfHrG/3qc29tMUt2RZFLVggsnu?=
 =?us-ascii?Q?9VNb6uuF3DxCmKP5qOomRznJr3zkGdLyAsL+5dwy3o7FlD+Q9P1E6cjFo8vy?=
 =?us-ascii?Q?/jAypMGxiEBL2Q0ZliRIAcfiesxLZ/Mz4ftKLnfhkMhHKxS+lSMe1ZKG9ZQa?=
 =?us-ascii?Q?qMDnP8tpdiHXYOR5W2yxfT2XIJ5+Gb2+k0i9CqsYY9F/VoXCChVk30c+Xi8c?=
 =?us-ascii?Q?MdAyOB5A/CHitRBd7bY7vATHrywyDMFBfWA6qxldkQjqUxIiF5tNkLB+bv8X?=
 =?us-ascii?Q?K59cpCXBmw6gZWb5sOrcTi8FTa27aNJ3hNX4qiOA6FnQ23NgqGh5+oF+naee?=
 =?us-ascii?Q?nqj25JZGqqcjGxQ7jYP2hsdzxMbK8YtaCpwab2n1yCO0PxZIYn8UK2Jix5Al?=
 =?us-ascii?Q?pqLLm5mYdgSKJA0plwxTnPqIs9XiZZZggvp8SWjcLbUb2RrNuVKaWTSIeRO6?=
 =?us-ascii?Q?J9Vte+xlL3XxtkKXVM5f6poJb6Ovg9a1jhOmEL0W7xS/FLjxgKpj2wRUYaf5?=
 =?us-ascii?Q?3eWoMEgYRfK8IOrBHH1zRm4H95XKCB6eCZWVSuIa7cr73fNaTSF+h9pDouXF?=
 =?us-ascii?Q?mcWgTp+aaH9O6rWOG7iwX4aVEd9FUBo+DDeTwkpE+DsEQeo7CZNESz3aLIYO?=
 =?us-ascii?Q?QJJ/764eqkQBgeXf8zK89xRfvslH7LNs+mV9e4cABYqUAoiRgvTDcCQZ2Lj1?=
 =?us-ascii?Q?B+eslmsHwHP92Bh2j/M6O3dullBZdv7xeHPW4Skrir6vXu1jO4ghlaOwWSqU?=
 =?us-ascii?Q?jyCED1rg0OEu0DXNQV6ySp2dHX1XvWe9gDfc05Vucrf7G0mK/Qnz+9keMq4x?=
 =?us-ascii?Q?dQObs6eNO7dkzwx4YuI4YxEbcyNmhfZtnZgnB5P91RD5UQMzG29hlaT9PiSl?=
 =?us-ascii?Q?l8pvx0bA4K+Bp6M+whfR2i8b29xV98O00maup7G8KR2TjxQRSfjzO6kLvidl?=
 =?us-ascii?Q?4CZiojZEt9xV59IIpD/crbpwgQZuc6qxYBneWnBED2vyTRh70PHtbQ42EyOp?=
 =?us-ascii?Q?YUPNLMncsvP0AeVcEy14pyNUu/ru8k6xZcLpZD/efIR2cSd24BQTgjIC7kHn?=
 =?us-ascii?Q?cQZEgjGtPy2Q9iWOOqlpqGejEhybGXXplHzcR9V80vuaoQ4zFcoCEWxfnENs?=
 =?us-ascii?Q?kSQwDk/ft1dsFWBmeA9gJ2QOk9hvoNzqaNEtuxnf4taazE3du8hXocbBaYEp?=
 =?us-ascii?Q?HSfcQiTH14w=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB9473.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?KXNVjnyCxmZuR4YMpIE1q8xwPmyMRGai6LhmEkQGLdn72y7wedlJc5607u6G?=
 =?us-ascii?Q?jANTKlgyUz2Bh/WJQ+eh9PIwQVLGa3dQYiTIHr9w1C9nRWtIWNc0tbq1SE54?=
 =?us-ascii?Q?ZeA5QgEspJFANu/M+ISbEJqeHV0ru4pOR1zh0sGQOu/Z9xx1cM3rYR+Z2GZ7?=
 =?us-ascii?Q?CBkKiTbp/Kf6dkSVTvuLuLovz+J/srrDssBX/2YYHcMOdn+yIZ7Qhq7ebDQR?=
 =?us-ascii?Q?RV4xqqLjU4U+5Lw/JIvQ8jE9XcgVUe+NBa+RQ7cjmx3PZbOU6cqXD6HkvlQ3?=
 =?us-ascii?Q?sAzGZf7PHOckyk4TS7rnyKSlMjMD/S7XGAPta3Zk5MgqGffY3O2i4oWKfK68?=
 =?us-ascii?Q?B6EKxdl3Nqc98T3x1IBt7v7tng9u8hFpaL4Kz/h/rFFM8UAZGETxLdzBJcLm?=
 =?us-ascii?Q?6vMX9x+zJmkg/WSDR7T1749QlU9Iui3ZWgEkRoy9JwwnV6HsYt8DAJmtgeis?=
 =?us-ascii?Q?mcA3j+GvlSa6b6shEmIkXJjpbFR4jEVxAKMZpjSQRw3rlhYC6L1rdyzjayge?=
 =?us-ascii?Q?dEr//19BKoBA4+XRpD9vlb+MqjswVQXQrs507TOXI1L/V6lyiKKw8/N8rKOT?=
 =?us-ascii?Q?5XYPHCZkJDotSIlnWlFO3VOWbb+YaZH6lCkVvqisKh3CtQC01b2VUWovnaAK?=
 =?us-ascii?Q?a5t+2kOG+jcxS7kn8A3awz7sXVNGrjVVwi8eZBZH7qlygsnytiaOXmbTTleT?=
 =?us-ascii?Q?bq8YHBGMNokwH1fkMbYQL0TuTGCUa3tnE0yVBFrnRDHRDGNCvi6ZJS6PvkY5?=
 =?us-ascii?Q?VhVFul4zmscapH080eAMDywoDuBp7Nn4kFgkuuM4wB/TdgF423xUGVYSB7aU?=
 =?us-ascii?Q?UwYcXWlXXZdpmk/EPakQbWuRB9CXLUbf2BTgH/n4iqWIa+2HI9MxmfswsKii?=
 =?us-ascii?Q?SFM6Ens1F2TNcY7k8kiIG9zMRZlVqHLdpcO4aiDFhx8L3IJuJlVse+p7rogi?=
 =?us-ascii?Q?ro9fsyu1L3PbVnn5l2VB8iAcEZ7r4PSoguBYwRp6kO1Qn5fw5XW6Zkl0uBpT?=
 =?us-ascii?Q?1yyYVYQBuhW+QNKYvYB4SYi+tTrxtbR/B3ZlNXQKwi7bVOBxGUY/vVJXQE1e?=
 =?us-ascii?Q?iK21wym9TJZG+TnbRNZSYAZydFbuyh3DrCEG0dMY4RpbEyPapXKm8BVatcI0?=
 =?us-ascii?Q?B5a/Zj5EwdyiqG0qbsFZem1L8BiakvNoPu4dCmgIN3uSkKO4gfn79eezBOQv?=
 =?us-ascii?Q?WpTVmo0oPEoCMIkDRJCoFUh42XwhcjAXNveGruJC5yXMDK2XkiNalSEpSkWG?=
 =?us-ascii?Q?qhNuRvkZRcTHMmOb0vn3qB0vvF/9CVcK0oC7UrNGgvVQJfYxa/cuzPFzrhFr?=
 =?us-ascii?Q?cpHY7OrQarngRrQ36WcVxA4deQpM9xy+VVtx36HYqVMTG5/885Zel6feY1Q6?=
 =?us-ascii?Q?RPW1pSToWUW3P0GNcrUm5Cn/sxoyES6tDJ03BFzDecGSqd8wvnabjDBsDSmp?=
 =?us-ascii?Q?k1wJngwFQ8Vg6/FOoyeCRBg2MIUhXQE8SgfMzTBX4bFVoGcipIC3bRp6phMu?=
 =?us-ascii?Q?+YKkgmFUM//hHM7b7CbIneaTZ3i8jyC3+E7GbYkqJ3wDV2nHjH08daM/oWKz?=
 =?us-ascii?Q?Ii2W8cQvLBwo1TaGVYUes03LWnOUNirnrwqFt8ms?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9a242f86-9b59-45ab-17d8-08dd930ee3b5
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB9473.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 May 2025 17:43:51.7225
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xrdc4Ork7KKyR7bsg9i6XuKWp+PAlvKxUQhcpUFsRyF9Skgmtom3K4DcJ9+s3cQv
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY1PR12MB9583

On 14 May 2025, at 13:28, David Hildenbrand wrote:

>>>
>>> Note that PageOffline() is a bit confusing because it's "Memory block=
 online but page is logically offline (e.g., has a memmap that can be tou=
ched, but the page content should not be touched)".
>>
>> So PageOffline() is before memory block offline, which is the first ph=
ase of
>> memory hotunplug.
>
> Yes.
>
>>
>>>
>>> (memory block offline -> all pages offline and have effectively no st=
ate because the memmap is stale)
>>
>> What do you mean by memmap is stale? When a memory block is offline, m=
emmap is
>> still present, so pfn scanner can see these pages. pfn scanner checks =
memmap
>> to know that it should not touch these pages, right?
>
> See pfn_to_online_page() for exactly that use case.
>
> For an offline memory section (either because it was just added or beca=
use it was just offlined), the memmap is assumed to contain garbage and s=
hould not be touched.
>
> See remove_pfn_range_from_zone() -> page_init_poison().
>
>>
>>>
>>>> removed from page allocator.
>>>
>>> Usually, all pages are freed back to the buddy (isolated pageblock ->=
 put onto the isolated list). Memory offlining code can then simply grab =
these "free" pages from the buddy -- no PageOffline involved.
>>>
>>> If something fails during memory offlining, these isolated pages are =
simply put back on the appropriate migratetype list and become ordinary f=
ree pages that can be allocated immediately.
>>
>> I am familiar with this part. Then, when PageOffline is used?
>>
>>  From the comment in page-flags.h, I see two examples: inflated pages =
by balloon driver
>> and not onlined pages when onlining the section. These are two differe=
nt operations:
>> 1) inflated pages are going to be offline, 2) not onlined pages are go=
ing to be
>> online. But you mentioned above that Memory off lining code does not i=
nvolve
>> PageOffline, so inflated pages by balloon driver is not part of memory=
 offlining
>> code, but a different way of offlining pages. Am I getting it right?
>
> Yes. PageOffline means logically offline, for whatever reason someone d=
ecides to turn pages logically offline.
>
> Memory ballooning uses and virtio-mem are two users, there are more.
>
>>
>> I read a little bit more on memory ballooning and virtio-mem and under=
stand
>> that memory ballooning still keeps the inflated page but guest cannot =
allocate
>> and use it, whereas virtio-mem and memory hotunplug remove the page fr=
om
>> Linux completely (i.e., Linux no longer sees the memory).
>
> In virtio-mem terms, they are considered "fake offline" -- memory behav=
es as if it would never have been onlined, but there is a memmap for it. =
Like a (current) memory hole.
>
>>
>> It seems that I am mixing memory offlining and memory hotunplug. IIUC,=

>> memory offlining means no one can allocate and use the offlined memory=
, but
>> Linux still sees it; memory hotunplug means Linux no longer sees it (n=
o related
>> memmap and other metadata). Am I getting it right?
>
> The doc has this "Phases of Memory Hotplug" description, where it is ro=
ughly divided into that, yes.
>
>>
>>>
>>> Some PageOffline pages can be migrated using the non-folio migration:=
 this is done for memory ballooning (memory comapction). As they get migr=
ated, they are freed back to the buddy, PageOffline() is cleared -- they =
become PageBuddy() -- and the above applies.
>>
>> After a PageOffline page is migrated, the destination page becomes Pag=
eOffline, right?
>> OK, I see it in balloon_page_insert().
>
> Yes.
>
>>
>>>
>>> Other PageOffline pages can be skipped during memory offlining (virti=
o-mem use case, what we are doing her). We don't want them to ever go thr=
ough the buddy, especially because if memory offlining fails they must de=
finitely not be treated like free pages that can be allocated immediately=
=2E
>>
>> What do you mean by "skipped during memory offlining"? Are you implyin=
g when
>> virtio-mem is offlining some pages by marking it PageOffline and PG_of=
fline_skippable,
>> someone else can do memory offlining in parallel?
>
> It could happen (e.g., manually offline a Linux memory block using sysf=
s), but that is not the primary use case.
>
> virtio-mem unplugs memory in the following sequence:
>
> 1) alloc_contig_range() small blocks (e.g., 2 MiB)
>
> 2) Report the blocks to the hypervisor
>
> 3) Mark them fake-offline: PageOffline (+ PageOfflineSkippable now)
>
> Once all small blocks that comprise a Linux memory block (e.g., 128 MiB=
) are fake-offline, offline the memory block and remove the memory using =
offline_and_remove_memory().
>
> In that operation -- offline_and_remove_memory() -- memory offlining co=
de must be able to skip these PageOffline pages, otherwise offline_and_re=
move_memory() will just fail, saying that there are unmovable pages in th=
ere.
>
>>
>>>
>>> Next, the page is removed from its memory
>>>> block. When will PG_offline_skippable be used? The second phase when=

>>>> the page is being removed from its memory block?
>>>
>>> PG_offline_skippable is used during memory offlining, while we look f=
or any pages that are not PageBuddy (... or hwpoisoned ...), to migrate t=
hem off the memory so they get converted to PageBuddy.
>>>
>>> PageOffline + PageOfflineSkippable are checked on that phase, such th=
at they don't require any migration.
>>
>> Hmm, if you just do not want to get PageOffline migrated, not setting =
it
>> __PageMovable would work right? PageOffline + __PageMovable is used by=

>> ballooning, as these inflated pages can be migrated. PageOffline witho=
ut
>> __PageMovable should be virtio-mem. Am I missing any other user?
>
> Sure. Just imagine !CONFIG_BALLOON_COMPACTION.
>
> In summary, we have
>
> 1) Migratable PageOffline pages (balloon compaction)
>
> 2) Unmigratable PageOffline pages (e.g., XEN balloon, hyper-v balloon,
>    memtrace, in the future likely some memory holes, ... )
>
> 3) Skippable PageOffline pages (virtio-mem)

Thank you for all the explanation. Now I understand how memory offline
and memory hotunplug work and shall begin to check the patches. :)


--
Best Regards,
Yan, Zi
