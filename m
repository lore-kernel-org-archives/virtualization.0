From: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Subject: Re: [PATCH v1 1/3] virtio-balloon: replace the coarse-grained
	balloon_lock
Date: Sun, 22 Oct 2017 14:20:34 +0900
Message-ID: <201710221420.FHG17654.OOMFQSFJVFHLtO__39748.8946481191$1508649682$gmane$org@I-love.SAKURA.ne.jp>
References: <1508500466-21165-1-git-send-email-wei.w.wang@intel.com>
	<1508500466-21165-2-git-send-email-wei.w.wang@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1508500466-21165-2-git-send-email-wei.w.wang@intel.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: wei.w.wang@intel.com, mst@redhat.com
Cc: linux-mm@kvack.org, virtualization@lists.linux-foundation.org, linux-kernel@vger.kernel.org, mhocko@kernel.org
List-Id: virtualization@lists.linuxfoundation.org

Wei Wang wrote:
> The balloon_lock was used to synchronize the access demand to elements
> of struct virtio_balloon and its queue operations (please see commit
> e22504296d). This prevents the concurrent run of the leak_balloon and
> fill_balloon functions, thereby resulting in a deadlock issue on OOM:
> 
> fill_balloon: take balloon_lock and wait for OOM to get some memory;
> oom_notify: release some inflated memory via leak_balloon();
> leak_balloon: wait for balloon_lock to be released by fill_balloon.
> 
> This patch breaks the lock into two fine-grained inflate_lock and
> deflate_lock, and eliminates the unnecessary use of the shared data
> (i.e. vb->pnfs, vb->num_pfns). This enables leak_balloon and
> fill_balloon to run concurrently and solves the deadlock issue.
> 

> @@ -162,20 +160,20 @@ static unsigned fill_balloon(struct virtio_balloon *vb, size_t num)
>  			msleep(200);
>  			break;
>  		}
> -		set_page_pfns(vb, vb->pfns + vb->num_pfns, page);
> -		vb->num_pages += VIRTIO_BALLOON_PAGES_PER_PAGE;
> +		set_page_pfns(vb, pfns + num_pfns, page);
>  		if (!virtio_has_feature(vb->vdev,
>  					VIRTIO_BALLOON_F_DEFLATE_ON_OOM))
>  			adjust_managed_page_count(page, -1);
>  	}
>  
> -	num_allocated_pages = vb->num_pfns;
> +	mutex_lock(&vb->inflate_lock);
>  	/* Did we get any? */
> -	if (vb->num_pfns != 0)
> -		tell_host(vb, vb->inflate_vq);
> -	mutex_unlock(&vb->balloon_lock);
> +	if (num_pfns != 0)
> +		tell_host(vb, vb->inflate_vq, pfns, num_pfns);
> +	mutex_unlock(&vb->inflate_lock);
> +	atomic64_add(num_pfns, &vb->num_pages);

Isn't this addition too late? If leak_balloon() is called due to
out_of_memory(), it will fail to find up to dated vb->num_pages value.

>  
> -	return num_allocated_pages;
> +	return num_pfns;
>  }
>  
>  static void release_pages_balloon(struct virtio_balloon *vb,
> @@ -194,38 +192,39 @@ static void release_pages_balloon(struct virtio_balloon *vb,
>  
>  static unsigned leak_balloon(struct virtio_balloon *vb, size_t num)
>  {
> -	unsigned num_freed_pages;
>  	struct page *page;
>  	struct balloon_dev_info *vb_dev_info = &vb->vb_dev_info;
>  	LIST_HEAD(pages);
> +	unsigned int num_pfns;
> +	__virtio32 pfns[VIRTIO_BALLOON_ARRAY_PFNS_MAX];

This array consumes 1024 bytes of kernel stack, doesn't it?
leak_balloon() might be called from out_of_memory() where kernel stack
is already largely consumed before entering __alloc_pages_nodemask().
For reducing possibility of stack overflow, since out_of_memory() is
serialized by oom_lock, I suggest using static (maybe kmalloc()ed as
vb->oom_pfns[VIRTIO_BALLOON_ARRAY_PFNS_MAX]) buffer when called from
out_of_memory().

>  
>  	/* We can only do one array worth at a time. */
> -	num = min(num, ARRAY_SIZE(vb->pfns));
> +	num = min_t(size_t, num, VIRTIO_BALLOON_ARRAY_PFNS_MAX);
>  
> -	mutex_lock(&vb->balloon_lock);
>  	/* We can't release more pages than taken */
> -	num = min(num, (size_t)vb->num_pages);
> -	for (vb->num_pfns = 0; vb->num_pfns < num;
> -	     vb->num_pfns += VIRTIO_BALLOON_PAGES_PER_PAGE) {
> +	num = min_t(size_t, num, atomic64_read(&vb->num_pages));
> +	for (num_pfns = 0; num_pfns < num;
> +	     num_pfns += VIRTIO_BALLOON_PAGES_PER_PAGE) {
>  		page = balloon_page_dequeue(vb_dev_info);

If balloon_page_dequeue() can be concurrently called by both host's request
and guest's OOM event, is (!dequeued_page) test in balloon_page_dequeue() safe?
Is such concurrency needed?

>  		if (!page)
>  			break;
> -		set_page_pfns(vb, vb->pfns + vb->num_pfns, page);
> +		set_page_pfns(vb, pfns + num_pfns, page);
>  		list_add(&page->lru, &pages);
> -		vb->num_pages -= VIRTIO_BALLOON_PAGES_PER_PAGE;
>  	}
>  
> -	num_freed_pages = vb->num_pfns;
>  	/*
>  	 * Note that if
>  	 * virtio_has_feature(vdev, VIRTIO_BALLOON_F_MUST_TELL_HOST);
>  	 * is true, we *have* to do it in this order
>  	 */
> -	if (vb->num_pfns != 0)
> -		tell_host(vb, vb->deflate_vq);
> +	mutex_lock(&vb->deflate_lock);
> +	if (num_pfns != 0)
> +		tell_host(vb, vb->deflate_vq, pfns, num_pfns);
> +	mutex_unlock(&vb->deflate_lock);
>  	release_pages_balloon(vb, &pages);
> -	mutex_unlock(&vb->balloon_lock);
> -	return num_freed_pages;
> +	atomic64_sub(num_pfns, &vb->num_pages);

Isn't this subtraction too late?

> +
> +	return num_pfns;
>  }
>  
>  static inline void update_stat(struct virtio_balloon *vb, int idx,

> @@ -465,6 +464,7 @@ static int virtballoon_migratepage(struct balloon_dev_info *vb_dev_info,
>  	struct virtio_balloon *vb = container_of(vb_dev_info,
>  			struct virtio_balloon, vb_dev_info);
>  	unsigned long flags;
> +	__virtio32 pfns[VIRTIO_BALLOON_PAGES_PER_PAGE];

If this is called from memory allocation path, maybe kmalloc()ed buffer is safer.
