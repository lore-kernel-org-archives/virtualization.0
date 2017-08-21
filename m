From: Wei Wang <wei.w.wang@intel.com>
Subject: Re: [PATCH v14 4/5] mm: support reporting free page blocks
Date: Mon, 21 Aug 2017 14:12:47 +0800
Message-ID: <599A79DF.2000707__26309.3241061599$1503295803$gmane$org@intel.com>
References: <1502940416-42944-1-git-send-email-wei.w.wang@intel.com>
	<1502940416-42944-5-git-send-email-wei.w.wang@intel.com>
	<20170818134650.GC18499@dhcp22.suse.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20170818134650.GC18499@dhcp22.suse.cz>
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

On 08/18/2017 09:46 PM, Michal Hocko wrote:
> On Thu 17-08-17 11:26:55, Wei Wang wrote:
>> This patch adds support to walk through the free page blocks in the
>> system and report them via a callback function. Some page blocks may
>> leave the free list after zone->lock is released, so it is the caller's
>> responsibility to either detect or prevent the use of such pages.
> This could see more details to be honest. Especially the usecase you are
> going to use this for. This will help us to understand the motivation
> in future when the current user might be gone a new ones largely diverge
> into a different usage. This wouldn't be the first time I have seen
> something like that.

OK, I will more details here about how it's used to accelerate live 
migration.

>> Signed-off-by: Wei Wang <wei.w.wang@intel.com>
>> Signed-off-by: Liang Li <liang.z.li@intel.com>
>> Cc: Michal Hocko <mhocko@kernel.org>
>> Cc: Michael S. Tsirkin <mst@redhat.com>
>> ---
>>   include/linux/mm.h |  6 ++++++
>>   mm/page_alloc.c    | 44 ++++++++++++++++++++++++++++++++++++++++++++
>>   2 files changed, 50 insertions(+)
>>
>> diff --git a/include/linux/mm.h b/include/linux/mm.h
>> index 46b9ac5..cd29b9f 100644
>> --- a/include/linux/mm.h
>> +++ b/include/linux/mm.h
>> @@ -1835,6 +1835,12 @@ extern void free_area_init_node(int nid, unsigned long * zones_size,
>>   		unsigned long zone_start_pfn, unsigned long *zholes_size);
>>   extern void free_initmem(void);
>>   
>> +extern void walk_free_mem_block(void *opaque1,
>> +				unsigned int min_order,
>> +				void (*visit)(void *opaque2,
>> +					      unsigned long pfn,
>> +					      unsigned long nr_pages));
>> +
>>   /*
>>    * Free reserved pages within range [PAGE_ALIGN(start), end & PAGE_MASK)
>>    * into the buddy system. The freed pages will be poisoned with pattern
>> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
>> index 6d00f74..a721a35 100644
>> --- a/mm/page_alloc.c
>> +++ b/mm/page_alloc.c
>> @@ -4762,6 +4762,50 @@ void show_free_areas(unsigned int filter, nodemask_t *nodemask)
>>   	show_swap_cache_info();
>>   }
>>   
>> +/**
>> + * walk_free_mem_block - Walk through the free page blocks in the system
>> + * @opaque1: the context passed from the caller
>> + * @min_order: the minimum order of free lists to check
>> + * @visit: the callback function given by the caller
> The original suggestion for using visit was motivated by a visit design
> pattern but I can see how this can be confusing. Maybe a more explicit
> name wold be better. What about report_free_range.


I'm afraid that name would be too long to fit in nicely.
How about simply naming it "report"?


>
>> + *
>> + * The function is used to walk through the free page blocks in the system,
>> + * and each free page block is reported to the caller via the @visit callback.
>> + * Please note:
>> + * 1) The function is used to report hints of free pages, so the caller should
>> + * not use those reported pages after the callback returns.
>> + * 2) The callback is invoked with the zone->lock being held, so it should not
>> + * block and should finish as soon as possible.
> I think that the explicit note about zone->lock is not really need. This
> can change in future and I would even bet that somebody might rely on
> the lock being held for some purpose and silently get broken with the
> change. Instead I would much rather see something like the following:
> "
> Please note that there are no locking guarantees for the callback

Just a little confused with this one:

The callback is invoked within zone->lock, why would we claim it "no
locking guarantees for the callback"?

> and
> that the reported pfn range might be freed or disappear after the
> callback returns so the caller has to be very careful how it is used.
>
> The callback itself must not sleep or perform any operations which would
> require any memory allocations directly (not even GFP_NOWAIT/GFP_ATOMIC)
> or via any lock dependency. It is generally advisable to implement
> the callback as simple as possible and defer any heavy lifting to a
> different context.
>
> There is no guarantee that each free range will be reported only once
> during one walk_free_mem_block invocation.
>
> pfn_to_page on the given range is strongly discouraged and if there is
> an absolute need for that make sure to contact MM people to discuss
> potential problems.
>
> The function itself might sleep so it cannot be called from atomic
> contexts.
>
> In general low orders tend to be very volatile and so it makes more
> sense to query larger ones for various optimizations which like
> ballooning etc... This will reduce the overhead as well.
> "

I think it looks quite comprehensive. Thanks.


Best,
Wei
