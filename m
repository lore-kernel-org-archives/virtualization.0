From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [RFC for Linux] virtio_balloon: Add VIRTIO_BALLOON_F_THP_ORDER
 to handle THP spilt issue
Date: Thu, 12 Mar 2020 04:18:42 -0400
Message-ID: <20200312035345-mutt-send-email-mst@kernel.org>
References: <1583999395-9131-1-git-send-email-teawater@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1583999395-9131-1-git-send-email-teawater@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Hui Zhu <teawater@gmail.com>
Cc: jasowang@redhat.com, akpm@linux-foundation.org, pagupta@redhat.com, mojha@codeaurora.org, david@redhat.com, namit@vmware.com, virtualization@lists.linux-foundation.org, linux-kernel@vger.kernel.org, qemu-devel@nongnu.org, Hui Zhu <teawaterz@linux.alibaba.com>
List-Id: virtualization@lists.linuxfoundation.org

On Thu, Mar 12, 2020 at 03:49:54PM +0800, Hui Zhu wrote:
> If the guest kernel has many fragmentation pages, use virtio_balloon
> will split THP of QEMU when it calls MADV_DONTNEED madvise to release
> the balloon pages.
> This is an example in a VM with 1G memory 1CPU:
> cat /proc/meminfo | grep AnonHugePages:
> AnonHugePages:         0 kB
> 
> usemem --punch-holes -s -1 800m &
> 
> cat /proc/meminfo | grep AnonHugePages:
> AnonHugePages:    976896 kB
> 
> (qemu) device_add virtio-balloon-pci,id=balloon1
> (qemu) info balloon
> balloon: actual=1024
> (qemu) balloon 624
> (qemu) info balloon
> balloon: actual=624
> 
> cat /proc/meminfo | grep AnonHugePages:
> AnonHugePages:    153600 kB
> 
> THP number decreased more than 800M.
> The reason is usemem with punch-holes option will free every other page
> after allocation.  Then 400M free memory inside the guest kernel is
> fragmentation pages.
> The guest kernel will use them to inflate the balloon.  When these
> fragmentation pages are freed, THP will be split.
> 
> This commit tries to handle this with add a new flag
> VIRTIO_BALLOON_F_THP_ORDER.
> When this flag is set, the balloon page order will be set to the THP order.
> Then THP pages will be freed together in the host.
> This is an example in a VM with 1G memory 1CPU:
> cat /proc/meminfo | grep AnonHugePages:
> AnonHugePages:         0 kB
> 
> usemem --punch-holes -s -1 800m &
> 
> cat /proc/meminfo | grep AnonHugePages:
> AnonHugePages:    976896 kB
> 
> (qemu) device_add virtio-balloon-pci,id=balloon1,thp-order=on
> (qemu) info balloon
> balloon: actual=1024
> (qemu) balloon 624
> (qemu) info balloon
> balloon: actual=624
> 
> cat /proc/meminfo | grep AnonHugePages:
> AnonHugePages:    583680 kB
> 
> The THP number decreases 384M.  This shows that VIRTIO_BALLOON_F_THP_ORDER
> can help handle the THP split issue.
> 
> Signed-off-by: Hui Zhu <teawaterz@linux.alibaba.com>
> ---
>  drivers/virtio/virtio_balloon.c     | 57 ++++++++++++++++++++++++++-----------
>  include/linux/balloon_compaction.h  | 14 ++++++---
>  include/uapi/linux/virtio_balloon.h |  4 +++
>  3 files changed, 54 insertions(+), 21 deletions(-)
> 
> diff --git a/drivers/virtio/virtio_balloon.c b/drivers/virtio/virtio_balloon.c
> index 7bfe365..1e1dc76 100644
> --- a/drivers/virtio/virtio_balloon.c
> +++ b/drivers/virtio/virtio_balloon.c
> @@ -175,18 +175,31 @@ static unsigned fill_balloon(struct virtio_balloon *vb, size_t num)
>  	unsigned num_pfns;
>  	struct page *page;
>  	LIST_HEAD(pages);
> +	int page_order = 0;
>  
>  	/* We can only do one array worth at a time. */
>  	num = min(num, ARRAY_SIZE(vb->pfns));
>  
> +	if (virtio_has_feature(vb->vdev, VIRTIO_BALLOON_F_THP_ORDER))
> +		page_order = VIRTIO_BALLOON_THP_ORDER;
> +
>  	for (num_pfns = 0; num_pfns < num;
>  	     num_pfns += VIRTIO_BALLOON_PAGES_PER_PAGE) {
> -		struct page *page = balloon_page_alloc();
> +		struct page *page;
> +
> +		if (page_order)
> +			page = alloc_pages(__GFP_HIGHMEM |
> +					   __GFP_KSWAPD_RECLAIM |
> +					   __GFP_RETRY_MAYFAIL |
> +					   __GFP_NOWARN | __GFP_NOMEMALLOC,

The set of flags is inconsistent with balloon_page_alloc.
Pls extend that do not bypass it.


> +					   page_order);
> +		else
> +			page = balloon_page_alloc();
>  
>  		if (!page) {
>  			dev_info_ratelimited(&vb->vdev->dev,
> -					     "Out of puff! Can't get %u pages\n",
> -					     VIRTIO_BALLOON_PAGES_PER_PAGE);
> +				"Out of puff! Can't get %u pages\n",
> +				VIRTIO_BALLOON_PAGES_PER_PAGE << page_order);
>  			/* Sleep for at least 1/5 of a second before retry. */
>  			msleep(200);
>  			break;

I suggest we do something guest side only for starters: if we need a
power of two pages, try to get them in a single chunk, with no retrying.
If that fails go back to a single page.


> @@ -206,7 +219,7 @@ static unsigned fill_balloon(struct virtio_balloon *vb, size_t num)
>  		vb->num_pages += VIRTIO_BALLOON_PAGES_PER_PAGE;
>  		if (!virtio_has_feature(vb->vdev,
>  					VIRTIO_BALLOON_F_DEFLATE_ON_OOM))
> -			adjust_managed_page_count(page, -1);
> +			adjust_managed_page_count(page, -(1 << page_order));
>  		vb->num_pfns += VIRTIO_BALLOON_PAGES_PER_PAGE;
>  	}
>  
> @@ -223,13 +236,20 @@ static void release_pages_balloon(struct virtio_balloon *vb,
>  				 struct list_head *pages)
>  {
>  	struct page *page, *next;
> +	int page_order = 0;
> +
> +	if (virtio_has_feature(vb->vdev, VIRTIO_BALLOON_F_THP_ORDER))
> +		page_order = VIRTIO_BALLOON_THP_ORDER;
>  
>  	list_for_each_entry_safe(page, next, pages, lru) {
>  		if (!virtio_has_feature(vb->vdev,
>  					VIRTIO_BALLOON_F_DEFLATE_ON_OOM))
> -			adjust_managed_page_count(page, 1);
> +			adjust_managed_page_count(page, 1 << page_order);
>  		list_del(&page->lru);
> -		put_page(page); /* balloon reference */
> +		if (page_order)
> +			__free_pages(page, page_order);
> +		else
> +			put_page(page); /* balloon reference */
>  	}
>  }
>  
> @@ -893,19 +913,21 @@ static int virtballoon_probe(struct virtio_device *vdev)
>  		goto out_free_vb;
>  
>  #ifdef CONFIG_BALLOON_COMPACTION
> -	balloon_mnt = kern_mount(&balloon_fs);
> -	if (IS_ERR(balloon_mnt)) {
> -		err = PTR_ERR(balloon_mnt);
> -		goto out_del_vqs;
> -	}
> +	if (!virtio_has_feature(vdev, VIRTIO_BALLOON_F_THP_ORDER)) {
> +		balloon_mnt = kern_mount(&balloon_fs);
> +		if (IS_ERR(balloon_mnt)) {
> +			err = PTR_ERR(balloon_mnt);
> +			goto out_del_vqs;
> +		}
>  
> -	vb->vb_dev_info.migratepage = virtballoon_migratepage;
> -	vb->vb_dev_info.inode = alloc_anon_inode(balloon_mnt->mnt_sb);
> -	if (IS_ERR(vb->vb_dev_info.inode)) {
> -		err = PTR_ERR(vb->vb_dev_info.inode);
> -		goto out_kern_unmount;
> +		vb->vb_dev_info.migratepage = virtballoon_migratepage;
> +		vb->vb_dev_info.inode = alloc_anon_inode(balloon_mnt->mnt_sb);
> +		if (IS_ERR(vb->vb_dev_info.inode)) {
> +			err = PTR_ERR(vb->vb_dev_info.inode);
> +			goto out_kern_unmount;
> +		}
> +		vb->vb_dev_info.inode->i_mapping->a_ops = &balloon_aops;
>  	}
> -	vb->vb_dev_info.inode->i_mapping->a_ops = &balloon_aops;
>  #endif
>  	if (virtio_has_feature(vdev, VIRTIO_BALLOON_F_FREE_PAGE_HINT)) {
>  		/*


I doubt this fixed all code. Anything using VIRTIO_BALLOON_PAGES_PER_PAGE
would be suspect. Also, the result might not fit in the pfns array.




> @@ -1058,6 +1080,7 @@ static unsigned int features[] = {
>  	VIRTIO_BALLOON_F_DEFLATE_ON_OOM,
>  	VIRTIO_BALLOON_F_FREE_PAGE_HINT,
>  	VIRTIO_BALLOON_F_PAGE_POISON,
> +	VIRTIO_BALLOON_F_THP_ORDER,
>  };
>  
>  static struct virtio_driver virtio_balloon_driver = {
> diff --git a/include/linux/balloon_compaction.h b/include/linux/balloon_compaction.h
> index 338aa27..4c9164e 100644
> --- a/include/linux/balloon_compaction.h
> +++ b/include/linux/balloon_compaction.h
> @@ -100,8 +100,12 @@ static inline void balloon_page_insert(struct balloon_dev_info *balloon,
>  				       struct page *page)
>  {
>  	__SetPageOffline(page);
> -	__SetPageMovable(page, balloon->inode->i_mapping);
> -	set_page_private(page, (unsigned long)balloon);
> +	if (balloon->inode) {
> +		__SetPageMovable(page, balloon->inode->i_mapping);
> +		set_page_private(page, (unsigned long)balloon);
> +	} else {
> +		set_page_private(page, 0);
> +	}
>  	list_add(&page->lru, &balloon->pages);
>  }
>  
> @@ -116,8 +120,10 @@ static inline void balloon_page_insert(struct balloon_dev_info *balloon,
>  static inline void balloon_page_delete(struct page *page)
>  {
>  	__ClearPageOffline(page);
> -	__ClearPageMovable(page);
> -	set_page_private(page, 0);
> +	if (page_private(page)) {
> +		__ClearPageMovable(page);
> +		set_page_private(page, 0);
> +	}
>  	/*
>  	 * No touch page.lru field once @page has been isolated
>  	 * because VM is using the field.
> diff --git a/include/uapi/linux/virtio_balloon.h b/include/uapi/linux/virtio_balloon.h
> index a1966cd7..a2998a9 100644
> --- a/include/uapi/linux/virtio_balloon.h
> +++ b/include/uapi/linux/virtio_balloon.h
> @@ -36,10 +36,14 @@
>  #define VIRTIO_BALLOON_F_DEFLATE_ON_OOM	2 /* Deflate balloon on OOM */
>  #define VIRTIO_BALLOON_F_FREE_PAGE_HINT	3 /* VQ to report free pages */
>  #define VIRTIO_BALLOON_F_PAGE_POISON	4 /* Guest is using page poisoning */
> +#define VIRTIO_BALLOON_F_THP_ORDER	5 /* Balloon page order to thp order */
>  
>  /* Size of a PFN in the balloon interface. */
>  #define VIRTIO_BALLOON_PFN_SHIFT 12
>  
> +/* The order of the balloon page */
> +#define VIRTIO_BALLOON_THP_ORDER 9
> +

Why 9?

>  #define VIRTIO_BALLOON_CMD_ID_STOP	0
>  #define VIRTIO_BALLOON_CMD_ID_DONE	1
>  struct virtio_balloon_config {


Assuming the idea is to also allow passing larger chunks to host,
I think we need to switch to using regular virtio S/G for starters.
That involves spec work though.



> -- 
> 2.7.4
