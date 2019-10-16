From: Michal Hocko <mhocko@kernel.org>
Subject: Re: [PATCH RFC v3 6/9] mm: Allow to offline PageOffline() pages with
	a reference count of 0
Date: Wed, 16 Oct 2019 13:43:21 +0200
Message-ID: <20191016114321.GX317__19106.2642306619$1571226216$gmane$org@dhcp22.suse.cz>
References: <20190919142228.5483-1-david@redhat.com>
	<20190919142228.5483-7-david@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20190919142228.5483-7-david@redhat.com>
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

On Thu 19-09-19 16:22:25, David Hildenbrand wrote:
> virtio-mem wants to allow to offline memory blocks of which some parts
> were unplugged, especially, to later offline and remove completely
> unplugged memory blocks. The important part is that PageOffline() has
> to remain set until the section is offline, so these pages will never
> get accessed (e.g., when dumping). The pages should not be handed
> back to the buddy (which would require clearing PageOffline() and
> result in issues if offlining fails and the pages are suddenly in the
> buddy).
> 
> Let's use "PageOffline() + reference count = 0" as a sign to
> memory offlining code that these pages can simply be skipped when
> offlining, similar to free or HWPoison pages.
> 
> Pass flags to test_pages_isolated(), similar as already done for
> has_unmovable_pages(). Use a new flag to indicate the
> requirement of memory offlining to skip over these special pages.
> 
> In has_unmovable_pages(), make sure the pages won't be detected as
> movable. This is not strictly necessary, however makes e.g.,
> alloc_contig_range() stop early, trying to isolate such page blocks -
> compared to failing later when testing if all pages were isolated.
> 
> Also, make sure that when a reference to a PageOffline() page is
> dropped, that the page will not be returned to the buddy.
> 
> memory devices (like virtio-mem) that want to make use of this
> functionality have to make sure to synchronize against memory offlining,
> using the memory hotplug notifier.
> 
> Alternative: Allow to offline with a reference count of 1
> and use some other sign in the struct page that offlining is permitted.

Few questions. I do not see onlining code to take care of this special
case. What should happen when offline && online?
Should we allow to try_remove_memory to succeed with these pages?
Do we really have hook into __put_page? Why do we even care about the
reference count of those pages? Wouldn't it be just more consistent to
elevate the reference count (I guess this is what you suggest in the
last paragraph) and the virtio driver would return that page to the
buddy by regular put_page. This is also related to the above question
about the physical memory remove.

[...]
> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> index d5d7944954b3..fef74720d8b4 100644
> --- a/mm/page_alloc.c
> +++ b/mm/page_alloc.c
> @@ -8221,6 +8221,15 @@ bool has_unmovable_pages(struct zone *zone, struct page *page, int count,
>  		if (!page_ref_count(page)) {
>  			if (PageBuddy(page))
>  				iter += (1 << page_order(page)) - 1;
> +			/*
> +			* Memory devices allow to offline a page if it is
> +			* marked PG_offline and has a reference count of 0.
> +			* However, the pages are not movable as it would be
> +			* required e.g., for alloc_contig_range().
> +			*/
> +			if (PageOffline(page) && !(flags & SKIP_OFFLINE))
> +				if (++found > count)
> +					goto unmovable;
>  			continue;
>  		}

Do we really need to distinguish offline and hwpoison pages? They are
both unmovable for allocator purposes and offlineable for the hotplug,
right? Should we just hide them behind a helper and use it rather than
an explicit SKIP_$FOO?
-- 
Michal Hocko
SUSE Labs
