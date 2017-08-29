From: Wei Wang <wei.w.wang@intel.com>
Subject: Re: [PATCH v15 4/5] mm: support reporting free page blocks
Date: Tue, 29 Aug 2017 11:23:52 +0800
Message-ID: <59A4DE48.9030206__24.384170728986$1503976886$gmane$org@intel.com>
References: <1503914913-28893-1-git-send-email-wei.w.wang@intel.com>
	<1503914913-28893-5-git-send-email-wei.w.wang@intel.com>
	<20170828133326.GN17097@dhcp22.suse.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20170828133326.GN17097@dhcp22.suse.cz>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Michal Hocko <mhocko@kernel.org>
Cc: aarcange@redhat.com, virtio-dev@lists.oasis-open.org, kvm@vger.kernel.org, mst@redhat.com, qemu-devel@nongnu.org, amit.shah@redhat.com, liliang.opensource@gmail.com, mawilcox@microsoft.com, linux-kernel@vger.kernel.org, willy@infradead.org, virtualization@lists.linux-foundation.org, linux-mm@kvack.org, yang.zhang.wz@gmail.com, quan.xu@aliyun.com, cornelia.huck@de.ibm.com, pbonzini@redhat.com, akpm@linux-foundation.org, mgorman@techsingularity.net
List-Id: virtualization@lists.linuxfoundation.org

On 08/28/2017 09:33 PM, Michal Hocko wrote:
> On Mon 28-08-17 18:08:32, Wei Wang wrote:
>> This patch adds support to walk through the free page blocks in the
>> system and report them via a callback function. Some page blocks may
>> leave the free list after zone->lock is released, so it is the caller's
>> responsibility to either detect or prevent the use of such pages.
>>
>> One use example of this patch is to accelerate live migration by skipping
>> the transfer of free pages reported from the guest. A popular method used
>> by the hypervisor to track which part of memory is written during live
>> migration is to write-protect all the guest memory. So, those pages that
>> are reported as free pages but are written after the report function
>> returns will be captured by the hypervisor, and they will be added to the
>> next round of memory transfer.
> OK, looks much better. I still have few nits.
>
>> +extern void walk_free_mem_block(void *opaque,
>> +				int min_order,
>> +				bool (*report_page_block)(void *, unsigned long,
>> +							  unsigned long));
>> +
> please add names to arguments of the prototype
>
>>   /*
>>    * Free reserved pages within range [PAGE_ALIGN(start), end & PAGE_MASK)
>>    * into the buddy system. The freed pages will be poisoned with pattern
>> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
>> index 6d00f74..81eedc7 100644
>> --- a/mm/page_alloc.c
>> +++ b/mm/page_alloc.c
>> @@ -4762,6 +4762,71 @@ void show_free_areas(unsigned int filter, nodemask_t *nodemask)
>>   	show_swap_cache_info();
>>   }
>>   
>> +/**
>> + * walk_free_mem_block - Walk through the free page blocks in the system
>> + * @opaque: the context passed from the caller
>> + * @min_order: the minimum order of free lists to check
>> + * @report_page_block: the callback function to report free page blocks
> page_block has meaning in the core MM which doesn't strictly match its
> usage here. Moreover we are reporting pfn ranges rather than struct page
> range. So report_pfn_range would suit better.
>
> [...]
>> +	for_each_populated_zone(zone) {
>> +		for (order = MAX_ORDER - 1; order >= min_order; order--) {
>> +			for (mt = 0; !stop && mt < MIGRATE_TYPES; mt++) {
>> +				spin_lock_irqsave(&zone->lock, flags);
>> +				list = &zone->free_area[order].free_list[mt];
>> +				list_for_each_entry(page, list, lru) {
>> +					pfn = page_to_pfn(page);
>> +					stop = report_page_block(opaque, pfn,
>> +								 1 << order);
>> +					if (stop)
>> +						break;
> 					if (stop) {
> 						spin_unlock_irqrestore(&zone->lock, flags);
> 						return;
> 					}
>
> would be both easier and less error prone. E.g. You wouldn't pointlessly
> iterate over remaining orders just to realize there is nothing to be
> done for those...
>

Yes, that's better, thanks. I will take other suggestions as well.

Best,
Wei
