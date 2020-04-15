From: Pankaj Gupta <pankaj.gupta.linux@gmail.com>
Subject: Re: [PATCH v2 07/10] mm/memory_hotplug: Introduce offline_and_remove_memory()
Date: Wed, 15 Apr 2020 09:35:36 +0200
Message-ID: <CAM9Jb+iz+meQ-fR+ZAHNeNFefTcoujCgEaSHLO6SJ6C6eTLLXg@mail.gmail.com>
References: <20200311171422.10484-1-david@redhat.com> <20200311171422.10484-8-david@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <20200311171422.10484-8-david@redhat.com>
Sender: kvm-owner@vger.kernel.org
To: David Hildenbrand <david@redhat.com>
Cc: LKML <linux-kernel@vger.kernel.org>, Linux MM <linux-mm@kvack.org>, virtio-dev@lists.oasis-open.org, virtualization@lists.linux-foundation.org, kvm@vger.kernel.org, Michal Hocko <mhocko@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, "Michael S . Tsirkin" <mst@redhat.com>, Oscar Salvador <osalvador@suse.com>, Michal Hocko <mhocko@suse.com>, Pavel Tatashin <pasha.tatashin@soleen.com>, Wei Yang <richard.weiyang@gmail.com>, Dan Williams <dan.j.williams@intel.com>, Qian Cai <cai@lca.pw>
List-Id: virtualization@lists.linuxfoundation.org

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
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: David Hildenbrand <david@redhat.com>
> Cc: Oscar Salvador <osalvador@suse.com>
> Cc: Michal Hocko <mhocko@suse.com>
> Cc: Pavel Tatashin <pasha.tatashin@soleen.com>
> Cc: Wei Yang <richard.weiyang@gmail.com>
> Cc: Dan Williams <dan.j.williams@intel.com>
> Cc: Qian Cai <cai@lca.pw>
> Signed-off-by: David Hildenbrand <david@redhat.com>
> ---
>  include/linux/memory_hotplug.h |  1 +
>  mm/memory_hotplug.c            | 37 ++++++++++++++++++++++++++++++++++
>  2 files changed, 38 insertions(+)
>
> diff --git a/include/linux/memory_hotplug.h b/include/linux/memory_hotplug.h
> index f4d59155f3d4..a98aa16dbfa1 100644
> --- a/include/linux/memory_hotplug.h
> +++ b/include/linux/memory_hotplug.h
> @@ -311,6 +311,7 @@ extern void try_offline_node(int nid);
>  extern int offline_pages(unsigned long start_pfn, unsigned long nr_pages);
>  extern int remove_memory(int nid, u64 start, u64 size);
>  extern void __remove_memory(int nid, u64 start, u64 size);
> +extern int offline_and_remove_memory(int nid, u64 start, u64 size);
>
>  #else
>  static inline bool is_mem_section_removable(unsigned long pfn,
> diff --git a/mm/memory_hotplug.c b/mm/memory_hotplug.c
> index ab1c31e67fd1..d0d337918a15 100644
> --- a/mm/memory_hotplug.c
> +++ b/mm/memory_hotplug.c
> @@ -1818,4 +1818,41 @@ int remove_memory(int nid, u64 start, u64 size)
>         return rc;
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
> +       struct memory_block *mem;
> +       int rc = -EINVAL;
> +
> +       if (!IS_ALIGNED(start, memory_block_size_bytes()) ||
> +           size != memory_block_size_bytes())
> +               return rc;
> +
> +       lock_device_hotplug();
> +       mem = find_memory_block(__pfn_to_section(PFN_DOWN(start)));
> +       if (mem)
> +               rc = device_offline(&mem->dev);
> +       /* Ignore if the device is already offline. */
> +       if (rc > 0)
> +               rc = 0;
> +
> +       /*
> +        * In case we succeeded to offline the memory block, remove it.
> +        * This cannot fail as it cannot get onlined in the meantime.
> +        */
> +       if (!rc) {
> +               rc = try_remove_memory(nid, start, size);
> +               WARN_ON_ONCE(rc);
> +       }
> +       unlock_device_hotplug();
> +
> +       return rc;
> +}
> +EXPORT_SYMBOL_GPL(offline_and_remove_memory);
>  #endif /* CONFIG_MEMORY_HOTREMOVE */

Acked-by: Pankaj Gupta <pankaj.gupta.linux@gmail.com>
