Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2057.outbound.protection.outlook.com [40.107.93.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF49D28C86D
	for <virtualization@lists.linux.dev>; Wed, 14 May 2025 19:01:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.57
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747249274; cv=fail; b=dR1P1bFkIiiBalT/m1K55Vopf/3smXxxmxx81Mh60uIQ4A6QF8LcBbp9TX+fdXa/mF4V89+gqX5tsJP8SdfNflT5+qY2dS+naYN9G6Cny1XTrk7NsIoUZPNoZ1braV8sqEyIYTmw8+cXAeRjezl6qIf/RNBlAPuBFDz30s6FzG4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747249274; c=relaxed/simple;
	bh=uZyRunFV2gEuVIZDDZgzq9uRSHhKv6fXEsVdmA0ylFQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=eDzhNlo5unv0V/nmugzZPOpVm1rt5mMe0icm6F5TX1UlhwXZt8Ec+3LKkJF1oxAZ4JGunw/5X4p5OwGpG53FsF/TgzkuthK2Ri3dMw57akLgJ6jqI3u8rup03JQ87ZOpl3qH3E7kn3g7Cy/vqXAAR+WI5VwCQ0lSalJYkx6f7o8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=g5BepHcm; arc=fail smtp.client-ip=40.107.93.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="g5BepHcm"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EPypQXN5o9WY6bESkpqIm4yIY+NVcVHWUzTdcEZiC0aTyUvSuVD6k6usxSG3MVEOtgSgPuC4mqlXMX0A6vf1loywJ0KHpw5V7D4xLDECrBu69oFKZpOkQifJKiO5uB+0MG0PQN6ZDJ8mvlEZC0J31CkzMcM1a6TsWP7Lphs3Q4GX4v/H2yLvIZMBlzwhVXZAOofHRyMcvnyaYEuzW1LZ2qAjrUQ3MlwQMzuYyb7sTUK3VSP+Yvc29whKx9VbFVbU7PCqgP+cpL21dH3j5qZ9hHXmTp/fETjQO0y5ButmDiiAexlLTRmODwOyAi8v3defcYOt3ZVewd1chBN0Zi6Ykw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GwAJGOsCtv6pI9eePN/GQDCEIs3QGce3SiYW1lSJYGM=;
 b=VzH1Yk8InYxQSUZ7CxZvxaWjJt5CNjEoPHt/yCI/M8NVlzdJesLweumJ7kB/wuFsh3OXbMQy1V1AQSZFMm0zSLzG2EQrnCW5C7GPO1dJrj22qusvwBmQQvU6pHvHjLv2BRRLUF2xIWmUqoASafIzQirm3I3jOmvF4zYDu82TjtFsyVn0eiWEmJANGLTbLC4IUtPAwE0bs98/KG963UAsmsCpVcnZVj9NNGqaEP8wlWcCFIdu6Ygr36rpH7gcwcHI/mElzmsA3KtfkrlHZlJyIsqITElpPKo1ft9UqjnQiNt+Omse2Y3yleP7nL8Fa5S9wFy9n7xWpsW1N3mLfxgI4Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GwAJGOsCtv6pI9eePN/GQDCEIs3QGce3SiYW1lSJYGM=;
 b=g5BepHcmSAveSiGcUltnFXq1PGSMHJaT/E0r/BDqHzSP1dOnNlIKLfIFbaHFv1f/cTEtLa8GbtUVj9+lMd2g5ODMAwklqumQ/zRlFonqCgCWLpG8kfqxT08HYZIms7TyHdKp0niVA7d0XVIss/fkAKFujaW2VmQOb8tslfaXmJWHC4EKMKbIufWGB8Ch0AHqPgLRTVC/ab7O/GHxyyEPFXrNuTRIoVHWV8GxAekCjyzkk/04HjRIM/oh3Cch8sBXQGn9b6wYOv0aHZcx0wAS8CfbezmjLDiQZS8EXzcSIJcAyR9fe+bsTd7bxLQU0zX8IBUsN9otsFenYaXfF09xDQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS7PR12MB9473.namprd12.prod.outlook.com (2603:10b6:8:252::5) by
 MW4PR12MB7191.namprd12.prod.outlook.com (2603:10b6:303:22d::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8722.27; Wed, 14 May 2025 19:01:03 +0000
Received: from DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::5189:ecec:d84a:133a]) by DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::5189:ecec:d84a:133a%5]) with mapi id 15.20.8722.027; Wed, 14 May 2025
 19:01:03 +0000
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
Date: Wed, 14 May 2025 15:00:59 -0400
X-Mailer: MailMate (2.0r6255)
Message-ID: <7E5BD96D-971F-4AFC-AC09-503310BE8E68@nvidia.com>
In-Reply-To: <20250514111544.1012399-2-david@redhat.com>
References: <20250514111544.1012399-1-david@redhat.com>
 <20250514111544.1012399-2-david@redhat.com>
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: BL1PR13CA0446.namprd13.prod.outlook.com
 (2603:10b6:208:2c3::31) To DS7PR12MB9473.namprd12.prod.outlook.com
 (2603:10b6:8:252::5)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB9473:EE_|MW4PR12MB7191:EE_
X-MS-Office365-Filtering-Correlation-Id: 557da976-8d09-4d6b-3d11-08dd9319ac1c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?H24Np2D28Cr/RIvUwMFEX0zxqe5IxAjxRNT0MFy+EWUw0EWIb2nW4qRzGDsW?=
 =?us-ascii?Q?fF9crku1HULHto13JbIhyJAVoGudbMmcwCbV6cVy1UoeQAXSu2WOkOgevNOa?=
 =?us-ascii?Q?0fDH3wSnGhdfvaLa853clly2hPKhiGyD73DTmTYipj1Gb8motmYqmvkKshzO?=
 =?us-ascii?Q?xmRVyZBKNMxX9ggqnVxsmJiBOE/kpLRJybPAaVonhKmYCIvqa1od+Kax7eeK?=
 =?us-ascii?Q?hnyJGMBxHKk34hFdaqYruQCCNa+Rg9Ettfk2Gmz7VZ92jjGp6mGAFlsExv7g?=
 =?us-ascii?Q?0cuZ2LQLUmdDvB0UqjatTvfHtPaqCoCJbvXALLAqKGvGJOHS5FqyeJZ+58Os?=
 =?us-ascii?Q?qgW4j6WHiUTMZIrHDym2VhdxQbgwJauOQUe7rHGKdySPys2oOWjjoB/GBrkJ?=
 =?us-ascii?Q?Tuzqh1KiOgD2puqq6v410GROgPO6PpCTceRXPrJKKCrIL3W+yLP/yuO4r4sc?=
 =?us-ascii?Q?DNZkkUsXjGWxlDVreTE6Czke385IVl/+LpbWQoEUnaQnIdrpagpd9gz0yGUN?=
 =?us-ascii?Q?esHkSk3ucFbemPRtg3TjH1u9F7FAmOVruSNdPzYRDPQ9XHUZ7U/1z6MI4gzM?=
 =?us-ascii?Q?32aQjtpuzDlf0YZJHNJct5SBz0Y0ONuwoCXE3oAqNdeXA1ePkXJ3fYbzcODo?=
 =?us-ascii?Q?xZ1O/Hbro/ZYR9AaKX2yqBPlWmMqiQ9eNDMC9gKiKXo1mjJdVEJRy9NRd+0A?=
 =?us-ascii?Q?oY0ogbytrW+dK3u24vC0MMTPa1BJfYPRT8QfAQGXyfudRpJYYRd1CItZaJ2x?=
 =?us-ascii?Q?DpocGpiciXFQNUQIpvnBVoDxU/I460ZAMnmxmPHyzfLOo1jSCaHPPuAzzsfh?=
 =?us-ascii?Q?0OfzJDS1kjUz7M/zHtWbFhYan4rRW4UibUBTBmLjdmapAG0IW8BWwwIpf+rW?=
 =?us-ascii?Q?oJZA/KQ6g06GqNHy4PZ57GyK0D/h2vSI5iS2Tqizaidht5+ARvyTan7TXiv2?=
 =?us-ascii?Q?BevqO9LPdDlWWD11VEGrW6LJEaWM/fc+c6biKWgX8OAMz7X7nPT1XXdxiAyb?=
 =?us-ascii?Q?dkIwsELfrJj+7rYTnsnYgoi15GMP6iUCLvDLpaFUKv2VcT1d9O7Yu+x7Z+MZ?=
 =?us-ascii?Q?Sp1wen9ikTUsAdGxSOHVkAe6C2l7uliZR/AVYTT7viOjOPgUwsiWVfq9WjKn?=
 =?us-ascii?Q?uHpSIvbb5ulV89YwY1WN+1jWf4xR6QdSH7dy/Q3LanuVMro6y/oiCXvCs8ic?=
 =?us-ascii?Q?CNYQxJde3LuFZw5Rfzr6fs04y1Ets0cRPkCO7luAMH3DDYp8NpchVEXAtjxC?=
 =?us-ascii?Q?1oP9Sj41KY97sGmqqXGmblyxkS6lfmEJK40A+QME62jTco5/pkrqP5hck7u1?=
 =?us-ascii?Q?AxwNG3MzwhrFMYp10L6AgwXfuUTZlwT+DYIUOpwfHTTKb0Geyi6hLn3ZdXDw?=
 =?us-ascii?Q?Bd0u2wdTWrxHJmcl4o0Bijzb5+T/4YVgCD1LuA+sLsMcQHBMj+Gksq45mOMW?=
 =?us-ascii?Q?xEGTch+d11s=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB9473.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?4D0K9X7KpXi5BJvl6DlP93dnn+9+tpY8ZKzN2mCzZC7D0a1NN4dq2xx4qR+O?=
 =?us-ascii?Q?SAB5szq/dQ+v3qwcY1DLU6JsqOWL8u+eMD4o80LwE3FRUEVRx+LNJuZbuUN0?=
 =?us-ascii?Q?l2Pj4aUMwLFErFghLhaxkfil9uwFiGn2Ae9WLLpV1WW6X24V849cnUTMDvj/?=
 =?us-ascii?Q?xNvWanb8wqKRxQVN49jcfhc2GOQyxWmuxH9IWh27oETfDz9nUM7dtANCCbbJ?=
 =?us-ascii?Q?SWNJhKD1qb7OYYX5Q2R2FX1y+mbAwuFywKKzs7pL7pul+ENcupx0UYfV9NXP?=
 =?us-ascii?Q?ORS9tS2WWsQrUke9pkdRxdvG3lYe/kyXdI+PEDrd40iDQYtt50I6pokIaLWs?=
 =?us-ascii?Q?E+3DvrvMUzD7P2vnXGumC7YpdoLz1tRUM559OsUBYQ6l1MOWgsP6HyYBemwr?=
 =?us-ascii?Q?LxFzaGaAi+xDyLW2tsE8JF4TDhPof0KG1MZaxn6f+7l2T/9+djynsz2szXDT?=
 =?us-ascii?Q?X6VYx0fY+AtEKCPFml4j20s9ziP6K2YZ5x4YhxqsCqtkIxRV703cebvoQVHs?=
 =?us-ascii?Q?a1N2GfJRFDGUxPBLzFtbbF0d9VtHd2s/pveE5+BHuKBazXMnCeIn3pH2WwYY?=
 =?us-ascii?Q?0QOw0NJUInTT+hHkVXuZcBqjkVb4L7fAaUvR4DUVaKizV5kd9wIzO655JgZ0?=
 =?us-ascii?Q?PRnDC5NJmCENRK58zkb9vwuArDGgGVyYgebuKWDKEpfKOgG+cmqe/5Jplv2n?=
 =?us-ascii?Q?HmXq+RiGIQKqzOp1UtCnA7aRg8OJeU8tez7flsBlai5YBqdvGFQ83c5elmrk?=
 =?us-ascii?Q?2+eqns54+F0G2ayNrGmTZ0k8J0ELtIPp7NIkKY0KjI41BakbSgZlJnzD+vqr?=
 =?us-ascii?Q?K7SBZuDY4qg4gC+XslQ3iF8BEMg86XyuyzIw3E1eeQAJOC4zOjse5Xl1nZRH?=
 =?us-ascii?Q?fPnRxHer5JLcyC7TkRKk0abx0rYxOety4j8TWZNBLS57nEwrAI5RLeo6chiw?=
 =?us-ascii?Q?haz4/O79e1Lh//byXUL/x0HvNwm0zBJjBrD30fU/w0GdZjnQ/QLv+FC0CPfL?=
 =?us-ascii?Q?9zQWkBHFUNngCE+1YLQFTXR0ZMFRnR9fB9iXAmdbiWj/CjVJzR6hkLefX9QQ?=
 =?us-ascii?Q?avwjIvgOnBZQBLLiny+FMk5kwHiMabUO0RFpLWgudGyN3y2QZRvGWpyjbqXu?=
 =?us-ascii?Q?bL3uxm86GJKu3jK7ga3pK1rZpm+A6o3vDOr6A1lmdGXXsrNjNMu7uVkR6hxH?=
 =?us-ascii?Q?/desmj0FDytSy1g+hVeqOwKw8S85ZQBLAze5/PtivSFErZYRjOcj9HeMdEKq?=
 =?us-ascii?Q?HKpt8iWJWCQMpCjBBsHLPtIk/lFFxYbM078Xtu1dSDuIZY+D5+KUvzUsA79B?=
 =?us-ascii?Q?bnxqUqDAdzCbywzf4kkXk0gLW0H7Y4mdKFDhUqlrOxeHefjXG6yVQJfnFUcW?=
 =?us-ascii?Q?lx6BA/SrdVPx3/yDWEDAGQVPGNBYn31oVwPehqyaWIWvqOMENZn+alE47RMY?=
 =?us-ascii?Q?HkFm67MejXFaaf3JdtOxlskFPaeZqYZ8v0GEB1sqwiXeMAtkvUvHgEZXMVFq?=
 =?us-ascii?Q?0+aIMVs4qdr1zphoyIjNJWKXEoFWNfdFGnqwfnut8LMwvknu5uHWRHHGfiqD?=
 =?us-ascii?Q?+iavCD7G+foXBDI2qApHRYw2linBL94D21I2oqPH?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 557da976-8d09-4d6b-3d11-08dd9319ac1c
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB9473.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 May 2025 19:01:02.9129
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tOxdSXnkQQGbZMdxBmBnTSTiSG15USBHYt6ES/nerOGoblSw41riuCge+PV/ihjO
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7191

On 14 May 2025, at 7:15, David Hildenbrand wrote:

> A long-term goal is supporting frozen PageOffline pages, and later
> PageOffline pages that don't have a refcount at all. Some more work for=

> that is needed -- in particular around non-folio page migration and
> memory ballooning drivers -- but let's start by handling PageOffline pa=
ges
> that can be skipped during memory offlining differently.
>
> Let's introduce a PageOffline specific page flag (PG_offline_skippable)=

> that for now reuses PG_owner_2. In the memdesc future, it will be one o=
f
> a small number of per-memdesc flags stored alongside the type.
>
> By setting PG_offline_skippable, a driver indicates that it can
> restore the PageOffline state of these specific pages when re-onlining =
a
> memory block: it knows that these pages are supposed to be PageOffline(=
)
> without the information in the vmemmap, so it can filter them out and
> not expose them to the buddy -> they stay PageOffline().
>
> While PG_offline_offlineable might be clearer, it is also super
> confusing. Alternatives (PG_offline_sticky?) also don't quite feel righ=
t.
> So let's use "skippable" for now.
>
> The flag is not supposed to be used for movable PageOffline pages as
> used for balloon compaction; movable PageOffline() pages can simply be
> migrated during the memory offlining stage.
>
> Let's convert the single user from our MEM_GOING_OFFLINE approach
> to the new PG_offline_skippable approach: virtio-mem. Fortunately,
> this simplifies the code quite a lot.
>
> What if someone decides to grab a reference on these pages although the=
y
> really shouldn't? After all, we'll now keep the refcount at 1 (until we=

> can properly stop using the refcount completely).
>
> Well, less worse things will happen than would currently: currently,
> if someone would grab a reference to these pages, in MEM_GOING_OFFLINE
> we would run into the
> 		if (WARN_ON(!page_ref_dec_and_test(page)))
> 			dump_page(page, "fake-offline page referenced");
>
> And once that unexpected reference would get dropped, we would end up
> freeing that page to the buddy: ouch.
>
> Now, we'll allow for offlining that memory, and when that unexpected
> reference would get dropped, we would not end up freeing that page to
> the buddy. Once we have frozen PageOffline() pages, it will all get a
> lot cleaner.
>
> Note that we didn't see the existing WARN_ON so far, because nobody
> should ever be referencing such pages.
>
> Signed-off-by: David Hildenbrand <david@redhat.com>
> ---
>  drivers/virtio/virtio_mem.c | 111 +-----------------------------------=

>  include/linux/page-flags.h  |  29 +++++++---
>  mm/memory_hotplug.c         |  12 ++--
>  mm/page_alloc.c             |   8 +--
>  mm/page_isolation.c         |  21 +++----
>  5 files changed, 42 insertions(+), 139 deletions(-)
>
> diff --git a/drivers/virtio/virtio_mem.c b/drivers/virtio/virtio_mem.c
> index 56d0dbe621637..77b72843c4b53 100644
> --- a/drivers/virtio/virtio_mem.c
> +++ b/drivers/virtio/virtio_mem.c
> @@ -278,10 +278,6 @@ static DEFINE_MUTEX(virtio_mem_mutex);
>  static LIST_HEAD(virtio_mem_devices);
>
>  static void virtio_mem_online_page_cb(struct page *page, unsigned int =
order);
> -static void virtio_mem_fake_offline_going_offline(unsigned long pfn,
> -						  unsigned long nr_pages);
> -static void virtio_mem_fake_offline_cancel_offline(unsigned long pfn,
> -						   unsigned long nr_pages);
>  static void virtio_mem_retry(struct virtio_mem *vm);
>  static int virtio_mem_create_resource(struct virtio_mem *vm);
>  static void virtio_mem_delete_resource(struct virtio_mem *vm);
> @@ -924,64 +920,6 @@ static void virtio_mem_sbm_notify_online(struct vi=
rtio_mem *vm,
>  	virtio_mem_sbm_set_mb_state(vm, mb_id, new_state);
>  }
>
> -static void virtio_mem_sbm_notify_going_offline(struct virtio_mem *vm,=

> -						unsigned long mb_id)
> -{
> -	const unsigned long nr_pages =3D PFN_DOWN(vm->sbm.sb_size);
> -	unsigned long pfn;
> -	int sb_id;
> -
> -	for (sb_id =3D 0; sb_id < vm->sbm.sbs_per_mb; sb_id++) {
> -		if (virtio_mem_sbm_test_sb_plugged(vm, mb_id, sb_id, 1))
> -			continue;
> -		pfn =3D PFN_DOWN(virtio_mem_mb_id_to_phys(mb_id) +
> -			       sb_id * vm->sbm.sb_size);
> -		virtio_mem_fake_offline_going_offline(pfn, nr_pages);
> -	}
> -}
> -
> -static void virtio_mem_sbm_notify_cancel_offline(struct virtio_mem *vm=
,
> -						 unsigned long mb_id)
> -{
> -	const unsigned long nr_pages =3D PFN_DOWN(vm->sbm.sb_size);
> -	unsigned long pfn;
> -	int sb_id;
> -
> -	for (sb_id =3D 0; sb_id < vm->sbm.sbs_per_mb; sb_id++) {
> -		if (virtio_mem_sbm_test_sb_plugged(vm, mb_id, sb_id, 1))
> -			continue;
> -		pfn =3D PFN_DOWN(virtio_mem_mb_id_to_phys(mb_id) +
> -			       sb_id * vm->sbm.sb_size);
> -		virtio_mem_fake_offline_cancel_offline(pfn, nr_pages);
> -	}
> -}
> -
> -static void virtio_mem_bbm_notify_going_offline(struct virtio_mem *vm,=

> -						unsigned long bb_id,
> -						unsigned long pfn,
> -						unsigned long nr_pages)
> -{
> -	/*
> -	 * When marked as "fake-offline", all online memory of this device bl=
ock
> -	 * is allocated by us. Otherwise, we don't have any memory allocated.=

> -	 */
> -	if (virtio_mem_bbm_get_bb_state(vm, bb_id) !=3D
> -	    VIRTIO_MEM_BBM_BB_FAKE_OFFLINE)
> -		return;
> -	virtio_mem_fake_offline_going_offline(pfn, nr_pages);
> -}
> -
> -static void virtio_mem_bbm_notify_cancel_offline(struct virtio_mem *vm=
,
> -						 unsigned long bb_id,
> -						 unsigned long pfn,
> -						 unsigned long nr_pages)
> -{
> -	if (virtio_mem_bbm_get_bb_state(vm, bb_id) !=3D
> -	    VIRTIO_MEM_BBM_BB_FAKE_OFFLINE)
> -		return;
> -	virtio_mem_fake_offline_cancel_offline(pfn, nr_pages);
> -}
> -
>  /*
>   * This callback will either be called synchronously from add_memory()=
 or
>   * asynchronously (e.g., triggered via user space). We have to be care=
ful
> @@ -1040,12 +978,6 @@ static int virtio_mem_memory_notifier_cb(struct n=
otifier_block *nb,
>  			break;
>  		}
>  		vm->hotplug_active =3D true;
> -		if (vm->in_sbm)
> -			virtio_mem_sbm_notify_going_offline(vm, id);
> -		else
> -			virtio_mem_bbm_notify_going_offline(vm, id,
> -							    mhp->start_pfn,
> -							    mhp->nr_pages);
>  		break;
>  	case MEM_GOING_ONLINE:
>  		mutex_lock(&vm->hotplug_mutex);
> @@ -1094,12 +1026,6 @@ static int virtio_mem_memory_notifier_cb(struct =
notifier_block *nb,
>  	case MEM_CANCEL_OFFLINE:
>  		if (!vm->hotplug_active)
>  			break;
> -		if (vm->in_sbm)
> -			virtio_mem_sbm_notify_cancel_offline(vm, id);
> -		else
> -			virtio_mem_bbm_notify_cancel_offline(vm, id,
> -							     mhp->start_pfn,
> -							     mhp->nr_pages);
>  		vm->hotplug_active =3D false;
>  		mutex_unlock(&vm->hotplug_mutex);
>  		break;
> @@ -1157,6 +1083,7 @@ static void virtio_mem_set_fake_offline(unsigned =
long pfn,
>  			SetPageDirty(page);
>  		else
>  			__SetPageOffline(page);
> +		__SetPageOfflineSkippable(page);
>  		VM_WARN_ON_ONCE(!PageOffline(page));
>  	}
>  	page_offline_end();
> @@ -1172,6 +1099,7 @@ static void virtio_mem_clear_fake_offline(unsigne=
d long pfn,
>  	for (; nr_pages--; pfn++) {
>  		struct page *page =3D pfn_to_page(pfn);
>
> +		__ClearPageOfflineSkippable(page);
>  		if (!onlined)
>  			/* generic_online_page() will clear PageOffline(). */
>  			ClearPageDirty(page);
> @@ -1261,41 +1189,6 @@ static int virtio_mem_fake_offline(struct virtio=
_mem *vm, unsigned long pfn,
>  	return -EBUSY;
>  }
>
> -/*
> - * Handle fake-offline pages when memory is going offline - such that =
the
> - * pages can be skipped by mm-core when offlining.
> - */
> -static void virtio_mem_fake_offline_going_offline(unsigned long pfn,
> -						  unsigned long nr_pages)
> -{
> -	struct page *page;
> -	unsigned long i;
> -
> -	/* Drop our reference to the pages so the memory can get offlined. */=

> -	for (i =3D 0; i < nr_pages; i++) {
> -		page =3D pfn_to_page(pfn + i);
> -		if (WARN_ON(!page_ref_dec_and_test(page)))
> -			dump_page(page, "fake-offline page referenced");
> -	}
> -}
> -
> -/*
> - * Handle fake-offline pages when memory offlining is canceled - to un=
do
> - * what we did in virtio_mem_fake_offline_going_offline().
> - */
> -static void virtio_mem_fake_offline_cancel_offline(unsigned long pfn,
> -						   unsigned long nr_pages)
> -{
> -	unsigned long i;
> -
> -	/*
> -	 * Get the reference again that we dropped via page_ref_dec_and_test(=
)
> -	 * when going offline.
> -	 */
> -	for (i =3D 0; i < nr_pages; i++)
> -		page_ref_inc(pfn_to_page(pfn + i));
> -}
> -
>  static void virtio_mem_online_page(struct virtio_mem *vm,
>  				   struct page *page, unsigned int order)
>  {
> diff --git a/include/linux/page-flags.h b/include/linux/page-flags.h
> index 1c1d49554c71a..581510ae8e83a 100644
> --- a/include/linux/page-flags.h
> +++ b/include/linux/page-flags.h
> @@ -178,6 +178,9 @@ enum pageflags {
>  	PG_vmemmap_self_hosted =3D PG_owner_priv_1,
>  #endif
>
> +	/* The driver allows for skipping these pages during memory offlining=
 */
> +	PG_offline_skippable =3D PG_owner_2,
> +
>  	/*
>  	 * Flags only valid for compound pages.  Stored in first tail page's
>  	 * flags word.  Cannot use the first 8 flags or any flag marked as
> @@ -1029,14 +1032,23 @@ PAGE_TYPE_OPS(Buddy, buddy, buddy)
>   * refcount of 1 and PageOffline(). generic_online_page() will
>   * take care of clearing PageOffline().
>   *
> - * If a driver wants to allow to offline unmovable PageOffline() pages=
 without
> - * putting them back to the buddy, it can do so via the memory notifie=
r by
> - * decrementing the reference count in MEM_GOING_OFFLINE and increment=
ing the
> - * reference count in MEM_CANCEL_OFFLINE. When offlining, the PageOffl=
ine()
> - * pages (now with a reference count of zero) are treated like free (u=
nmanaged)
> - * pages, allowing the containing memory block to get offlined. A driv=
er that
> - * relies on this feature is aware that re-onlining the memory block w=
ill
> - * require not giving them to the buddy via generic_online_page().
> + * If a driver wants to allow for offlining unmovable PageOffline() pa=
ges
> + * when offlining a memory block without exposing these pages as "free=
" to
> + * the buddy, it can mark them as PG_offline_skippable.
> + *
> + * By marking these PageOffline pages PG_offline_skippable, the driver=

> + * acknowledges that it
> + * (a) knows which pages are PageOffline even without the memmap.
> + * (b) implements the online_page_callback_t callback to exclude these=
 pages
> + *     from getting exposed to the buddy, so they will stay PageOfflin=
e()
> + *     when onlining a memory block.
> + * (c) synchronizes against concurrent memory onlining/offlining whene=
ver
> + *     adjusting the PG_offline_skippable flag.
> + *
> + * Note that the refcount of these pages will for now be assumed to al=
ways
> + * be 1: nobody except the owner should be referencing these pages.
> + * Offlining code will complain if the refcount is not 1. In the futur=
e,
> + * these pages will always be frozen and not have a refcount.
>   *
>   * Memory offlining code will not adjust the managed page count for an=
y
>   * PageOffline() pages, treating them like they were never exposed to =
the
> @@ -1048,6 +1060,7 @@ PAGE_TYPE_OPS(Buddy, buddy, buddy)
>   * page_offline_freeze()/page_offline_thaw().
>   */
>  PAGE_TYPE_OPS(Offline, offline, offline)
> +__PAGEFLAG(OfflineSkippable, offline_skippable, PF_NO_COMPOUND)
>
>  extern void page_offline_freeze(void);
>  extern void page_offline_thaw(void);
> diff --git a/mm/memory_hotplug.c b/mm/memory_hotplug.c
> index b1caedbade5b1..0cc5537f234bb 100644
> --- a/mm/memory_hotplug.c
> +++ b/mm/memory_hotplug.c
> @@ -1767,12 +1767,10 @@ static int scan_movable_pages(unsigned long sta=
rt, unsigned long end,
>  			goto found;
>
>  		/*
> -		 * PageOffline() pages that are not marked __PageMovable() and
> -		 * have a reference count > 0 (after MEM_GOING_OFFLINE) are
> -		 * definitely unmovable. If their reference count would be 0,
> -		 * they could at least be skipped when offlining memory.
> +		 * PageOffline() pages that are neither "movable" nor
> +		 * "skippable" prevent memory offlining.
>  		 */
> -		if (PageOffline(page) && page_count(page))
> +		if (PageOffline(page) && !PageOfflineSkippable(page))
>  			return -EBUSY;
>
>  		if (!PageHuge(page))
> @@ -1807,6 +1805,10 @@ static void do_migrate_range(unsigned long start=
_pfn, unsigned long end_pfn)
>  		struct page *page;
>
>  		page =3D pfn_to_page(pfn);
> +
> +		if (PageOffline(page) && PageOfflineSkippable(page))
> +			continue;
> +

Some comment like "Skippable PageOffline() pages are not migratable but a=
re
skipped during memory offline" might help understand the change.

Some thoughts after reading the related code:

offline_pages() is a little convoluted, since it has two steps to make
sure a range of memory can be offlined:
1. start_isolate_page_range() checks unmovable (maybe not migratable
is more precise) pages using has_unmovable_pages(), but leaves unmovable
PageOffline() page handling to the driver;
2. scan_movable_pages() and do_migrate_range() migrate pages and handle
different types of PageOffline() pages.

It might make the logic cleaner if start_isolate_page_range() can
have a callback to allow driver to handle PageOffline() pages.

Hmm, Skippable PageOffline() pages are virtio-mem specific, I wonder
why offline_pages() takes care of them. Shouldn't virtio-mem driver
handle them? I also realize that the two steps in offline_pages()
are very similar to alloc_contig_range() and virtio-mem is using
alloc_contig_range(). I wonder if the two steps in offline_pages()
can be abstracted out and shared with virtio-mem. Yes, offline_pages()
operates at memory section granularity, different from the granularity,
pageblock size, of alloc_contig_range() used in virtio-mem, but
both are trying to check unmovable pages and migrate movable pages.


>  		folio =3D page_folio(page);
>
>  		if (!folio_try_get(folio))
> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> index a6fe1e9b95941..325b51c905076 100644
> --- a/mm/page_alloc.c
> +++ b/mm/page_alloc.c
> @@ -7023,12 +7023,12 @@ unsigned long __offline_isolated_pages(unsigned=
 long start_pfn,
>  			continue;
>  		}
>  		/*
> -		 * At this point all remaining PageOffline() pages have a
> -		 * reference count of 0 and can simply be skipped.
> +		 * At this point all remaining PageOffline() pages must be
> +		 * "skippable" and have exactly one reference.
>  		 */
>  		if (PageOffline(page)) {
> -			BUG_ON(page_count(page));
> -			BUG_ON(PageBuddy(page));
> +			WARN_ON_ONCE(!PageOfflineSkippable(page));
> +			WARN_ON_ONCE(page_count(page) !=3D 1);
>  			already_offline++;
>  			pfn++;
>  			continue;
> diff --git a/mm/page_isolation.c b/mm/page_isolation.c
> index b2fc5266e3d26..debd898b794ea 100644
> --- a/mm/page_isolation.c
> +++ b/mm/page_isolation.c
> @@ -121,16 +121,11 @@ static struct page *has_unmovable_pages(unsigned =
long start_pfn, unsigned long e
>  			continue;
>
>  		/*
> -		 * We treat all PageOffline() pages as movable when offlining
> -		 * to give drivers a chance to decrement their reference count
> -		 * in MEM_GOING_OFFLINE in order to indicate that these pages
> -		 * can be offlined as there are no direct references anymore.
> -		 * For actually unmovable PageOffline() where the driver does
> -		 * not support this, we will fail later when trying to actually
> -		 * move these pages that still have a reference count > 0.
> -		 * (false negatives in this function only)
> +		 * PageOffline() pages that are marked as "skippable"
> +		 * are treated like movable pages for memory offlining.
>  		 */
> -		if ((flags & MEMORY_OFFLINE) && PageOffline(page))
> +		if ((flags & MEMORY_OFFLINE) && PageOffline(page) &&
> +		    PageOfflineSkippable(page))
>  			continue;

With this change, we are no longer give non-virtio-mem driver a chance
to decrease PageOffline(page) refcount? Or virtio-mem is the only driver
doing this?

>
>  		if (__PageMovable(page) || PageLRU(page))
> @@ -577,11 +572,11 @@ __test_page_isolated_in_pageblock(unsigned long p=
fn, unsigned long end_pfn,
>  			/* A HWPoisoned page cannot be also PageBuddy */
>  			pfn++;
>  		else if ((flags & MEMORY_OFFLINE) && PageOffline(page) &&
> -			 !page_count(page))
> +			 PageOfflineSkippable(page))

The same question as above.

>  			/*
> -			 * The responsible driver agreed to skip PageOffline()
> -			 * pages when offlining memory by dropping its
> -			 * reference in MEM_GOING_OFFLINE.
> +			 * If the page is a skippable PageOffline() page,
> +			 * we can offline the memory block, as the driver will
> +			 * re-discover them when re-onlining the memory.
>  			 */
>  			pfn++;
>  		else
> -- =

> 2.49.0

Otherwise, LGTM. Acked-by: Zi Yan <ziy@nvidia.com>

--
Best Regards,
Yan, Zi
