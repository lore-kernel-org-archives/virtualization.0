Received: from CH4PR04CU002.outbound.protection.outlook.com (mail-northcentralusazon11013023.outbound.protection.outlook.com [40.107.201.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D342312831
	for <virtualization@lists.linux.dev>; Wed, 10 Jun 2026 16:21:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.201.23
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781108500; cv=fail; b=A3Gw3sr9XH4TkPxenJNpF75yDgAQDz8bxo8rJZv5+6tyeH7X+n9xZveahA8SvF4Ye5Lteb/OaTt6IjxaQex9p+73K8oMUs4pTqv6Mo46vSV0o61ehedM+NsBb1LOjsnNwEo+hefGyKgZNYd20IZS3w3lweXaqQEwc2Q8B3QKZ0c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781108500; c=relaxed/simple;
	bh=hxziTgj+mAxO7iPwAhzOoeOihlzyVbTcPwd14ahuz7Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=UT3Am/UYpWKqE4yL0+JHpAI0zGzvzOWrbdZVWyZaHgbMKM4mRkXviK+amSMqCJTdrSy0y0J2pDm08AHakziu80Vljv4mXXyv+xT44/swFUbff1CK+YWdOX5nxjxH70kGFXViVLkJb4k1t3prcBoezaMpUF0B0abvXKfgnDRnJCE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=IUTIUH7Y; arc=fail smtp.client-ip=40.107.201.23
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="IUTIUH7Y"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FdaM6OhjHIWRP+mYvcEeA++w6B7F/fDI1xp+v75Qi4vDkdNsXBs9aEatJmbrZIEm5J9eOHnpjw5thgoRY7KzllscnTG7Z6xCLA6IHCtIxleYZlVU32C0J8gDuR+TO3VnG7DBSEw6QRgX+m5oDCarZNOB4jUMdoPMVsrUgVb4ArN4D0u4WMhBn8N5aSWidPOg+GNv6QNti2DOz4/5P3l234DhkbOT1bwhwu3GYZKY+VYaCk0YW1SLtIv/Yifwv9JYNUzFgcqzxC81EXOp0Aw27AhyT6JISR+PEsAYtrXcJftPi0vKWaXmiPsuepOd1mhm1lUwKzV5uuQ09QVY07H4kA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZSYYTRmCMNXCOMh61hjDk1ZU6wDnMhk0hCux4OuVniU=;
 b=lZrLxaa4Wuhso+yBBm0SlzkZLas+/EhjmfygoQMgAqhj1Ip/zDaNBhM3dXQd6dbqmPHFo5HFi/yKjuYLdBYOZfodK8d3UeuU+RkGbB8jLeSFuaVMMHSHdHfP2cPKQoeeCLYJutvyTSahTtNMPjCs0XrnX5okrSXOwkFdAipO5ReMdL6uFxQNrUHmdUW6hltY9ZnBKc40cgFNdRhPa5h4E6an/hghRNNb8ilH8xfKigelZ9asG1TuzgCgpQOvwlHHzZdqmFyurxNQjQh5j1+7mj9HAoZXvxkChBkmviLgrxBFtNBRe7adfIJlz24QDIHmyf0lcFqnEIyycEr88mkl3Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZSYYTRmCMNXCOMh61hjDk1ZU6wDnMhk0hCux4OuVniU=;
 b=IUTIUH7Y/5YJFHkQ5fX71z4OhfG7Ih7S9Vh2OCeqMRMYwP1i8hviIRoOPO+/lbmEkjnyea9uVkItYnPdbkwURnLiP3gKp7mu5WX2FH1L1m1vVhNx7ldDm3j5hFJu/US/jklFpKySP2mV/Tq5IiEiRGBcBxVHsPlWuN+cn38k8X4DuPhoRKuwyQZkabf1wI3o2IEQpslDDfiw3YU8cGz5qO9IAzNVKpg5j3PZun660wSr55dt70TXW+ZZ1v9byzZ3Z4q32YYOuxvGMVHWUq2OXSNJlnWKAM7DwuaP9X79/7TkL7Dr+iufsV/sJpBeD2FLqHjO9ywY+xrVxXXOkljB2Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS7PR12MB9473.namprd12.prod.outlook.com (2603:10b6:8:252::5) by
 SN7PR12MB8436.namprd12.prod.outlook.com (2603:10b6:806:2e3::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.12; Wed, 10 Jun
 2026 16:21:32 +0000
Received: from DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::f01d:73d2:2dda:c7b2]) by DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::f01d:73d2:2dda:c7b2%5]) with mapi id 15.21.0092.011; Wed, 10 Jun 2026
 16:21:32 +0000
From: Zi Yan <ziy@nvidia.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: linux-kernel@vger.kernel.org, Miaohe Lin <linmiaohe@huawei.com>,
 "David Hildenbrand (Arm)" <david@kernel.org>,
 Jason Wang <jasowang@redhat.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
 Eugenio Perez <eperezma@redhat.com>, Muchun Song <muchun.song@linux.dev>,
 Oscar Salvador <osalvador@suse.de>,
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
 Naoya Horiguchi <nao.horiguchi@gmail.com>,
 Alexander Duyck <alexander.h.duyck@linux.intel.com>
Subject: Re: [PATCH v2] mm: page_reporting: allow driver to set batch capacity
Date: Wed, 10 Jun 2026 12:21:27 -0400
X-Mailer: MailMate (2.0r6290)
Message-ID: <826570F3-F091-4567-81D9-0BFBE8761D5A@nvidia.com>
In-Reply-To: <cb43adc61d2ed3069b2fe428f3e051dbdc4cc28d.1781097156.git.mst@redhat.com>
References: <cb43adc61d2ed3069b2fe428f3e051dbdc4cc28d.1781097156.git.mst@redhat.com>
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: YQZPR01CA0088.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:84::16) To DS7PR12MB9473.namprd12.prod.outlook.com
 (2603:10b6:8:252::5)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB9473:EE_|SN7PR12MB8436:EE_
X-MS-Office365-Filtering-Correlation-Id: 1c0e4835-dd76-41e7-d414-08dec70c5554
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|7416014|10070799003|23010399003|376014|1800799024|56012099006|11063799006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	obSre5UGy6KnhZHO+oLHoCht8YAGBBXZLon4SXWqu+2p9OEhoEKMVbVfQBLYAE9sOkcGSRjKbLSYgs3LWHkWWB+z3t9wBinVwZPXIWLJPeImF6F9UeALjeR5R8+w7tx9WX/1DDj83c23Ehjj779FqcsM2uCDtoExlWGJiL028Lg4kCl00X8vfPN25hjTkpEyQ3464GZjk+0L//dfiu1bMTCr4OSrocY+BEUtUoN31c6LlkknCQZnUkAfEvr/9YXSAIRR6bJ1z8MNTDNBwnuDj/raatjaiilI75jigXAW2b3nNIfFtjh8pAkG1BWvDQu+pXWSpVPO41zNmKnNKxn7C7WhtrOZViqT70Tx8lxuqIn1FDM2qjrB7G0llXFhKDW7w36sYK2V/6450JTTJzz0HeUUwqyUGboetDEtD2lS6CJ8gtJpemCKLHE+uDTk6gHTAp1ZKqiOQD6Cu2uhqcQtgE/jyu5bQRiwxr4SPd4Ipb+DDqBJuM1/68i4pQCXK6nvf/TdcHk7U+e61PJ5Wh/hrxXPOJilHLcmbQMOlB27s/oqkpmoRcJNOaOPVj5Y1XcAxU6ynrSoo6CaaduEtlTfeWyrFviu8nh+lb1Y5gvUnbCr2ijLj6ZSULt3IUbfeqq4uq+SCmXfZqm8RDaGgkCXXg5oaJbNPrpeqYsON8DXbLhNnyEhBrYCrLVp62yJlFaf
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB9473.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(10070799003)(23010399003)(376014)(1800799024)(56012099006)(11063799006)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?FGOkaeFW/4BTmPC0sFjzpjGFXnFM69mdwvndc+4TFcUrBG3WQvht7w/DQGE4?=
 =?us-ascii?Q?NG8Rf4G++xkR2xukdx5cLkMGKo/GbSb9lI1PLl7M0QMw4iDijNdkyeWsQf8o?=
 =?us-ascii?Q?Z/k8ypRekHXKMK1/Dum3vanU/ERmOWmuzSsUn5qyJqlqI4HTkSDSnZnxZMSX?=
 =?us-ascii?Q?vDlr7gTY95qDejmYMygEuYSLhTk12AlAPtYIupQj5mgEwea98cE1KB6rzfV6?=
 =?us-ascii?Q?t+L9ckuAgFXey4irtbCf7sWCRBBPmATLRAoDyM/KNXAu/bUWDN+sDDYmcyje?=
 =?us-ascii?Q?lYnECyZjVYr+4t0jfH8CvRn4is/YphStjvhAzq4arDAnsDoLuohDgQ4wBMEk?=
 =?us-ascii?Q?F8ListdgbhoWOSE1n7Vl9pfQdOd1R+O0T4pZHkcD4Wd3hLkbdh7dSJ0oHJ8t?=
 =?us-ascii?Q?sx3K1JbsnYBppTMDG6wJn3dZlxbM5yDJ/hFFrMN7fZMP0AFIFcFSE0USQRqc?=
 =?us-ascii?Q?xEdiNZW5kk/Bs8IRAc+Z7l6EDyduOVzMovxT6iiI9DDZLaT6RjB1QtFVFXsM?=
 =?us-ascii?Q?bhOAwymtUDjpDQ++GEQjfDbsrKffAyLDB5tghCw0Dl+oeaX27tjz/Md5CS6a?=
 =?us-ascii?Q?WTzDSUqnnEIl2TohQ7yVI5WVXdEamW7yNkmjErPZzi+0O5QfULrIEHXWONyk?=
 =?us-ascii?Q?uKkeGWTL0aeA7LmI4Nv/29dSXliKYWOctRW1Bpt3JidWj5x6rA4cVvyqUaxI?=
 =?us-ascii?Q?G7YIdn7JgXroveEckqlZNYhcxPtYaiU9PMpZu66D9ONKGj9W4XnpnxSMtebZ?=
 =?us-ascii?Q?z44u1XjzRKmI7kdnSvvd+ycwGX1+iVhnSyJ4a6XKKDznEwqovL/YJJwpRlTD?=
 =?us-ascii?Q?OvkG1B0Bc/V4SX5Laudc331sgaPC60qXjWgb7lNU9nlIzHZlNrMu/vAxHCXR?=
 =?us-ascii?Q?kgG2I0YJE1jdRWJZIK3wUnoN5aW6Jan+l0u1O4TlREEtrmJW8Fk9rxVHKaT/?=
 =?us-ascii?Q?JhRwdxVtenWPbwdT/nSOd8hjRxfPbpocZTaZ8N5zfcwaYnGEZe8/QJQAJHXd?=
 =?us-ascii?Q?ASXmxdZ5NyolEgvF5wZ7oHUR7jVe39JB3Rzmy5IRMkSIcfbdsmDMHHyvSNpQ?=
 =?us-ascii?Q?YapUji720OF9zsHVtgpE4RP+oBRvwMyQjR2Q3U8wHXDeLwA0qwwXp9uMWyL0?=
 =?us-ascii?Q?Y+bUbFrfZGlx9o87TJhR+CdCS527jfPVcHEsF+RHF5bxJdlnVZW9SFgE7hWH?=
 =?us-ascii?Q?zS/Zef9nP6Z7YRdMJjmblLhOu1Qlg8l6u2FzgpYIta4zUQZD1d8+RbKCnLLc?=
 =?us-ascii?Q?jJG7q3C8qP0X4u39j3Ju/kDHsGKz1Q9tYxLtJhcHDmAnmVqaYIoldT1BF0dJ?=
 =?us-ascii?Q?8cGbxvR2YJuGWGYTzRdJJMQSL6I9T4GFJkDHkV0KI0zecwArSVGyuUUXToJm?=
 =?us-ascii?Q?+kSKzeY+/UO9qcLJeYncBF5VTCrNZCV5rpv0zBd517cObIpAx8ZC+P+JI1/u?=
 =?us-ascii?Q?vUmOksnsjhVVGYf037hdeAwX/X3FpWuHbMnVa6FCtwszSIKhNKUO0CMw902Y?=
 =?us-ascii?Q?fA7eZBx9WIobYA0Ixm1d41mqSuoRwlt1bSdUOd4Sl3YDSS0mXOxjR2/GA2/o?=
 =?us-ascii?Q?k67xrv3vkzcsBNAnNMRVJuTCuWvKPI5ChUM2f1VAftpe3spfj0bG4nvs3sHi?=
 =?us-ascii?Q?fsNDg3k3belWPUBypnfP4AQa7oBJhQdARZ5osKaoNR1xbmy8nRXq/5h0tOYM?=
 =?us-ascii?Q?2p6UM+yDuSB1nKqiNkf3nT5oyWhRlrzy54+SdlIFWS/Dr+ZsFUH4mrbsrGrh?=
 =?us-ascii?Q?cZ78csbKibEfHoMrURkVccWUE05mDPZKR03AtVWbKPsaA6fO/uwO?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1c0e4835-dd76-41e7-d414-08dec70c5554
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB9473.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jun 2026 16:21:32.1318
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: U1Wh5sU8pOjhbfyC2bOo387ZpxdgrCkeB0XlOJtV/GLCjD31eVpkbzhGgUw2bFNI
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB8436

On 10 Jun 2026, at 9:17, Michael S. Tsirkin wrote:

> At the moment, if a virtio balloon device has a page reporting vq but
> its size is < PAGE_REPORTING_CAPACITY (32), the balloon driver fails
> probe.
>
> But, there's no way for host to know this value, so it can easily
> create a smaller vq and suddenly adding the reporting capability
> to the device makes all of the driver fail. Not pretty.
>
> Add a capacity field to page_reporting_dev_info so drivers can
> control the maximum number of pages per report batch.
>
> In virtio-balloon, set the capacity to the reporting virtqueue size,
> letting page_reporting adapt to whatever the device provides.
>
> Capacity need not be a power of two.  Code previously called out
> division by PAGE_REPORTING_CAPACITY as cheap since it was a power
> of 2, but no performance difference was observed with non-power-of-2
> values.
>
> If capacity is 0 or exceeds PAGE_REPORTING_CAPACITY, it defaults
> to PAGE_REPORTING_CAPACITY.  The 0 check and the clamping is done in
> page_reporting_register(), before the reporting work is scheduled,
> so we never get division by 0.
>
> Fixes: b0c504f15471 ("virtio-balloon: add support for providing free pa=
ge reports to host")
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> Assisted-by: Claude:claude-opus-4-6
> ---
> Changes v1->v2:
> - Document capacity=3D0 as default in commit log
> - Document that capacity need not be a power of two
> - Drop unnecessary comment about integer division cost
> - Update comment on capacity field: "0 (default) means PAGE_REPORTING_C=
APACITY"
>
>  drivers/virtio/virtio_balloon.c |  5 +----
>  include/linux/page_reporting.h  |  3 +++
>  mm/page_reporting.c             | 24 ++++++++++++------------
>  3 files changed, 16 insertions(+), 16 deletions(-)
>

LGTM. With David's concern addressed, feel free to add:

Acked-by: Zi Yan <ziy@nvidia.com>

--
Best Regards,
Yan, Zi
