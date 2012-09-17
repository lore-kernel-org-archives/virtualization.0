From: Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH v10 3/5] virtio_balloon: introduce migration primitives
	to balloon pages
Date: Mon, 17 Sep 2012 15:15:52 -0700
Message-ID: <20120917151552.ffbb9293.akpm@linux-foundation.org>
References: <cover.1347897793.git.aquini@redhat.com>
	<39738cbd4b596714210e453440833db7cca73172.1347897793.git.aquini@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <39738cbd4b596714210e453440833db7cca73172.1347897793.git.aquini@redhat.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Rafael Aquini <aquini@redhat.com>
Cc: Rik van Riel <riel@redhat.com>, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, "Michael S. Tsirkin" <mst@redhat.com>, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, linux-mm@kvack.org, Peter Zijlstra <peterz@infradead.org>, Andi Kleen <andi@firstfloor.org>, Minchan Kim <minchan@kernel.org>, "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
List-Id: virtualization@lists.linuxfoundation.org

On Mon, 17 Sep 2012 13:38:18 -0300
Rafael Aquini <aquini@redhat.com> wrote:

> Memory fragmentation introduced by ballooning might reduce significantly
> the number of 2MB contiguous memory blocks that can be used within a guest,
> thus imposing performance penalties associated with the reduced number of
> transparent huge pages that could be used by the guest workload.
> 
> Besides making balloon pages movable at allocation time and introducing
> the necessary primitives to perform balloon page migration/compaction,
> this patch also introduces the following locking scheme, in order to
> enhance the syncronization methods for accessing elements of struct
> virtio_balloon, thus providing protection against concurrent access
> introduced by parallel memory compaction threads.
> 
>  - balloon_lock (mutex) : synchronizes the access demand to elements of
>                           struct virtio_balloon and its queue operations;
>  - pages_lock (spinlock): special protection to balloon's pages bookmarking
>                           elements (list and atomic counters) against the
>                           potential memory compaction concurrency;
> 
>
> ...
>
>  struct virtio_balloon
>  {
> @@ -46,11 +48,24 @@ struct virtio_balloon
>  	/* The thread servicing the balloon. */
>  	struct task_struct *thread;
>  
> +	/* balloon special page->mapping */
> +	struct address_space *mapping;
> +
> +	/* Synchronize access/update to this struct virtio_balloon elements */
> +	struct mutex balloon_lock;
> +
>  	/* Waiting for host to ack the pages we released. */
>  	wait_queue_head_t acked;
>  
> +	/* Protect pages list, and pages bookeeping counters */
> +	spinlock_t pages_lock;
> +
> +	/* Number of balloon pages isolated from 'pages' list for compaction */
> +	unsigned int num_isolated_pages;

Is it utterly inconceivable that this counter could exceed 4G, ever?

>  	/* Number of balloon pages we've told the Host we're not using. */
>  	unsigned int num_pages;
> +
>  	/*
>  	 * The pages we've told the Host we're not using.
>  	 * Each page on this list adds VIRTIO_BALLOON_PAGES_PER_PAGE
> @@ -60,7 +75,7 @@ struct virtio_balloon
>  
>  	/* The array of pfns we tell the Host about. */
>  	unsigned int num_pfns;
> -	u32 pfns[256];
> +	u32 pfns[VIRTIO_BALLOON_ARRAY_PFNS_MAX];
>  
>  	/* Memory statistics */
>  	int need_stats_update;
> @@ -122,13 +137,17 @@ static void set_page_pfns(u32 pfns[], struct page *page)
>  
>  static void fill_balloon(struct virtio_balloon *vb, size_t num)
>  {
> +	/* Get the proper GFP alloc mask from vb->mapping flags */
> +	gfp_t vb_gfp_mask = mapping_gfp_mask(vb->mapping);
> +
>  	/* We can only do one array worth at a time. */
>  	num = min(num, ARRAY_SIZE(vb->pfns));
>  
> +	mutex_lock(&vb->balloon_lock);
>  	for (vb->num_pfns = 0; vb->num_pfns < num;
>  	     vb->num_pfns += VIRTIO_BALLOON_PAGES_PER_PAGE) {
> -		struct page *page = alloc_page(GFP_HIGHUSER | __GFP_NORETRY |
> -					__GFP_NOMEMALLOC | __GFP_NOWARN);
> +		struct page *page = alloc_page(vb_gfp_mask | __GFP_NORETRY |
> +					       __GFP_NOWARN | __GFP_NOMEMALLOC);

That looks like an allocation which could easily fail.

>  		if (!page) {
>  			if (printk_ratelimit())
>  				dev_printk(KERN_INFO, &vb->vdev->dev,

Strangely, we suppressed the core page allocator's warning and
substituted this less useful one.

Also, it would be nice if someone could get that printk_ratelimit() out
of there, for reasons described at the printk_ratelimit() definition
site.

> @@ -139,9 +158,15 @@ static void fill_balloon(struct virtio_balloon *vb, size_t num)
>  			break;
>  		}
>  		set_page_pfns(vb->pfns + vb->num_pfns, page);
> -		vb->num_pages += VIRTIO_BALLOON_PAGES_PER_PAGE;
>  		totalram_pages--;
> +
> +		BUG_ON(!trylock_page(page));
> +		spin_lock(&vb->pages_lock);
>  		list_add(&page->lru, &vb->pages);
> +		assign_balloon_mapping(page, vb->mapping);
> +		vb->num_pages += VIRTIO_BALLOON_PAGES_PER_PAGE;
> +		spin_unlock(&vb->pages_lock);
> +		unlock_page(page);
>  	}
>
> ...
>
