Received: from canpmsgout04.his.huawei.com (canpmsgout04.his.huawei.com [113.46.200.219])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB909349B19
	for <virtualization@lists.linux.dev>; Tue, 16 Jun 2026 11:41:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.219
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781610064; cv=none; b=tnh9eJWAE2HQcJylmnRuK5hbkLEGHMmWg3d8ryM8Xm2/o0Xza498OStalnJv6Y+Zcp+pY2gzQO4FBz2se8tkiYCB4eJkMSzwI56oPlyIzZ/TFvXRl+LzuKfqWWtRS1Fwp6X2BCd4vYM8c90s2cHx8N/GEksESS1h+VDVRq8ykwU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781610064; c=relaxed/simple;
	bh=ZKY541PHRK5mS2QQlJ0RUzWgMzWcVhZyoHp7NTIr7Wc=;
	h=Subject:To:CC:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=Y62aUjgCumgA8PaX+7/fO0FtwpFsP81lLicDFVb8K2By1Gz1KHYjXFyfNX+mPe0ZG+rrN6r2pmrkvM/BFw27oZx7co7hRgALGf3BT2RQD5DVfwuyVbmhECkH43A9kjQiko2P5f/pA1Ax/njZkKXc/hIB/ZfmbvZNpKzkFJjEcBs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=0ldNTPgB; arc=none smtp.client-ip=113.46.200.219
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="0ldNTPgB"
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=8+J60USgrUvH3LFLxRTooQBxk9P9/aNFG9XnU26kKPQ=;
	b=0ldNTPgBCc3wKVkCgQQjKgDgMcd1VIEt5A/6xtM9UDVQL7hLaCFrrhJpHHdDofhCyI3vi59VE
	ovc2bS74QjXe8KWm9Sp9kEEhywWMaN3Os6EWcJzsjcWtJ5HmTZbvZEtjXWz96eQrUzmh70r7ZfS
	AWihOWc64kXDngv7+blHhps=
Received: from mail.maildlp.com (unknown [172.19.162.140])
	by canpmsgout04.his.huawei.com (SkyGuard) with ESMTPS id 4gflGf2QC7z1prLM;
	Tue, 16 Jun 2026 19:32:58 +0800 (CST)
Received: from dggemv706-chm.china.huawei.com (unknown [10.3.19.33])
	by mail.maildlp.com (Postfix) with ESMTPS id EC3192012A;
	Tue, 16 Jun 2026 19:40:58 +0800 (CST)
Received: from kwepemq500010.china.huawei.com (7.202.194.235) by
 dggemv706-chm.china.huawei.com (10.3.19.33) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Tue, 16 Jun 2026 19:40:58 +0800
Received: from [10.173.124.160] (10.173.124.160) by
 kwepemq500010.china.huawei.com (7.202.194.235) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Tue, 16 Jun 2026 19:40:56 +0800
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
 <984d9775-e17c-0231-b021-126b13a9aa42@huawei.com>
 <be1b20ed-5b75-46b8-b7be-3c9b029f016b@kernel.org>
 <d7e97bec-72bf-7d56-3811-6d9c41fefb35@huawei.com>
 <e4e123f3-ef32-417f-8369-ff944b6f358d@kernel.org>
From: Miaohe Lin <linmiaohe@huawei.com>
Message-ID: <438389f2-332d-2f70-cad4-784d7f54af9f@huawei.com>
Date: Tue, 16 Jun 2026 19:40:55 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <e4e123f3-ef32-417f-8369-ff944b6f358d@kernel.org>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: kwepems200002.china.huawei.com (7.221.188.68) To
 kwepemq500010.china.huawei.com (7.202.194.235)

On 2026/6/16 14:56, David Hildenbrand (Arm) wrote:
>>>
>>>
>>> Assume that we enlighten all non-atomics to grab the rcu read lock, such as
>>
>> These non-atomics are defined and used because they want to avoid atomic ops overhead?
>> So I'm afraid using rcu read lock in these places would lead to unexpected overhead.
> 
> It should be cheaper than atomics IIUC. Further, I assume that some pages could
> batch over multiple such operations (esp. page freeing path when we process tail
> pages).
> 
> With !CONFIG_PREEMPT_RCU it's simply preempt_disable()/preempt_enable(), which
> is either a NOP or just adjusting the preempt counter of the current thread. Cheap.
> 
> With CONFIG_PREEMPT_RCU we mostly increment current->rcu_read_lock_nesting. But
> there might be a function call involved (did not look into the details). So that
> variant should be slightly more expensive.

I scanned the code and found rcu_read_unlock_special might be called in some cases.
Some expensive ops, e.g. irq_work_queue_on, might be called in some corner cases.
So the overhead of rcu read lock might be fluctuating.

> 
> We'd have to measure what an addition rcu read lock would cost in there. that
> should be fairly easy to benchmark.

Sure. We can do that if needed.

> 
>>>
>>> Maybe that would work. There would still be issues to solve
>>>
>>> (a) We don't hold the mf_mutex on all call paths, but we really need it so a
>>> page_test_set_hwpoison() cannot race in weird ways with the other primitives I think.
>>>
>>> (b) There are some leftover SetPageHWPoison etc. instances. The ones in
>>> arch/x86/kernel/cpu/mce/core.c likely cannot grab the mutex, but maybe they are
>>> corner cases either way and we can document the situation.
>>>
>>>
>>> Further, while I assume the synchronize_rcu() on the MCE path should be fine
>>> (who cares about performance there?), I don't know if the added RCU read lock
>>> on some paths could be noticable.
>>>
>>> So one idea worth discussing, but I am sure there are more problems.
>>
>> I think this is a good idea, although there are some remaining issues.
>> But such race should be really rare, is it worth all this effort? Could we
>> simply aim to resolve, not to be flawless? I.e. could we simply check
>> and re-set the hwpoison flag at the end of memory_failure handling to
>> simply avoid losing hwpoison flag as a best-effort attempt? Would it be
>> acceptable?
> 
> Hacky. Sufficient for the hypervisor to suspend the nonatomic-setting CPU at the
> wrong time to still trigger the same behavior.

Right. hypervisor could make the issue easier to trigger...

> 
> I think, either we fix it properly, or we redesign hwpoison handling to deal
> with setting/clearing becoming stale at some random point in the future.

I think your proposal, although there are still some issues to be resolved, is
nevertheless a good solution. We could also wait and see if anyone comes up with
a better one.

Thanks.
.
