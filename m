Received: from canpmsgout02.his.huawei.com (canpmsgout02.his.huawei.com [113.46.200.217])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFDD8286891
	for <virtualization@lists.linux.dev>; Mon, 15 Jun 2026 03:29:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.217
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781494172; cv=none; b=UMCwXIpzlCsJqjCLpAyNoWMTAwRbsvqPmewi6/UNvnzTba7fwtBQdkJRWVnGbfxRQdZ0cQbyth7/6RGSYkYveT8P1P7cPs6p1q8ka0sI1eOZ3fZCFQvH+VhP63wY9UA85qbWVlCKKHjctnR6OiGS4ebaiIp/60sPqBSPU5iPCl4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781494172; c=relaxed/simple;
	bh=X6zI8OSsc1yxlIgMkI48n0emhqbBgmBaqMZd0vema7o=;
	h=Subject:To:CC:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=DU5MpwyqzlvyG4bC6FZkwJsGhPQhRZxHecG5qZdMp1/aKnl38fMtg62W2o/9Y/c9PShrv1L4/N+4ePysH21nrOJdAEIagsEoWjXB85Xg59XEjj+cml6J1aruiSWPAxnTgNktM2oTWVnzDLDUqgbrCnB/z7RN8oJh9ru72ur0EkE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=Cw+MEhA/; arc=none smtp.client-ip=113.46.200.217
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="Cw+MEhA/"
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=QJb9FmlHeruupdTIUIXHdJBdFqX4Ek20qkGI45QfU+0=;
	b=Cw+MEhA/Z9r3S/Yb0WxjaWWfrIiUyusoknamGmnrQxVVKZOtAG/Un1ZKbcNCgCmNpvN/Mx8MP
	BB2TViSG1Gw6XlU8aFpUpnK1x2h+T965BO8X/z0R9wl3Y20UqryBUqVixbJZlxf8K6FQX/QiZZQ
	LheTXmB1a2jCF5U6ytCSM08=
Received: from mail.maildlp.com (unknown [172.19.163.0])
	by canpmsgout02.his.huawei.com (SkyGuard) with ESMTPS id 4gdwPS1pB9zcZxy;
	Mon, 15 Jun 2026 11:21:00 +0800 (CST)
Received: from dggemv712-chm.china.huawei.com (unknown [10.1.198.32])
	by mail.maildlp.com (Postfix) with ESMTPS id D949940561;
	Mon, 15 Jun 2026 11:29:20 +0800 (CST)
Received: from kwepemq500010.china.huawei.com (7.202.194.235) by
 dggemv712-chm.china.huawei.com (10.1.198.32) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Mon, 15 Jun 2026 11:29:20 +0800
Received: from [10.173.124.160] (10.173.124.160) by
 kwepemq500010.china.huawei.com (7.202.194.235) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Mon, 15 Jun 2026 11:29:18 +0800
Subject: Re: [PATCH splitout] mm: memory-failure: serialize
 TestSetPageHWPoison with zone->lock
To: "David Hildenbrand (Arm)" <david@kernel.org>, "Michael S. Tsirkin"
	<mst@redhat.com>
CC: Zi Yan <ziy@nvidia.com>, Andrew Morton <akpm@linux-foundation.org>,
	<linux-kernel@vger.kernel.org>, Jason Wang <jasowang@redhat.com>, Xuan Zhuo
	<xuanzhuo@linux.alibaba.com>, =?UTF-8?Q?Eugenio_P=c3=a9rez?=
	<eperezma@redhat.com>, Muchun Song <muchun.song@linux.dev>, Oscar Salvador
	<osalvador@suse.de>, Lorenzo Stoakes <ljs@kernel.org>, "Liam R. Howlett"
	<liam@infradead.org>, Vlastimil Babka <vbabka@kernel.org>, Mike Rapoport
	<rppt@kernel.org>, Suren Baghdasaryan <surenb@google.com>, Michal Hocko
	<mhocko@suse.com>, Brendan Jackman <jackmanb@google.com>, Johannes Weiner
	<hannes@cmpxchg.org>, Baolin Wang <baolin.wang@linux.alibaba.com>, Nico Pache
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
	Andrea Arcangeli <aarcange@redhat.com>, Naoya Horiguchi
	<nao.horiguchi@gmail.com>
References: <20260609111020.e88f51a7b6ebc37360d66fdc@linux-foundation.org>
 <8c1f468e-b50a-487a-a267-8d1ea5a61c87@kernel.org>
 <FB250C43-790E-4AB0-BD40-74665FC601A0@nvidia.com>
 <38C84F23-E881-4DB2-86BA-93F39D44AE1B@nvidia.com>
 <20260609162437-mutt-send-email-mst@kernel.org>
 <4BA276D9-9EB9-4E2A-8A05-657ACACFF227@nvidia.com>
 <20260609165829-mutt-send-email-mst@kernel.org>
 <dd8d89be-9c73-8ff7-7d44-9705bddeda4d@huawei.com>
 <20260610171646-mutt-send-email-mst@kernel.org>
 <14537566-94d9-eac5-2636-35f925a9d159@huawei.com>
 <20260611013644-mutt-send-email-mst@kernel.org>
 <1b5676ab-0dc5-ef33-9d79-a2bd6090a62d@huawei.com>
 <cbffabdc-42bf-4e67-9d2b-ace9a1e09f29@kernel.org>
From: Miaohe Lin <linmiaohe@huawei.com>
Message-ID: <984d9775-e17c-0231-b021-126b13a9aa42@huawei.com>
Date: Mon, 15 Jun 2026 11:29:18 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <cbffabdc-42bf-4e67-9d2b-ace9a1e09f29@kernel.org>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: kwepems500002.china.huawei.com (7.221.188.17) To
 kwepemq500010.china.huawei.com (7.202.194.235)

On 2026/6/11 21:20, David Hildenbrand (Arm) wrote:
> On 6/11/26 09:36, Miaohe Lin wrote:
>> On 2026/6/11 13:43, Michael S. Tsirkin wrote:
>>> On Thu, Jun 11, 2026 at 11:35:36AM +0800, Miaohe Lin wrote:
>>>>
>>>> Do you mean repeating SetPageHWPoison on every branch?
>>>
>>> Right.
>>>
>>>> Is it possible
>>>> to make __free_pages_prepare changes page->flags atomically or this race
>>>> is specified to memory_failure?
>>>>
>>>> Thanks.
>>>> .
>>>
>>>
>>> Adding an atomic op on every fast path page allocation is, I am
>>> guessing, going to slow down Linux measureably.
>>>
>>> Doing it for the benefit of memory_failure, which is the slowest of
>>> slow paths, seems unpalatable, to me.
>>
>> Agree, it's not worth to do so.
>>
>>>
>>> Neither am I sure it's the only racy place -
>>> grep for __SetPage and __ClearPage - all these have the same issue, I
>>> suspect.
>>>
>>> At the same time, I'm not an mm maintainer. If you disagree, try to
>>> upstream a change converting all non atomics in mm to atomics, and see
>>> what others say.
>>
>> Since memory_failure might be the only place, this change would be unacceptable.
>> We should come up with a better solution. Maybe we can try repeating SetPageHWPoison
>> and ClearPageHWPoison at a first attempt though it looks somewhat weird to me and makes
>> code more complicated.
> 
> And I am fairly sure we could still have some remaining races ... it's shaky.

I have to agree it's shaky. Any suggestion for next step?

Thanks.
.
