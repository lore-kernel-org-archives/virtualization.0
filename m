From: Michal Hocko <mhocko@kernel.org>
Subject: Re: [PATCH RFC v3 6/9] mm: Allow to offline PageOffline() pages with
	a reference count of 0
Date: Fri, 18 Oct 2019 13:20:16 +0200
Message-ID: <20191018111843.GH5017__14510.0611190841$1571397638$gmane$org@dhcp22.suse.cz>
References: <20190919142228.5483-1-david@redhat.com>
	<20190919142228.5483-7-david@redhat.com>
	<20191016114321.GX317@dhcp22.suse.cz>
	<36fef317-78e3-0500-43ba-f537f9a6fea4@redhat.com>
	<20191016140350.GD317@dhcp22.suse.cz>
	<7c7bef01-f904-904a-b0a7-f7b514b8bda8@redhat.com>
	<20191018081524.GD5017@dhcp22.suse.cz>
	<83d0a961-952d-21e4-74df-267912b7b6fa@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <83d0a961-952d-21e4-74df-267912b7b6fa@redhat.com>
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

On Fri 18-10-19 10:50:24, David Hildenbrand wrote:
> On 18.10.19 10:15, Michal Hocko wrote:
> > On Wed 16-10-19 16:14:52, David Hildenbrand wrote:
> > > On 16.10.19 16:03, Michal Hocko wrote:
> > [...]
> > > > But why cannot you keep the reference count at 1 (do get_page when
> > > > offlining the page)? In other words as long as the driver knows the page
> > > > has been returned to the host then it has ref count at 1. Once the page
> > > > is returned to the guest for whatever reason it can free it to the
> > > > system by clearing the offline state and put_page.
> > > 
> > > I think I explained how the reference count of 1 is problematic when wanting
> > > to offline the memory. After all that's the problem I try to solve: Keep
> > > PG_offline set until the memory is offline and make sure nobody will touch
> > > the page.
> > 
> > Please bear with me but I still believe that elevated reference count
> > has some merits. I do understand that you maintain your metadata to
> > recognize that the memory handed over to the hypervisor will not
> > magically appear after onlining. But I believe that you can achieve
> > the same with an elevated reference count and have a more robust design
> > as well.
> 
> Thanks for thinking about this. I still believe it is problematic. And I
> don't like releasing "pages that should not be used" to the buddy. It comes
> with some problems if offlining fails (see below).

Sure I will not be pushing if that turns out to be unfeasible. But I
would like to explore that path before giving up on it.
 
[...]
> > An elevated reference count would prevent offlining to finish. And I
> > believe this is a good thing because the owner of the offline page might
> > still need to do something to "untrack" that page. We have an interface
> 
> And here is the thing: The owner of the page does not have to do anything to
> untrack the page. I mean that's what a reference count of zero actually
> means - no direct reference.

Will this be the case for other potential users of the similar/same
mechanism? I thought that this would become a more spread mechanism.
 
[...]

> > for that - MEM_GOING_OFFLINE notification. This sounds like a good place
> > for the driver to decide whether it is safe to let the page go or not.
> 
> As I explained, this is too late and fragile. I post again what I posted
> before with some further explanations
> 
> __offline_pages() works like this:
> 
> 1) start_isolate_page_range()
> -> offline pages with a reference count of one will be detected as
> unmovable -> offlining aborted. (see below on the memory isolation notifier)

I am assuming that has_unmovable_pages would skip over those pages. Your
patch already does that, no?

> 2) memory_notify(MEM_GOING_OFFLINE, &arg);
> -> Here, we could release all pages to the buddy, clearing PG_offline
> -> PF_offline must not be cleared so dumping tools will not touch
>    these pages. There is a time where pages are !PageBuddy() and
>    !PageOffline().

Well, this is fully under control of the driver, no? Reference count
shouldn't play any role here AFAIU.
 
> 3) scan_movable_pages() ...
> 
> 4a) Memory offlining succeeded: memory_notify(MEM_OFFLINE, &arg);
> 
> Perfect, it worked. Sections are offline.
> 
> 4b) Memory offlining failed
> 
>     undo_isolate_page_range(start_pfn, end_pfn, MIGRATE_MOVABLE);
>     memory_notify(MEM_CANCEL_OFFLINE, &arg);

Doesn't this return pages back to buddy only when they were marked Buddy
already?

MEM_CANCEL_OFFLINE could gain the reference back to balance the
MEM_GOING_OFFLINE step.

One think that I would like to clarify because my previous email could
be misleading a bit. You do not really have to drop the reference by
releasing the page to the allocator (via put_page). You can also set
the reference count to 0 explicitly. The driver is in control of the
page, right?  And that is the whole point I wanted to make. There is an
explicit control via the reference count which is the standard way to
control the struct page life cycle.

Anyway hooking into __put_page (which tends to be a hot path with
something that is barely used on most systems) doesn't sound nice to me.
This is the whole point which made me think about the whole reference
count approach in the first place.

I do realize that the reference count doesn't solve the problem with
onlining. Drivers still have to special case the onlining and that is
something I really dislike but I do not have a good answer for.

> > If you can let the page go then just drop the reference count. The page
> > is isolated already by that time. If you cannot let it go for whatever
> > reason you can fail the offlining.
> 
> We do have one hack in current MM code, which is the memory isolation
> notifier only used by CMM on PPC. It allows to "cheat" has_unmovable_pages()
> to skip over unmovable pages. But quite frankly, I rather want to get rid of
> that crap (something I am working on right now) than introduce new users.
> This stuff is racy as hell and for CMM, if memory offlining fails, the
> ballooned pages are suddenly part of the buddy. Fragile.

Could you be more specific please?

> > An advantage is that the driver has the full control over offlining and
> > also you do not really have to track a new online request to do the
> > right thing.
> 
> The driver still has to synchronize against onlining/offlining requests and
> track the state of the memory blocks.
> 
> Simple example: virtio-mem wants to try yo unplug a 4MB chunk. If the memory
> block is online, it has to use alloc contig_range(). If the memory block is
> offline (e.g., user space has not onlined it yet), it is sufficient to
> update metadata. It has to be aware of the state of the memory blocks and
> synchronize against onlining/offlining.

Hmm, so the driver might offline a part of the memory which never got
onlined? Is there really a sensible usecases for that?
-- 
Michal Hocko
SUSE Labs
