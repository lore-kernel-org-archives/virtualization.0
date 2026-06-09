Received: from MW6PR02CU001.outbound.protection.outlook.com (mail-westus2azon11012036.outbound.protection.outlook.com [52.101.48.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B0CF48A2BF
	for <virtualization@lists.linux.dev>; Tue,  9 Jun 2026 18:39:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.48.36
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781030378; cv=fail; b=rFA4HYRA+8g6NsvR/H3trGgUSTEOGm9cv0b9yaIGR9vQVDJAG3qF9G+uE7llnzod5lbNe+4yPxFnA4SGsvzHoBRZx0HAVqHlWsFV9tVnCqS8r3l4b20PU2UAKsuWpGKQxwoqE/D7W7iHUOXv688Ci1nSvPcxsCwmpFLhYF8sS4M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781030378; c=relaxed/simple;
	bh=c6LqVVPqpl8/ZINj8gc1fnMVjbBECGxgXWlcEYBxhKE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=PO5dzTBj9PrlkjMayTN2gtD5kKH9hS8ou0zOaeB8yd+aiNHXcuUX4S22FcSK6fHFTErOume7mtB+K53NQnst6TX9HwKy/jsL930dFMXwcitv5CciSL1Hd9eUsYoXKKhO3GLeVKGzSUtX68c2GOHEd0i1Kx0XEq7rZPvq/X1ydZ4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=HW/7XQDn; arc=fail smtp.client-ip=52.101.48.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="HW/7XQDn"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PoS320x0u9F7TF//qpcd/gQP9ht94gAoSThxa6bgvSFyDiqQEkNFmoZslw2ebyZEtRU6kP/cGtZxTwqYqdA9Nk7s6Y0MaPqQn284umG9ko7QpZyVSJO/L+977eVUc7DbF7nkMEv17w73tzQeoSBaXhcXV/9cC/wERoWZli9Y3eTtd1gtjqdUvzKw0IBkCrk22l8cxtEKZXvOD6XRIAgs3QvBJhkv4vIK6DDZ8EorRrx/uT4gUcsQZ1545ke1Cl7SSVse/otse1DWnm8i0MFXB6o+IBZ5amAFMhcQfHO5bue8BHlr355VAXciM/B+Wb9Kc7sdrev25D9pQVPVWuCaag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CUYy7hWVfORsTFymfhojemPuStjNYx7jE+eVlMQ4xA8=;
 b=cpeKAjAKkjjCQBiDHZoVt/+RkdhakugtAHRpibdOdxfv/eYe1UldA+2XcVc5y+QgabhI3rL7fl4Mp2DGxckS6IsEa2zUZgYilDuq181tcTzyMBI3pDepHXE0y8N2iKJSyRB4ThPCzj0BGd2hns5fBfICQlEf1c/akCDdEQxSSC0enwSGqW7kN5UgmksGxlQs5PjneF/7Fpx/ohn5PqoBEOtBDAXdAOUJypyoIOHfLwxmBw6WJjJlDdaHAmZXXfwERmbw+srsqmmYRhYqF+KIxXF1QKvJWyL6bjPZvnBkLrCxecrTSLf1K9h9oo7JWeDzztRndVGr42jw/nsmmzIp2g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CUYy7hWVfORsTFymfhojemPuStjNYx7jE+eVlMQ4xA8=;
 b=HW/7XQDnaIm4i8s+CEfGeezqQ4Xh0gcga4aopHPvtOzVt5sl4VT477AvIbSGAWJF1RqSEXSNpM0QtV7DDZ/0uJtv88nUa1d40G/uPIKcDjr7bAqfcBLNPbzxVRAOjwp3BRlf49IFGXaHxa9K3dCLfjaFo2SmBXU0OkHO4YEHW5VCBnP2PD8EEHCAxyv+vuEN+U7MGAkV0YrukRLxB66swZgY6GjeHP1lCQuNZdgFykyt69ZctNLZ6Kne9eb2Suq6Hf2yawD4OCCn346aByrUMcc5hM4ltQiqESH6x8Td+n7fkGyU7xZlwVfTcf7q2L+8oWtK6JhWuHQbOeibk5zO6w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS7PR12MB9473.namprd12.prod.outlook.com (2603:10b6:8:252::5) by
 CYXPR12MB9280.namprd12.prod.outlook.com (2603:10b6:930:e4::5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.92.13; Tue, 9 Jun 2026 18:39:31 +0000
Received: from DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::f01d:73d2:2dda:c7b2]) by DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::f01d:73d2:2dda:c7b2%5]) with mapi id 15.21.0092.011; Tue, 9 Jun 2026
 18:39:31 +0000
From: Zi Yan <ziy@nvidia.com>
To: "David Hildenbrand (Arm)" <david@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
 "Michael S. Tsirkin" <mst@redhat.com>, linux-kernel@vger.kernel.org,
 Miaohe Lin <linmiaohe@huawei.com>, Jason Wang <jasowang@redhat.com>,
 Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
 =?utf-8?q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>,
 Muchun Song <muchun.song@linux.dev>, Oscar Salvador <osalvador@suse.de>,
 Lorenzo Stoakes <ljs@kernel.org>, "Liam R. Howlett" <liam@infradead.org>,
 Vlastimil Babka <vbabka@kernel.org>, Mike Rapoport <rppt@kernel.org>,
 Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>,
 Brendan Jackman <jackmanb@google.com>, Johannes Weiner <hannes@cmpxchg.org>,
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
 Andrea Arcangeli <aarcange@redhat.com>,
 Naoya Horiguchi <nao.horiguchi@gmail.com>
Subject: Re: [PATCH splitout] mm: memory-failure: serialize
 TestSetPageHWPoison with zone->lock
Date: Tue, 09 Jun 2026 14:39:27 -0400
X-Mailer: MailMate (2.0r6290)
Message-ID: <FB250C43-790E-4AB0-BD40-74665FC601A0@nvidia.com>
In-Reply-To: <8c1f468e-b50a-487a-a267-8d1ea5a61c87@kernel.org>
References: <df06b66fe4ff8e925ee0714955abc2183a727b90.1780998980.git.mst@redhat.com>
 <20260609111020.e88f51a7b6ebc37360d66fdc@linux-foundation.org>
 <8c1f468e-b50a-487a-a267-8d1ea5a61c87@kernel.org>
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: MN2PR07CA0007.namprd07.prod.outlook.com
 (2603:10b6:208:1a0::17) To DS7PR12MB9473.namprd12.prod.outlook.com
 (2603:10b6:8:252::5)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB9473:EE_|CYXPR12MB9280:EE_
X-MS-Office365-Filtering-Correlation-Id: 34baee54-7467-49e5-9c62-08dec65671c2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|366016|1800799024|11063799006|4143699003|56012099006|18002099003|6133799003|22082099003;
X-Microsoft-Antispam-Message-Info:
	FB6+tAcXRNJvG1t+CfUD4ggbBZ3PPRxAXeH00rOFRktlnanbFvEbSR4pQeXTPA+ttzb1aBW0x7hsP309egnzXWQEALsIIdRAizMzoA4oZtGvI/O0BQUcCNjWS7P7q9AtNf+OVa02WXdVEJJ7W1WkWLuMLIlAKjeG1/HWa5p1i3luemjwJePIgaX5XIvbrWc/z8aq7ahttD/Cgo61EfeCvspAitjmezsX/OgkMI6ysAgeeiv3jY/3lnL3nHCs12gBlSdj83UOaEyVX8LgGRwOaT56J8cXCmeO67sQbU9/cibbkQZUXkr8LeZtA2dU5u0bR/O1Ao8roaV3cUGCpL+EKPRRhR01Laz4l7ASAgSAVO1H2QBbmn7yUv5CiL6RLVpNOZJRg4eFixSoqcTkryOUSMXJladob+ttX5zkwmAA6sPYa1ZegQB27r4nX28VlUErphVtCPjEVWgY+wStFhoMj7xKGV5ldbgEpRmdCvuz0zZv0NLfwU+Vi/5WQ1NKJLAuENe8ImkRx4eS9frPnpoggi3mVztjdhDboyhYWrB0tw6gKTxuyDz9GHaTQqK9Uh2elr7g2mj6I/C08ovkRD7BQLhV/lLdIBLc8WpEzLiOV6gjmyyQ5gTaTU1wFFIGm+DQGxanAoctWbMx5lweGYmrJV0BOnRZyqmS234Y9WagEyVQuPMTqmXiA8sEBTb0vVB/
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB9473.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024)(11063799006)(4143699003)(56012099006)(18002099003)(6133799003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?u91ofIT1qFAWCkYr3jBRz61zI9ZE35FgnhbLWOKmXEY3Bw8ZbIp4snUcfgTC?=
 =?us-ascii?Q?A3bw7d2x8ab7pVSmyNUtQDyrdsCFMfchy7LpGWqDlOUkT69hVZFSvkN5pa6s?=
 =?us-ascii?Q?mGKDPY7o+pzJP3KO593lz/CnJ1dUbt/T4Jf4ofNxw4OjVHbav8M/sP6Nf8d8?=
 =?us-ascii?Q?O3IbXPlIPg+G6U4nl0zER9xubv+Jkh1C0c0AttPA0Q4ydnL5Y1GTXz7R8Fya?=
 =?us-ascii?Q?V2vanjDY3btsQv38Poh3fBAQANkvIJH1L+xPSJSnb+4yl3bkUYmgHjeL+Td2?=
 =?us-ascii?Q?ND84sGIOecjwwiWKUdxfFGxcgWgmqYOMfYar7QEvGo2rnDDi0gwR05NMl28W?=
 =?us-ascii?Q?+Jh/X+N1//auDsE5Jfz+Jh4ee/BoMrvBNfrmndM6xUJeJrcITv4KoXxTHZAD?=
 =?us-ascii?Q?tPi3Ou6rOLPo/6pPzGcwIGMfEAK6Oou73EjFLMDpJHU/Eh6iUOg6l1Ry46NK?=
 =?us-ascii?Q?XxMVNBuczDpWS2cvzs+uQSASsVZdKbdNvPQcaCVGd4hgjMGVyjmWGx3wYr1q?=
 =?us-ascii?Q?cUwkXmW88a+TVmLnOMv0bFGCLlf6UehZeWIeZ8N6UTCI0yMgh7lLYhsSxdHd?=
 =?us-ascii?Q?w360TxJvagPAfz6BhND29E9GxUadK3h17yP13tc/GMDSK1eE/kELf6bPjCQR?=
 =?us-ascii?Q?eW2AQHBO4pYiNoNimYTuJDvXTuZd1j5fh5XrQu1smIC+29z7MBxR1MSNhdjq?=
 =?us-ascii?Q?wmKO4dWoYx8JGc9cml0x7m1uYRnR7raP/2Z36ex/mwqNkxeJGMMCTjp+fIfy?=
 =?us-ascii?Q?jjneKxaz7fFVaeKeyti3ZtyD1lzsBr3y4xi5ndzZErTS/ondYtZfyhi8WIwp?=
 =?us-ascii?Q?hKugkUIe3V4ecZgVBePf4W6jRJjEKGR+gYA0755PTSCb5ft9DWlsn9frdPQw?=
 =?us-ascii?Q?+Ul2ad8IBTeETmgFwgm/TJPh2sbmHcFJ8bVGIF3hLUrlcFY1Z5XPfRllC4v/?=
 =?us-ascii?Q?jwVj2pbKg3b2F9pBbpn1Z2jHdFg4U685pzKBeUpcsoL5frggLXDhhXW6JmGG?=
 =?us-ascii?Q?nno/AinMeTTNFW597nyyC6nzqfnyH13mW4B7VoKr5zoKgHbIjFlk7JMDcFcc?=
 =?us-ascii?Q?xNOtgHh62X+HYqDvrMQ0uW1l6DpwSzPtdp/haqq7k1yUzDw5MUrMfF6KeQ6X?=
 =?us-ascii?Q?EXuBzkBoxJlQynRXkIbUwJY2H5hZSl0QhpeGHXw1soBNoebm2ddZia2BT1Ys?=
 =?us-ascii?Q?QDn1SbYICnsQEYZ38RoUX09QF2rhI36bo7CkXua3jyAcPTptERymkeUc5fiY?=
 =?us-ascii?Q?QODkdK6juZ2t16MzHm6fn6qEGMols6skgaG+HminfZmj7gVfy4jrD71XTlZH?=
 =?us-ascii?Q?Ss0CsmievusJ8XyaPZreXUOYBEd5NTeNUgnpKDqWvbWZpVssTxzYkZmYZGci?=
 =?us-ascii?Q?qmS/ye1Nekk303GqphRZ6SIvlOP9USFmJmGD42afYLS+sLnXhstxDpQiA/G1?=
 =?us-ascii?Q?3A4kyilgxMBLheHQFsFEltsfGpP7oROOnJPr3k2MdMD3SfHcUqeOigyKuZN0?=
 =?us-ascii?Q?efZH20YdMwcGVjBWCCHFiIRum1sCikzWKRFJhNx46LrIrXZcmoyQ+i+umyHY?=
 =?us-ascii?Q?OQgWjaAYr7s2xKa+tCqT91qeAZUxl29LfS5Ut+sLdc0MfpRdR0wbr/CSkCUb?=
 =?us-ascii?Q?436KksjhAwCXpVgydn34olzJgl472cXxsLp3vEV0vcPQN/7qbc12kJ9v2TzH?=
 =?us-ascii?Q?PSUO5ZWBl2AVjF7SRHASeAwB4LYURBXpNImW6qg3I7GMCF3yOjlY1JaqO+t/?=
 =?us-ascii?Q?HpcvMl0X+g=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 34baee54-7467-49e5-9c62-08dec65671c2
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB9473.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jun 2026 18:39:31.2216
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 23nzwLhNddzLeMl/euDW2G4Y8gRs2MuGtN8OJlTwyUb7q4RLnQhMPf/pfg5Q1xyk
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYXPR12MB9280

On 9 Jun 2026, at 14:38, David Hildenbrand (Arm) wrote:

> On 6/9/26 20:10, Andrew Morton wrote:
>> On Tue, 9 Jun 2026 06:12:49 -0400 "Michael S. Tsirkin" <mst@redhat.com=
> wrote:
>>
>>> TestSetPageHWPoison() is called without zone->lock, so its atomic
>>> update to page->flags can race with non-atomic flag operations
>>> that run under zone->lock in the buddy allocator.
>>>
>>> In particular, __free_pages_prepare() does:
>>>
>>>     page->flags.f &=3D ~PAGE_FLAGS_CHECK_AT_PREP;
>>>
>>> This non-atomic read-modify-write, while correctly excluding
>>> __PG_HWPOISON from the mask, can still lose a concurrent
>>> TestSetPageHWPoison if the read happens before the poison bit
>>> is set and the write happens after.  Will only get worse if/when
>>> we add more non-atomic flag operations.
>>>
>>> Fix by acquiring zone->lock around TestSetPageHWPoison and
>>> around ClearPageHWPoison in the retry path.  This
>>> serializes with all buddy flag manipulation.  The cost is
>>> negligible: one lock/unlock in an extremely rare path
>>> (hardware memory errors).
>>>
>>> Note: SetPageHWPoison and TestClearPageHWPoison calls elsewhere
>>> in this file operate on pages already removed from the buddy
>>> allocator or on non-buddy pages (DAX, hugetlb), so they do not
>>> need zone->lock protection.
>>
>> Sashiko is saying this doesn't do anything "Because
>> __free_pages_prepare() executes entirely locklessly".  Did it goof?
>>
>> https://sashiko.dev/#/patchset/df06b66fe4ff8e925ee0714955abc2183a727b9=
0.1780998980.git.mst@redhat.com
>
> Battle of the bots: it's right.

Yep, __free_pages_prepare() changes the page flag without holding
zone->lock.

Best Regards,
Yan, Zi
