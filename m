Received: from SN4PR0501CU005.outbound.protection.outlook.com (mail-southcentralusazon11011046.outbound.protection.outlook.com [40.93.194.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AC24376469
	for <virtualization@lists.linux.dev>; Tue,  9 Jun 2026 16:12:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.194.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781021566; cv=fail; b=uipHzFcIg31KqTJFxtM9cV+KC0Rvjul6ojDNKLeKZr7kRbPLw5H2yCE9psAFIGCS0eugyQ74xInb62QF8sFcoUMzjL9tye8HAdgvowGJHvxivLnXvxF9K/OqA/P9+dMQympLrFw4yO+QZ6Ix1xyh2xwaaKxLO2pK3TsX9yJj6p8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781021566; c=relaxed/simple;
	bh=cmkZ1usK57k6a8yOW6yCE8UShyHVj3ewVWRPQShlkXo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=cN1Kj5z5Gr/nMChcURGsWFyuhXvL/s6znknUhh1EDmFFRXcAyOn55QqLK1ZUb+fb8wmgOYtlBgYNF+Ve+yO4MFEGCDzpx9mW6YJJLbZZajQRfpZg43unFvWWw4ijuF1OWTk0KWlO+UgByTWWKosFQeWShh5IGreWX3NE7wkQ36Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=R86UCIAN; arc=fail smtp.client-ip=40.93.194.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="R86UCIAN"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KeEp0lf2pfW4FIyzwjLSiIjPrgiyK5eYMC0XzxGNX+BwbB1dO6nVKcwZx2Bu082GZwAmEhwYOh3sJsE3eLgRT81qmJnDIQh8dSI3bGydidyGQD7OQA80LVkXr+NTu+pW7TJ8oNj2MZ7uIyitsrbDwDuP0Qd3Yzguiy0x6zsSWGL+ecxuqU2fk0WrIpndkZy2XYWcEz4nPZ8b8a6pOCDzg/vzYVUtB7DNCUgli4h1PHzcDJBDE1sCAe2P1VibW5nWVFziv+LA/rEPA0gWNPLV2pHCeMX8O2DnpuryfV5gcl2BT1W38/KlZyTzSvjFPS2zD7KYZ7fYFeKhHulWRH0ouA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=s6ZWf/bRbAz05RSHSAfTYT0EQKPOOT5Fhim61AvQH+g=;
 b=yFcWP9cNzNywqpAwLtlq7036R4uo6XjQ0YYAz5mXGcV6S+sj56mvW8UxrHlNXNAvoSuYBVvVE27foUOby1ynZRwac1Mc9SqdOX97xotvwc+okRrPsKOKMqf+7AtgWX7UJ8WUEidKrstTiLT+7GYpwfYXrFKKINvKngwTqDRLLnIFdTvqKXZ7oeFgUhD3+ZE1PTEwddRbfsr8uOuZZAk7lwqLWbLZI/ZRfbLgCqrP3nukn5tSo7kDae+gtUso3q7s0+D8W5xwFzEJqLXem1rvFhE4/ceoPWK14+emcKUSL1EaRLbNT9+Y8PRsNACgYw05p7DLIyzeV0gYKoOLKTkq9g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=s6ZWf/bRbAz05RSHSAfTYT0EQKPOOT5Fhim61AvQH+g=;
 b=R86UCIAN/T3fJO871/z5pO8B9yX+/54UnonJaqpcqaK5+Z4orfoG53bZiU1CBxoz6viSNIeKt1ZxtQtnSKJ4GB5X3gn/k+jSCoqk8w0braGexw/wa0aiZftK6dp3Mg4DceWHczr13GohFPp8aoW6oMtlp2oOHpZKDfUOwzdrtPYn4utR/rM5jUTt0pNMEm7Hes6q3gePnyo/6Vt/lTHghsZv0QE60Esypz85NdUOy4qCpkBPikJDEyDqWfvLLwjRIDJDwFEOo0ulJrXdVbFZrGNSqi0Q92koCTBwsv3GB66W9mZjql7tyh/jdUvKrNJLnuWeMZHCpcg6ebQTafViPg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS7PR12MB9473.namprd12.prod.outlook.com (2603:10b6:8:252::5) by
 SA1PR12MB7248.namprd12.prod.outlook.com (2603:10b6:806:2be::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.13; Tue, 9 Jun 2026
 16:12:35 +0000
Received: from DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::f01d:73d2:2dda:c7b2]) by DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::f01d:73d2:2dda:c7b2%5]) with mapi id 15.21.0092.011; Tue, 9 Jun 2026
 16:12:35 +0000
From: Zi Yan <ziy@nvidia.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: linux-kernel@vger.kernel.org, Miaohe Lin <linmiaohe@huawei.com>,
 "David Hildenbrand (Arm)" <david@kernel.org>,
 Jason Wang <jasowang@redhat.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
 =?utf-8?q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>,
 Muchun Song <muchun.song@linux.dev>, Oscar Salvador <osalvador@suse.de>,
 Andrew Morton <akpm@linux-foundation.org>, Lorenzo Stoakes <ljs@kernel.org>,
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
 Andrea Arcangeli <aarcange@redhat.com>,
 Naoya Horiguchi <nao.horiguchi@gmail.com>
Subject: Re: [PATCH splitout] mm: memory-failure: serialize
 TestSetPageHWPoison with zone->lock
Date: Tue, 09 Jun 2026 12:12:30 -0400
X-Mailer: MailMate (2.0r6290)
Message-ID: <3DDB3AF6-114C-4988-B43A-AF683C649F2E@nvidia.com>
In-Reply-To: <df06b66fe4ff8e925ee0714955abc2183a727b90.1780998980.git.mst@redhat.com>
References: <df06b66fe4ff8e925ee0714955abc2183a727b90.1780998980.git.mst@redhat.com>
Content-Type: text/plain
X-ClientProxiedBy: BN9PR03CA0859.namprd03.prod.outlook.com
 (2603:10b6:408:13d::24) To DS7PR12MB9473.namprd12.prod.outlook.com
 (2603:10b6:8:252::5)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB9473:EE_|SA1PR12MB7248:EE_
X-MS-Office365-Filtering-Correlation-Id: 7904a072-76f3-4f98-b5d8-08dec641eb0c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|7416014|366016|22082099003|18002099003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info:
	d58q++XOzj6CQlYfRXMMDosludDyJIrB1YwSJ0EpjCebWrjXpI6ssi4PoOP2RHyah96aK8fAeMWfgLrsS2+F8FZiuHoTyBpKL2ucDUeYAYl9HsmgwR2i6IdypiyCxGfjV2aHUaRP2feyKnCxQTIaglFmoQi+3y7lRSPIFclL4tZ8Jza/OqpN8L/HO3GzlOXzbs3prY2CZS6FQjq/3DVVz5/IhHn2IryFoEpNXHYGIx/HsD43f5Ck90oVEOT11JhJZrZkZEQBmneH/b6jlnOen8QX+qppZaSFEgZelKZjCgIuj2BUHCMmRBQzz0CKaU89mcBEnCmNIh2juzIN3piPqOY2adsgloTw8Q/Mz1iWhWX/Z2qX/yfdBtUmRuQ0PQFj5o8c+shUF3HWD1rRKodCHKFaBosguYG8U8cjZOBcfRn42tPaZ3DZ53j/p8pkTzSHz90SgAyDTtY7qxpQkwIto7zgWUUSy0dHV2hEOuSm2e9XpmMXQiIPWI0Wov0Rqy8+85FXbMAyR/plJAwm1yu03qe6m5yOFhTK48tB6Ema2MH1x9q1A8Ds4sfXH6mA/Zc+eoyi9KxEzDDBXdMT/pyVhCw5gvjpyGOT+lauBW2SzCrihSD/M361kqFSb10XiT4VuOy78bS+txbyVYcCrdtKlv2WZO/33IMeYPzchvz80XYkuHtSoK9ipwDVJCkyXZQ/
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB9473.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016)(22082099003)(18002099003)(56012099006)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?c/R+1/cNvKFvBt/Ta40EsAroMSy02YLgDKuQxaeCcLGKQgtbdjuixfe01KTH?=
 =?us-ascii?Q?SR6xQcA/Q+Y0uos4DdDOaNPcttbVQUSytyAVuvVblkn0OBxGRrt/PIb3kYPL?=
 =?us-ascii?Q?7DLns+P2JZAH97O/b++vzdax3qfyDkc8OLdYORUp8LLqToA7mS1fnucJ3AO4?=
 =?us-ascii?Q?AO4NJak8ya8eH+ZOT+9FYBn53qmaBNuR3UH+a9c8qoS2NdaL84jFl1bvLoWZ?=
 =?us-ascii?Q?Q+8B7j6yC8+EqdMLAkYqrAycb1bq9tNjbQa9Q6OFLtMQGKy3HRWT2HUL1FYl?=
 =?us-ascii?Q?Ed1Ffwu6jHrlqmtxv+Ux2AXK6gwJf4urpJKHRtCTtsSXuiWERcH3jjCnwOEi?=
 =?us-ascii?Q?KATN8My7Ei1SVYfCZ5lstpELFnf8J+gX4QEHgIudjICo3Z3baJ5Z6izE1YLB?=
 =?us-ascii?Q?D2qZw6BvRRwgo/jzpZx7ywoKRTOmkwYOMQPVibjPuoQ15Hr1503x55E7/22r?=
 =?us-ascii?Q?iOaKy8Cofy4q0K3z/zhP/x0/xRIqjA57r7LtvYJ/X6PBJmCcHC7bDpOlIOf4?=
 =?us-ascii?Q?2p+E6Dow3vTp59W1K5nSEA2poVmTv+TfOku/W7F1OEup7DdbJvsU/GKpdLd0?=
 =?us-ascii?Q?AoCqrsTEgSWz6DckqUXWD2BkPa5K1FHt6lsNhfNeV7DOSTXjA7glOtRvr4tY?=
 =?us-ascii?Q?xj7Pst9xRI9xzR1I3E9PxdVHyKE5+l3zbMDhkoVIRlWPLmDUgi+OG2mmcM97?=
 =?us-ascii?Q?D5pgg1D9+EG2z9xwGH6Wf6MzGh+lWcWe0zaGt8L4P597QwwITs03eI5FP5Q0?=
 =?us-ascii?Q?1ePQrO1uAdQTefnY2ZMQfW1uRW131qxJxIvFhf+cEynkYO5I9pYcYAQBIzqY?=
 =?us-ascii?Q?jplqVUbuBIapX2Wb8nrWy+uWv9uVe8tGE0hybnu598gFZ3RLUUqaA4s0JSPS?=
 =?us-ascii?Q?Tx7JQfV+Ra9KeKfl1BAPhtpb0xL7BE6xQ26bD+x2EDOwdZxg6WM4B0W2IlRX?=
 =?us-ascii?Q?vqt30Urhg/Y5ZFJ1m+dN+L4CYcmMp4QSd+eSg4TDyArKCVr+00HEguiTkmi5?=
 =?us-ascii?Q?jIqKqyLcuHSGXR06zSay17L30DLcvA509Jt4MEmq5iipxQWPV0JffVEUSbFU?=
 =?us-ascii?Q?Q5VlJ4sDrGhqFaog03MdWLloHuFeyJTw+m3SXf8MSFM40bO8hfzxD+AcNOX8?=
 =?us-ascii?Q?6AtsQ8+W7r59GwJMZrcdBsXxWyH1A3FTttjyz+BnY0kyfNrNFZaIXES7gADh?=
 =?us-ascii?Q?vaxoKTy7QC3ZW/xXzd21UvPy1eQgsvZh0YbBFPfRpWtKL4K7+yqWCKskeMF4?=
 =?us-ascii?Q?Jwc5ygpCLmeB8rB3wfe0kzqY9NH7EzuU4EUzg1ubyBxLjJzld9Rv/chrhyEZ?=
 =?us-ascii?Q?B0sW7C/p/JW8K4Rlct1m3/iRDb0mpOyTil5I+Kz6wtiSt5y2VDFKDqvC4pIM?=
 =?us-ascii?Q?GOap8WvtTTWJ96zsIjpQX5/vgEeORUzft3xQyHKdB3ZYJI1HnFZ6dSZGG5aX?=
 =?us-ascii?Q?NCEW+qr6YlJZUD/x+BXt3FXtGvjZ4ZJdD+8JeqM7zwgA6mDQ5p+lYmZ+8pgP?=
 =?us-ascii?Q?rP0Ab9pURACTgSvvj42btIhlI5Hqy5dgtYgni6dDk5sSGtMdqzBTya5ydmK4?=
 =?us-ascii?Q?ahs2gGJIhG/HQMhrr4TTL3oZj7sM5zEh3lM0pwfYJPqxiA6aBfC6pQbAVfbF?=
 =?us-ascii?Q?kthsHij1e5p4CND4bU+NmcuPpEfOWUAlsnthaVMuE6j/BWkq3lFPPTrSvGPu?=
 =?us-ascii?Q?GzZxx5x2u12kKqyWw9zRZfItlaUUTu5i3q/jbKKTAN/GW8iu?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7904a072-76f3-4f98-b5d8-08dec641eb0c
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB9473.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jun 2026 16:12:35.3526
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rXVCSRTwu1+aQ9VwEXe9hoPE0LWZ+WQsE57lPdGEy1Trp5bB8EUMoFpJXGDkoPIe
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7248

On 9 Jun 2026, at 6:12, Michael S. Tsirkin wrote:

> TestSetPageHWPoison() is called without zone->lock, so its atomic
> update to page->flags can race with non-atomic flag operations
> that run under zone->lock in the buddy allocator.
>
> In particular, __free_pages_prepare() does:
>
>     page->flags.f &= ~PAGE_FLAGS_CHECK_AT_PREP;
>
> This non-atomic read-modify-write, while correctly excluding
> __PG_HWPOISON from the mask, can still lose a concurrent
> TestSetPageHWPoison if the read happens before the poison bit
> is set and the write happens after.  Will only get worse if/when
> we add more non-atomic flag operations.
>
> Fix by acquiring zone->lock around TestSetPageHWPoison and
> around ClearPageHWPoison in the retry path.  This
> serializes with all buddy flag manipulation.  The cost is
> negligible: one lock/unlock in an extremely rare path
> (hardware memory errors).
>
> Note: SetPageHWPoison and TestClearPageHWPoison calls elsewhere
> in this file operate on pages already removed from the buddy
> allocator or on non-buddy pages (DAX, hugetlb), so they do not
> need zone->lock protection.
>
> Fixes: 6a46079cf57a ("HWPOISON: The high level memory error handler in the VM v7")
> Acked-by: Miaohe Lin <linmiaohe@huawei.com>
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> Assisted-by: Claude:claude-opus-4-6
> ---
>
> Sending separately as suggested by multiple people. I also added
> a Fixes tag.
>
>
>  mm/memory-failure.c | 10 ++++++++++
>  1 file changed, 10 insertions(+)
>
Makes sense to me. Thanks.

Acked-by: Zi Yan <ziy@nvidia.com>

Best Regards,
Yan, Zi
