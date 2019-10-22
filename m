From: David Hildenbrand <david@redhat.com>
Subject: Re: [PATCH RFC v3 6/9] mm: Allow to offline PageOffline() pages with
	a reference count of 0
Date: Tue, 22 Oct 2019 16:02:09 +0200
Message-ID: <b4be42a4-cbfc-8706-cc94-26211ddcbe4a@redhat.com>
References: <20190919142228.5483-1-david@redhat.com>
	<20190919142228.5483-7-david@redhat.com>
	<20191016114321.GX317@dhcp22.suse.cz>
	<36fef317-78e3-0500-43ba-f537f9a6fea4@redhat.com>
	<20191016140350.GD317@dhcp22.suse.cz>
	<7c7bef01-f904-904a-b0a7-f7b514b8bda8@redhat.com>
	<20191018081524.GD5017@dhcp22.suse.cz>
	<83d0a961-952d-21e4-74df-267912b7b6fa@redhat.com>
	<20191018111843.GH5017@dhcp22.suse.cz>
	<709d39aa-a7ba-97aa-e66b-e2fec2fdf3c4@redhat.com>
	<20191022122326.GL9379@dhcp22.suse.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20191022122326.GL9379@dhcp22.suse.cz>
Content-Language: en-US
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
Cc: Pingfan Liu <kernelfans@gmail.com>, virtualization@lists.linux-foundation.org, linux-mm@kvack.org, Alexander Potapenko <glider@google.com>, Mauro Carvalho Chehab <mchehab+samsung@kernel.org>, Alexander Duyck <alexander.h.duyck@linux.intel.com>, Ira Weiny <ira.weiny@intel.com>, Andrea Arcangeli <aarcange@redhat.com>, Stephen Rothwell <sfr@canb.auug.org.au>, Yu Zhao <yuzhao@google.com>, Matthew Wilcox <willy@infradead.org>, Jason Gunthorpe <jgg@ziepe.ca>, Anthony Yznaga <anthony.yznaga@oracle.com>, Pavel Tatashin <pavel.tatashin@microsoft.com>, Anshuman Khandual <anshuman.khandual@arm.com>, Mike Rapoport <rppt@linux.vnet.ibm.com>, Qian Cai <cai@lca.pw>, Andrey Ryabinin <aryabinin@virtuozzo.com>, Dan Williams <dan.j.williams@intel.com>, Vlastimil Babka <vbabka@suse.cz>, Oscar Salvador <osalvador@suse.de>, Juergen Gross <jgross@suse.com>, Yang Shi <yang.shi@linux.alibaba.c>
List-Id: virtualization@lists.linuxfoundation.org

>> Please note that we have other users that use PG_offline + refcount >= 1
>> (HyperV balloon, XEN). We should not affect these users (IOW,
>> has_unmovable_pages() has to stop right there if we see one of these pages).
> 
> OK, this is exactly what I was worried about. I can see why you might
> want to go an easier way and rule those users out but wouldn't be it
> actually more reasonable to explicitly request PageOffline users to
> implement MEM_GOING_OFFLINE and prepare their offlined pages for the
> offlining operation or fail right there if that is not possible.
> If you fail right there during the isolation phase then there is no way
> to allow the offlining to proceed from that context.

I am not sure I agree. But let's discuss the details. See below.

>   
>>>> 2) memory_notify(MEM_GOING_OFFLINE, &arg);
>>>> -> Here, we could release all pages to the buddy, clearing PG_offline
>>>> -> PF_offline must not be cleared so dumping tools will not touch
>>>>      these pages. There is a time where pages are !PageBuddy() and
>>>>      !PageOffline().
>>>
>>> Well, this is fully under control of the driver, no? Reference count
>>> shouldn't play any role here AFAIU.
>>
>> Yes, this is more a PG_offline issue. The reference count is an issue of
>> reaching this call :) If we want to go via the buddy:
>>
>> 1. Clear PG_offline
>> 2. Free page (gets set PG_buddy)
>>
>> Between 1 and 2, a dumping tool could not exclude these pages and therefore
>> try to read from these pages. That is an issue IFF we want to return the
>> pages back to the buddy instead of doing what I propose here.
> 
> If the driver is going to free page to the allocator then it would have
> to claim the page back and so it is usable again. If it cannot free it
> then it would simply set the reference count to 0. It can even keep the
> PG_offline if necessary although I have to admit I am not really sure it
> is necessary.

Yes it is necessary to keep PG_offline set to avoid anybody touching the
page until the section is offline. (especially, dumping tools)
But that's another discussion. The important part is to not go via the buddy.

> 
>>>> 3) scan_movable_pages() ...
>>
>> Please note that when we don't put the pages back to the buddy and don't
>> implement something like I have in this patch, we'll loop/fail here.
>> Especially if we have pages with PG_offline + refcount >= 1 .
> 
> You should have your reference count 0 at this stage as it is after
> MEM_GOING_OFFLINE.
>   
>>> MEM_CANCEL_OFFLINE could gain the reference back to balance the
>>> MEM_GOING_OFFLINE step.
>>
>> The pages are already unisolated and could be used by the buddy. But again,
>> I think you have an idea that tries to avoid putting pages to the buddy.
> 
> Yeah, set_page_count(page, 0) if you do not want to release that page
> from the notifier context to reflect that the page is ok to be offlined
> with the rest.
>   

I neither see how you deal with __test_page_isolated_in_pageblock() nor with
__offline_isolated_pages(). Sorry, but what I read is incomplete and you
probably have a full proposal in your head. Please read below how I think
you want to solve it.

> 
>>> explicit control via the reference count which is the standard way to
>>> control the struct page life cycle.
>>>
>>> Anyway hooking into __put_page (which tends to be a hot path with
>>> something that is barely used on most systems) doesn't sound nice to me.
>>> This is the whole point which made me think about the whole reference
>>> count approach in the first place.
>>
>> Again, the race I think that is possible
>>
>> somebody: get_page_unless_zero(page)
>> virtio_mem: page_ref_dec(pfn_to_page(pfn)
>> somebody: put_page() -> straight to the buddy
> 
> Who is that somebody? I thought that it is only the owner/driver to have
> a control over the page. Also the above is not possible as long as the
> owner/driver keeps a reference to the PageOffline page throughout the
> time it is marked that way.
>   

I was reading

include/linux/mm_types.h:

"If you want to use the refcount field, it must be used in such a way
 that other CPUs temporarily incrementing and then decrementing the
 refcount does not cause problems"

And that made me think "anybody can go ahead and try get_page_unless_zero()".

If I am missing something here and this can indeed not happen (e.g.,
because PageOffline() pages are never mapped to user space), then I'll
happily remove this code.

> 
>>>>> If you can let the page go then just drop the reference count. The page
>>>>> is isolated already by that time. If you cannot let it go for whatever
>>>>> reason you can fail the offlining.
>>>>
>>>> We do have one hack in current MM code, which is the memory isolation
>>>> notifier only used by CMM on PPC. It allows to "cheat" has_unmovable_pages()
>>>> to skip over unmovable pages. But quite frankly, I rather want to get rid of
>>>> that crap (something I am working on right now) than introduce new users.
>>>> This stuff is racy as hell and for CMM, if memory offlining fails, the
>>>> ballooned pages are suddenly part of the buddy. Fragile.
>>>
>>> Could you be more specific please?
>>
>> Let's take a look at how arch/powerpc/platforms/pseries/cmm.c handles it:
>>
>> cmm_memory_isolate_cb() -> cmm_count_pages(arg):
>> - Memory Isolation notifier callback
>> - Count how many pages in the range to be isolated are in the ballooon
>> - This makes has_unmovable_pages() succeed. Pages can be isolated.
>>
>> cmm_memory_cb -> cmm_mem_going_offline(arg):
>> - Memory notifier (online/offline)
>> - Release all pages in the range to the buddy
>>
>> If offlining fails, the pages are now in the buddy, no longer in the
>> balloon. MEM_CANCEL_ONLINE is too late, because the range is already
>> unisolated again and the pages might be in use.
>>
>> For CMM it might not be that bad, because it can actually "reloan" any
>> pages. In contrast, virtio-mem cannot simply go ahead and reuse random
>> memory in unplugged. Any access to these pages would be evil. Giving them
>> back to the buddy is dangerous.
> 
> Thanks, I was not aware of that code. But from what I understood this is
> an outright bug in this code because cmm_mem_going_offline releases
> pages to the buddy allocator which is something that is not recoverable
> on a later failure.
> 

Yes, and that should be gone if we switch to balloon compaction.



Let's recap what I suggest:

"PageOffline() pages that have a reference count of 0 will be treated
 like free pages when offlining pages, allowing the containing memory
 block to get offlined. In case a driver wants to revive such a page, it
 has to synchronize against memory onlining/offlining (e.g., using memory
 notifiers) while incrementing the reference count. Also, a driver that
 relies in this feature is aware that re-onlining the memory will require
 to re-set the pages PageOffline() - e.g., via the online_page_callback_t."

a) has_unmovable_pages() already skips over pages with a refcount of zero.
   The code I add to not skip over these pages when !MEMORY_OFFLINE is a pure
   optimization to fail early when trying to allocate from that range.

b) __test_page_isolated_in_pageblock() is modified to skip over
   PageOffline() pages with a refcount of zero

c) __offline_isolated_pages() is modified to skip over
   PageOffline() pages with a refcount of zero

d) __put_page() is modified to not return pages to the buddy in any
   case as a safety net. We might be able to get rid of that.



What I think you suggest:

a) has_unmovable_pages() skips over all PageOffline() pages.
   This results in a lot of false negatives when trying to offline. Might be ok.

b) The driver decrements the reference count of the PageOffline pages
   in MEM_GOING_OFFLINE.

c) The driver increments the reference count of the PageOffline pages
   in MEM_CANCEL_OFFLINE. One issue might be that the pages are no longer
   isolated once we get that call. Might be ok.

d) How to make __test_page_isolated_in_pageblock() succeed?
   Like I propose in this patch (PageOffline() + refcount == 0)?

e) How to make __offline_isolated_pages() succeed?
   Like I propose in this patch (PageOffline() + refcount == 0)?

In summary, is what you suggest simply delaying setting the reference count to 0
in MEM_GOING_OFFLINE instead of right away when the driver unpluggs the pages?
What's the big benefit you see and I fail to see?

-- 

Thanks,

David / dhildenb
