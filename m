Received: from canpmsgout06.his.huawei.com (canpmsgout06.his.huawei.com [113.46.200.221])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF23438239F
	for <virtualization@lists.linux.dev>; Mon,  1 Jun 2026 07:17:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.221
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780298243; cv=none; b=HGXKjO+3mgPPWj0oms6gcBu3Jgc3lUtx2CibKQ7jIpk6jirmPQqMLoKUPDfV5ZZmtE7Y2T8pTzS3Ccse9bSZuajPmxWtcTbESjUTkiLEWW5c9/Ak1CGyDSwf/JHCVDJRVlELns8XM+eS7ttBqSpxyC+A51BkWi7OkayswBP0XMU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780298243; c=relaxed/simple;
	bh=DJP1TMISf1OnwfZ6Z/TPoB/1wKsEjUGLCF78QUmf6Hc=;
	h=Subject:To:CC:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=CPuNpTKvZKhKKiDDfBPbIlN9kdOgNXNnWNR/s9mL3nGRBtnZ26CzXoQBiQSNgqTrihqEXoLpnEeARYPE+rNj0EzlHxc5dVYTstRdbz4sRBlkPyzVyWmqRFwHQtqduwzoWvK3DHU0AKDpjQGr5sgrekpAXx/Xao7Ld0GzZUrIeTk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=Hc97jZvn; arc=none smtp.client-ip=113.46.200.221
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="Hc97jZvn"
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=8ST2Tg32v5NWZL0Digt/7WzPOrgnDtd7aEPB8tVaCFQ=;
	b=Hc97jZvnUog6kvHS/SX8VtoZXhoq3IxJcSa3DvnoLPRqjnFX+cqB3OR0/dYSIi/cVnzJQbcZu
	CZugFwzI326auRogHOGW48AD5zvD4HCSYq7T+t1sC9FNA3hC3iys/yoQvOFWiLbvPFbtoPRCeK/
	8PTo1FvjAcQ+S+KoNAuPXW0=
Received: from mail.maildlp.com (unknown [172.19.162.223])
	by canpmsgout06.his.huawei.com (SkyGuard) with ESMTPS id 4gTQ7Q1xsmzRhR3;
	Mon,  1 Jun 2026 15:09:22 +0800 (CST)
Received: from dggemv712-chm.china.huawei.com (unknown [10.1.198.32])
	by mail.maildlp.com (Postfix) with ESMTPS id 9188840561;
	Mon,  1 Jun 2026 15:17:10 +0800 (CST)
Received: from kwepemq500010.china.huawei.com (7.202.194.235) by
 dggemv712-chm.china.huawei.com (10.1.198.32) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Mon, 1 Jun 2026 15:17:10 +0800
Received: from [10.173.124.160] (10.173.124.160) by
 kwepemq500010.china.huawei.com (7.202.194.235) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Mon, 1 Jun 2026 15:17:08 +0800
Subject: Re: [PATCH v9 02/37] mm: memory-failure: serialize
 TestSetPageHWPoison with zone->lock
To: "Michael S. Tsirkin" <mst@redhat.com>
CC: "David Hildenbrand (Arm)" <david@kernel.org>, Jason Wang
	<jasowang@redhat.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	=?UTF-8?Q?Eugenio_P=c3=a9rez?= <eperezma@redhat.com>, Muchun Song
	<muchun.song@linux.dev>, Oscar Salvador <osalvador@suse.de>, Andrew Morton
	<akpm@linux-foundation.org>, Lorenzo Stoakes <ljs@kernel.org>, "Liam R.
 Howlett" <liam@infradead.org>, Vlastimil Babka <vbabka@kernel.org>, "Mike
 Rapoport" <rppt@kernel.org>, Suren Baghdasaryan <surenb@google.com>, "Michal
 Hocko" <mhocko@suse.com>, Brendan Jackman <jackmanb@google.com>, "Johannes
 Weiner" <hannes@cmpxchg.org>, Zi Yan <ziy@nvidia.com>, Baolin Wang
	<baolin.wang@linux.alibaba.com>, Nico Pache <npache@redhat.com>, Ryan Roberts
	<ryan.roberts@arm.com>, Dev Jain <dev.jain@arm.com>, Barry Song
	<baohua@kernel.org>, Lance Yang <lance.yang@linux.dev>, Hugh Dickins
	<hughd@google.com>, Matthew Brost <matthew.brost@intel.com>, Joshua Hahn
	<joshua.hahnjy@gmail.com>, Rakie Kim <rakie.kim@sk.com>, Byungchul Park
	<byungchul@sk.com>, Gregory Price <gourry@gourry.net>, Ying Huang
	<ying.huang@linux.alibaba.com>, Alistair Popple <apopple@nvidia.com>,
	Christoph Lameter <cl@gentwo.org>, David Rientjes <rientjes@google.com>,
	Roman Gushchin <roman.gushchin@linux.dev>, Harry Yoo <harry.yoo@oracle.com>,
	Axel Rasmussen <axelrasmussen@google.com>, Yuanchu Xie <yuanchu@google.com>,
	Wei Xu <weixugc@google.com>, Chris Li <chrisl@kernel.org>, Kairui Song
	<kasong@tencent.com>, Kemeng Shi <shikemeng@huaweicloud.com>, Nhat Pham
	<nphamcs@gmail.com>, Baoquan He <bhe@redhat.com>,
	<virtualization@lists.linux.dev>, <linux-mm@kvack.org>, Andrea Arcangeli
	<aarcange@redhat.com>, Naoya Horiguchi <nao.horiguchi@gmail.com>,
	linux-kernel <linux-kernel@vger.kernel.org>
References: <cover.1780067977.git.mst@redhat.com>
 <2c527d20c99cdfe64a77bcf8da75f742d4c6991e.1780067977.git.mst@redhat.com>
From: Miaohe Lin <linmiaohe@huawei.com>
Message-ID: <9c73bc2e-20f2-c7b0-cd8c-63ea5437f2ed@huawei.com>
Date: Mon, 1 Jun 2026 15:17:07 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <2c527d20c99cdfe64a77bcf8da75f742d4c6991e.1780067977.git.mst@redhat.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: kwepems200001.china.huawei.com (7.221.188.67) To
 kwepemq500010.china.huawei.com (7.202.194.235)

On 2026/5/29 23:22, Michael S. Tsirkin wrote:
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
> is set and the write happens after.  Follow-up patches in this
> series add similar non-atomic flag operations as well.
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
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> Assisted-by: Claude:claude-opus-4-6
> ---
>  mm/memory-failure.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/mm/memory-failure.c b/mm/memory-failure.c
> index ee42d4361309..d106f2c135c7 100644
> --- a/mm/memory-failure.c
> +++ b/mm/memory-failure.c
> @@ -2348,6 +2348,8 @@ int memory_failure(unsigned long pfn, int flags)
>  	unsigned long page_flags;
>  	bool retry = true;
>  	int hugetlb = 0;
> +	struct zone *zone;
> +	unsigned long mf_flags;
>  
>  	if (!sysctl_memory_failure_recovery)
>  		panic("Memory failure on page %lx", pfn);
> @@ -2390,7 +2392,10 @@ int memory_failure(unsigned long pfn, int flags)
>  	if (hugetlb)
>  		goto unlock_mutex;
>  
> +	zone = page_zone(p);
> +	spin_lock_irqsave(&zone->lock, mf_flags);

Would it be better to add a comment here why zone->lock is needed?

>  	if (TestSetPageHWPoison(p)) {
> +		spin_unlock_irqrestore(&zone->lock, mf_flags);
>  		res = -EHWPOISON;
>  		if (flags & MF_ACTION_REQUIRED)
>  			res = kill_accessing_process(current, pfn, flags);
> @@ -2399,6 +2404,7 @@ int memory_failure(unsigned long pfn, int flags)
>  		action_result(pfn, MF_MSG_ALREADY_POISONED, MF_FAILED);
>  		goto unlock_mutex;
>  	}
> +	spin_unlock_irqrestore(&zone->lock, mf_flags);
>  
>  	/*
>  	 * We need/can do nothing about count=0 pages.
> @@ -2420,7 +2426,9 @@ int memory_failure(unsigned long pfn, int flags)
>  			} else {
>  				/* We lost the race, try again */
>  				if (retry) {
> +					spin_lock_irqsave(&zone->lock, mf_flags);
>  					ClearPageHWPoison(p);
> +					spin_unlock_irqrestore(&zone->lock, mf_flags);

Ditto.

Acked-by: Miaohe Lin <linmiaohe@huawei.com>

Thanks.
.
