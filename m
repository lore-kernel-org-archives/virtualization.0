Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2076.outbound.protection.outlook.com [40.107.244.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0F6F190497
	for <virtualization@lists.linux.dev>; Wed, 14 May 2025 15:49:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.76
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747237777; cv=fail; b=dWqrR9FYS/hCxZFBbw/REoJhbGs5dyFU7pcuKrXD8KWWQNqBlwtnLie08+6qdrlCKYF26k9CzxnlFIviQZwXgugyMYTXHNSvxbNa9kVUNZWtlSGnwgQYUQBqgGtTUSZwn8S30gec/pOp5gzmONV0U/hCsCB8E6Or3pADOEr7K4o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747237777; c=relaxed/simple;
	bh=CweNqeKTkaK49C98GhABsoSqDlWvOG34ELRK3WzKATQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ld4J+ig1bMR9igx9RGQvbYjdOrCOtQZRwAEFKZKb9KIElVlCSQSUyeFiUCuIgm4J1PfKWpVATDaZlyypCgmwB2L69YH8nqUcPUh27+oNGXlHpR/am9EKkzjKnurilS+erM/7VBoZgRipMc07ZF45L4pzPKXK1kv0hEocDft2Pe4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=sTp0PxRV; arc=fail smtp.client-ip=40.107.244.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="sTp0PxRV"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Wv/j3DyDmbPfcVHJBzzmjD5CrBYK991fLVxfmEgh5lS1iJ1tDPTpBK6csZ/5/bWktEFH/qwkWzyxObgZc61c2v2Roj76EHXKzNzWw5yZ3izGy8eHhIS7m1sOTNfvgr2DfMRJt/1kSYZzD2tjIcEVqlSikfg14ytoSu74JllhtVNkbTteQ1ZUTNz8Pjin7o0uDCZ+FsQG5J8nIBleIVQOa8dVHJNQzXNWUtB9bkR3TgWHGFi1yLLfovDIzYrDeJtmMexdnnqNrsq5B0lYbgtKdSc02T7Fs4l6BV/IAarMjZaXCKFqQP+E03s2uJTgZPNHc3DXXmo7kaSrg9Kof4r+ug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CweNqeKTkaK49C98GhABsoSqDlWvOG34ELRK3WzKATQ=;
 b=bXl1445dFW1nWeDg0Q8/9fX3xRgYOxyAyzCRjTZogpHJeg5wdJvzEb54Wseuciam1dyri7D+OVkHYPx5GWjZ69/fglwD/MJOsLLNw/Kp5qk60VFrxsjgtPxbz7tB2fNYH9fvyaZ5pxQgExyDEKsOEpX695KcLLqOrOWWTnC2+qWjxpgUtaaTbvRgjtCPsUHsKMWebnngHC2Mbh5ru5Y3wQAQZBp0w6Gd5sfPDpbu4XshpdnydwbrslubnCLP782KorV9D3AZPAq7yx0h6lBNskZK8HbgKhaMTH9TLaij2/s21ll+USdqgE0H2OOpQYpCu2IemU/0YTKJBwNWMOHgyA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CweNqeKTkaK49C98GhABsoSqDlWvOG34ELRK3WzKATQ=;
 b=sTp0PxRVWvMyn1OUnC8CO4O2UxR0uHbPiWuF+qvzc7cScato6HTaRI7YnPxxQWKd8B9C0PNb4YoNDm4mcG3vLvkbqoJN0V7/ziqL2c47qC5ZBBz11YehS/1xoivxWr32zlxc7UQpX4k8456fMqMfX5nEyZ/2OrJf6sC1rO+JkuQDu1SHbRFqCJzn6924eLZgjskRQRDyyxeQBmFDbMcYuqK+1VMgwHs5IavD1rqOtuo/G7jw1W9rmRkZ1FLMCGV1gC1StOzAOX7pspkilx4cRM0XlZpeJkA1pX2ey1RlmE2qo0VzCNB0sNc3//tamXynzLbl1E+eO51bYnQ82Fn8Qg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS7PR12MB9473.namprd12.prod.outlook.com (2603:10b6:8:252::5) by
 IA0PR12MB7699.namprd12.prod.outlook.com (2603:10b6:208:431::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8722.30; Wed, 14 May 2025 15:49:31 +0000
Received: from DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::5189:ecec:d84a:133a]) by DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::5189:ecec:d84a:133a%5]) with mapi id 15.20.8722.027; Wed, 14 May 2025
 15:49:31 +0000
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
Date: Wed, 14 May 2025 11:49:29 -0400
X-Mailer: MailMate (2.0r6255)
Message-ID: <1662085A-4536-4020-957D-90FB262C6014@nvidia.com>
In-Reply-To: <8ce464e2-1447-4e60-8abe-f4ddd511d7a7@redhat.com>
References: <20250514111544.1012399-1-david@redhat.com>
 <4B7FCC74-EAB2-426B-AFE0-4250FE4F7480@nvidia.com>
 <8ce464e2-1447-4e60-8abe-f4ddd511d7a7@redhat.com>
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: BN9PR03CA0240.namprd03.prod.outlook.com
 (2603:10b6:408:f8::35) To DS7PR12MB9473.namprd12.prod.outlook.com
 (2603:10b6:8:252::5)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB9473:EE_|IA0PR12MB7699:EE_
X-MS-Office365-Filtering-Correlation-Id: b7718875-e6de-4a06-db42-08dd92feeaa9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?V49lA0YScqeaaVbSZGHtR+8lXaQFm0z+dwC4zCrd5cQ3rPVWOGBqrSyacsSb?=
 =?us-ascii?Q?PE9A3vPjjqVydbVe9k2HU/Chci1Q8XplFCZW8nS1KxE4RKmeOyKAnLKNnqiq?=
 =?us-ascii?Q?oXEe2ojbxm4PJOgJOpjqZXaDi/PMEAyFgjkBDzvBLOEkE1l5knQPNLMaB6MO?=
 =?us-ascii?Q?shdp6vdfA66gSu35AtzaZGXHFSKDyaTFpPlz47QDqH1Ou2cOgl4ztv/3ELrM?=
 =?us-ascii?Q?YHjNfZZCiUT85jRa118gv9Nji15AJUz1bTJRCAfUpWDq1v0IG8I9T3+qNtcm?=
 =?us-ascii?Q?FIeD/dCw8vFe7g+gw3yYkwCSFHzkMy3KOTCZGVyyIZzGHoCJlMZQySz2rz0y?=
 =?us-ascii?Q?L2b+gSYNWSE2fbk4k6NYYM10/M9K2NZJuJtBe50YRsxnRLKGGUwUCpUVvFu+?=
 =?us-ascii?Q?vq9T9r0J1aCOVZ93eV3OK++6YyREuCWTtwCn8HudKDlzd5So/B+bU55+8XUx?=
 =?us-ascii?Q?zccx443JEQRX4kwAKYqvigU1GTqXXKNfpe2X6D9akJHRXLnTuYIdS27aE/ha?=
 =?us-ascii?Q?vgPoJFelgCrxBPnc6HehpVH+RmBLWU5WKGpu7zrX9zv+PwST++byB7XKUiqG?=
 =?us-ascii?Q?fQ90RYLA82bmIXvS1Dy+rTF4CSLRVel/afLsTp2MpViNNjJOMNvcW2bjn0WW?=
 =?us-ascii?Q?6sW8Z+eMEpmWf8fvKj187GH0HRH146ReP5h2cXRIdAoLkOsBUfQuVVl+WG+X?=
 =?us-ascii?Q?kQogu/pN5F1PmunUsrEGELEWKrc1FdSvmexXvr6HmgIQbnl0cLv/H6H6Ko9x?=
 =?us-ascii?Q?gQYiWD+4o38ZDUegaBFQ9UPh6J27PH4rOWv4Pvo8LkkCiIkNUVeeV+0WmtCv?=
 =?us-ascii?Q?BjS2VB/HQAHzX4vDdfI0+H9vbPV3diO25uuDuekiDDcZv6GAtaxuQkXlQjfl?=
 =?us-ascii?Q?4N7XAJaj2+PoDsd8DvtXtnQ7GsVYt/RbRZFugSv5LjDLfC22kAm8BJFEJLZ2?=
 =?us-ascii?Q?TNntNTmb0e7hNJoJuFF/A8gKwZNuy2Ak4TaCUu5+3gb1eaarlE0/dFuL0kqL?=
 =?us-ascii?Q?vAfXD4Tf0y7wFNPec8riQ3+IXQxS+p2cLY5HETpilVPzAdwQ+k7DGW3zuBI8?=
 =?us-ascii?Q?OWOv8ni2dSpjEH8x7MPT3G8y1pCW/ckgk5Q/l3uE3RKwu1Lt/YDauE8bQ+JI?=
 =?us-ascii?Q?1R8hSLOeRq/sCVVjgQkPztSLzCO54/PXFMi+yzsA5Jy/w56cHEJlfsSikBwu?=
 =?us-ascii?Q?GwLvUSLX6UcZOaBcQ9oA0WUs3if+ITH504RF/v3w+5YWcZh3kca643n2DqQF?=
 =?us-ascii?Q?iUnNuqBfgkBEW0pJVN5KpIr/3z1adZI8L08RzAJ3idirfXXjOyTNoRuRtH+g?=
 =?us-ascii?Q?1pAEcSH+nr6fLIx4t5z8WpsWxEFf0f229c6200mFxoCEJCMt5qB8zJvlFQSB?=
 =?us-ascii?Q?x3N0IIlMEcCd40+6HI2kpto06Mw3ZMGFxiLr/diQchw/gXxXxrvfpdG9+/be?=
 =?us-ascii?Q?PTnXrbZYcc8=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB9473.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?UXf5MF7xUmSYWN4lf5dt6kuILe2t7593TmvG4OBwiCnWl+GDokXsSgIT1z8d?=
 =?us-ascii?Q?MtWBeKcScPFlm/9CXd7Y8Z78XgE9v5u6ZcTH1lnr7gipOJI4VCmkb6pKt46w?=
 =?us-ascii?Q?Q3HdDTFw7YCorsFvg2eiGLFZzz7QA/+iApXmGHD53JSTKaeVEFOoSEmfwDo8?=
 =?us-ascii?Q?wFg2LD8RpFWfDLi1WqsH8ywwv56BydpvvMgBDhDfr602t4qDQbztdVKaFTEb?=
 =?us-ascii?Q?U7d6KpPzqG1Vum3c/ySg1i7ma/EszxujGF7qQ5vHzsX555wDXVDv2He1PIJo?=
 =?us-ascii?Q?Z6n0dTMJ4EdrmlZkDapZ9AkcuxwfP1+Wc4CgAbPDA9rJ3N5V8ZreAssju5x8?=
 =?us-ascii?Q?3WbXZagS+N6wfkCnCtjgAA/NWVlbfh+cXe4H0EWi5/q7lV+smEJCOLs/dshh?=
 =?us-ascii?Q?QoXLt9LtiEdYd5wWWS4JHMjfsto0mk67HOYgLjQLhUI4O8rpuLqjvRmWuvy9?=
 =?us-ascii?Q?QQzzW+fnU57iiuZtkfChgyfg5bpUFL5E9v2WIvm3F+dLUU4W8jhCfjIHR0jK?=
 =?us-ascii?Q?8uk8NOtJqMKArdkPpI0F027LQqw04dklw0UJ00Zr3tOEJl9fV0bvGCfrQdAp?=
 =?us-ascii?Q?8EQkuUUIsoNStDI2BdrfCHx/O0F+sFEOf3XPMoPvzgEbL7bPKNKOcddTruFA?=
 =?us-ascii?Q?FsJiMB91B+xvMgJmJWJxUwEnKHXQ1axOBLw3f8Q2vpSmFYHUaBFnTirtSRgt?=
 =?us-ascii?Q?OE2bv/Wimftz+/OFjWR1oubKnEb8OgpBsQf5DqpYqbgQDD6wrA4xhoIvsk3C?=
 =?us-ascii?Q?qti0WT0vd0pK57qh2oVaasEIl0z7sLnqbU9ViXtU3HX654mZO66WMr80mJv/?=
 =?us-ascii?Q?JNyLq6GsThwrjR2byOrO2e4pijXIwyQ6FtFzbyBu5G2T+NrXTre+t/N7PMJ/?=
 =?us-ascii?Q?v9uSLNzT5rg15vhSzcjVFIszaPr7k5rgBMYaeIb3vz6svI3D90ZQbSyqLMqI?=
 =?us-ascii?Q?DJCwt1gSg6Vfcz5tBI4B6D8vI1VHxKIGJ30Tt3SE3et62egX/2PNNItcWjaU?=
 =?us-ascii?Q?hHEtesDjirv1Fc5Je8qf8TQ9fSd2F4jO8oe5z1mlzdP5sOhj7+C3UIecF1we?=
 =?us-ascii?Q?tzD2ECI5glYrRchUlJ1MgaWAWRG4Q6N9eCFfmLZRd0TDzmsKJzF13isz/5iF?=
 =?us-ascii?Q?g5jH0WzmYCjULP+TAM7SGkbh0qWKls29bEMhR3WrhLKFNh0ijSO6RedWPH/2?=
 =?us-ascii?Q?QZlvxY6926WD+DM3knuwE5Qyw/TTE1QzzUIZj+Rj3P9TeuHID5GI9XWNV0xU?=
 =?us-ascii?Q?lJlOZALYqKNo7zR7ykgzcQYFnVaSN0tsTBcMdhWPqQeQ9OJVOPpGZvUGLLuG?=
 =?us-ascii?Q?NzLxhN967CkapXUZUiX6QX6EsMyePEuafffbS4mloh/xe8jDXd36jQJIFIId?=
 =?us-ascii?Q?hGCp++6i3uNJ5Ab8WRYuL6GlT8Da7dO6IaRcc/Lwrj1VUak82oJwhtjgwLmz?=
 =?us-ascii?Q?WBuX1d06OdSQ+9k0DBIp8EJDviMGDQMd4KqWXSU1mJcTb8AHfnfhpPhaG0Ls?=
 =?us-ascii?Q?DUiPgtt6AJ7WdgFRdOTS188Uw4raDqImUgexOtx08AocnckF7Jm+got3xOna?=
 =?us-ascii?Q?P8FFqEkc8+KLWkwvOJGG2SFJaKj6ZqgoQzT2k17E?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b7718875-e6de-4a06-db42-08dd92feeaa9
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB9473.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 May 2025 15:49:31.4037
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: b+7ym4BOvluoGxXTm3CAsQh0xVnPWfuGH/qnMIuAAquTWMwn1OhM9dkTqbVx2l50
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB7699

On 14 May 2025, at 10:12, David Hildenbrand wrote:

> On 14.05.25 15:45, Zi Yan wrote:
>> On 14 May 2025, at 7:15, David Hildenbrand wrote:
>>
>>> This is a requirement for making PageOffline pages not have a refcoun=
t
>>> in the long future ("frozen"), and for reworking non-folio page migra=
tion
>>> in the near future.
>>>
>>> I have patches mostly ready to go to handle the latter. For turning a=
ll
>>> PageOffline() pages frozen, the non-folio page migration and memory
>>> ballooning drivers will have to be reworked first, to no longer rely =
on
>>> the refcount of PageOffline pages.
>>>
>>> Introduce PG_offline_skippable that only applies to PageOffline() pag=
es --
>>> of course, reusing one of the existing PG_ flags for now -- and conve=
rt
>>> virtio-mem to make use of the new way: to allow for skipping PageOffl=
ine
>>> pages during memory offlining, treating them as if they would not be
>>> allocated.
>>
>
> Thanks for taking a look!
>
>> IIUC, based on Documentation/admin-guide/mm/memory-hotplug.rst,
>> to offline a page, the page first needs to be set PageOffline() to be
>
> PageOffline is not mentioned in there. :)

Sorry, I was mixing the code with the documentation as I was reading
both.

>
> Note that PageOffline() is a bit confusing because it's "Memory block o=
nline but page is logically offline (e.g., has a memmap that can be touch=
ed, but the page content should not be touched)".

So PageOffline() is before memory block offline, which is the first phase=
 of
memory hotunplug.

>
> (memory block offline -> all pages offline and have effectively no stat=
e because the memmap is stale)

What do you mean by memmap is stale? When a memory block is offline, memm=
ap is
still present, so pfn scanner can see these pages. pfn scanner checks mem=
map
to know that it should not touch these pages, right?

>
>> removed from page allocator.
>
> Usually, all pages are freed back to the buddy (isolated pageblock -> p=
ut onto the isolated list). Memory offlining code can then simply grab th=
ese "free" pages from the buddy -- no PageOffline involved.
>
> If something fails during memory offlining, these isolated pages are si=
mply put back on the appropriate migratetype list and become ordinary fre=
e pages that can be allocated immediately.

I am familiar with this part. Then, when PageOffline is used?

=46rom the comment in page-flags.h, I see two examples: inflated pages by=
 balloon driver
and not onlined pages when onlining the section. These are two different =
operations:
1) inflated pages are going to be offline, 2) not onlined pages are going=
 to be
online. But you mentioned above that Memory off lining code does not invo=
lve
PageOffline, so inflated pages by balloon driver is not part of memory of=
flining
code, but a different way of offlining pages. Am I getting it right?

I read a little bit more on memory ballooning and virtio-mem and understa=
nd
that memory ballooning still keeps the inflated page but guest cannot all=
ocate
and use it, whereas virtio-mem and memory hotunplug remove the page from
Linux completely (i.e., Linux no longer sees the memory).

It seems that I am mixing memory offlining and memory hotunplug. IIUC,
memory offlining means no one can allocate and use the offlined memory, b=
ut
Linux still sees it; memory hotunplug means Linux no longer sees it (no r=
elated
memmap and other metadata). Am I getting it right?

>
> Some PageOffline pages can be migrated using the non-folio migration: t=
his is done for memory ballooning (memory comapction). As they get migrat=
ed, they are freed back to the buddy, PageOffline() is cleared -- they be=
come PageBuddy() -- and the above applies.

After a PageOffline page is migrated, the destination page becomes PageOf=
fline, right?
OK, I see it in balloon_page_insert().

>
> Other PageOffline pages can be skipped during memory offlining (virtio-=
mem use case, what we are doing her). We don't want them to ever go throu=
gh the buddy, especially because if memory offlining fails they must defi=
nitely not be treated like free pages that can be allocated immediately.

What do you mean by "skipped during memory offlining"? Are you implying w=
hen
virtio-mem is offlining some pages by marking it PageOffline and PG_offli=
ne_skippable,
someone else can do memory offlining in parallel?

>
> Next, the page is removed from its memory
>> block. When will PG_offline_skippable be used? The second phase when
>> the page is being removed from its memory block?
>
> PG_offline_skippable is used during memory offlining, while we look for=
 any pages that are not PageBuddy (... or hwpoisoned ...), to migrate the=
m off the memory so they get converted to PageBuddy.
>
> PageOffline + PageOfflineSkippable are checked on that phase, such that=
 they don't require any migration.

Hmm, if you just do not want to get PageOffline migrated, not setting it
__PageMovable would work right? PageOffline + __PageMovable is used by
ballooning, as these inflated pages can be migrated. PageOffline without
__PageMovable should be virtio-mem. Am I missing any other user?

--
Best Regards,
Yan, Zi
