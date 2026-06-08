Received: from PH8PR06CU001.outbound.protection.outlook.com (mail-westus3azon11012003.outbound.protection.outlook.com [40.107.209.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A7823FFAD1
	for <virtualization@lists.linux.dev>; Mon,  8 Jun 2026 15:27:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.209.3
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780932472; cv=fail; b=mpW52y/Cwx144Dukmj4fEGG+KiYuoucnojk3QPxKSmA4E/u5LRPNkC6R1KFKPFIC1gsLc3XVbkmx1N/4Nq4oa3vaywGAxPuK6O0PayKghecVVU3wd+vxd2CrFmzmblSnZBiBUw5KNxpOvldai9Om8wAjUT8GHF+1jh6PfIcvQLM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780932472; c=relaxed/simple;
	bh=OFYq8Vc7Iep/qCG5BAPP5it6ApqCJwkMfG+oYROZH8w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=E203YbN4jERGbf4uo9yObXSozNnmty2t6Pw+YJMgr2PfCc/0bWBg2f8ahsunkaHHf5ZKfbD/Z5HdlFWxeHiwzyiQMG3qmy2xYsqMVc8TBx+Egl57qlFie/z8FyH5zdCMOH5CQlSHPN+Ox323jokUTeAsX7NljrADSq2eX03V4H4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=ZU5ioRD5; arc=fail smtp.client-ip=40.107.209.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="ZU5ioRD5"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=G5/VQBryiXnmo3Uz/IYmQg5lB8OypYa/A2zcIBfjRcBndxhiExwqHue3C+sh9U4+mA/Np3ljKOK9lbCuAm26uiiLOMY7iR5EbrpeLBN4nVVsD6h/+zoZ/qqB7SgTYPOmGeF+OA5p03Qz29QCJEKwWXbDZJrRGkkoKsuA8chuU4U12Sdb5vHUPhQ6gSE/4dOe6HbnqwEQKZmtDi+ZeJ3U33sD8OzCgvEZUo0o7jySg0KmwDiP9qCPMZFqTOkdf0JlNr81z4UwfaHQej7kwCCARAdP4c0bzVwBZXdVz+yhIVMcfMHrcyCNmD1JmxM6S8UHgxHDX5YLhEn2Pje3Z7GBbQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fSeF3v7zfQBEzEHW0nIwfERRccpPMhQWVXORWReQN9A=;
 b=B7D6sEmfYVncrfJepdY92MeAg5crtkRVSHxjoU5UymK4JxpUFNuyg4LJ7YZFdgIiE3SCHma3GVL55UT5FNlGpPgvEktdYZ4I9xZCFmpDevtQ7Jvge69f/Wgu7oLETDws94t1NzeH/3Qui2IzvUmKwO5cmKVbC+R9ZQl6qfKqVU5FdHMiVlJMuh+NrMZphLzQU9VveaHiesDwyW96d8U8E3lgf43PZgRcbkIKq9uiOEmnihSu6mEHdbKoCBZnBg7rr604H0ML2GLhI3PdfZRrK7zXJ2fomeJJ+i1tYT2EyXCCWO1S2Rnysiw3SZfGeaoulAr2yTx+D4NmbMD8yWIRqQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fSeF3v7zfQBEzEHW0nIwfERRccpPMhQWVXORWReQN9A=;
 b=ZU5ioRD5lPcRVmquk3dkDRgjbShGDq0YLPlgNZFkPcvmq82vMaToDF5Y3ocWpnhfqKGrgKhDbBRdBhaVTFndK97T3uU+UOck/AScvmCQb2DjdfpT53W+BdFhq3tg7vrDCYcyvAJexlhf16vlg2xZ4lcJN7z4JSXpXSVFC8CGmIY2do0vxtMKe3qkx32vW/1xXeLAEjN+rzFqYF8/nsJm5Y1FJuvGSBWIBZnczTo6mLljm8xpuLohm/Xu9qq7rFkwTQlf3oUz0XZq2hWYPjTuFMWFwBC/OmKMeqb61PkYFihbgkLdKv32NIIpwlsK7F6uU88MivnUSi6Bj79Wli5omA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS7PR12MB9473.namprd12.prod.outlook.com (2603:10b6:8:252::5) by
 DS2PR12MB9710.namprd12.prod.outlook.com (2603:10b6:8:276::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.92.13; Mon, 8 Jun 2026 15:27:41 +0000
Received: from DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::f01d:73d2:2dda:c7b2]) by DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::f01d:73d2:2dda:c7b2%5]) with mapi id 15.21.0092.011; Mon, 8 Jun 2026
 15:27:41 +0000
From: Zi Yan <ziy@nvidia.com>
To: "David Hildenbrand (Arm)" <david@kernel.org>
Cc: Lorenzo Stoakes <ljs@kernel.org>, "Michael S. Tsirkin" <mst@redhat.com>,
 linux-kernel@vger.kernel.org, Jason Wang <jasowang@redhat.com>,
 Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
 =?utf-8?q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>,
 Muchun Song <muchun.song@linux.dev>, Oscar Salvador <osalvador@suse.de>,
 Andrew Morton <akpm@linux-foundation.org>,
 "Liam R. Howlett" <liam@infradead.org>, Vlastimil Babka <vbabka@kernel.org>,
 Mike Rapoport <rppt@kernel.org>, Suren Baghdasaryan <surenb@google.com>,
 Michal Hocko <mhocko@suse.com>, Brendan Jackman <jackmanb@google.com>,
 Johannes Weiner <hannes@cmpxchg.org>,
 Baolin Wang <baolin.wang@linux.alibaba.com>, Nico Pache <npache@redhat.com>,
 Ryan Roberts <ryan.roberts@arm.com>, Dev Jain <dev.jain@arm.com>,
 Barry Song <baohua@kernel.org>, Lance Yang <lance.yang@linux.dev>,
 Hugh Dickins <hughd@google.com>, Matthew Brost <matthew.brost@intel.com>,
 Joshua Hahn <joshua.hahnjy@gmail.com>, Rakie Kim <rakie.kim@sk.com>,
 Byungchul Park <byungchul@sk.com>, Gregory Price <gourry@gourry.net>,
 Ying Huang <ying.huang@linux.alibaba.com>,
 Alistair Popple <apopple@nvidia.com>, Christoph Lameter <cl@gentwo.org>,
 David Rientjes <rientjes@google.com>,
 Roman Gushchin <roman.gushchin@linux.dev>, Harry Yoo <harry.yoo@oracle.com>,
 Axel Rasmussen <axelrasmussen@google.com>, Yuanchu Xie <yuanchu@google.com>,
 Wei Xu <weixugc@google.com>, Chris Li <chrisl@kernel.org>,
 Kairui Song <kasong@tencent.com>, Kemeng Shi <shikemeng@huaweicloud.com>,
 Nhat Pham <nphamcs@gmail.com>, Baoquan He <bhe@redhat.com>,
 virtualization@lists.linux.dev, linux-mm@kvack.org,
 Andrea Arcangeli <aarcange@redhat.com>
Subject: Re: [PATCH v10 07/37] mm: thread user_addr through page allocator for
 cache-friendly zeroing
Date: Mon, 08 Jun 2026 11:27:31 -0400
X-Mailer: MailMate (2.0r6290)
Message-ID: <AEB19464-20A9-4C5B-97B8-681CCDD81031@nvidia.com>
In-Reply-To: <64f2e580-aa82-4849-9236-b8ec4208ca24@kernel.org>
References: <cover.1780906288.git.mst@redhat.com>
 <50d410b47fe3f45327783e05bd306d5eaab75e65.1780906288.git.mst@redhat.com>
 <aiaUDTeHDA45ZXFS@lucifer> <64f2e580-aa82-4849-9236-b8ec4208ca24@kernel.org>
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR13CA0058.namprd13.prod.outlook.com
 (2603:10b6:a03:2c2::33) To DS7PR12MB9473.namprd12.prod.outlook.com
 (2603:10b6:8:252::5)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB9473:EE_|DS2PR12MB9710:EE_
X-MS-Office365-Filtering-Correlation-Id: 8370052c-bdd0-49a6-96c7-08dec5727b0d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|366016|1800799024|11063799006|4143699003|56012099006|6133799003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	YOHQhzvBaeqsmlazoFZsCKtQ/gHhSVYhaNOLEm4sytCZd6jiCmKMKvDSiWW95hiQKKwPeLODibZcZ3pDiPMghbJScUUm8Cp/D3miGICSFK6prZFKDLtBA1tkKz1L63oP+afQU+yZdnKHSz3VOrwRHH+00MwIkOkdQ5cQSd24yS/5MSFfULa1QbB0FhcVdo2iwcHYEASEMTpdRv9l9l96Xg7IAn/3bDQb+WhEGdhHHCo4NL81NAeiE9oRq8vC6yCh+nhM5mLIXq+2sGU4LY4ZG1HrNEp/8VpCNp9cJWFC62ZMRCtaASGmc8kj2/plZdaQRyXkBrKpU3k1DoaY7MTZYFW31TScL5DTCGHN0ZhpP4gR+VxkuyafVICxTxvqP+rDGF+JdsR81zzJ0tjm4qjMDQJWWO7LhePcQH4zsSHYrsHcraFA9hJMjce0FP3kj1ptR3kJ1MT6eKHBv8NcEaAX2HgmUIbTVOmCUApw7nrEmzG0hajwSl7q1SknbIez9KsJOzQieWxD/SH+AoWvYhvE6egLKjUiKe4pxPAQVIAr/l/31mXiymyujimw5zFyJF67NnyQR+4FPw6cIRuD/dACoLr6VpsNumuQ+I249A4rpfTwul1TTGT9y8IDx/1aT+K19WuVkswi6xILC+NEk/4D6qmiST5XIfBeuauIjjO6RR+6Zcc5HXuDGeL4TgAY28nA
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB9473.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024)(11063799006)(4143699003)(56012099006)(6133799003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?+Shc/nztSTZxTZPJnLxru/K0XrNpDoGqT41+1CovLFJEedEpizouVxnmSFH7?=
 =?us-ascii?Q?thA0iGT8DVzEAZtTqOmFdWwLPQ52h7DZWxhjc8uxOJrZW+/IsOh4mIVTWB3D?=
 =?us-ascii?Q?eXn4kUWWHhdwU+sQHq64eWW3/5zNCgqIM/zK/4p2Ms1KCHnFB54jRNx3eVwa?=
 =?us-ascii?Q?JgAleaPWxH3PASjGCNg/3AWNNoWxi0Icw7FvQipGPXkAcN1uieTShmyLDq2i?=
 =?us-ascii?Q?QDz35beRCiAT5AHJxwe5cG3RpEBgvT6PGdgQpKEU4xX3ayBzh3jEFlIZ+N/t?=
 =?us-ascii?Q?gL4ZHrNo5jioxGlHHEoA27l8mSesyHnVjidejs38XomlZBED1KVlh2sIMSNG?=
 =?us-ascii?Q?vq8eY74shXxs7tb/6jBZee5Pd9/UE4UOwYf3Y9+sEeQ9BD++FYj88O6Q9Ras?=
 =?us-ascii?Q?CMXheIYuu2xin14BqCBFF8BVkT6l5Jaz95Ouu20BubdFY2YuQ9zBeWpIUrlh?=
 =?us-ascii?Q?dgt54N1UCuSVpG3I1epsCAB0cJvEH+Ms0JZ1sZ1rb3ytwbJRDvpYxwVMsuBA?=
 =?us-ascii?Q?aamdsV4CkHnNav+DKRJt289XNggJ5kvNoE+T9ZOFALKPnSDc2zb9LWIYEkLe?=
 =?us-ascii?Q?XAxcskykUPNMO0ja8wFY+tpozpV2wkHM5TH0UAdaD0apgABX5KTLeiY+XlVO?=
 =?us-ascii?Q?7mqk14P9TzgrK0TzRXxBkVRdPE+HGk3cO5UBMzrb2VAoBMKhE8Rpwuz9tMc9?=
 =?us-ascii?Q?BgTrNJBD34emtXCAaDZbF4nSSYxq7JhHsTW1+phhtr+oEe2Y3OyrW9H5oOmb?=
 =?us-ascii?Q?VR7J6wYSvko/WmPuyQQTQECDzSjv4PvBHgvHQxH6z4FOXqIuxUt22VugLP/2?=
 =?us-ascii?Q?Uy0RP9l9HmXTpGdmygKOdM333jXfBLv9LWcN6YkxSKChxTv4AaUPXfnCxaQa?=
 =?us-ascii?Q?eTTe7wxgwH4DDs0okfhgM8YC3V5BoPsu+0lfRSpVXykK+jFG7dbX7IY+JXKh?=
 =?us-ascii?Q?osVsxQlUxc2Hl0r5ouIEudykVPiLLNaJvZDARyfecjoFfUK50nx1qF4LJVPz?=
 =?us-ascii?Q?xMDv66nTxykH7eckpV/hWABTWa2DbPze6Ehj1WIlCK74WzKEv1473wB1UcDL?=
 =?us-ascii?Q?HelR5GjM/oFyl8W20965NColN8CJfc1QdI3r4MfMIbWBVgyI+HePsy2yHGzA?=
 =?us-ascii?Q?kKoAXCmGRm5mB88F2rmcX9j2VXbiUXdjlkq/xvfzY6Ts6Fq5VGzjYEzbBPTl?=
 =?us-ascii?Q?RAxzFd1/W50C7jYbCymLIcoh1G+46uQNmQhj5EyLdPVvOXaCzqaOPMGvW0JC?=
 =?us-ascii?Q?tQlTauMuvdZDbBrYaUMSe4w/6HCgGYKa4xboqPEAh9rjiPLiFPukLN4NVD1h?=
 =?us-ascii?Q?gEEPLYlxglP+XTt4JyOcEO2onhFJRnCZpUa2oWVBHmzt+7YaB2Iqe4GM8P8t?=
 =?us-ascii?Q?y7JN76lOUSE+/dD4dXs2iy665z9bVaih++qyEUl3hZxFWPliZliEsXAeJJLx?=
 =?us-ascii?Q?7Zrci2YDnwZGGx0gd7Lg+g2jy6XxjUYFK4DOhvqvjUrJdP7XnWLUF3vmG5/z?=
 =?us-ascii?Q?Kf/95/7bilW62xHYPJLYpusjyE+I1O9Y2Th/9QlwKKjyfpJfcyErLoHMyr65?=
 =?us-ascii?Q?yaoDqPci25gF8tf2wsogsoW8Ge1vaSZnOBTj09AQffvOmK6Cih+POO3MMS5m?=
 =?us-ascii?Q?HruzY+2wqa+/qjvPTkAP1I1fu9Slf/H0kCTAbtJJ6GkHeWc26TZ1MXciekI4?=
 =?us-ascii?Q?/FrS5+cb4w8xTh84qTT8Hae1aR2JKFBwsu7+tpsXAmK7AeqQ?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8370052c-bdd0-49a6-96c7-08dec5727b0d
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB9473.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jun 2026 15:27:41.6481
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zicRQc7atexF3ooAlI2/aMbqRUmceSIRkLdfJdJUyM8e54RMIhTMwF19iGCHEFud
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS2PR12MB9710

On 8 Jun 2026, at 7:08, David Hildenbrand (Arm) wrote:

> On 6/8/26 12:23, Lorenzo Stoakes wrote:
>> I noticed this patch, again, sneaks in some additional code changes that
>> are not mentioned in the commit message and seem irrelevant to the patch.
>>
>> Not sure if the AI is doing this, but please don't do that.
>>
>> On Mon, Jun 08, 2026 at 04:35:17AM -0400, Michael S. Tsirkin wrote:
>>> Thread a user virtual address from vma_alloc_folio() down through
>>> the page allocator to post_alloc_hook(). This is plumbing
>>> preparation for a subsequent patch that will use user_addr to
>>> call folio_zero_user() for cache-friendly zeroing of user pages.
>>
>> This feels like very weak justification for code that massively changes mm
>> code and makes it all much worse.
>>
>>>
>>> The user_addr is stored in struct alloc_context and flows through:
>>>   vma_alloc_folio -> folio_alloc_mpol -> __alloc_pages_mpol ->
>>>   __alloc_frozen_pages -> get_page_from_freelist -> prep_new_page ->
>>>   post_alloc_hook
>>
>> Is this the only relevant code path? You're changing a TON of code here
>> that will have multiple different code paths?
>>
>>>
>>> USER_ADDR_NONE ((unsigned long)-1) is used for non-user
>>> allocations, since address 0 is a valid userspace mapping.
>>
>> Ugh god, so now we're passing a user address through allocation paths that
>> might not even be aware of this or be allocating memory at a point when the
>> mapping is known?
>
> The original ideas was to do this only with internal interfaces. I think I
> raised before to leave hugetlb alone for now.
>
> Fundamentally, user_alloc_needs_zeroing() is something we should get rid of, to
> just be able use __GFP_ZERO and do zeroing at exactly one place.

Just a reminder that user_alloc_needs_zeroing() not only checks init_on_alloc,
but also some arc clearing page requirements. To do zeroing in one place,
clear_page() used in post_alloc_hook() will need to learn how to handle
arch-specific zeroing from clear_user_page()/clear_user_highpage().

>
>
> The question is how to pass that information (user_addr) through internal APIs.

Or should we defer zeroing after a page is returned from allocator? So that
user_addr does not need to be passed through irrelevant allocation APIs.
Something like:

alloc_page_wrapper(gfp, order, user_addr)
{
	page = alloc_pages();
	if (gfp & __GFP_ZERO)
		clear_page(page);
}

>
> I previously said, that ideally we'd end up with a folio allocation interface in
> mm/page_alloc.c, from where we could get this done more cleanly internally.
>
> But I don't want what the previous proposals did: use GFP flags+leak state or
> return magic "zeroed" flags.


Best Regards,
Yan, Zi
