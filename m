Received: from MW6PR02CU001.outbound.protection.outlook.com (mail-westus2azon11012069.outbound.protection.outlook.com [52.101.48.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 669483E314C
	for <virtualization@lists.linux.dev>; Tue,  9 Jun 2026 18:53:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.48.69
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781031183; cv=fail; b=prhoXhCWZuYY8+b+Sw9KL7q9T0AUSEmgE87nH5RHR6S380mcG5YfHb7VzPCdezQ67iPp1hUopGBC//k/6sNUdXx+pDSTo/eXLqTIdYKOAQhY/Un9G5zyeamSWX8zfhR640XOkobXMOc9P4rZViA7aMRPl98+D5a5DQ6T6UTOzfU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781031183; c=relaxed/simple;
	bh=XzXa8QrqAPEV47NgIJfl3IiIM4JXMy/9c6vcCQA2P5s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=biqMKtgvX2gnakqwOYsWmnw7Wv2uLFkNsPxZOc8fLMH1PMJzw8jMMXi+x+v0MmnlpCxZhJK0LX11XOG4E828FsfvRSeAnS8oSTiQwbHPFCGARzrZvqQC9eNJunf3rb5e1Iao0zD8qiwtYrar1uHforeOkg2Tn8Spn3dBVw0SMYo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=cnWMy0Hb; arc=fail smtp.client-ip=52.101.48.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="cnWMy0Hb"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yPiDTUksv2aXRnRSxZAZI2mOt2vxOLK5GOmf3UJl7WtH5AY4DIQgu5HuB3k7zhmxbd2PIofyV3xjU0/K5EjFHDHGOj4wTvbDk9mjcJmpiSId4Z9aRY3P1LZY/tiMx/n3cDcauApHaTwsGuUcdVNWUbUw3xrNnTqU24pq8X0CG/fQebZkax20S4GTqdO94IVDACo53osauGf3S+XiWS4hM8V9GOs8q4yT1/T+kwqP7rcNH8XKuKWbfITNoGqoCHVHcKwlt2M+aWVb6eyVftRQe0/qhwQEPxmVpsYGL77BSVSCP97DBaGVJdJIohEPV8h4EjonnqpXfS2LdhjvpUBcVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=99+1M+IVtMlRMe407WjQc467U9XqC6IJAz0nmEG3pek=;
 b=fIDdbpA7nopCDrbuI0N3CeCoRjBHwCTXDbRgQirQrseYftdKhdBl0A8aSGKO6kWwoOwo3xqUDrAQ2YCqhrJL6QRNgeb0ItDpL/SDZyRUTWy+jdaIyHxV8gM4F+3gbJud24a0INaKaOoxNx2toAtyYR7P3HnKcJoHmdnVosa7S39hHi15WgkhhVFPMhGRkj64DTxsZhTJVvOgNhsWYAoOAXpQcQmsGKtC5BOctfymgIhSe7SqaHfj1d/A39Zme5c9dlXrjNWQ2vME/VgOFZzflV9qjOylWj1ahplTU5JlWuBBq3LHyJcE0OR1wkwyHhH6sBRGKuCkHJR+l78yog50ow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=99+1M+IVtMlRMe407WjQc467U9XqC6IJAz0nmEG3pek=;
 b=cnWMy0HbtPaDxTNF6Oht2nvWQ+X1DQa+xYUVPFTulyWs5BH64+E+AO1fGxIjBb9WxVPTxbe7sWJ74eVf1l9yOpH4NQ2bQVgBPOz9KTyqYcaFdsV3NQTRaLEWVDyRm/eBQQdindYSvhSHKQWK/PAurDIrHudio/1TIMy5lnUgz4ndoHr6m9ZcRWAu4Zse5F56FH+BhcPVQXJewoOT2SmWRNklhvXtNhVa9J1vfb//K6zn/bJ5l3mM8R6fQf1Upwd2EJyZZakC4L1dTyyzh1ZSb9caJt85fbvLpnt97hocu6n+ANkpm5aOI/eDuoVrWgNh8Gl3P6rvvy2tHJcxnOqILQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS7PR12MB9473.namprd12.prod.outlook.com (2603:10b6:8:252::5) by
 MW4PR12MB7238.namprd12.prod.outlook.com (2603:10b6:303:229::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.12; Tue, 9 Jun 2026
 18:52:52 +0000
Received: from DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::f01d:73d2:2dda:c7b2]) by DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::f01d:73d2:2dda:c7b2%5]) with mapi id 15.21.0092.011; Tue, 9 Jun 2026
 18:52:52 +0000
From: Zi Yan <ziy@nvidia.com>
To: "David Hildenbrand (Arm)" <david@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
 "Michael S. Tsirkin" <mst@redhat.com>, <linux-kernel@vger.kernel.org>,
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
 <virtualization@lists.linux.dev>, <linux-mm@kvack.org>,
 Andrea Arcangeli <aarcange@redhat.com>,
 Naoya Horiguchi <nao.horiguchi@gmail.com>
Subject: Re: [PATCH splitout] mm: memory-failure: serialize
 TestSetPageHWPoison with zone->lock
Date: Tue, 09 Jun 2026 14:52:47 -0400
X-Mailer: MailMate (2.0r6290)
Message-ID: <38C84F23-E881-4DB2-86BA-93F39D44AE1B@nvidia.com>
In-Reply-To: <FB250C43-790E-4AB0-BD40-74665FC601A0@nvidia.com>
References: <df06b66fe4ff8e925ee0714955abc2183a727b90.1780998980.git.mst@redhat.com>
 <20260609111020.e88f51a7b6ebc37360d66fdc@linux-foundation.org>
 <8c1f468e-b50a-487a-a267-8d1ea5a61c87@kernel.org>
 <FB250C43-790E-4AB0-BD40-74665FC601A0@nvidia.com>
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: MN2PR01CA0037.prod.exchangelabs.com (2603:10b6:208:23f::6)
 To DS7PR12MB9473.namprd12.prod.outlook.com (2603:10b6:8:252::5)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB9473:EE_|MW4PR12MB7238:EE_
X-MS-Office365-Filtering-Correlation-Id: 1c6d706f-1d10-48c8-c62f-08dec6584f78
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|1800799024|7416014|56012099006|11063799006|4143699003|6133799003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	/TltIYIUnWWIaEkHYRGhS/ApmFvWgFd5v3ZGRKwmR+TjPCRPJPq4T+2w6IoVrMaDdfynq+YucBFMcpa6Q1Jse9fFpSqZjuA6YJdG8il5AGAbQ6gYxWOiMd7QgeBmiLSzkIvnU7O/OQhLenOmDx/a1iejBaULa0Y/9dcm0cfu6T5jFRBJgT6tG04/5EDEC7vCvKLTdRIC9T/oicf5SqY1aEibYNNPHn16gvNCII+1bHmnX53GNxW7epNTj3ed02rhaadwWSqITHQDSfXTX0LgOVTe1a5GVQax/40B4r501Lwfhu9uhswVM/yAesrt5lgQ3XjoDAgE3e9cliLlQ3nQBV+x+QIbHv3ftaZDdM0/ygeiVYyk+k1y4jcpoq6RFFqQP0jcpLtu+IOv9+i2cRXguSISyYGEu23Ri0BFEPEVfODxRTtnbd/YvT/TIs9woxeiv7KK8ofjsiUaKnxGFeagweEHHjt/vNbCdxF+mtL6xKqnPb+UqeLiq2lV+WcmlUZ3jeRWYAooe9Qjc7ggFdw2lQ+UBU5T9vNJCot0uee+tLL/atWOW+mfWI3cbicDjARy/sNn1bjGCR2fB31S9regKBaeELJUtX4o1Cc7R7if6EYuYadQ6K9vyqOt/HlwCq0lbyTWHVOVwuviG0YDgE93HH7MwGBl1HigzD0jceJGkyxrY2JQ2Oz8ZpetsesfQ7GN
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB9473.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(7416014)(56012099006)(11063799006)(4143699003)(6133799003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?/tO/oTG6a+letA0vE9uu8S5YXfyVHUulolzQYGecsuy+lkbj3b1/zNbqMD7b?=
 =?us-ascii?Q?tment+dk+C878SoxDzkWiCwSajmSmNOgYibYkF+OglE1taj6yVvzAdq3nd1p?=
 =?us-ascii?Q?BAswBGlFGbtdedDySgT8Ptv3fPefa+xG/i2yJF8rwnkmIa2FBIVF2GhdUSPB?=
 =?us-ascii?Q?MJ691K+YtHoQ+xZWQ7qIpBne+8Mf6dBDyR8pWnB5bqLLgXNQRdGl3bFL36F4?=
 =?us-ascii?Q?j6Dm0wKYTDq9weookeQkWlB9D/J1WYoG+wcaMJOiNNvAy3f2IH+0b8lRaAsu?=
 =?us-ascii?Q?iUJxKSdBQxq8qO6rAl8CBQe/qqc+gEX7GR9XhQF4ZMvkj+pUw1vnavQbyWAb?=
 =?us-ascii?Q?5xccTkiy6n5SmomWJBJ+52FBLMAPlXEv1W/+XV8VUpGIbv7dCKtugO6PJriq?=
 =?us-ascii?Q?AzO92bNpkEpTLdI+l56DoXLGCFCg1mtC4SFd8nYFM8cohKmkK6RqX77LIIzw?=
 =?us-ascii?Q?T4sle0xshNpWMV05V/RkIfTHjQ8KxUTnY+vhRpYdzwCDYjNTPhVRiu2LCuXY?=
 =?us-ascii?Q?1wnF9JY1+SFf+dopv/rWkT7QP4UKxYI4EuYXQ7sn7hr/trZoB8Y24jdtQdYE?=
 =?us-ascii?Q?OSHuo/VI6fBTtYZJXwCcMXaJQhxOsGq55Rg9J/EOAcd6+1l3SbhWq7h/kZSm?=
 =?us-ascii?Q?2ecEBX51IuoM1SEwAWaaR/nrw/+4DtUwugd+9UAaN5JlXFZEkHYgUBSQWTNv?=
 =?us-ascii?Q?KGxev8MwwxJw0Xd8ozXoD5HsCdGoOyrYqprOfqJCCLTi3V5nP1WYM/d2lY01?=
 =?us-ascii?Q?aNbcP7VihweDum+zse4cQAHhuloqGuTOlbl4lcbglzR+9Qmd9d5EbLhR/PWS?=
 =?us-ascii?Q?nW8Bx9uS8JV0aEwelkB6SogArz5mmqb2GUt2dH6/PYAW6BJh+f92RgIrg9Ll?=
 =?us-ascii?Q?4QkPNOhJQiczK/P7yeVR15/U+uMPXLBvTHeYFUYk7vnPL4yUzs9hGG9xu5jB?=
 =?us-ascii?Q?XcxbYnFkspxsI71hgEcsw99B+8osns5/+3p/tfro9U6KBQlBQ+gq4S9f2eDc?=
 =?us-ascii?Q?3Us1jAqoMSND8b6Wb7aUiPqxOQqlMsmK5YpuXWdo83ROUyZEUYgT9aoTHppu?=
 =?us-ascii?Q?7Si3o65YIc1Fz3SYVj31WDi75wfH5PQK4iS39qNiBNMUuw5/CNmp/Nkga+Ns?=
 =?us-ascii?Q?nDoC16rlu8Z9yUZ0GH2rh/QLGNy9BTv9DPFGeUdnS2hnRku5oUaWdwLT9GDq?=
 =?us-ascii?Q?J2gNDnEfanm2RFOalyjoaDxUq5eXHyZLK6WBKwyLtslLx/fc3htGHGhm7RYc?=
 =?us-ascii?Q?B6xGlKG9ypuymksGE1pd/nDdDxmnys3jNqFOGN/tCJpizAqtxOn9FHr63yWV?=
 =?us-ascii?Q?2FlbFXyXTOnBWRQsClS41YgkJBpZ+CYO6MaZdkiMdAn6rHzYIlPsWxqRW2Dy?=
 =?us-ascii?Q?4Rc4Ir1WMAzkmgvMGVxEekInTt7SOmPoej+G6uk1G/IohXZRF2b9Xpl9sRYw?=
 =?us-ascii?Q?Ra2f5dcMfOu2LpP2LFGPBM5a5VYPKue2H+czrc22cH53wdjuN7APe2IhmpDy?=
 =?us-ascii?Q?ssmeJkg5KNd5u4KC3I69GnWiHCX+6P0q3bxJdrecjhXIqaj56WetY9Ren4th?=
 =?us-ascii?Q?K9USSl9/HAjjZTI7nBUYlXaLV2lUTioGCKhqRNNCNfmQ+iN3l2ABraGfJeQy?=
 =?us-ascii?Q?W4+HDqUu+WnWOFYgIEpn5rwEbapfBnkw4cG0QKXV196f5qiwgLPGzZ5q8kUj?=
 =?us-ascii?Q?zQwR9KgUFVv6DrZjyQtc9wGwElC4pzfS9XLiL7OsLoMiAN8leLjfNsF/COF5?=
 =?us-ascii?Q?SSMH1eb7bQ=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1c6d706f-1d10-48c8-c62f-08dec6584f78
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB9473.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jun 2026 18:52:52.7135
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zwdgwja9gt6lhwuy6IGAdkkd6xjLKyZQ/zd4klVod1lRlv8cR6kU2uKzdMgKZXyz
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7238

On 9 Jun 2026, at 14:39, Zi Yan wrote:

> On 9 Jun 2026, at 14:38, David Hildenbrand (Arm) wrote:
>
>> On 6/9/26 20:10, Andrew Morton wrote:
>>> On Tue, 9 Jun 2026 06:12:49 -0400 "Michael S. Tsirkin" <mst@redhat.co=
m> wrote:
>>>
>>>> TestSetPageHWPoison() is called without zone->lock, so its atomic
>>>> update to page->flags can race with non-atomic flag operations
>>>> that run under zone->lock in the buddy allocator.
>>>>
>>>> In particular, __free_pages_prepare() does:
>>>>
>>>>     page->flags.f &=3D ~PAGE_FLAGS_CHECK_AT_PREP;
>>>>
>>>> This non-atomic read-modify-write, while correctly excluding
>>>> __PG_HWPOISON from the mask, can still lose a concurrent
>>>> TestSetPageHWPoison if the read happens before the poison bit
>>>> is set and the write happens after.  Will only get worse if/when
>>>> we add more non-atomic flag operations.
>>>>
>>>> Fix by acquiring zone->lock around TestSetPageHWPoison and
>>>> around ClearPageHWPoison in the retry path.  This
>>>> serializes with all buddy flag manipulation.  The cost is
>>>> negligible: one lock/unlock in an extremely rare path
>>>> (hardware memory errors).
>>>>
>>>> Note: SetPageHWPoison and TestClearPageHWPoison calls elsewhere
>>>> in this file operate on pages already removed from the buddy
>>>> allocator or on non-buddy pages (DAX, hugetlb), so they do not
>>>> need zone->lock protection.
>>>
>>> Sashiko is saying this doesn't do anything "Because
>>> __free_pages_prepare() executes entirely locklessly".  Did it goof?
>>>
>>> https://sashiko.dev/#/patchset/df06b66fe4ff8e925ee0714955abc2183a727b=
90.1780998980.git.mst@redhat.com
>>
>> Battle of the bots: it's right.
>
> Yep, __free_pages_prepare() changes the page flag without holding
> zone->lock.

__free_pages_prepare() works on frozen pages and assumes no one else
touches the input page. To avoid this race, memory_failure() might
want to try_get_page() before TestClearPageHWPoison(), but I am not
sure if that works along with memory failure flow.

Best Regards,
Yan, Zi
