Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2086.outbound.protection.outlook.com [40.107.93.86])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBD2C18D620
	for <virtualization@lists.linux.dev>; Wed, 14 May 2025 20:30:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.86
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747254641; cv=fail; b=VEfIZnYLjpO57a+ApGLkETkTJuvSQo7/KsJtZ0Ad200MFiYAepjqYjU/yLwmI7VBsyKO/+TE4HId4g8Zxyd5z849yfhwYZRSQDQNGIX15IYD8zwjCfPUXntUDeZjRaXzJ8JX0aldx6J0sDjIu3/JxIE8bTl+gSnp1OAd5JnmF08=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747254641; c=relaxed/simple;
	bh=tNPYANixIP69beMV2QIZb+BaOVq42zU23ytn9zO4Scg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=cAx/N+LLitJAyAQwxwGoz3j2qd/7xlaS/mxcIR3csPgTlhwD6jzctYGHinvK9xdDfPhRXxYsRDzYsTgWHMk0RdWbq1d7fiUCW6xS+eg1j0mrodjipczG1TtHGP8dWuvWYDs43rSdhz/ypbyCZpWL8yTGOYL95901MvrOLed2V+4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=jxnwJttk; arc=fail smtp.client-ip=40.107.93.86
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="jxnwJttk"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ccmZ1h5LBlTqCejUkUtjT8OYJpdl17my1zg+3+3ww4Bt9cNxPuADtxZzr9rdz4n5Bgb76NKfcvEA1bbL9O3XQsZYflzuup0lfsrCx6j8XCJ8l8UU6h5s8Q01poT0pq32bBMAv3Edu0JdnzinrVengmm8GT1lwGhJwiRZUXsKZOYabWk2PEr/vJ+187yK4nL8iDIS2Fb/3v9B9g1KJRhIl/GqFOtjkP2sVNac4T0pYbKIqQOaFJv/MenSKz7KK+jeci4HdUg5w/52XgvIR9AX7dSboi2dWssXlxW7GF5dV3QBLUM2NNgJBdce+SIL2keFAlX1lbcQ8d+FgNfmn8dgYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=451TJi/qi+0YhAjSmC4XWk341FlTPZEn6A5i4UcgLh8=;
 b=hsFp9hwllwZ7DMTcdD+Ml/xc/3s7ekWvFXMjLtxEhSFDMd+HefaO1fLzv8e9gyaJ7u9d2KJPKN9StOBWj4szkW6EwEzZ2nEMDWB4nrTZx0fuYbBmatkb7Ol+lmrb1JItoB6wN9Ns7rzN1yxTLv/xdMbpDj4pNGArZ10mdlawdMoKLLrnMSLr1kqEehY7YRek/7puy7ow0e6fUu3JkNOA7hK9cSVw6z431lJhJ8S679ZuHc6mz8u+u041U7vymxnkFsy5nVP+tyo0VXGuijz2esxPBrnLzM+8a8PYmIVd29NytdhYpFn12WxSM3IJJ25iWmpOWQv/AookIoWz0mEeRg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=451TJi/qi+0YhAjSmC4XWk341FlTPZEn6A5i4UcgLh8=;
 b=jxnwJttkQ+lAkIm5YihspzA9vLBgy4UKotQUi+Z7WaA3fbqSqoDIDU1UJ6cos5FYmd2nXYXjfQpY64cww3z260oGkt/Scjl8Qa5cJ1ljyYZKwrF9LPZzhdFWHOCiQGg/dceTlWBCRdcjqIiUByUSiFjRKMp6GtlcuQ58X4+GAoYemmqI2G2eEu9ton7lq+eAaFxG6TE0etbiajVBSC72fvrBWxmJJVpmZeN3Il8T1fKziqRSfmZyGfwRQLR54SfGzbH36jCHvSoAuwJLCugDlT+aSwoCJugkO/R+FVFg89Qab3oUPRjTnH7XZNoYyzo32xyjk2ucxf2LsYw0JMSQHw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS7PR12MB9473.namprd12.prod.outlook.com (2603:10b6:8:252::5) by
 PH7PR12MB7915.namprd12.prod.outlook.com (2603:10b6:510:27c::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.29; Wed, 14 May
 2025 20:30:36 +0000
Received: from DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::5189:ecec:d84a:133a]) by DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::5189:ecec:d84a:133a%5]) with mapi id 15.20.8722.027; Wed, 14 May 2025
 20:30:35 +0000
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
Subject: Re: [PATCH v1 1/2] mm/memory_hotplug: PG_offline_skippable for
 offlining memory blocks with PageOffline pages
Date: Wed, 14 May 2025 16:30:33 -0400
X-Mailer: MailMate (2.0r6255)
Message-ID: <0F0BB46A-F7C2-40BE-A045-C65525956D52@nvidia.com>
In-Reply-To: <fb12fab1-f2df-4b4f-ae83-1b45e2a7d6bd@redhat.com>
References: <20250514111544.1012399-1-david@redhat.com>
 <20250514111544.1012399-2-david@redhat.com>
 <7E5BD96D-971F-4AFC-AC09-503310BE8E68@nvidia.com>
 <fb12fab1-f2df-4b4f-ae83-1b45e2a7d6bd@redhat.com>
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: BL1P223CA0024.NAMP223.PROD.OUTLOOK.COM
 (2603:10b6:208:2c4::29) To DS7PR12MB9473.namprd12.prod.outlook.com
 (2603:10b6:8:252::5)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB9473:EE_|PH7PR12MB7915:EE_
X-MS-Office365-Filtering-Correlation-Id: d7859a79-9d10-49c1-4aeb-08dd93262e67
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?sFxd3KYfDDRMdDQS6xAKErtdabCKCBppbhBn+3eDJ6jUilJkG4nv4ZWCkcsI?=
 =?us-ascii?Q?cKGnB9/TLmVZOu+9LLS9MGirkpJmweXTMtULIrrQG6jQ3J8pO7Q+G54rumXm?=
 =?us-ascii?Q?zuoxtExQeB6vXzv7wzjhtiYhmngPysFmHlMymRzsUHCpmTyM1IWNuZ6GolVk?=
 =?us-ascii?Q?rtrNpKx8dotqbM6geyBxaTtNwJGCCA2GaPjPpO6SSP/Mcih62O+1k81b0Qj9?=
 =?us-ascii?Q?0+80DN2KYfWbtJhyzIEOJzWlESDW6tOdU3A85HaepIQGc4WId5ttkOa8ZTOj?=
 =?us-ascii?Q?gFLcUUjdhTYE0ALMU4r6z4vcwG5Gd3lNwbpy5omU6hIczM4CWb//aH4l9LW+?=
 =?us-ascii?Q?PhTnIdjmcORjXYTYtbF+RoH7kxvhZ4IxnxuOsAlZBV1VJqBlTlSW6+JA7KkD?=
 =?us-ascii?Q?6InlKx2eRbdtpc4ho5U3OVV1gttdR5B0e9pxR0lZkN7nmi+1Cy7wyi2GH++h?=
 =?us-ascii?Q?+bY9D5MbnCWxrINOa9DxsdOEvaPW9DnNJZWnmLoM/GJSEqHDC0iaJSOlYMXa?=
 =?us-ascii?Q?e3s9aVhWnGoBiEdLFRdC6JoWZpadW2F4sxbqq7r4kdtpT1GjLv5OU2kNWSn0?=
 =?us-ascii?Q?8tnRNE1N6PIiQFN9/8ctCyLToE6h5O9ED9UEJv3n+sxb0WCo9Oh8ZnlSsdeZ?=
 =?us-ascii?Q?o7FOP5O4QXeg4GbW7sn470nHSK1L3KQvOhXLZkBE3z8vCm16CPIgK9vObDEo?=
 =?us-ascii?Q?HafykTBuS5oOYoxzbktH6GWuNai2eWudZA3Mo1NFdW1ZcpQ65+q+PXanwpRD?=
 =?us-ascii?Q?m/PiaE5nwZ6sZ+VRpjwpcM8X8ah7APOip0c+TQf7l5DEVyydAnGjvzFAe/fc?=
 =?us-ascii?Q?mHjgqtxEE5rcwGafcHtIeLX92O8MMYtmviUauCqY+nQUAKxtNFsZDpGVmbxN?=
 =?us-ascii?Q?L2dtfS5uAxYhJutFSu5NPu0TJhAkkJCzmDSesD9Do6umn5IMvrjc/LETZvbk?=
 =?us-ascii?Q?uhYpdXRi6Ks9yJzsFgkxfSMTRifjd75ol3ZGuMrBdpvEawFnX2UqvNbQw7nN?=
 =?us-ascii?Q?EwZvs071iojhEBhiHvB32KvTpOaRwjqzhxxPsyn7SlaKbVVD5M0iIy7bPMOQ?=
 =?us-ascii?Q?dVJJM8BknUbSEVNnHqxvbKbREparWJc8/hXO4wz6lw+KaNUvjnFs3AxRliV7?=
 =?us-ascii?Q?nOnhL0kOYQMWEkA8LnE2sni2gHZL+GSPbKO5fIsDWn1ylgsZP8pkw2BYrJBp?=
 =?us-ascii?Q?tMnNwFpwwmY82tR11A+SKw88LACPYxWEiFK3L6Z1bK/0Agxym4vxvhtTPLv2?=
 =?us-ascii?Q?Iu4kjXBezHuK3PQ4EFanLOHTn4y5zoMLtbALKNFb6P+a5oNELUAa0FhWJPR7?=
 =?us-ascii?Q?zXvuajSkIKj0qeEL3uwSlIISzJVq/u9R4cPD5iSz+JdhGZq0sio2btvkiW36?=
 =?us-ascii?Q?MLFmPe30bN9OEUPZH5C1UBbmABa0mMKMj4LvYOIuoj1VSfQXhxwBN252A0Iq?=
 =?us-ascii?Q?qfUlca7xSbk=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB9473.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?jnKR0Y3uE1v2HTZlx13q8yyqMRyCGef3TKVcT3cHrxKNPjwSNHtjGW9+oBKD?=
 =?us-ascii?Q?yd5a8YGiq3z84rWt+winUMkPS6aPvEBlHphNbZoKzCMWApQuZZiVnFBuAG2T?=
 =?us-ascii?Q?SIjI/PlPVPaYpSTJSwF6bVa/DxzHKBpEQdlpF4AW8AflhKSVmRpfKBmjErSJ?=
 =?us-ascii?Q?pjjLqBXX9CX6V7mzptspFTCP/rTW9XIG//NsHvKC55eGgG9urtWz71agS2Iy?=
 =?us-ascii?Q?HHFXLlUf03UIt8kUcGURNJ/lke48JaiEtBN6DM2yBHUnzJKc91q3LXGnKasL?=
 =?us-ascii?Q?AQMdWL27P4LyFQEiEOosO2ZxKGAMIIaCMkUcUT6ncGslaqf3EMgU/x0CaZFi?=
 =?us-ascii?Q?9WwoDkocPqylZGUHF4aSguPV3vgJq0ZqfuAOt2Ju2b4sWI16Wk2XEUgvMYPJ?=
 =?us-ascii?Q?JCui8K3p0RNbaUIqkNZshzSpzLh4lh9fRiZ/qxdivqCAQ++XWqxWK236Pif9?=
 =?us-ascii?Q?2elTvbjosWB0+y/K3TT5NE1wYXPCooWoBJPUax3UXIb1NZOWuL6M8NW7rs8e?=
 =?us-ascii?Q?5PP29phNmHLlWzRVt0JVEQ3t7D44rR+UXIRn3ObkXxl4rJK3ltZW6Nqk/k+E?=
 =?us-ascii?Q?1r29gVwE+tVZhN06bj+OPIIpByA0V1b2H9MhC/7D4uLF3msypsBNZDEIk6OY?=
 =?us-ascii?Q?PAl7AUgVO/Onha7Qri9mYkb6G/NwpzaS21/OaIj9ImD/iSdgg7+zXaRqUtwj?=
 =?us-ascii?Q?ds2oG8FbqO99G7Lb0dBg9APWshwhqb0cDWcGRwGuEtk1H1WYu5rtnt5H7Pk/?=
 =?us-ascii?Q?O7jUfMK977KPuWjR+OWuMP/sCruVb5sWKVwY8UsYUmdFQr3QhIRm4HzqelvW?=
 =?us-ascii?Q?QnXaGeGVBuiDDbuVb4hRgjiIkH9Haa0W8MfW964iQQ6S9HTtfOFd5K51ixCu?=
 =?us-ascii?Q?bHfHEd4mkmIErF9Om5c+3NVY61mEQZCPbVBCFsT4zMkzdRHrmAwASMm9VKw5?=
 =?us-ascii?Q?rfGHnoB20D1tQOvZl7MQGzesjPQANVH0vZMsmqGJ7PlBw7Aqi9IXgd8O4nUI?=
 =?us-ascii?Q?wn/MYwRMe17nFnQTb5MAKCXmIkL7eB4EiJnvijieHgP3fn1OeAHXTDMV4slB?=
 =?us-ascii?Q?wv+spELHy2KWzSq5rgE2lN8CMI8+V3ChnguuUt/I0ZScdlQKa7qSPAA3Xy5p?=
 =?us-ascii?Q?zm2kM2Rd9Z4PAlZeOaa+AfhfXLfuEc4kQ2RKv62m7SN84zZmXJGmugBcjATm?=
 =?us-ascii?Q?qT9cOBee1jFwALb7SeDeVJpVSZsppR04HoNFftPb948JIQmbyYzok9Rf+82t?=
 =?us-ascii?Q?K9QPoBhsSrPRfnASyX+zPEpjhTNJPGt3W5zkj2VJqJRY0TOgUbJdpN7VARrM?=
 =?us-ascii?Q?/TivoosICbWoRSmdlavZcWVjT0aNTpGgp18OXc+OaQheBFryBtxYbpaVwFrT?=
 =?us-ascii?Q?iBB0YXc31PXB+Z20FS5erTP9qZI+zzcAvz56cCJXCGKiSqsbl6B9zNiYBXnH?=
 =?us-ascii?Q?f80gA4W/1fzq72X9D2yRxxCtlD4JMzVXqzhnnwdKxkL365PLgUs9uUjB4ow0?=
 =?us-ascii?Q?q5rbTlhrsr3qSE3M14DlQqNK7Z9ajrrNMT3JiK73XfS11YRT7bt0oQvycPeo?=
 =?us-ascii?Q?Yf4o2BGdtwbqXUoy3+lbKvAQIak0CFrefy7pZ2lK?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d7859a79-9d10-49c1-4aeb-08dd93262e67
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB9473.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 May 2025 20:30:35.4164
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VjP2wKxOurFJJ4MVKiw75/asWmqoU7TUjTgrhoPJfSevKhwrMM8//DBxbqg6bcDo
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7915

On 14 May 2025, at 15:51, David Hildenbrand wrote:

> Thanks a bucnh for the review!
>
>>> +
>>> +		if (PageOffline(page) && PageOfflineSkippable(page))
>>> +			continue;
>>> +
>>
>> Some comment like "Skippable PageOffline() pages are not migratable bu=
t are
>> skipped during memory offline" might help understand the change.
>
> I can add a comment like for the other cases.

Thanks.

>>
>> Some thoughts after reading the related code:
>>
>> offline_pages() is a little convoluted, since it has two steps to make=

>> sure a range of memory can be offlined:
>> 1. start_isolate_page_range() checks unmovable (maybe not migratable
>> is more precise) pages using has_unmovable_pages(), but leaves unmovab=
le
>> PageOffline() page handling to the driver;
>
> Right, it's best-effort. For ZONE_MOVABLE we're skipping the checks com=
pletely.
>
> I was wondering for a longer time that -- with the isolate flag being a=
 separate bit soon :) -- we could simply isolate the whole range, and the=
n fail if we stumble over

Talking about that, I will need your input on my change to move_pfn_range=
_to_zone()
in online_pages()[1]. Making MIGRATE_ISOLATE a separate bit means if you =
isolate
a pageblock without a migratetype, unisolating it will give an unpredicta=
ble
migratetype.

[1] https://lore.kernel.org/linux-mm/20250509200111.3372279-3-ziy@nvidia.=
com/

> an unmovable page during migration. That is, get rid of has_unmovable_p=
ages() entirely. Un-doing the isolation would then properly preserve the =
migratetype -- no harm done?
>
> Certainly worth a look. What do you think about that?

In principle, the method should work and simplifies the code. But it suff=
ers more
penalty (pages are migrated) when an unmovable page is encountered after =
the
isolation, since before nothing will be migrated. To mitigate this,
we probably would want some retry mechanism. For example, register a call=
back
to each unmovable page and once the unmovable page is deallocated,
alloc_contig_range() can move forward progress.

>
>> 2. scan_movable_pages() and do_migrate_range() migrate pages and handl=
e
>> different types of PageOffline() pages.
>
> Right, migrate what we can, skip these special once, and bail out on an=
y others (at least in this patch, patch #2 restores the pre-virtio-mem be=
havior).
>
>>
>> It might make the logic cleaner if start_isolate_page_range() can
>> have a callback to allow driver to handle PageOffline() pages.
>
> We have to identify them repeadetly, so start_isolate_page_range() woul=
d not be sufficient. Also, callbacks are rather tricky for the case where=
 we cannot really stabilize the page.

During start_isolate_page_range(), all pageblocks are isolated, so
free pages cannot be used by anyone else, meaning no new PageOffline()
pages or any other unmovable pages, right?

>
>>
>> Hmm, Skippable PageOffline() pages are virtio-mem specific, I wonder
>> why offline_pages() takes care of them. Shouldn't virtio-mem driver
>> handle them?
>> I also realize that the two steps in offline_pages()> are very similar=
 to alloc_contig_range() and virtio-mem is using
>> alloc_contig_range(). I wonder if the two steps in offline_pages()
>> can be abstracted out and shared with virtio-mem.Yes, offline_pages()>=
 operates at memory section granularity, different from the granularity,
>> pageblock size, of alloc_contig_range() used in virtio-mem, but
>> both are trying to check unmovable pages and migrate movable pages.
>
> Not sure I get completely what you mean. virtio-mem really wants to use=
 alloc_contig_range() to allocate ranges it wants to unplug, because it w=
ill fail fast and allows for smaller ranges.
>
> offline_pages() is primarily also about offlining the memory section, w=
hich virtio-mem must do in order to remove the Linux memory block.

To clarify, I mean the steps of start_isolate_page_range(), scan_movable_=
pages(),
do_migrate_range(), dissolve_free_hugetlb_folios() and test_pages_isolate=
d() in
offline_pages() is very similar to the steps of start_isolate_page_range(=
),
__alloc_contig_migrate_range(), replace_free_hugepage_folios(),
and test_pages_isolate() in alloc_contig_range(). So I wonder if a common=

function routine can be shared.

>
>>
>>
>>>   		folio =3D page_folio(page);
>>>
>>>   		if (!folio_try_get(folio))
>>> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
>>> index a6fe1e9b95941..325b51c905076 100644
>>> --- a/mm/page_alloc.c
>>> +++ b/mm/page_alloc.c
>>> @@ -7023,12 +7023,12 @@ unsigned long __offline_isolated_pages(unsign=
ed long start_pfn,
>>>   			continue;
>>>   		}
>>>   		/*
>>> -		 * At this point all remaining PageOffline() pages have a
>>> -		 * reference count of 0 and can simply be skipped.
>>> +		 * At this point all remaining PageOffline() pages must be
>>> +		 * "skippable" and have exactly one reference.
>>>   		 */
>>>   		if (PageOffline(page)) {
>>> -			BUG_ON(page_count(page));
>>> -			BUG_ON(PageBuddy(page));
>>> +			WARN_ON_ONCE(!PageOfflineSkippable(page));
>>> +			WARN_ON_ONCE(page_count(page) !=3D 1);
>>>   			already_offline++;
>>>   			pfn++;
>>>   			continue;
>>> diff --git a/mm/page_isolation.c b/mm/page_isolation.c
>>> index b2fc5266e3d26..debd898b794ea 100644
>>> --- a/mm/page_isolation.c
>>> +++ b/mm/page_isolation.c
>>> @@ -121,16 +121,11 @@ static struct page *has_unmovable_pages(unsigne=
d long start_pfn, unsigned long e
>>>   			continue;
>>>
>>>   		/*
>>> -		 * We treat all PageOffline() pages as movable when offlining
>>> -		 * to give drivers a chance to decrement their reference count
>>> -		 * in MEM_GOING_OFFLINE in order to indicate that these pages
>>> -		 * can be offlined as there are no direct references anymore.
>>> -		 * For actually unmovable PageOffline() where the driver does
>>> -		 * not support this, we will fail later when trying to actually
>>> -		 * move these pages that still have a reference count > 0.
>>> -		 * (false negatives in this function only)
>>> +		 * PageOffline() pages that are marked as "skippable"
>>> +		 * are treated like movable pages for memory offlining.
>>>   		 */
>>> -		if ((flags & MEMORY_OFFLINE) && PageOffline(page))
>>> +		if ((flags & MEMORY_OFFLINE) && PageOffline(page) &&
>>> +		    PageOfflineSkippable(page))
>>>   			continue;
>>
>> With this change, we are no longer give non-virtio-mem driver a chance=

>> to decrease PageOffline(page) refcount? Or virtio-mem is the only driv=
er
>> doing this?
>
> The only in-tree driver making use of this so far, yes.

Got it. Thanks.
>
>
> There is one tweak I'll have to perform in the virtio-mem driver to cov=
er one corner case: when force-unloading the virtio-mem driver, we have t=
o make sure that memory blocks with fake-offline pages cannot get offline=
d (re-onlining would be bad). I'll fix that up.


--
Best Regards,
Yan, Zi
