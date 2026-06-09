Received: from MW6PR02CU001.outbound.protection.outlook.com (mail-westus2azon11012041.outbound.protection.outlook.com [52.101.48.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A9133B0AE3
	for <virtualization@lists.linux.dev>; Tue,  9 Jun 2026 20:54:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.48.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781038456; cv=fail; b=oqThM9ecBCunaJ1ZKWNwCnwzcAXHMJkLnQ+K9QwatP+wl2YdW0F9j530NFyWrg3rohzK7EBd6PewgG56tF4R0bHvZbuPWiOoM17E7MY80vh+ocMcj8ieGPbqmF7fjD97O4Oyg1vGnc1G4PdqGi7yFJ7eNxrmmTrxuY/xXMwyd8U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781038456; c=relaxed/simple;
	bh=0+eFCaTBQDIA/oqwtd4ztEAv+HTBwkZtdfGqKxd4XIc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=lcKyK1u9eikoIs3ftWdV1HkiFhSEMT/B6ttyGvff4fVhsezUBPLSF/GlniMKmucJtqOdjntVXFhclwDlg1X5gZ1gArJXaRycnOMAlQUvcJZbbiKkk4mWurFTn8q+WhkiBAYwfG9j4Ik3juXCXUzm3pwqR2kaZiTKfhdttoi3UUA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Bls8DDTg; arc=fail smtp.client-ip=52.101.48.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Bls8DDTg"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AgfhAQe1GscJzS2yTdSejJlW4aibatjzT3Cm4+gLGyKtKYDoeUrbTTF+HkyNkc2WFCYsTwJBudx3kUysXgZ1sJmXC0rUYKuIdaEKMkmL/YiaZEdwYmhVorKFgNotzzTBBgCW6dSowkzyZG16tg8Lb8MQ7/tdvDnI87Urrb3Pyx3qa/oPkoTRsMA4ctTpUFYFQ7nZl0kmlKpMwe+LBOzwRMYcvlXzJplSX7mrBPWMZbDNF+8gviS8LG+tf6J53hwHFsQUvnhjIsyIniEe76Adyb1yicfEjoE4dZuuBTK9Rl3q6Ez99NDNSGvOFglcVobBAxT7pc2WJ+D+3HR3x3SYpA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ltc2sYZ1jQgNq8eTbayFrnsEjmaFVkawinOpfFW6WKo=;
 b=EVKjdBNm6raEklR9EcU9l4qK+QjtqOFwZprCaqggqr4kTrfkAPo0larsO7mHVyQhdBr9YKNAkkEj0klqHlLIGsnPgum0cTnHF0nD19T5Z/d0L0Xgs3O/3kYreG8FzgwUddKTvPv0hlRUUW+BBjdqoxNuRoip2Ed6K5qcXzrGalrPdyAqAUes4kixWMiVTtryESyrq2+Ao0YLW6oDsV/nUdkSsPqCTprjywGT6mbUK6POxE+Qz5GwEABk9dEvAK24MvUDQZbyDTx2oFp8KdmWiPwN6buudNwjnwYXtbmLIvtrh36ybn7AOkcF2hmYQ/TkCPbMJS0SVcnck3OHGsthkQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ltc2sYZ1jQgNq8eTbayFrnsEjmaFVkawinOpfFW6WKo=;
 b=Bls8DDTgrhVeCbxS1VeLDjLpB0FNtm9Yh8idr9VrS3G/fU/xtK4fd9F8rZYk5tgqqsiF/nxS8WjSBqL2LWOjfdDVZuTRTFRl0igWDqIVfTveiNpkIkFD9Z0i/sd4k/TX/qKYOFaky8jEK5Yj+ujlrTYlaN6DjB2ulZGGPV6ysL/37tC2ozB6IxZzhZ5/uS4+tPnUJ6mMnyjnMLZUtBrqgQJTq9VZCbeq8QkoGRyvDTfIFok1ECEQeRgUDtn1PjVc1rSTwKVQ6lVAbVgfywRCW3euhRQAFyUm1+gO66zsCNHInn1IKXkRqhAFAAABoamdb9B97gCl4Twyo2qDuHl6LA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS7PR12MB9473.namprd12.prod.outlook.com (2603:10b6:8:252::5) by
 SJ5PPFF62310189.namprd12.prod.outlook.com (2603:10b6:a0f:fc02::9a9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.11; Tue, 9 Jun 2026
 20:54:07 +0000
Received: from DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::f01d:73d2:2dda:c7b2]) by DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::f01d:73d2:2dda:c7b2%5]) with mapi id 15.21.0092.011; Tue, 9 Jun 2026
 20:54:06 +0000
From: Zi Yan <ziy@nvidia.com>
To: "Michael S. Tsirkin" <mst@redhat.com>, Miaohe Lin <linmiaohe@huawei.com>
Cc: "David Hildenbrand (Arm)" <david@kernel.org>,
 Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org,
 Jason Wang <jasowang@redhat.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
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
Date: Tue, 09 Jun 2026 16:54:01 -0400
X-Mailer: MailMate (2.0r6290)
Message-ID: <4BA276D9-9EB9-4E2A-8A05-657ACACFF227@nvidia.com>
In-Reply-To: <20260609162437-mutt-send-email-mst@kernel.org>
References: <df06b66fe4ff8e925ee0714955abc2183a727b90.1780998980.git.mst@redhat.com>
 <20260609111020.e88f51a7b6ebc37360d66fdc@linux-foundation.org>
 <8c1f468e-b50a-487a-a267-8d1ea5a61c87@kernel.org>
 <FB250C43-790E-4AB0-BD40-74665FC601A0@nvidia.com>
 <38C84F23-E881-4DB2-86BA-93F39D44AE1B@nvidia.com>
 <20260609162437-mutt-send-email-mst@kernel.org>
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: MN2PR07CA0025.namprd07.prod.outlook.com
 (2603:10b6:208:1a0::35) To DS7PR12MB9473.namprd12.prod.outlook.com
 (2603:10b6:8:252::5)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB9473:EE_|SJ5PPFF62310189:EE_
X-MS-Office365-Filtering-Correlation-Id: 270f9ed1-70e5-428b-6024-08dec6693ec1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|7416014|366016|22082099003|18002099003|4143699003|6133799003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info:
	dN3lE9NMPCGxxFoK2kL3CR279kE+EjTz1dK8AS3Z882MSlSdKzKEsVm7e/BVtk5BMxz5tyat6AVo94Lj8w3rQ7IMr8MBwsFeKf4KYPdTe8A6k62eYRJUAcPFF4P/rO/acNillj2Bbi6MPEZIIuruogExfDH8OzsVEPbbNkzbBIqhRXnQAvbrSz8plH/rHhQtEs+AhbMs4zGqHBInLAXjFAeVIQozobXsgf8AstcAz3exhLRFAkfx84hIsoEwxxyi7jB2hnlDuh8PBaZ7vUu1Jq3TDZB2Ez3m1iW5I9SAs4OHMCov0XiZ6wEt89AkQLt96HtwQIiX8jrAOdiCVoAhsvTwswHmRizGstgyLpOQmbUTNxzJFzWGyOBODy+mB/zRcX4FMYucryZNm7+5Alm3VmHpjAdRBaL+RtV2UjwOJJjwPkzEufOF7tvq48vdC8zkX4FdwucGCnicPgVF17+d1zJBOE/QCJ8OPQdTndFJhbhwp7sAiReFI7R03TpugpC16n21JGScd+c6L6UAkEImATCQ5qNdlJB/Gv7LxEfPp54ZRhY39MubtoJbRFu7jcD3+ccHcRf0p3l1rMqnFFxvVMNfzxD1C66Alt36tO+r18bdXkXfed/yzevI3VmhY55NPLp7gCpSrXlWa9QRh0bgS2LO+NSGZq74DavfqrfWF5BY7NUl77mj0DxJVjMgBvuQ
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB9473.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016)(22082099003)(18002099003)(4143699003)(6133799003)(11063799006)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?sIS2/Ov940ohoBpB0x+uTu7OKGyc2K7HXdt4zvZv6vK9+/sqlQnaVf6uZj+E?=
 =?us-ascii?Q?8ula9ugnF3VQ13S3+F2XA6A/TCWbFr48zrG5/x4MvYd8yuPSKmZzj6yjDM4+?=
 =?us-ascii?Q?BonBA7LFbv9bo0uFdsvVNO+q5QXlredM5csEUcNVDMGBLElnshREeh7XsIwA?=
 =?us-ascii?Q?omcObGJsA12jHy8ZLp6ogTHNjzGC1u+t+trLbzJ6iWBy6WWWRmT+X0jgfcDi?=
 =?us-ascii?Q?z4hzj5ceVxo/RYqaLeId2F2cKytvRLuQAaq+bmUN6Jg0IrtZ7kR4YjdjiexQ?=
 =?us-ascii?Q?38p0Mhh40/rmqcBw8ZNUMpy45IxGqTmirlIHqYDNiGxHhV3zxyMCvC0uD5HV?=
 =?us-ascii?Q?k4QJ73ICaEmUeqFRLCy4Jkw6q5nS3lD8D26zsrh/RvNL6NgYHmv/u8FdbFx9?=
 =?us-ascii?Q?Ly4RPaxoyZ2ipnB0Gjy6ktRid1MmbDWw499DGmcx6yZs8mQq33MPU6+DJyYC?=
 =?us-ascii?Q?BunntUZF9Xeku6xf3K4R/GjGlnxdxlp8DqMRY52bCphwxrLmHLmIfq1W3Gzd?=
 =?us-ascii?Q?FkHqQDjj5bHgGRLRH7m6QMcZEbbguFNFeKoO/1v2wy2UFIdjrRJFyInyn6nc?=
 =?us-ascii?Q?yLBkvFpWlDLlOPgzC6CX3zM60P4pIemcUpG7epKXS2WYj2rVgMmclGlxg5x7?=
 =?us-ascii?Q?UMXzmlPyI0snW5VoNHfYsYimqyk7C/93MQewKohoZrWMcsiDEKbpI8xYl920?=
 =?us-ascii?Q?+qhek6AKgjRwUK5Pqj6SglEvZadFasr6+b0veFhKRPpHJ7pvWtWc+2IpmfrD?=
 =?us-ascii?Q?uwRMTWB/euIc2hdx7tZHvxZ4mgAUPoYQAwlvJAnNVjDU6RhRjv/I7F50nnUH?=
 =?us-ascii?Q?aETUvbk5PMTjzD82yAXJIJcjdrtNqxJO5wCX7LzSDwzTD1IRc/lgxkkkCUo/?=
 =?us-ascii?Q?Kcs52NaRO/uW5bJUL57pGyD1ZUrolAwX3Aqge9ROqGpLQ5CbKtLf2yVQyh2t?=
 =?us-ascii?Q?Rs2duiaJFeVjfxLBxO0gBS1GkYvPGw8oKCA2abF3WY6E8U8MbY1uCk0baDAb?=
 =?us-ascii?Q?23I7K2e2lGu8zcOv87b80aDCWEHppyB3E8INN1I2r7Cj9eVi7RDt12OdbRxk?=
 =?us-ascii?Q?/0R9rY8SPaqaRB20EhbwsGisw5jpitJpz16UAWKoIAvD5L3sxQiQLWXKc7B6?=
 =?us-ascii?Q?R56sitmLZ0iGK+WawoKv/aqueR6viF+clQ2rgceydKn81JaaXkmOsDVQo1OI?=
 =?us-ascii?Q?X+JvEtQc5ms7kis9TEL+heZFw9XAPydPG5ftw5VkWE+PdgLfXbFUNyv2ith3?=
 =?us-ascii?Q?08/kOK0rtx8wouiyqlx91l9HwuJTwYAu6Wz+tia5PxwkJAMZr3gIKA0Guk8C?=
 =?us-ascii?Q?0oPCy/HVpKB6PGCqqG+9pYA3LIYBiDghYKXRjlpsRYwBR8pCV/3kfVaX3Ujb?=
 =?us-ascii?Q?uyglXjoyyuoaGHi2SxgO42C4rNKsPJKQuJlJp3aVcq+PTJqk4oqvXduA73RX?=
 =?us-ascii?Q?OvSzBNJmS/16vKQWtQ2DJ4RpfrITGR03IHs3aroalF81vTftT4VNFGEuVXNy?=
 =?us-ascii?Q?wTU6PfkMCT/o+ViHCuZgefo+tPciCoX/xj0sXfZCpbAbHvr9BpAheQokY0KU?=
 =?us-ascii?Q?dZpvpCeV6bdHy+C0Oe931OVbDNhmG1wTJXZgN//hExsx2agH8zVhcTdY7yHz?=
 =?us-ascii?Q?RUKgRN63ZQqqT6CZ7uNfum6fA9OC2CRNoO6LUX65gJjeUkSuc4+Aq7YSHyQn?=
 =?us-ascii?Q?1iVi/ysJ/fVaR1OzHcMdC3/Jab4nagbjDgj4N05N2uAvS+yT?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 270f9ed1-70e5-428b-6024-08dec6693ec1
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB9473.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jun 2026 20:54:06.0971
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Xj1kNZgD+u5aVdvO4nparUCyV2DRfevVDfuwQpPk7Dbc34lvGw6fOeIcf4bTG2mG
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ5PPFF62310189

On 9 Jun 2026, at 16:34, Michael S. Tsirkin wrote:

> On Tue, Jun 09, 2026 at 02:52:47PM -0400, Zi Yan wrote:
>> On 9 Jun 2026, at 14:39, Zi Yan wrote:
>>
>>> On 9 Jun 2026, at 14:38, David Hildenbrand (Arm) wrote:
>>>
>>>> On 6/9/26 20:10, Andrew Morton wrote:
>>>>> On Tue, 9 Jun 2026 06:12:49 -0400 "Michael S. Tsirkin" <mst@redhat.=
com> wrote:
>>>>>
>>>>>> TestSetPageHWPoison() is called without zone->lock, so its atomic
>>>>>> update to page->flags can race with non-atomic flag operations
>>>>>> that run under zone->lock in the buddy allocator.
>>>>>>
>>>>>> In particular, __free_pages_prepare() does:
>>>>>>
>>>>>>     page->flags.f &=3D ~PAGE_FLAGS_CHECK_AT_PREP;
>>>>>>
>>>>>> This non-atomic read-modify-write, while correctly excluding
>>>>>> __PG_HWPOISON from the mask, can still lose a concurrent
>>>>>> TestSetPageHWPoison if the read happens before the poison bit
>>>>>> is set and the write happens after.  Will only get worse if/when
>>>>>> we add more non-atomic flag operations.
>>>>>>
>>>>>> Fix by acquiring zone->lock around TestSetPageHWPoison and
>>>>>> around ClearPageHWPoison in the retry path.  This
>>>>>> serializes with all buddy flag manipulation.  The cost is
>>>>>> negligible: one lock/unlock in an extremely rare path
>>>>>> (hardware memory errors).
>>>>>>
>>>>>> Note: SetPageHWPoison and TestClearPageHWPoison calls elsewhere
>>>>>> in this file operate on pages already removed from the buddy
>>>>>> allocator or on non-buddy pages (DAX, hugetlb), so they do not
>>>>>> need zone->lock protection.
>>>>>
>>>>> Sashiko is saying this doesn't do anything "Because
>>>>> __free_pages_prepare() executes entirely locklessly".  Did it goof?=

>>>>>
>>>>> https://sashiko.dev/#/patchset/df06b66fe4ff8e925ee0714955abc2183a72=
7b90.1780998980.git.mst@redhat.com
>>>>
>>>> Battle of the bots: it's right.
>>>
>>> Yep, __free_pages_prepare() changes the page flag without holding
>>> zone->lock.
>>
>> __free_pages_prepare() works on frozen pages and assumes no one else
>> touches the input page. To avoid this race, memory_failure() might
>> want to try_get_page() before TestClearPageHWPoison(), but I am not
>> sure if that works along with memory failure flow.
>>
>> Best Regards,
>> Yan, Zi
>
>
>
> Actually memory failure already plays with this down the road no?
>
> So maybe it's enough to just SetPageHWPoison afterwards again?
>
>
> diff --git a/mm/memory-failure.c b/mm/memory-failure.c
> index ee42d4361309..4758fea94a96 100644
> --- a/mm/memory-failure.c
> +++ b/mm/memory-failure.c
> @@ -2415,6 +2415,7 @@ int memory_failure(unsigned long pfn, int flags)
>  	if (!res) {
>  		if (is_free_buddy_page(p)) {
>  			if (take_page_off_buddy(p)) {
> +				SetPageHWPoison(p);
>  				page_ref_inc(p);
>  				res =3D MF_RECOVERED;
>  			} else {
>
>
> and maybe in a bunch of other places in there?

You mean for fear of losing HWPoison flag in the earlier TestSetPageHWPoi=
son(),
just set it again here? Why not do it after get_hwpoison_page(), since th=
at
is the expected page flag? Miaohe probably can give a better answer here.=



Best Regards,
Yan, Zi
