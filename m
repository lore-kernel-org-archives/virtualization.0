Received: from CY3PR05CU001.outbound.protection.outlook.com (mail-westcentralusazon11013047.outbound.protection.outlook.com [40.93.201.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 163C8335072
	for <virtualization@lists.linux.dev>; Mon, 27 Apr 2026 15:14:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.201.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777302871; cv=fail; b=f+o+FusFpz519ANome+aSq/dv05zQ4TwZNy+zKxJuD8HsLUXOAASn+tZqH7jvaqxvuuqkTYiwyNmuYYyTUJ+vLSUbriq26D1qnnB53rCHP1CFHcXjz2qiv3CIe0TFIvubvXwMz2C0JHSbsjKvFmsqow3fYjp8l9ZRrW4JwWo0wI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777302871; c=relaxed/simple;
	bh=rjmqXtAYZ1tb/s6BZolzl+onIP5VRtgquoVQ0sH3kzE=;
	h=Content-Type:Date:Message-Id:Subject:Cc:To:From:References:
	 In-Reply-To:MIME-Version; b=inBq6qAxIWlhIAQd+o/1MPwShwm9cSKF6h+7IJ4q5oOtG7+VW0s8ucSLm5ELoVp0wlmNFqd6adMLy35rCKdGIpUIVcFOmCQldWRSn1GqfzZxmcIM+7Xxpz77WclY9BItC1UKS7lVM4c8F/1TE//j9nBHXdq7ycJbhz+24B0QlS4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Gx+Kx9Aw; arc=fail smtp.client-ip=40.93.201.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Gx+Kx9Aw"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZKGLAbOHqWqHpMFklJ5KdUV9GYtcZhofthWIsu04pscaBykr1Qb11KYnipPBvqO3kR6MPKZCndW3RMDCmEb2j+mEU+XbUKRCCEJacCjphDQIM7E2uL1vqMgAWuVJY5uSmiqX655Itv1QQmRjvOBNPTjDt00wQT0eAxEWPvQ722bOP7mWIEEDK50b0eanBlanVo/JmlFAkUqxt5rpDllzQFRv8YCZG31mP5jyS9AKhGGjSq7+amEdQhgQLNr7d295jbE+HK5cSLQYtPb54EfhCe/1AEEHzV1FW32Gnj50NFLm3I/l5vc+EBm/z6VoV2VT+PxShZu58cNKk1NLX/65BA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9f0ZUQCx8tznsexAQvc9lxOG7t4mOu9VoARfprPP13w=;
 b=PnmPM/R1WSLirBNU2K3Yt1JP3wVLAmZNb2cdrFNAytNOCsVcLu8glBj7QcWVZ4bISx7rwhlrEDPf0+2rNpSq9qAHVB6SBQvXOrCDc85V+xRhWf/wOcauRMsAOED7mHm7M0snjJf27eflZsMGQ3tg941CvX4dfbWqIzn11sXqSAMh93F1C9JjSBSRZUkxm+C3d+xEOl0D59pEuI+eSqQ3P4GbHpKfWxITBjnC7ZG3yxTXQwSiUeBPL/s2OuE34+aR0+LGMN751mTLu7EdOu9+2N0kKpjie8eBtY3+Z4GN9zKUb1P8ubNTgPIPWVhL9XzzQAjER+qJG0nB3cpKl/+m7w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9f0ZUQCx8tznsexAQvc9lxOG7t4mOu9VoARfprPP13w=;
 b=Gx+Kx9AwlQke0H89tPcklRzHTZpsqRqI4FUzuq6MI8ZKIgrJR5CGDlLi/9jpgKwqPEZuo2Nh3SUePSR2eD4rSRUK0A4e+wGM41jYFc8yCOUTg7o0mlutD/ko6xT75VMCCHfffF7qwj/FzAi2tW7bMl6fKZLXmMgCEWQzqhsZjIWIH3J6iCaVgixmL4Njsydi0Sc/o1a/v6886BFpMNj9Jw6t4wKgjGTc8poNczDHhmT56wlZkqwugtWkL8vAuPHkOIxHyf3Wr34S/CEtBntBVVFEyHctcH3qpnjApNcUpPtpLCk81ASLgfdyHIPFfU0Xv3VZRo8MGHieYAmJkf/Kvw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS7PR12MB9473.namprd12.prod.outlook.com (2603:10b6:8:252::5) by
 LV8PR12MB9155.namprd12.prod.outlook.com (2603:10b6:408:183::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9870.15; Mon, 27 Apr 2026 15:14:24 +0000
Received: from DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::f01d:73d2:2dda:c7b2]) by DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::f01d:73d2:2dda:c7b2%4]) with mapi id 15.20.9870.013; Mon, 27 Apr 2026
 15:14:24 +0000
Content-Type: text/plain; charset=UTF-8
Date: Mon, 27 Apr 2026 11:13:44 -0400
Message-Id: <DI419PSP5050.15VGMJFDMWBQU@nvidia.com>
Subject: Re: [PATCH RFC v4 14/22] mm: page_reporting: skip redundant zeroing
 of host-zeroed reported pages
Cc: "Andrew Morton" <akpm@linux-foundation.org>, "David Hildenbrand"
 <david@kernel.org>, "Vlastimil Babka" <vbabka@kernel.org>, "Brendan
 Jackman" <jackmanb@google.com>, "Michal Hocko" <mhocko@suse.com>, "Suren
 Baghdasaryan" <surenb@google.com>, "Jason Wang" <jasowang@redhat.com>,
 "Andrea Arcangeli" <aarcange@redhat.com>, "Gregory Price"
 <gourry@gourry.net>, <linux-mm@kvack.org>,
 <virtualization@lists.linux.dev>, "Lorenzo Stoakes"
 <lorenzo.stoakes@oracle.com>, "Liam R. Howlett" <Liam.Howlett@oracle.com>,
 "Mike Rapoport" <rppt@kernel.org>, "Johannes Weiner" <hannes@cmpxchg.org>,
 "Zi Yan" <ziy@nvidia.com>, "Matthew Wilcox" <willy@infradead.org>
To: "Michael S. Tsirkin" <mst@redhat.com>, <linux-kernel@vger.kernel.org>
From: "Zi Yan" <ziy@nvidia.com>
Content-Transfer-Encoding: quoted-printable
X-Mailer: aerc 0.21.0
References: <cover.1777223007.git.mst@redhat.com>
 <788d5a09394ed1456beaab23f75d91846ceeb611.1777223007.git.mst@redhat.com>
In-Reply-To: <788d5a09394ed1456beaab23f75d91846ceeb611.1777223007.git.mst@redhat.com>
X-ClientProxiedBy: YQBPR01CA0154.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:7e::12) To DS7PR12MB9473.namprd12.prod.outlook.com
 (2603:10b6:8:252::5)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB9473:EE_|LV8PR12MB9155:EE_
X-MS-Office365-Filtering-Correlation-Id: 3f50090e-40ca-491f-a472-08dea46faa4d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|366016|10070799003|1800799024|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	mUcpvGlq8GK5lfFmspAIvYmQz2TD3NOYkHOQ9MDHqJBU7P+2umJjR6X4jnVhrIYvvy5KJSO51cDt9WR2buf4t89ayKcJzneSsYo4F9ZBE8BQh4UvXGpPvXQ16ubOJG0ICUfH57usYxNgak5R+RNHQ0WPNjytFvUL8lmZoRawoYUhSXYJJRHpMGWSXzUKB1DS2RBwdPyGaeTBsiyP+nLYO54Qx6E74R5Ja3SxGQ6/6h+cNcnY4MBK8CFvV1bKoWU+oLTnwAg4fiHYeQQ42/uxJTYzvn5LMbxF6aABb8r2EarjOgEjsiDOiiEBQN6wgoWZa6Ah+5rx8ttRlHfVluu0v9LWjAKfgMeqr0lGsuSlEUo4SB6b4fjGes9DomwfOWNqICwQEDKDW8KFgyCBFxEJCWI5N+RNpVoBPLArHsFEWmZQCjIQUERLKCi2Fcv3fnAoF9A7zdAF8ZSfAae7AmB62W8RSmrlXIoFSOIoT19A1H0BpgQYcMe5LGw4QqhBEGpjyJytB3hI8wWEhOYnlAoIZOhzG0PguK4ZhhmMLRhv+kgcQZ19SxZ/1remu6ZJZWkhdBoju55HI1+eJEh8O/kfYrFcacKzftZPaLCZM+0qDN/BeISf/7EQuXzXip5gJ7zm/ChzQutIsV+Lg4JIhPYJYt1s93pXL2EBUFjdwIkrM8qdSoQiQQKmJP9afTftsz0hpkWlSJxTiGqOj9ZV/y9UDc7urpPycw3E5Llvlk+K518=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB9473.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(10070799003)(1800799024)(56012099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?YVJLQlF0aUZ4UE9xa21idW0yV2NPKzc2M2I1MnlaYmQyVjloUE1BeGszSEx2?=
 =?utf-8?B?Zmw5YURkMXlYMU1yd0l4emtjRWZmdlYxa1NQb2ZUcTBXRnFYZ0NqY0JHN1dr?=
 =?utf-8?B?b1M2ZjBPVEhWVlYwUW1VbStqSk1YN2NjT1NRdE92TVNlSml2N25ncExUTUxD?=
 =?utf-8?B?RW1pb3J0RW0veG1wV2dvd1hjSllCN3NLaUU5WXk1Z2hPSGdLN1k4RGRDVTJp?=
 =?utf-8?B?Nm5kQ2ZZaWRrK3QwNm90Z2lWT0FrRFZ2TGpYNVgrNVkzNk02OC8vSyswbHE1?=
 =?utf-8?B?blBFenIrclU1K2htQlhqSDlVVjBwVWdKMHZoK25udWt4UHY2dVI4akQrZ3Mw?=
 =?utf-8?B?MGRiVE4xcW82MzRxa2NMRkdsSVdmWGh4eXRpRWFYb2NGWmVnZXk5VDJDaUR2?=
 =?utf-8?B?TUpwVTNDVXhlUGdJK0V6VlRzODNOK2FvWWpBTjV1OWpTZEs5bkQxaUdhWlNM?=
 =?utf-8?B?S0VzSmRKd1Y0WEc0NnNNK29VUDJzTmpjR3R5bjFjRTZadFNFY3FtQzFQakdV?=
 =?utf-8?B?VmxrYnFqT0dsSzQyWXRZYTcyblMybFp0R1lOVkNQc1gzNVZNczlmSDJpcEcv?=
 =?utf-8?B?MmxNdTJPb01EUGxCK256Y1Vadk5kWGdDQlNscnZtL2lYNlVYbmI3NTNFRHky?=
 =?utf-8?B?TkRNcUN1bzZKelNEZ3Evb0dueGpGcGdxNGdGTHAyWFdXRG12UkZDaU12blJ6?=
 =?utf-8?B?RllmNEUzOVorZXhTWnFTVW03Q2l2RGVXRE14SWdsTlArN05NT0tmUkpQSldM?=
 =?utf-8?B?eC93eVBYQU1oNzU5ZEh0anlkc2ZHcEhVQnIvNlhWcFNNSVQ1Mnhkc2U4bW10?=
 =?utf-8?B?TVZOYzI3ZmZjYjBpMGNTbnBDeXJyYyszWFVCbFNXTWhNN1ZnV1ZqOGo4TzNv?=
 =?utf-8?B?bS9XZjZZTy90ZTJJMDRrbkIzRFluZmFLTkE0QzA4cERKL21lTWpVcmgzNS9T?=
 =?utf-8?B?ZjRNVzJ0dmJSWkZoVC8xSlNvWnZ3MmhJay9CT3R6QWJXM0U4SEVmOXBHcXhI?=
 =?utf-8?B?L0I1SjlrWm9tSTgvWW1CeTVyUElobUNKN0lZZGNMRjZKckxZMGtydlJyN1Av?=
 =?utf-8?B?Q3R3NzRuUU1Kb0hTNWZFY0MxN1lhM2NLc1Z2WVVGL0xSYjlJMHc4aC9sM2M1?=
 =?utf-8?B?cjZDdElISXcyNWxmNmtqR2c0bjdYQXFoRm1VcS9XNnFRUXBXaGgxY1RJM012?=
 =?utf-8?B?LzdUQk1vT0hhV1VpZi94bjMwMlFtNnE3MDZGTWhZdTl3aU55V2dNNUJIc1BT?=
 =?utf-8?B?Z1U2M2NCdFQwbVZZU3RDQ28rQVhwa3FIaUpJeGo4bzNxRGo0N2c5dHdmejdl?=
 =?utf-8?B?SUdKK3VIZ1BrdkJoeDZHcFJFNHhHUGFNYnFORlZPRnErRzZpaG1tM0hwcWNV?=
 =?utf-8?B?dUlXWGYyY3VneGgrSnF3cHNEWklBN2pmTFN4a1A0S2dxNFVFRlZNbm5PZHNE?=
 =?utf-8?B?WE9oVk9ETHlWRk5Sem04N0ZSenltRWs5TkRxb3ByTFUxS2R6SmZ1Z1MzNUtE?=
 =?utf-8?B?Nmhjemw1NGgxeUpQNlBTU2k3ZWlxOXQzMWh5ZlZ4WkRZNmpjR295U1NaMHlz?=
 =?utf-8?B?bDBoSzdMR3BSdit1TzBuOWJOVG9VVTNpUDF1aitmV3RRVFFDV01ZVHRNc1FL?=
 =?utf-8?B?MnhKeE10MUhJQ3JzeS84TE5xREtiZzlSTTVqZThTZ0tmQ2ZoYTJnNmQvNHJP?=
 =?utf-8?B?U1ZkbTFZVVNJMmpMaVMxdUJKcjA1U3BralB5bTJ5dlpndDlWcHhhVXUrNlk5?=
 =?utf-8?B?a2RSUmVKcHRrelZPRDBFZVdhTUpzMXpvMTVFeWkyekZEQXdUclF6bldvWjN2?=
 =?utf-8?B?UUtKZkxQbkYwc3NLU2JVRU0xbm9vaXFOVnErejVTcFJmSXNWYldHWlZPakJr?=
 =?utf-8?B?TzBRT3AwR0dYYno1bDUxV3RTTWM0NUVXcHl0VkRkZlp6Tmxnb0VPSGRoZmFk?=
 =?utf-8?B?MXU1MHBxNUJKU0pOejVDVTRKbjZXWXc3WWszcjNmc2VYKzJ5c3NCTlg3VFBR?=
 =?utf-8?B?b3AyODNrb3U1QXY2UHljTm9oYW94WVp1WENhUktuODZNWWVVd0JjVEdmNmRN?=
 =?utf-8?B?eWMzRVgzWnJveW0wNWtvUGViT250eUNROTUvMUtiOERYVnhFNUZFT3JRbXhi?=
 =?utf-8?B?TkpYVFhJLzIvYWVaUnNVeGNVQXg3dDFPUTVGaUh2bS96aUtiaWdwR3poQUhP?=
 =?utf-8?B?cVVKQkQrVURnblZOOUxkZTU0dS9LVnNmT2U4MGtCcXkySmtMTGZleDF3UzBP?=
 =?utf-8?B?N2dEd1FSS1ZHckpLeUZXZlJqTDltWnlOSUxTMWEwN0h5L2NzNFBVWC84RnRD?=
 =?utf-8?B?R2RzYWxMV3ZSSmlJQzRNQnZ4VHZNVVF4aVU3akg4Z3NjeE5WWGMwbG9Ea2R4?=
 =?utf-8?Q?SClca7k+pYdpeMwFeJalvNd2syq3h7wPIiwA2?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3f50090e-40ca-491f-a472-08dea46faa4d
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB9473.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Apr 2026 15:14:24.0574
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: j/iEbwHiazUoFQ5xz3cnpT7D1Fo9xW+bJY3zCN+Bo8nuFX9iSAq2uB6Id0ncS3L+
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9155

On Sun Apr 26, 2026 at 5:48 PM EDT, Michael S. Tsirkin wrote:
> When a guest reports free pages to the hypervisor via the page reporting
> framework (used by virtio-balloon and hv_balloon), the host typically
> zeros those pages when reclaiming their backing memory.  However, when
> those pages are later allocated in the guest, post_alloc_hook()
> unconditionally zeros them again if __GFP_ZERO is set.  This
> double-zeroing is wasteful, especially for large pages.
>
> Avoid redundant zeroing:
>
> - Add a host_zeroes_pages flag to page_reporting_dev_info, allowing
>   drivers to declare that their host zeros reported pages on reclaim.
>   A static key (page_reporting_host_zeroes) gates the fast path.
>
> - Add PG_zeroed page flag (sharing PG_private bit) to mark pages
>   that have been zeroed by the host.  Set it on reported pages during
>   allocation from the buddy in page_del_and_expand().
>
> - Thread the zeroed bool through rmqueue -> prep_new_page ->
>   post_alloc_hook, where it skips redundant zeroing for __GFP_ZERO
>   allocations.
>
> No driver sets host_zeroes_pages yet; a follow-up patch to
> virtio_balloon is needed to opt in.
>
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> Assisted-by: Claude:claude-opus-4-6
> Assisted-by: cursor-agent:GPT-5.4-xhigh
> ---
>  include/linux/page-flags.h     |  9 +++++
>  include/linux/page_reporting.h |  3 ++
>  mm/compaction.c                |  6 ++--
>  mm/internal.h                  |  2 +-
>  mm/page_alloc.c                | 66 +++++++++++++++++++++++-----------
>  mm/page_reporting.c            | 14 +++++++-
>  mm/page_reporting.h            | 12 +++++++
>  7 files changed, 87 insertions(+), 25 deletions(-)
>
> diff --git a/include/linux/page-flags.h b/include/linux/page-flags.h
> index f7a0e4af0c73..eef2499cba8b 100644
> --- a/include/linux/page-flags.h
> +++ b/include/linux/page-flags.h
> @@ -135,6 +135,8 @@ enum pageflags {
>  	PG_swapcache =3D PG_owner_priv_1, /* Swap page: swp_entry_t in private =
*/
>  	/* Some filesystems */
>  	PG_checked =3D PG_owner_priv_1,
> +	/* Page contents are known to be zero */
> +	PG_zeroed =3D PG_private,

+willy,

I was discussing with willy and David about removing PG_private and
repurposing it to PG_folio to identify folios. IIUC, PG_zeroed is only
set for PageBuddy, so it should not be an issue to set it for allocated
pages for folio identification. Let me know if I get it wrong.

Thanks.

--=20
Best Regards,
Yan, Zi

