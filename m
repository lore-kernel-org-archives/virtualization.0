From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH] virtio_balloon: fix PFN format for virtio-1
Date: Mon, 13 Jun 2016 21:08:44 +0300
Message-ID: <20160613210800-mutt-send-email-mst__18531.4198876315$1465841345$gmane$org@redhat.com>
References: <1463574848-15630-1-git-send-email-mst@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <1463574848-15630-1-git-send-email-mst@redhat.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: linux-kernel@vger.kernel.org
Cc: stable@vger.kernel.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

On Wed, May 18, 2016 at 03:38:53PM +0300, Michael S. Tsirkin wrote:
> Everything should be LE when using virtio-1, but
> the linux balloon driver does not seem to care about that.
> 
> Cc: stable@vger.kernel.org
> Reported-by: Cornelia Huck <cornelia.huck@de.ibm.com>
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>

Forgot to CC stable.
Please consider this patch for inclusion in the next stable Linux.


> ---
>  drivers/virtio/virtio_balloon.c | 20 ++++++++++++--------
>  1 file changed, 12 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/virtio/virtio_balloon.c b/drivers/virtio/virtio_balloon.c
> index 7b6d74f..476c0e3 100644
> --- a/drivers/virtio/virtio_balloon.c
> +++ b/drivers/virtio/virtio_balloon.c
> @@ -75,7 +75,7 @@ struct virtio_balloon {
>  
>  	/* The array of pfns we tell the Host about. */
>  	unsigned int num_pfns;
> -	u32 pfns[VIRTIO_BALLOON_ARRAY_PFNS_MAX];
> +	__virtio32 pfns[VIRTIO_BALLOON_ARRAY_PFNS_MAX];
>  
>  	/* Memory statistics */
>  	struct virtio_balloon_stat stats[VIRTIO_BALLOON_S_NR];
> @@ -127,14 +127,16 @@ static void tell_host(struct virtio_balloon *vb, struct virtqueue *vq)
>  
>  }
>  
> -static void set_page_pfns(u32 pfns[], struct page *page)
> +static void set_page_pfns(struct virtio_balloon *vb,
> +			  __virtio32 pfns[], struct page *page)
>  {
>  	unsigned int i;
>  
>  	/* Set balloon pfns pointing at this page.
>  	 * Note that the first pfn points at start of the page. */
>  	for (i = 0; i < VIRTIO_BALLOON_PAGES_PER_PAGE; i++)
> -		pfns[i] = page_to_balloon_pfn(page) + i;
> +		pfns[i] = cpu_to_virtio32(vb->vdev,
> +					  page_to_balloon_pfn(page) + i);
>  }
>  
>  static unsigned fill_balloon(struct virtio_balloon *vb, size_t num)
> @@ -158,7 +160,7 @@ static unsigned fill_balloon(struct virtio_balloon *vb, size_t num)
>  			msleep(200);
>  			break;
>  		}
> -		set_page_pfns(vb->pfns + vb->num_pfns, page);
> +		set_page_pfns(vb, vb->pfns + vb->num_pfns, page);
>  		vb->num_pages += VIRTIO_BALLOON_PAGES_PER_PAGE;
>  		if (!virtio_has_feature(vb->vdev,
>  					VIRTIO_BALLOON_F_DEFLATE_ON_OOM))
> @@ -177,10 +179,12 @@ static unsigned fill_balloon(struct virtio_balloon *vb, size_t num)
>  static void release_pages_balloon(struct virtio_balloon *vb)
>  {
>  	unsigned int i;
> +	struct page *page;
>  
>  	/* Find pfns pointing at start of each page, get pages and free them. */
>  	for (i = 0; i < vb->num_pfns; i += VIRTIO_BALLOON_PAGES_PER_PAGE) {
> -		struct page *page = balloon_pfn_to_page(vb->pfns[i]);
> +		page = balloon_pfn_to_page(virtio32_to_cpu(vb->vdev,
> +							   vb->pfns[i]));
>  		if (!virtio_has_feature(vb->vdev,
>  					VIRTIO_BALLOON_F_DEFLATE_ON_OOM))
>  			adjust_managed_page_count(page, 1);
> @@ -203,7 +207,7 @@ static unsigned leak_balloon(struct virtio_balloon *vb, size_t num)
>  		page = balloon_page_dequeue(vb_dev_info);
>  		if (!page)
>  			break;
> -		set_page_pfns(vb->pfns + vb->num_pfns, page);
> +		set_page_pfns(vb, vb->pfns + vb->num_pfns, page);
>  		vb->num_pages -= VIRTIO_BALLOON_PAGES_PER_PAGE;
>  	}
>  
> @@ -471,13 +475,13 @@ static int virtballoon_migratepage(struct balloon_dev_info *vb_dev_info,
>  	__count_vm_event(BALLOON_MIGRATE);
>  	spin_unlock_irqrestore(&vb_dev_info->pages_lock, flags);
>  	vb->num_pfns = VIRTIO_BALLOON_PAGES_PER_PAGE;
> -	set_page_pfns(vb->pfns, newpage);
> +	set_page_pfns(vb, vb->pfns, newpage);
>  	tell_host(vb, vb->inflate_vq);
>  
>  	/* balloon's page migration 2nd step -- deflate "page" */
>  	balloon_page_delete(page);
>  	vb->num_pfns = VIRTIO_BALLOON_PAGES_PER_PAGE;
> -	set_page_pfns(vb->pfns, page);
> +	set_page_pfns(vb, vb->pfns, page);
>  	tell_host(vb, vb->deflate_vq);
>  
>  	mutex_unlock(&vb->balloon_lock);
> -- 
> MST
