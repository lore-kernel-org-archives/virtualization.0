From: Michal Hocko <mhocko@kernel.org>
Subject: Re: [PATCH v1 04/11] mm: Export alloc_contig_range() /
 free_contig_range()
Date: Mon, 2 Mar 2020 15:05:19 +0100
Message-ID: <20200302140519.GN4380@dhcp22.suse.cz>
References: <20200302134941.315212-1-david@redhat.com>
 <20200302134941.315212-5-david@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20200302134941.315212-5-david@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
To: David Hildenbrand <david@redhat.com>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org, virtio-dev@lists.oasis-open.org, virtualization@lists.linux-foundation.org, kvm@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>, "Michael S . Tsirkin" <mst@redhat.com>, Vlastimil Babka <vbabka@suse.cz>, Oscar Salvador <osalvador@suse.de>, Mel Gorman <mgorman@techsingularity.net>, Mike Rapoport <rppt@linux.ibm.com>, Dan Williams <dan.j.williams@intel.com>, Alexander Duyck <alexander.h.duyck@linux.intel.com>, Pavel Tatashin <pavel.tatashin@microsoft.com>, Alexander Potapenko <glider@google.com>
List-Id: virtualization@lists.linuxfoundation.org

On Mon 02-03-20 14:49:34, David Hildenbrand wrote:
> A virtio-mem device wants to allocate memory from the memory region it
> manages in order to unplug it in the hypervisor - similar to
> a balloon driver. Also, it might want to plug previously unplugged
> (allocated) memory and give it back to Linux. alloc_contig_range() /
> free_contig_range() seem to be the perfect interface for this task.
> 
> In contrast to existing balloon devices, a virtio-mem device operates
> on bigger chunks (e.g., 4MB) and only on physical memory it manages. It
> tracks which chunks (subblocks) are still plugged, so it can go ahead
> and try to alloc_contig_range()+unplug them on unplug request, or
> plug+free_contig_range() unplugged chunks on plug requests.
> 
> A virtio-mem device will use alloc_contig_range() / free_contig_range()
> only on ranges that belong to the same node/zone in at least
> MAX(MAX_ORDER - 1, pageblock_order) order granularity - e.g., 4MB on
> x86-64. The virtio-mem device added that memory, so the memory
> exists and does not contain any holes. virtio-mem will only try to allocate
> on ZONE_NORMAL, never on ZONE_MOVABLE, just like when allocating
> gigantic pages (we don't put unmovable data into the movable zone).

Same feedback as in pxm_to_node export. No objections to exporting the
symbol but it would be better to squash this function into the patch
which uses it. The changelog is highly virtio-mem specific anyway.
Maybe it is just a dejavu but I feel I have already said that but I do
not remember any details.

> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Michal Hocko <mhocko@suse.com>
> Cc: Vlastimil Babka <vbabka@suse.cz>
> Cc: Oscar Salvador <osalvador@suse.de>
> Cc: Mel Gorman <mgorman@techsingularity.net>
> Cc: Mike Rapoport <rppt@linux.ibm.com>
> Cc: Dan Williams <dan.j.williams@intel.com>
> Cc: Alexander Duyck <alexander.h.duyck@linux.intel.com>
> Cc: Pavel Tatashin <pavel.tatashin@microsoft.com>
> Cc: Alexander Potapenko <glider@google.com>
> Acked-by: Michal Hocko <mhocko@suse.com> # to export contig range allocator API
> Signed-off-by: David Hildenbrand <david@redhat.com>
> ---
>  mm/page_alloc.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> index 79e950d76ffc..8d7be3f33e26 100644
> --- a/mm/page_alloc.c
> +++ b/mm/page_alloc.c
> @@ -8597,6 +8597,7 @@ int alloc_contig_range(unsigned long start, unsigned long end,
>  				pfn_max_align_up(end), migratetype);
>  	return ret;
>  }
> +EXPORT_SYMBOL(alloc_contig_range);
>  
>  static int __alloc_contig_pages(unsigned long start_pfn,
>  				unsigned long nr_pages, gfp_t gfp_mask)
> @@ -8712,6 +8713,7 @@ void free_contig_range(unsigned long pfn, unsigned int nr_pages)
>  	}
>  	WARN(count != 0, "%d pages are still in use!\n", count);
>  }
> +EXPORT_SYMBOL(free_contig_range);
>  
>  /*
>   * The zone indicated has a new number of managed_pages; batch sizes and percpu
> -- 
> 2.24.1

-- 
Michal Hocko
SUSE Labs
