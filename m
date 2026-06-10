Received: from canpmsgout07.his.huawei.com (canpmsgout07.his.huawei.com [113.46.200.222])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9694B38AC6E
	for <virtualization@lists.linux.dev>; Wed, 10 Jun 2026 07:24:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.222
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781076280; cv=none; b=BOYOzEaC5JiP8zkxY0ZOsm7ar8IZ5onXIzbzQbeelsT/Na1VhqL5Y3kFpK3I6wPZUXN+5i5I6FG/OI3Dq0MeLEAhnRV6i02yjNQ4HSgIPEBwSzHX4mRuCAzBogpKYJvHFoLX3eJ1xQNMcWxaCg8kyDZb+zrw7QIGxNE7+q8LFuc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781076280; c=relaxed/simple;
	bh=ef4ynL/2dHl1SgaQIzeYZSOTnMsQJviyHt7XfKKhMos=;
	h=Subject:To:CC:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=eEKgTASUd+/ALBW6kCx4umygKVOOx8awDKE6rQNyStCEASTYcyTiPp4DeBQa7Q/obUJSM/OvHh1zehQkE5Rl+nA+E9YlymJKlBezUSOgH12p2FokEikfLRpv64r60rnvOQiro51ouhFgPcruLxmiavycLAgkaCGhfnPv/ap+7n4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=pUAcpUCX; arc=none smtp.client-ip=113.46.200.222
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="pUAcpUCX"
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=crRRLRHMwOqSlZxpvEgm0rohsPbYMLQzjHRhzUhnKk4=;
	b=pUAcpUCXcIbmjmTiSx3U5UTBV/3/rMsFIK5zjYAueWsPFLJehR3ItKMetYHDKTwv8ZOEcC+mq
	7fOTCLSG5LPNHSiJlrZIYT9xa2sisxyjsFhiQ6iSHrPv7xClMP8PmlHnq2fWYf3JTIZVClsGMhe
	yYfoS9ENJsp5sdYL/OjOC3w=
Received: from mail.maildlp.com (unknown [172.19.163.127])
	by canpmsgout07.his.huawei.com (SkyGuard) with ESMTPS id 4gZxsh0nwQzLlY6;
	Wed, 10 Jun 2026 15:16:40 +0800 (CST)
Received: from dggemv706-chm.china.huawei.com (unknown [10.3.19.33])
	by mail.maildlp.com (Postfix) with ESMTPS id DCF44402AB;
	Wed, 10 Jun 2026 15:24:33 +0800 (CST)
Received: from kwepemq500010.china.huawei.com (7.202.194.235) by
 dggemv706-chm.china.huawei.com (10.3.19.33) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Wed, 10 Jun 2026 15:24:33 +0800
Received: from [10.173.124.160] (10.173.124.160) by
 kwepemq500010.china.huawei.com (7.202.194.235) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Wed, 10 Jun 2026 15:24:30 +0800
Subject: Re: [PATCH splitout] mm: memory-failure: serialize
 TestSetPageHWPoison with zone->lock
To: "Michael S. Tsirkin" <mst@redhat.com>, Zi Yan <ziy@nvidia.com>
CC: "David Hildenbrand (Arm)" <david@kernel.org>, Andrew Morton
	<akpm@linux-foundation.org>, <linux-kernel@vger.kernel.org>, Jason Wang
	<jasowang@redhat.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	=?UTF-8?Q?Eugenio_P=c3=a9rez?= <eperezma@redhat.com>, Muchun Song
	<muchun.song@linux.dev>, Oscar Salvador <osalvador@suse.de>, Lorenzo Stoakes
	<ljs@kernel.org>, "Liam R. Howlett" <liam@infradead.org>, Vlastimil Babka
	<vbabka@kernel.org>, Mike Rapoport <rppt@kernel.org>, Suren Baghdasaryan
	<surenb@google.com>, Michal Hocko <mhocko@suse.com>, Brendan Jackman
	<jackmanb@google.com>, Johannes Weiner <hannes@cmpxchg.org>, Baolin Wang
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
	<aarcange@redhat.com>, Naoya Horiguchi <nao.horiguchi@gmail.com>
References: <df06b66fe4ff8e925ee0714955abc2183a727b90.1780998980.git.mst@redhat.com>
 <20260609111020.e88f51a7b6ebc37360d66fdc@linux-foundation.org>
 <8c1f468e-b50a-487a-a267-8d1ea5a61c87@kernel.org>
 <FB250C43-790E-4AB0-BD40-74665FC601A0@nvidia.com>
 <38C84F23-E881-4DB2-86BA-93F39D44AE1B@nvidia.com>
 <20260609162437-mutt-send-email-mst@kernel.org>
 <4BA276D9-9EB9-4E2A-8A05-657ACACFF227@nvidia.com>
 <20260609165829-mutt-send-email-mst@kernel.org>
From: Miaohe Lin <linmiaohe@huawei.com>
Message-ID: <dd8d89be-9c73-8ff7-7d44-9705bddeda4d@huawei.com>
Date: Wed, 10 Jun 2026 15:24:30 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <20260609165829-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: kwepems200002.china.huawei.com (7.221.188.68) To
 kwepemq500010.china.huawei.com (7.202.194.235)

On 2026/6/10 5:00, Michael S. Tsirkin wrote:
> On Tue, Jun 09, 2026 at 04:54:01PM -0400, Zi Yan wrote:
>> On 9 Jun 2026, at 16:34, Michael S. Tsirkin wrote:
>>
>>> On Tue, Jun 09, 2026 at 02:52:47PM -0400, Zi Yan wrote:
>>>> On 9 Jun 2026, at 14:39, Zi Yan wrote:
>>>>
>>>>> On 9 Jun 2026, at 14:38, David Hildenbrand (Arm) wrote:
>>>>>
>>>>>> On 6/9/26 20:10, Andrew Morton wrote:
>>>>>>> On Tue, 9 Jun 2026 06:12:49 -0400 "Michael S. Tsirkin" <mst@redhat.com> wrote:
>>>>>>>
>>>>>>>> TestSetPageHWPoison() is called without zone->lock, so its atomic
>>>>>>>> update to page->flags can race with non-atomic flag operations
>>>>>>>> that run under zone->lock in the buddy allocator.
>>>>>>>>
>>>>>>>> In particular, __free_pages_prepare() does:
>>>>>>>>
>>>>>>>>     page->flags.f &= ~PAGE_FLAGS_CHECK_AT_PREP;
>>>>>>>>
>>>>>>>> This non-atomic read-modify-write, while correctly excluding
>>>>>>>> __PG_HWPOISON from the mask, can still lose a concurrent
>>>>>>>> TestSetPageHWPoison if the read happens before the poison bit
>>>>>>>> is set and the write happens after.  Will only get worse if/when
>>>>>>>> we add more non-atomic flag operations.
>>>>>>>>
>>>>>>>> Fix by acquiring zone->lock around TestSetPageHWPoison and
>>>>>>>> around ClearPageHWPoison in the retry path.  This
>>>>>>>> serializes with all buddy flag manipulation.  The cost is
>>>>>>>> negligible: one lock/unlock in an extremely rare path
>>>>>>>> (hardware memory errors).
>>>>>>>>
>>>>>>>> Note: SetPageHWPoison and TestClearPageHWPoison calls elsewhere
>>>>>>>> in this file operate on pages already removed from the buddy
>>>>>>>> allocator or on non-buddy pages (DAX, hugetlb), so they do not
>>>>>>>> need zone->lock protection.
>>>>>>>
>>>>>>> Sashiko is saying this doesn't do anything "Because
>>>>>>> __free_pages_prepare() executes entirely locklessly".  Did it goof?
>>>>>>>
>>>>>>> https://sashiko.dev/#/patchset/df06b66fe4ff8e925ee0714955abc2183a727b90.1780998980.git.mst@redhat.com
>>>>>>
>>>>>> Battle of the bots: it's right.
>>>>>
>>>>> Yep, __free_pages_prepare() changes the page flag without holding
>>>>> zone->lock.
>>>>
>>>> __free_pages_prepare() works on frozen pages and assumes no one else
>>>> touches the input page. To avoid this race, memory_failure() might
>>>> want to try_get_page() before TestClearPageHWPoison(), but I am not
>>>> sure if that works along with memory failure flow.
>>>>
>>>> Best Regards,
>>>> Yan, Zi
>>>
>>>
>>>
>>> Actually memory failure already plays with this down the road no?
>>>
>>> So maybe it's enough to just SetPageHWPoison afterwards again?
>>>
>>>
>>> diff --git a/mm/memory-failure.c b/mm/memory-failure.c
>>> index ee42d4361309..4758fea94a96 100644
>>> --- a/mm/memory-failure.c
>>> +++ b/mm/memory-failure.c
>>> @@ -2415,6 +2415,7 @@ int memory_failure(unsigned long pfn, int flags)
>>>  	if (!res) {
>>>  		if (is_free_buddy_page(p)) {
>>>  			if (take_page_off_buddy(p)) {
>>> +				SetPageHWPoison(p);
>>>  				page_ref_inc(p);
>>>  				res = MF_RECOVERED;
>>>  			} else {
>>>
>>>
>>> and maybe in a bunch of other places in there?
>>
>> You mean for fear of losing HWPoison flag in the earlier TestSetPageHWPoison(),
>> just set it again here?
> 
> Yea.
> 
>> Why not do it after get_hwpoison_page(), since that
>> is the expected page flag?
> 
> It's still in the buddy at that point right? I'm worried buddy might
> poke at flags.

Since __free_pages_prepare() executes entirely locklessly, the only way to ensure
HWPoison flag won't be lost might be only set hwpoison flag iff we can make sure
pages are not on the way to buddy...

Thanks.
.
