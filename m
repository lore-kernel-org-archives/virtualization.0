Received: from canpmsgout12.his.huawei.com (canpmsgout12.his.huawei.com [113.46.200.227])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A75663DEACC
	for <virtualization@lists.linux.dev>; Tue, 16 Jun 2026 06:32:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.227
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781591579; cv=none; b=OVLqN5No4yThQQx8LNktQMX/+pDTEROYDowVxd+MUklHFKhg77BA8lvNKi0AM5BrYrcHIUf2DbhCdGB8fsVk8MYVV3HsKcp2LypejdKFnO8zzqvq3rGgdSkHa13ToPPx5m0TKV6hz4Fe4tl8tjjxBTEy56SBx0Y4RpH06isX6FY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781591579; c=relaxed/simple;
	bh=wv8v9dzq9RBQec55hpin3Rw5PZNcMVHFqSbnvqAnGvI=;
	h=Subject:To:CC:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=A6lNqz3/S/Ntzzb9vnqdF+5toWuHa+8soZb4wNqKGBQGyuruRZoU9K31Hcq8lVCwCQ6UuGnmj4TLRJ5Z2hshIefrHdOq6l+lGUJHHK1A8CIYaLP13SWeF4x+caf6yEIgjv811v4LBu6ZjQxfCHBxyn0+qK9TWFyR4Ubj48TW0GY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=p3ZshAIj; arc=none smtp.client-ip=113.46.200.227
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="p3ZshAIj"
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=xfEXurfwiXS6hQbSomuIzoJi4SEH3p8QW4ZrwV2jlLU=;
	b=p3ZshAIjm/97kXgaVsr3RsDHgv7/SktsxygitPswCr0YGjOeymxWpP+QyAAi7gU1NK4txv/5q
	Kymp6EOvUjOlp6oFGR8XfmmdUhJhXOYfCp2rM1Nb85js42T9861VGcPVqmTYC7umK+ioDVsQCV/
	v/cMb3LhZp4L7zY//Mz7K5c=
Received: from mail.maildlp.com (unknown [172.19.163.214])
	by canpmsgout12.his.huawei.com (SkyGuard) with ESMTPS id 4gfcQC0nM2znTb1;
	Tue, 16 Jun 2026 14:24:03 +0800 (CST)
Received: from dggemv705-chm.china.huawei.com (unknown [10.3.19.32])
	by mail.maildlp.com (Postfix) with ESMTPS id 947C840561;
	Tue, 16 Jun 2026 14:32:51 +0800 (CST)
Received: from kwepemq500010.china.huawei.com (7.202.194.235) by
 dggemv705-chm.china.huawei.com (10.3.19.32) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Tue, 16 Jun 2026 14:32:51 +0800
Received: from [10.173.124.160] (10.173.124.160) by
 kwepemq500010.china.huawei.com (7.202.194.235) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Tue, 16 Jun 2026 14:32:49 +0800
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
From: Miaohe Lin <linmiaohe@huawei.com>
Message-ID: <d7e97bec-72bf-7d56-3811-6d9c41fefb35@huawei.com>
Date: Tue, 16 Jun 2026 14:32:48 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <be1b20ed-5b75-46b8-b7be-3c9b029f016b@kernel.org>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: kwepems100001.china.huawei.com (7.221.188.238) To
 kwepemq500010.china.huawei.com (7.202.194.235)

On 2026/6/15 18:54, David Hildenbrand (Arm) wrote:
> On 6/15/26 05:29, Miaohe Lin wrote:
>> On 2026/6/11 21:20, David Hildenbrand (Arm) wrote:
>>> On 6/11/26 09:36, Miaohe Lin wrote:
>>>>
>>>> Agree, it's not worth to do so.
>>>>
>>>>
>>>> Since memory_failure might be the only place, this change would be unacceptable.
>>>> We should come up with a better solution. Maybe we can try repeating SetPageHWPoison
>>>> and ClearPageHWPoison at a first attempt though it looks somewhat weird to me and makes
>>>> code more complicated.
>>>
>>> And I am fairly sure we could still have some remaining races ... it's shaky.
>>
>> I have to agree it's shaky.
> 
> Right, just let writing task reschedule after reading the flags,
> but before writing the flags.
> 
>> Any suggestion for next step?
> 
> We have various code that assumes that no concurrent writes are
> possible, and consequently, we use no atomics.
> 
> __free_pages_prepare() is just one user.
> 
> Then we have __folio_set_locked(), __folio_clear_active()
> and __folio_clear_unevictable().
> 
> But also __folio_mark_uptodate(), which is called rather frequently.
> 
> page_cpupid_reset_last() is also a thing, but it mostly falls
> under __free_pages_prepare() handling.
> 
> ... and __split_folio_to_order() also messes with flags directly without atomics.
> 
> 
> Many of these are only possible for frozen pages (refcount == 0). I think
> only  __folio_set_locked() and __folio_mark_uptodate() are called on
> non-frozen pages, when there is the expectation that nobody will concurrently
> use atomics that would be bad (e.g., don't trylock if not an lru page).
> 

Thanks David! This information is really helpful!

> 
> We don't want to use atomics at these places just to please memory failure code.

Bad news. We have more places racing with memory failure code.

> 
> Would it be sufficient to know in memory-failure code that concurrent
> handling succeeded?

I think so, that would be useful.

> 
> 
> Assume that we enlighten all non-atomics to grab the rcu read lock, such as

These non-atomics are defined and used because they want to avoid atomic ops overhead?
So I'm afraid using rcu read lock in these places would lead to unexpected overhead.

> 
> diff --git a/include/linux/page-flags.h b/include/linux/page-flags.h
> index 7223f6f4e2b4..3c3852b60bbd 100644
> --- a/include/linux/page-flags.h
> +++ b/include/linux/page-flags.h
> @@ -803,10 +803,30 @@ static inline bool PageUptodate(const struct page *page)
>         return folio_test_uptodate(page_folio(page));
>  }
>  
> +#ifdef CONFIG_MEMORY_FAILURE
> +static inline void page_flags_modify_nonatomic_begin(void)
> +{
> +       rcu_read_lock();
> +}
> +static inline void page_flags_modify_nonatomic_end(void)
> +{
> +       rcu_read_unlock();
> +}
> +#else
> +static inline void page_flags_modify_nonatomic_begin(void)
> +{
> +}
> +static inline void page_flags_modify_nonatomic_end(void)
> +{
> +}
> +#endif
> +
>  static __always_inline void __folio_mark_uptodate(struct folio *folio)
>  {
>         smp_wmb();
> +       page_flags_modify_nonatomic_begin();
>         __set_bit(PG_uptodate, folio_flags(folio, 0));
> +       page_flags_modify_nonatomic_end();
>  }
>  
> 
> And then we have some retry logic such as:
> 
> diff --git a/mm/memory-failure.c b/mm/memory-failure.c
> index 51508a55c405..1123c40aaf43 100644
> --- a/mm/memory-failure.c
> +++ b/mm/memory-failure.c
> @@ -162,6 +162,62 @@ static struct rb_root_cached pfn_space_itree = RB_ROOT_CACHED;
>  
>  static DEFINE_MUTEX(pfn_space_lock);
>  
> +static bool page_test_set_hwpoison(struct page *page)
> +{
> +	lockdep_assert_held(&mf_mutex);
> +
> +	while (true) {
> +		/* Already set -> not our problem. */
> +		if (TestSetPageHWPoison(page))
> +			return true;
> +		/* Make sure concurrent non-atomic writers completed. */
> +		synchronize_rcu();
> +		/* Setting the flag was sticky. */
> +		if (PageHWPoison(page))
> +			return false;
> +	}
> +}
> +
> +static bool page_test_clear_hwpoison(struct page *page)
> +{
> +	lockdep_assert_held(&mf_mutex);
> +
> +	while (true) {
> +		/* Already clear -> not our problem. */
> +		if (!TestClearPageHWPoison(page))
> +			return false;
> +		/* Make sure concurrent non-atomic writers completed. */
> +		synchronize_rcu();
> +		/* Clearing the flag was sticky. */
> +		if (!PageHWPoison(page))
> +			return true;
> +	}
> +}
> +
> +static void page_set_hwpoison(struct page *page)
> +{
> +	lockdep_assert_held(&mf_mutex);
> +
> +	while (!PageHWPoison(page)) {
> +		SetPageHWPoison(page);
> +
> +		/* Make sure concurrent non-atomic writers completed. */
> +		synchronize_rcu();
> +	}
> +}
> +
> +static void page_clear_hwpoison(struct page *page)
> +{
> +	lockdep_assert_held(&mf_mutex);
> +
> +	while (PageHWPoison(page)) {
> +		ClearPageHWPoison(page);
> +
> +		/* Make sure concurrent non-atomic writers completed. */
> +		synchronize_rcu();
> +	}
> +}
> +
>  /*
>   * Return values:
>   *   1:   the page is dissolved (if needed) and taken off from buddy,
> @@ -199,7 +255,7 @@ static bool page_handle_poison(struct page *page, bool hugepage_or_freepage, boo
>  			return false;
>  	}
>  
> -	SetPageHWPoison(page);
> +	page_set_hwpoison(page);
>  	if (release)
>  		put_page(page);
>  	page_ref_inc(page);
> @@ -1744,7 +1800,7 @@ static int mf_generic_kill_procs(unsigned long long pfn, int flags,
>  	 * Use this flag as an indication that the dax page has been
>  	 * remapped UC to prevent speculative consumption of poison.
>  	 */
> -	SetPageHWPoison(&folio->page);
> +	page_set_hwpoison(&folio->page);
>  
>  	/*
>  	 * Unlike System-RAM there is no possibility to swap in a
> @@ -1789,7 +1845,7 @@ int mf_dax_kill_procs(struct address_space *mapping, pgoff_t index,
>  			goto unlock;
>  
>  		if (!pre_remove)
> -			SetPageHWPoison(page);
> +			page_set_hwpoison(page);
>  
>  		/*
>  		 * The pre_remove case is revoking access, the memory is still
> @@ -1866,7 +1922,7 @@ static unsigned long __folio_free_raw_hwp(struct folio *folio, bool move_flag)
>  	head = llist_del_all(raw_hwp_list_head(folio));
>  	llist_for_each_entry_safe(p, next, head, node) {
>  		if (move_flag)
> -			SetPageHWPoison(p->page);
> +			page_set_hwpoison(p->page);
>  		else
>  			num_poisoned_pages_sub(page_to_pfn(p->page), 1);
>  		kfree(p);
> @@ -2380,7 +2436,7 @@ int memory_failure(unsigned long pfn, int flags)
>  	if (res != -ENOENT)
>  		goto unlock_mutex;
>  
> -	if (TestSetPageHWPoison(p)) {
> +	if (page_test_set_hwpoison(p)) {
>  		res = -EHWPOISON;
>  		if (flags & MF_ACTION_REQUIRED)
>  			res = kill_accessing_process(current, pfn, flags);
> @@ -2410,7 +2466,7 @@ int memory_failure(unsigned long pfn, int flags)
>  			} else {
>  				/* We lost the race, try again */
>  				if (retry) {
> -					ClearPageHWPoison(p);
> +					page_clear_hwpoison(p);
>  					retry = false;
>  					goto try_again;
>  				}
> @@ -2431,7 +2487,7 @@ int memory_failure(unsigned long pfn, int flags)
>  	/* filter pages that are protected from hwpoison test by users */
>  	folio_lock(folio);
>  	if (hwpoison_filter(p)) {
> -		ClearPageHWPoison(p);
> +		page_clear_hwpoison(p);
>  		folio_unlock(folio);
>  		folio_put(folio);
>  		res = -EOPNOTSUPP;
> @@ -2751,7 +2807,7 @@ int unpoison_memory(unsigned long pfn)
>  		}
>  
>  		folio_put(folio);
> -		if (TestClearPageHWPoison(p)) {
> +		if (page_test_clear_hwpoison(p)) {
>  			folio_put(folio);
>  			ret = 0;
>  		}
> 
> 
> Maybe that would work. There would still be issues to solve
> 
> (a) We don't hold the mf_mutex on all call paths, but we really need it so a
> page_test_set_hwpoison() cannot race in weird ways with the other primitives I think.
> 
> (b) There are some leftover SetPageHWPoison etc. instances. The ones in
> arch/x86/kernel/cpu/mce/core.c likely cannot grab the mutex, but maybe they are
> corner cases either way and we can document the situation.
> 
> 
> Further, while I assume the synchronize_rcu() on the MCE path should be fine
> (who cares about performance there?), I don't know if the added RCU read lock
> on some paths could be noticable.
> 
> So one idea worth discussing, but I am sure there are more problems.

I think this is a good idea, although there are some remaining issues.
But such race should be really rare, is it worth all this effort? Could we
simply aim to resolve, not to be flawless? I.e. could we simply check
and re-set the hwpoison flag at the end of memory_failure handling to
simply avoid losing hwpoison flag as a best-effort attempt? Would it be
acceptable?

Thanks.
.

