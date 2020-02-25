From: Michal Hocko <mhocko@kernel.org>
Subject: Re: [PATCH RFC v4 11/13] mm/vmscan: Move count_vm_event(DROP_SLAB)
 into drop_slab()
Date: Tue, 25 Feb 2020 15:13:39 +0100
Message-ID: <20200225141339.GV22443@dhcp22.suse.cz>
References: <20191212171137.13872-1-david@redhat.com>
 <20191212171137.13872-12-david@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20191212171137.13872-12-david@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
To: David Hildenbrand <david@redhat.com>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org, virtio-dev@lists.oasis-open.org, virtualization@lists.linux-foundation.org, kvm@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>, "Michael S . Tsirkin" <mst@redhat.com>, Alexander Viro <viro@zeniv.linux.org.uk>, linux-fsdevel@vger.kernel.org
List-Id: virtualization@lists.linuxfoundation.org

On Thu 12-12-19 18:11:35, David Hildenbrand wrote:
> Let's count within the function itself, so every invocation (of future
> users) will be counted.
> 
> Cc: Alexander Viro <viro@zeniv.linux.org.uk>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: linux-fsdevel@vger.kernel.org
> Signed-off-by: David Hildenbrand <david@redhat.com>

Slight inconsistency with the page cache droppint but nothing earth
shattering.

Acked-by: Michal Hocko <mhocko@suse.com>

> ---
>  fs/drop_caches.c | 4 +---
>  mm/vmscan.c      | 1 +
>  2 files changed, 2 insertions(+), 3 deletions(-)
> 
> diff --git a/fs/drop_caches.c b/fs/drop_caches.c
> index d31b6c72b476..a042da782fcd 100644
> --- a/fs/drop_caches.c
> +++ b/fs/drop_caches.c
> @@ -61,10 +61,8 @@ int drop_caches_sysctl_handler(struct ctl_table *table, int write,
>  			iterate_supers(drop_pagecache_sb, NULL);
>  			count_vm_event(DROP_PAGECACHE);
>  		}
> -		if (sysctl_drop_caches & 2) {
> +		if (sysctl_drop_caches & 2)
>  			drop_slab();
> -			count_vm_event(DROP_SLAB);
> -		}
>  		if (!stfu) {
>  			pr_info("%s (%d): drop_caches: %d\n",
>  				current->comm, task_pid_nr(current),
> diff --git a/mm/vmscan.c b/mm/vmscan.c
> index 5a6445e86328..c3e53502a84a 100644
> --- a/mm/vmscan.c
> +++ b/mm/vmscan.c
> @@ -726,6 +726,7 @@ void drop_slab(void)
>  
>  	for_each_online_node(nid)
>  		drop_slab_node(nid);
> +	count_vm_event(DROP_SLAB);
>  }
>  
>  static inline int is_page_cache_freeable(struct page *page)
> -- 
> 2.23.0

-- 
Michal Hocko
SUSE Labs
