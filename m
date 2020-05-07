From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH v3 07/15] mm/memory_hotplug: Introduce
 offline_and_remove_memory()
Date: Thu, 7 May 2020 06:46:46 -0400
Message-ID: <20200507064558-mutt-send-email-mst@kernel.org>
References: <20200507103119.11219-1-david@redhat.com>
 <20200507103119.11219-8-david@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <kvm-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20200507103119.11219-8-david@redhat.com>
Sender: kvm-owner@vger.kernel.org
To: David Hildenbrand <david@redhat.com>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org, virtio-dev@lists.oasis-open.org, virtualization@lists.linux-foundation.org, kvm@vger.kernel.org, Michal Hocko <mhocko@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, Michal Hocko <mhocko@suse.com>, Pankaj Gupta <pankaj.gupta.linux@gmail.com>, Oscar Salvador <osalvador@suse.com>, Pavel Tatashin <pasha.tatashin@soleen.com>, Wei Yang <richard.weiyang@gmail.com>, Dan Williams <dan.j.williams@intel.com>, Qian Cai <cai@lca.pw>
List-Id: virtualization@lists.linuxfoundation.org

On Thu, May 07, 2020 at 12:31:11PM +0200, David Hildenbrand wrote:
> virtio-mem wants to offline and remove a memory block once it unplugged
> all subblocks (e.g., using alloc_contig_range()). Let's provide
> an interface to do that from a driver. virtio-mem already supports to
> offline partially unplugged memory blocks. Offlining a fully unplugged
> memory block will not require to migrate any pages. All unplugged
> subblocks are PageOffline() and have a reference count of 0 - so
> offlining code will simply skip them.
> 
> All we need is an interface to offline and remove the memory from kernel
> module context, where we don't have access to the memory block devices
> (esp. find_memory_block() and device_offline()) and the device hotplug
> lock.
> 
> To keep things simple, allow to only work on a single memory block.
> 
> Acked-by: Michal Hocko <mhocko@suse.com>
> Tested-by: Pankaj Gupta <pankaj.gupta.linux@gmail.com>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: David Hildenbrand <david@redhat.com>
> Cc: Oscar Salvador <osalvador@suse.com>
> Cc: Michal Hocko <mhocko@suse.com>
> Cc: Pavel Tatashin <pasha.tatashin@soleen.com>
> Cc: Wei Yang <richard.weiyang@gmail.com>
> Cc: Dan Williams <dan.j.williams@intel.com>
> Cc: Qian Cai <cai@lca.pw>
> Signed-off-by: David Hildenbrand <david@redhat.com>


didn't you lose Andrew Morton's ack here?

> ---
>  include/linux/memory_hotplug.h |  1 +
>  mm/memory_hotplug.c            | 37 ++++++++++++++++++++++++++++++++++
>  2 files changed, 38 insertions(+)

I get:

error: sha1 information is lacking or useless (mm/memory_hotplug.c).
error: could not build fake ancestor

which version is this against? Pls post patches on top of some tag
in Linus' tree if possible.


> diff --git a/include/linux/memory_hotplug.h b/include/linux/memory_hotplug.h
> index 7dca9cd6076b..d641828e5596 100644
> --- a/include/linux/memory_hotplug.h
> +++ b/include/linux/memory_hotplug.h
> @@ -318,6 +318,7 @@ extern void try_offline_node(int nid);
>  extern int offline_pages(unsigned long start_pfn, unsigned long nr_pages);
>  extern int remove_memory(int nid, u64 start, u64 size);
>  extern void __remove_memory(int nid, u64 start, u64 size);
> +extern int offline_and_remove_memory(int nid, u64 start, u64 size);
>  
>  #else
>  static inline void try_offline_node(int nid) {}
> diff --git a/mm/memory_hotplug.c b/mm/memory_hotplug.c
> index 936bfe208a6e..bf1941f02a60 100644
> --- a/mm/memory_hotplug.c
> +++ b/mm/memory_hotplug.c
> @@ -1748,4 +1748,41 @@ int remove_memory(int nid, u64 start, u64 size)
>  	return rc;
>  }
>  EXPORT_SYMBOL_GPL(remove_memory);
> +
> +/*
> + * Try to offline and remove a memory block. Might take a long time to
> + * finish in case memory is still in use. Primarily useful for memory devices
> + * that logically unplugged all memory (so it's no longer in use) and want to
> + * offline + remove the memory block.
> + */
> +int offline_and_remove_memory(int nid, u64 start, u64 size)
> +{
> +	struct memory_block *mem;
> +	int rc = -EINVAL;
> +
> +	if (!IS_ALIGNED(start, memory_block_size_bytes()) ||
> +	    size != memory_block_size_bytes())
> +		return rc;
> +
> +	lock_device_hotplug();
> +	mem = find_memory_block(__pfn_to_section(PFN_DOWN(start)));
> +	if (mem)
> +		rc = device_offline(&mem->dev);
> +	/* Ignore if the device is already offline. */
> +	if (rc > 0)
> +		rc = 0;
> +
> +	/*
> +	 * In case we succeeded to offline the memory block, remove it.
> +	 * This cannot fail as it cannot get onlined in the meantime.
> +	 */
> +	if (!rc) {
> +		rc = try_remove_memory(nid, start, size);
> +		WARN_ON_ONCE(rc);
> +	}
> +	unlock_device_hotplug();
> +
> +	return rc;
> +}
> +EXPORT_SYMBOL_GPL(offline_and_remove_memory);
>  #endif /* CONFIG_MEMORY_HOTREMOVE */
> -- 
> 2.25.3
