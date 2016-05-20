From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH RFC kernel] balloon: speed up inflating/deflating process
Date: Fri, 20 May 2016 15:00:38 +0300
Message-ID: <20160520120038.GA28757__21917.6076273017$1463745714$gmane$org@redhat.com>
References: <1463738386-30868-1-git-send-email-liang.z.li@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <1463738386-30868-1-git-send-email-liang.z.li@intel.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Liang Li <liang.z.li@intel.com>
Cc: kvm@vger.kernel.org, qemu-devel@nongnu.org, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, amit.shah@redhat.com, pbonzini@redhat.com, akpm@linux-foundation.org, dgilbert@redhat.com
List-Id: virtualization@lists.linuxfoundation.org

On Fri, May 20, 2016 at 05:59:46PM +0800, Liang Li wrote:
> The implementation of the current virtio-balloon is not very efficient,
> Bellow is test result of time spends on inflating the balloon to 3GB of
> a 4GB idle guest:
> 
> a. allocating pages (6.5%, 103ms)
> b. sending PFNs to host (68.3%, 787ms)
> c. address translation (6.1%, 96ms)
> d. madvise (19%, 300ms)
> 
> It takes about 1577ms for the whole inflating process to complete. The
> test shows that the bottle neck is the stage b and stage d.
> 
> If using a bitmap to send the page info instead of the PFNs, we can
> reduce the overhead spends on stage b quite a lot. Furthermore, it's
> possible to do the address translation and do the madvise with a bulk
> of pages, instead of the current page per page way, so the overhead of
> stage c and stage d can also be reduced a lot.
> 
> This patch is the kernel side implementation which is intended to speed
> up the inflating & deflating process by adding a new feature to the
> virtio-balloon device. And now, inflating the balloon to 3GB of a 4GB
> idle guest only takes 175ms, it's about 9 times as fast as before.
> 
> TODO: optimize stage a by allocating/freeing a chunk of pages instead
> of a single page at a time.
> 
> Signed-off-by: Liang Li <liang.z.li@intel.com>
> ---
>  drivers/virtio/virtio_balloon.c     | 199 ++++++++++++++++++++++++++++++++++--
>  include/uapi/linux/virtio_balloon.h |   1 +
>  mm/page_alloc.c                     |   6 ++
>  3 files changed, 198 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/virtio/virtio_balloon.c b/drivers/virtio/virtio_balloon.c
> index 7b6d74f..5330b6f 100644
> --- a/drivers/virtio/virtio_balloon.c
> +++ b/drivers/virtio/virtio_balloon.c
> @@ -45,6 +45,8 @@ static int oom_pages = OOM_VBALLOON_DEFAULT_PAGES;
>  module_param(oom_pages, int, S_IRUSR | S_IWUSR);
>  MODULE_PARM_DESC(oom_pages, "pages to free on OOM");
>  
> +extern unsigned long get_max_pfn(void);
> +
>  struct virtio_balloon {
>  	struct virtio_device *vdev;
>  	struct virtqueue *inflate_vq, *deflate_vq, *stats_vq;
> @@ -62,6 +64,9 @@ struct virtio_balloon {
>  
>  	/* Number of balloon pages we've told the Host we're not using. */
>  	unsigned int num_pages;
> +	unsigned long *page_bitmap;
> +	unsigned long start_pfn, end_pfn;
> +	unsigned long bmap_len;
>  	/*
>  	 * The pages we've told the Host we're not using are enqueued
>  	 * at vb_dev_info->pages list.
> @@ -111,15 +116,66 @@ static void balloon_ack(struct virtqueue *vq)
>  	wake_up(&vb->acked);
>  }
>  
> +static int balloon_page_bitmap_init(struct virtio_balloon *vb)
> +{
> +	unsigned long max_pfn, bmap_bytes;
> +
> +	max_pfn = get_max_pfn();

This is racy. max_pfn could be increased by memory hotplug
after you got it.


> +	bmap_bytes = ALIGN(max_pfn, BITS_PER_LONG) / BITS_PER_BYTE;
> +	if (!vb->page_bitmap)
> +		vb->page_bitmap = kzalloc(bmap_bytes, GFP_KERNEL);

Likely to fail for a huge busy guest.
Why not init on device probe?
this way
	- probe will fail, or we can clear the feature bit
	- free memory is more likely to be available


> +	else {
> +		if (bmap_bytes <= vb->bmap_len)
> +			memset(vb->page_bitmap, 0, bmap_bytes);
> +		else {
> +			kfree(vb->page_bitmap);
> +			vb->page_bitmap = kzalloc(bmap_bytes, GFP_KERNEL);
> +		}
> +	}
> +	if (!vb->page_bitmap) {
> +		dev_err(&vb->vdev->dev, "%s failure: allocate page bitmap\n",
> +			 __func__);
> +		return -ENOMEM;
> +	}
> +	vb->bmap_len = bmap_bytes;
> +	vb->start_pfn = max_pfn;
> +	vb->end_pfn = 0;
> +
> +	return 0;
> +}
> +

>  {
> -	struct scatterlist sg;
>  	unsigned int len;
>  
> -	sg_init_one(&sg, vb->pfns, sizeof(vb->pfns[0]) * vb->num_pfns);
> +	if (virtio_has_feature(vb->vdev, VIRTIO_BALLOON_F_PAGE_BITMAP)) {
> +		u32 page_shift = PAGE_SHIFT;
> +		unsigned long start_pfn, end_pfn, flags = 0, bmap_len;
> +		struct scatterlist sg[5];
> +
> +		start_pfn = rounddown(vb->start_pfn, BITS_PER_LONG);
> +		end_pfn = roundup(vb->end_pfn, BITS_PER_LONG);
> +		bmap_len = (end_pfn - start_pfn) / BITS_PER_LONG * sizeof(long);
> +
> +		sg_init_table(sg, 5);
> +		sg_set_buf(&sg[0], &flags, sizeof(flags));
> +		sg_set_buf(&sg[1], &start_pfn, sizeof(start_pfn));
> +		sg_set_buf(&sg[2], &page_shift, sizeof(page_shift));
> +		sg_set_buf(&sg[3], &bmap_len, sizeof(bmap_len));
> +		sg_set_buf(&sg[4], vb->page_bitmap +
> +				 (start_pfn / BITS_PER_LONG), bmap_len);

This can be pre-initialized, correct?

> +		virtqueue_add_outbuf(vq, sg, 5, vb, GFP_KERNEL);
> +
> +	} else {
> +		struct scatterlist sg;
> +
> +		sg_init_one(&sg, vb->pfns, sizeof(vb->pfns[0]) * vb->num_pfns);
> +		/* We should always be able to add one buffer to an
> +		* empty queue.
> +		*/
> +		virtqueue_add_outbuf(vq, &sg, 1, vb, GFP_KERNEL);
> +	}
>  
> -	/* We should always be able to add one buffer to an empty queue. */
> -	virtqueue_add_outbuf(vq, &sg, 1, vb, GFP_KERNEL);
>  	virtqueue_kick(vq);
>  
>  	/* When host has read buffer, this completes via balloon_ack */
> @@ -137,7 +193,21 @@ static void set_page_pfns(u32 pfns[], struct page *page)
>  		pfns[i] = page_to_balloon_pfn(page) + i;
>  }
>  
> -static unsigned fill_balloon(struct virtio_balloon *vb, size_t num)
> +static void set_page_bitmap(struct virtio_balloon *vb, struct page *page)
> +{
> +	unsigned int i;
> +	unsigned long *bitmap = vb->page_bitmap;
> +	unsigned long balloon_pfn = page_to_balloon_pfn(page);
> +
> +	for (i = 0; i < VIRTIO_BALLOON_PAGES_PER_PAGE; i++)
> +		set_bit(balloon_pfn + i, bitmap);
> +	if (balloon_pfn < vb->start_pfn)
> +		vb->start_pfn = balloon_pfn;
> +	if (balloon_pfn > vb->end_pfn)
> +		vb->end_pfn = balloon_pfn;
> +}
> +
> +static unsigned fill_balloon_pfns(struct virtio_balloon *vb, size_t num)
>  {
>  	struct balloon_dev_info *vb_dev_info = &vb->vb_dev_info;
>  	unsigned num_allocated_pages;
> @@ -174,7 +244,104 @@ static unsigned fill_balloon(struct virtio_balloon *vb, size_t num)
>  	return num_allocated_pages;
>  }
>  
> -static void release_pages_balloon(struct virtio_balloon *vb)
> +static long fill_balloon_bitmap(struct virtio_balloon *vb, size_t num)
> +{
> +	struct balloon_dev_info *vb_dev_info = &vb->vb_dev_info;
> +	long num_allocated_pages = 0;
> +
> +	if (balloon_page_bitmap_init(vb) < 0)
> +		return num;
> +
> +	mutex_lock(&vb->balloon_lock);
> +	for (vb->num_pfns = 0; vb->num_pfns < num;
> +	     vb->num_pfns += VIRTIO_BALLOON_PAGES_PER_PAGE) {
> +		struct page *page = balloon_page_enqueue(vb_dev_info);
> +
> +		if (!page) {
> +			dev_info_ratelimited(&vb->vdev->dev,
> +					     "Out of puff! Can't get %u pages\n",
> +					     VIRTIO_BALLOON_PAGES_PER_PAGE);
> +			/* Sleep for at least 1/5 of a second before retry. */
> +			msleep(200);
> +			break;
> +		}
> +		set_page_bitmap(vb, page);
> +		vb->num_pages += VIRTIO_BALLOON_PAGES_PER_PAGE;
> +		if (!virtio_has_feature(vb->vdev,
> +					VIRTIO_BALLOON_F_DEFLATE_ON_OOM))
> +			adjust_managed_page_count(page, -1);
> +	}

This is grossly inefficient if you only requested a single page.
And it's also allocating memory very aggressively without ever telling
the host what is going on.
> +
> +	num_allocated_pages = vb->num_pfns;
> +	/* Did we get any? */
> +	if (vb->num_pfns != 0)
> +		tell_host(vb, vb->inflate_vq);
> +	mutex_unlock(&vb->balloon_lock);
> +
> +	return num_allocated_pages;
> +}
> +
> +static long fill_balloon(struct virtio_balloon *vb, size_t num)
> +{
> +	long num_allocated_pages;
> +
> +	if (virtio_has_feature(vb->vdev, VIRTIO_BALLOON_F_PAGE_BITMAP))
> +		num_allocated_pages = fill_balloon_bitmap(vb, num);
> +	else
> +		num_allocated_pages = fill_balloon_pfns(vb, num);
> +
> +	return num_allocated_pages;
> +}
> +
> +static void release_pages_balloon_bitmap(struct virtio_balloon *vb)
> +{
> +	unsigned long pfn, offset, size;
> +	struct page *page;
> +
> +	size = min(vb->bmap_len * BITS_PER_BYTE, vb->end_pfn);
> +	for (offset = vb->start_pfn; offset < size;
> +		 offset = pfn + VIRTIO_BALLOON_PAGES_PER_PAGE) {
> +		pfn = find_next_bit(vb->page_bitmap, size, offset);
> +		if (pfn < size) {
> +			page = balloon_pfn_to_page(pfn);
> +			if (!virtio_has_feature(vb->vdev,
> +					VIRTIO_BALLOON_F_DEFLATE_ON_OOM))
> +				adjust_managed_page_count(page, 1);
> +			put_page(page);
> +		}
> +	}
> +}
> +
> +static unsigned long leak_balloon_bitmap(struct virtio_balloon *vb, size_t num)
> +{
> +	unsigned long num_freed_pages = num;
> +	struct page *page;
> +	struct balloon_dev_info *vb_dev_info = &vb->vb_dev_info;
> +
> +	if (balloon_page_bitmap_init(vb) < 0)
> +		return num_freed_pages;
> +
> +	mutex_lock(&vb->balloon_lock);
> +	for (vb->num_pfns = 0; vb->num_pfns < num;
> +	     vb->num_pfns += VIRTIO_BALLOON_PAGES_PER_PAGE) {
> +		page = balloon_page_dequeue(vb_dev_info);
> +		if (!page)
> +			break;
> +		set_page_bitmap(vb, page);
> +		vb->num_pages -= VIRTIO_BALLOON_PAGES_PER_PAGE;
> +	}
> +
> +	num_freed_pages = vb->num_pfns;
> +
> +	if (vb->num_pfns != 0)
> +		tell_host(vb, vb->deflate_vq);
> +	release_pages_balloon_bitmap(vb);
> +	mutex_unlock(&vb->balloon_lock);
> +
> +	return num_freed_pages;
> +}
> +
> +static void release_pages_balloon_pfns(struct virtio_balloon *vb)
>  {
>  	unsigned int i;
>  
> @@ -188,7 +355,7 @@ static void release_pages_balloon(struct virtio_balloon *vb)
>  	}
>  }
>  
> -static unsigned leak_balloon(struct virtio_balloon *vb, size_t num)
> +static unsigned leak_balloon_pfns(struct virtio_balloon *vb, size_t num)
>  {
>  	unsigned num_freed_pages;
>  	struct page *page;
> @@ -215,11 +382,23 @@ static unsigned leak_balloon(struct virtio_balloon *vb, size_t num)
>  	 */
>  	if (vb->num_pfns != 0)
>  		tell_host(vb, vb->deflate_vq);
> -	release_pages_balloon(vb);
> +	release_pages_balloon_pfns(vb);
>  	mutex_unlock(&vb->balloon_lock);
>  	return num_freed_pages;
>  }
>  
> +static long leak_balloon(struct virtio_balloon *vb, size_t num)
> +{
> +	long num_freed_pages;
> +
> +	if (virtio_has_feature(vb->vdev, VIRTIO_BALLOON_F_PAGE_BITMAP))
> +		num_freed_pages = leak_balloon_bitmap(vb, num);
> +	else
> +		num_freed_pages = leak_balloon_pfns(vb, num);
> +
> +	return num_freed_pages;
> +}
> +
>  static inline void update_stat(struct virtio_balloon *vb, int idx,
>  			       u16 tag, u64 val)
>  {
> @@ -510,6 +689,8 @@ static int virtballoon_probe(struct virtio_device *vdev)
>  	spin_lock_init(&vb->stop_update_lock);
>  	vb->stop_update = false;
>  	vb->num_pages = 0;
> +	vb->page_bitmap = NULL;
> +	vb->bmap_len = 0;
>  	mutex_init(&vb->balloon_lock);
>  	init_waitqueue_head(&vb->acked);
>  	vb->vdev = vdev;
> @@ -567,6 +748,7 @@ static void virtballoon_remove(struct virtio_device *vdev)
>  	cancel_work_sync(&vb->update_balloon_stats_work);
>  
>  	remove_common(vb);
> +	kfree(vb->page_bitmap);
>  	kfree(vb);
>  }
>  
> @@ -605,6 +787,7 @@ static unsigned int features[] = {
>  	VIRTIO_BALLOON_F_MUST_TELL_HOST,
>  	VIRTIO_BALLOON_F_STATS_VQ,
>  	VIRTIO_BALLOON_F_DEFLATE_ON_OOM,
> +	VIRTIO_BALLOON_F_PAGE_BITMAP,
>  };
>  
>  static struct virtio_driver virtio_balloon_driver = {
> diff --git a/include/uapi/linux/virtio_balloon.h b/include/uapi/linux/virtio_balloon.h
> index 343d7dd..f78fa47 100644
> --- a/include/uapi/linux/virtio_balloon.h
> +++ b/include/uapi/linux/virtio_balloon.h
> @@ -34,6 +34,7 @@
>  #define VIRTIO_BALLOON_F_MUST_TELL_HOST	0 /* Tell before reclaiming pages */
>  #define VIRTIO_BALLOON_F_STATS_VQ	1 /* Memory Stats virtqueue */
>  #define VIRTIO_BALLOON_F_DEFLATE_ON_OOM	2 /* Deflate balloon on OOM */
> +#define VIRTIO_BALLOON_F_PAGE_BITMAP	3 /* Send page info with bitmap */
>  
>  /* Size of a PFN in the balloon interface. */
>  #define VIRTIO_BALLOON_PFN_SHIFT 12
> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> index c1069ef..74b2fc5 100644
> --- a/mm/page_alloc.c
> +++ b/mm/page_alloc.c
> @@ -2139,6 +2139,12 @@ void drain_all_pages(struct zone *zone)
>  								zone, 1);
>  }
>  
> +unsigned long get_max_pfn(void)
> +{
> +	return max_pfn;
> +}
> +EXPORT_SYMBOL(get_max_pfn);
> +
>  #ifdef CONFIG_HIBERNATION
>  
>  void mark_free_pages(struct zone *zone)

Suggestion to address all above comments:
	1. allocate a bunch of pages and link them up,
	   calculating the min and the max pfn.
	   if max-min exceeds the allocated bitmap size,
	   tell host.
	2. limit allocated bitmap size to something reasonable.
	   How about 32Kbytes? This is 256kilo bit in the map, which comes
	   out to 1Giga bytes of memory in the balloon.
> -- 
> 1.9.1
