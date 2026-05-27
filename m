Received: from canpmsgout08.his.huawei.com (canpmsgout08.his.huawei.com [113.46.200.223])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EB2C39902B
	for <virtualization@lists.linux.dev>; Wed, 27 May 2026 06:40:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.223
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779864053; cv=none; b=bZbts8UkU3Fm1v2SyaPX7eauLSM5p7x8gILtODgqBODYej91l8mp55TmAzYu8LAGE/PmdJmy2LSPMcss6VcvEzaiiilv5QuKIPgmU3T9bNKUvYkTrqvysgRvb9KnSM3eNHrzIGhXfJ8X1Mij61XYL3hQnEABZgFFPhtxwrDqcCY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779864053; c=relaxed/simple;
	bh=DBqLrNNtieDmtxM7ODTZjJSeYSIjABoh/8w2/biWCXc=;
	h=Subject:To:CC:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=mgpvDQa3hBTjI6Ggg/xx3r1OOOvHoh2xlQ+39wQyjZqwyIf8RlfJm1mG6s8dP0aw2+h2PLZTGOa/mcpqTv2QcaaK0PQp6BHmHh7iDrfKKuYPS0KrcwJmCVuyThyV/OxnPS7Cc1IwTIvz7QSq0WSH0CK8pb+VmiXrRpnaphC0vu8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=MATKi6Ci; arc=none smtp.client-ip=113.46.200.223
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="MATKi6Ci"
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=uPNbX2SUFH5m3MJbTk7cfi4r1VdowVrOjxlCOTcinjw=;
	b=MATKi6CiyOY97oC8E9hLWBql0R2dJidPc6AsVABVKYPLjLFmNrBiOt9hr0zbu5ypB/kAIFsa3
	tLy9KruRxtXWCE47y6rTmx5e2qwSuHxnhyA+7SHAJfIoZTUgzWNe80XuxoU4zUUfDxGvbBRKxfX
	9apSqaEng0HWInJb7/lYlUw=
Received: from mail.maildlp.com (unknown [172.19.162.92])
	by canpmsgout08.his.huawei.com (SkyGuard) with ESMTPS id 4gQKYk3pvczmV64;
	Wed, 27 May 2026 14:32:58 +0800 (CST)
Received: from dggemv712-chm.china.huawei.com (unknown [10.1.198.32])
	by mail.maildlp.com (Postfix) with ESMTPS id 568DC40565;
	Wed, 27 May 2026 14:40:45 +0800 (CST)
Received: from kwepemq500010.china.huawei.com (7.202.194.235) by
 dggemv712-chm.china.huawei.com (10.1.198.32) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Wed, 27 May 2026 14:40:45 +0800
Received: from [10.173.124.160] (10.173.124.160) by
 kwepemq500010.china.huawei.com (7.202.194.235) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Wed, 27 May 2026 14:40:42 +0800
Subject: Re: [PATCH v8 00/37] mm/virtio: skip redundant zeroing of host-zeroed
 pages
To: "Michael S. Tsirkin" <mst@redhat.com>
CC: <linux-kernel@vger.kernel.org>, "David Hildenbrand (Arm)"
	<david@kernel.org>, Jason Wang <jasowang@redhat.com>, Xuan Zhuo
	<xuanzhuo@linux.alibaba.com>, =?UTF-8?Q?Eugenio_P=c3=a9rez?=
	<eperezma@redhat.com>, Muchun Song <muchun.song@linux.dev>, Oscar Salvador
	<osalvador@suse.de>, Andrew Morton <akpm@linux-foundation.org>, "Lorenzo
 Stoakes" <ljs@kernel.org>, "Liam R. Howlett" <liam@infradead.org>, "Vlastimil
 Babka" <vbabka@kernel.org>, Mike Rapoport <rppt@kernel.org>, "Suren
 Baghdasaryan" <surenb@google.com>, Michal Hocko <mhocko@suse.com>, "Brendan
 Jackman" <jackmanb@google.com>, Johannes Weiner <hannes@cmpxchg.org>, Zi Yan
	<ziy@nvidia.com>, Baolin Wang <baolin.wang@linux.alibaba.com>, Nico Pache
	<npache@redhat.com>, Ryan Roberts <ryan.roberts@arm.com>, Dev Jain
	<dev.jain@arm.com>, Barry Song <baohua@kernel.org>, Lance Yang
	<lance.yang@linux.dev>, Hugh Dickins <hughd@google.com>, Matthew Brost
	<matthew.brost@intel.com>, Joshua Hahn <joshua.hahnjy@gmail.com>, Rakie Kim
	<rakie.kim@sk.com>, Byungchul Park <byungchul@sk.com>, Gregory Price
	<gourry@gourry.net>, Ying Huang <ying.huang@linux.alibaba.com>, "Alistair
 Popple" <apopple@nvidia.com>, Christoph Lameter <cl@gentwo.org>, "David
 Rientjes" <rientjes@google.com>, Roman Gushchin <roman.gushchin@linux.dev>,
	Harry Yoo <harry.yoo@oracle.com>, Axel Rasmussen <axelrasmussen@google.com>,
	Yuanchu Xie <yuanchu@google.com>, Wei Xu <weixugc@google.com>, Chris Li
	<chrisl@kernel.org>, Kairui Song <kasong@tencent.com>, Kemeng Shi
	<shikemeng@huaweicloud.com>, Nhat Pham <nphamcs@gmail.com>, Baoquan He
	<bhe@redhat.com>, <virtualization@lists.linux.dev>, <linux-mm@kvack.org>,
	Andrea Arcangeli <aarcange@redhat.com>
References: <cover.1779315441.git.mst@redhat.com>
 <20260521100313-mutt-send-email-mst@kernel.org>
 <eda29390-94a2-c4f6-a3e3-32bea8c6b363@huawei.com>
 <20260527012249-mutt-send-email-mst@kernel.org>
From: Miaohe Lin <linmiaohe@huawei.com>
Message-ID: <b26314f4-4a1c-c8c0-eac0-48be984ef8be@huawei.com>
Date: Wed, 27 May 2026 14:40:42 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <20260527012249-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: kwepems500001.china.huawei.com (7.221.188.70) To
 kwepemq500010.china.huawei.com (7.202.194.235)

On 2026/5/27 13:25, Michael S. Tsirkin wrote:
> On Wed, May 27, 2026 at 11:23:23AM +0800, Miaohe Lin wrote:
>> On 2026/5/21 22:09, Michael S. Tsirkin wrote:
>>> On Wed, May 20, 2026 at 06:20:13PM -0400, Michael S. Tsirkin wrote:
>>>> When a guest reports free pages to the hypervisor via virtio-balloon's
>>>> free page reporting, the host typically zeros those pages when reclaiming
>>>> their backing memory (e.g., via MADV_DONTNEED on anonymous mappings).
>>>> When the guest later reallocates those pages, the kernel zeros them
>>>> again, redundantly.
>>>
>>> FYI Sashiko reported a couple of issues. Mostly false positives but
>>> I tweaked commit log to make it clearer. But also a couple of
>>> real issues. So far I have this diff on top:
>>>
>>> --->
>>>
>>> Changes from v8 to v9 candidate (code only):
>>>
>>> 1. mm/mempolicy.c (patch 1: mm: mempolicy: fix interleave index calculation)
>>>    Combine vm_pgoff and VMA offset into a single expression before
>>>    shifting, fixing carry loss for file-backed VMAs with unaligned
>>>    vm_pgoff.
>>>
>>> 2. mm/memory-failure.c (patch 2: mm: memory-failure: serialize TestSetPageHWPoison with zone->lock)
>>>    Wrap ClearPageHWPoison in retry path with zone->lock too.
>>
>> It seems TestClearPageHWPoison and SetPageHWPoison are missing. Should we serialize them with zone->lock too?
>>
>> Thanks.
>> .
> 
> I don't think so.  As far as I could tell, none of these are called on
> pages that could be in the buddy. And all the non atomic page flags
> games we play are only on pages in the buddy.

I scanned the code and it seems no one breaks the game. So I agree with you.

Thanks.
.

