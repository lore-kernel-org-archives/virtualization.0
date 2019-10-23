From: Michal Hocko <mhocko@kernel.org>
Subject: Re: [PATCH RFC v3 6/9] mm: Allow to offline PageOffline() pages with
	a reference count of 0
Date: Wed, 23 Oct 2019 11:43:45 +0200
Message-ID: <20191023094345.GL754@dhcp22.suse.cz>
References: <20191016114321.GX317@dhcp22.suse.cz>
	<36fef317-78e3-0500-43ba-f537f9a6fea4@redhat.com>
	<20191016140350.GD317@dhcp22.suse.cz>
	<7c7bef01-f904-904a-b0a7-f7b514b8bda8@redhat.com>
	<20191018081524.GD5017@dhcp22.suse.cz>
	<83d0a961-952d-21e4-74df-267912b7b6fa@redhat.com>
	<20191018111843.GH5017@dhcp22.suse.cz>
	<709d39aa-a7ba-97aa-e66b-e2fec2fdf3c4@redhat.com>
	<20191022122326.GL9379@dhcp22.suse.cz>
	<b4be42a4-cbfc-8706-cc94-26211ddcbe4a@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <b4be42a4-cbfc-8706-cc94-26211ddcbe4a@redhat.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: David Hildenbrand <david@redhat.com>
Cc: Pingfan Liu <kernelfans@gmail.com>, virtualization@lists.linux-foundation.org, linux-mm@kvack.org, Alexander Potapenko <glider@google.com>, Mauro Carvalho Chehab <mchehab+samsung@kernel.org>, Alexander Duyck <alexander.h.duyck@linux.intel.com>, Ira Weiny <ira.weiny@intel.com>, Andrea Arcangeli <aarcange@redhat.com>, Stephen Rothwell <sfr@canb.auug.org.au>, Yu Zhao <yuzhao@google.com>, Matthew Wilcox <willy@infradead.org>, Jason Gunthorpe <jgg@ziepe.ca>, Anthony Yznaga <anthony.yznaga@oracle.com>, Pavel Tatashin <pavel.tatashin@microsoft.com>, Anshuman Khandual <anshuman.khandual@arm.com>, Mike Rapoport <rppt@linux.vnet.ibm.com>, Qian Cai <cai@lca.pw>, Andrey Ryabinin <aryabinin@virtuozzo.com>, Dan Williams <dan.j.williams@intel.com>, Vlastimil Babka <vbabka@suse.cz>, Oscar Salvador <osalvador@suse.de>, Juergen Gross <jgross@suse.com>, Yang Shi <yang.shi@linux.alibaba.c>
List-Id: virtualization@lists.linuxfoundation.org

On Tue 22-10-19 16:02:09, David Hildenbrand wrote:
[...]
> >>> MEM_CANCEL_OFFLINE could gain the reference back to balance the
> >>> MEM_GOING_OFFLINE step.
> >>
> >> The pages are already unisolated and could be used by the buddy. But again,
> >> I think you have an idea that tries to avoid putting pages to the buddy.
> > 
> > Yeah, set_page_count(page, 0) if you do not want to release that page
> > from the notifier context to reflect that the page is ok to be offlined
> > with the rest.
> >   
> 
> I neither see how you deal with __test_page_isolated_in_pageblock() nor with
> __offline_isolated_pages(). Sorry, but what I read is incomplete and you
> probably have a full proposal in your head. Please read below how I think
> you want to solve it.

Yeah, sorry that I am throwing incomplete ideas at you. I am just trying
to really nail down how to deal with reference counting here because it
is an important aspect.
 
> >>> explicit control via the reference count which is the standard way to
> >>> control the struct page life cycle.
> >>>
> >>> Anyway hooking into __put_page (which tends to be a hot path with
> >>> something that is barely used on most systems) doesn't sound nice to me.
> >>> This is the whole point which made me think about the whole reference
> >>> count approach in the first place.
> >>
> >> Again, the race I think that is possible
> >>
> >> somebody: get_page_unless_zero(page)
> >> virtio_mem: page_ref_dec(pfn_to_page(pfn)
> >> somebody: put_page() -> straight to the buddy
> > 
> > Who is that somebody? I thought that it is only the owner/driver to have
> > a control over the page. Also the above is not possible as long as the
> > owner/driver keeps a reference to the PageOffline page throughout the
> > time it is marked that way.
> >   
> 
> I was reading
> 
> include/linux/mm_types.h:
> 
> "If you want to use the refcount field, it must be used in such a way
>  that other CPUs temporarily incrementing and then decrementing the
>  refcount does not cause problems"
> 
> And that made me think "anybody can go ahead and try get_page_unless_zero()".
> 
> If I am missing something here and this can indeed not happen (e.g.,
> because PageOffline() pages are never mapped to user space), then I'll
> happily remove this code.

The point is that if the owner of the page is holding the only reference
to the page then it is clear that nothing like that's happened.
 
[...]

> Let's recap what I suggest:
> 
> "PageOffline() pages that have a reference count of 0 will be treated
>  like free pages when offlining pages, allowing the containing memory
>  block to get offlined. In case a driver wants to revive such a page, it
>  has to synchronize against memory onlining/offlining (e.g., using memory
>  notifiers) while incrementing the reference count. Also, a driver that
>  relies in this feature is aware that re-onlining the memory will require
>  to re-set the pages PageOffline() - e.g., via the online_page_callback_t."

OK

[...]
> d) __put_page() is modified to not return pages to the buddy in any
>    case as a safety net. We might be able to get rid of that.

I do not like exactly this part
 
> What I think you suggest:
> 
> a) has_unmovable_pages() skips over all PageOffline() pages.
>    This results in a lot of false negatives when trying to offline. Might be ok.
> 
> b) The driver decrements the reference count of the PageOffline pages
>    in MEM_GOING_OFFLINE.

Well, driver should make the page unreferenced or fail. What is done
really depends on the specific driver

> c) The driver increments the reference count of the PageOffline pages
>    in MEM_CANCEL_OFFLINE. One issue might be that the pages are no longer
>    isolated once we get that call. Might be ok.

Only previous PageBuddy pages are returned to the allocator IIRC. Mostly
because of MovablePage()

> d) How to make __test_page_isolated_in_pageblock() succeed?
>    Like I propose in this patch (PageOffline() + refcount == 0)?

Yep

> e) How to make __offline_isolated_pages() succeed?
>    Like I propose in this patch (PageOffline() + refcount == 0)?

Simply skip over PageOffline pages. Reference count should never be != 0
at this stage.
 
> In summary, is what you suggest simply delaying setting the reference count to 0
> in MEM_GOING_OFFLINE instead of right away when the driver unpluggs the pages?

Yes

> What's the big benefit you see and I fail to see?

Aparat from no hooks into __put_page it is also an explicit control over
the page via reference counting. Do you see any downsides?
-- 
Michal Hocko
SUSE Labs
