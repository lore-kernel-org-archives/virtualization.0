From: David Hildenbrand <david@redhat.com>
Subject: Re: [PATCH RFC] virtio_balloon: conservative balloon page shrinking
Date: Thu, 6 Feb 2020 10:09:58 +0100
Message-ID: <6ccbfeea-de66-20d7-0e08-a5834a3c3d3f@redhat.com>
References: <1580976107-16013-1-git-send-email-wei.w.wang@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1580976107-16013-1-git-send-email-wei.w.wang@intel.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Wei Wang <wei.w.wang@intel.com>, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org
Cc: tysand@google.com, mst@redhat.com, alexander.h.duyck@linux.intel.com, rientjes@google.com, mhocko@kernel.org, namit@vmware.com, penguin-kernel@I-love.SAKURA.ne.jp
List-Id: virtualization@lists.linuxfoundation.org

On 06.02.20 09:01, Wei Wang wrote:
> There are cases that users want to shrink balloon pages after the
> pagecache depleted. The conservative_shrinker lets the shrinker
> shrink balloon pages when all the pagecache has been reclaimed.
> 
> Signed-off-by: Wei Wang <wei.w.wang@intel.com>
> ---
>  drivers/virtio/virtio_balloon.c | 14 +++++++++++++-
>  1 file changed, 13 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/virtio/virtio_balloon.c b/drivers/virtio/virtio_balloon.c
> index 93f995f6cf36..b4c5bb13a867 100644
> --- a/drivers/virtio/virtio_balloon.c
> +++ b/drivers/virtio/virtio_balloon.c
> @@ -42,6 +42,10 @@
>  static struct vfsmount *balloon_mnt;
>  #endif
>  
> +static bool conservative_shrinker = true;
> +module_param(conservative_shrinker, bool, 0644);
> +MODULE_PARM_DESC(conservative_shrinker, "conservatively shrink balloon pages");
> +
>  enum virtio_balloon_vq {
>  	VIRTIO_BALLOON_VQ_INFLATE,
>  	VIRTIO_BALLOON_VQ_DEFLATE,
> @@ -796,6 +800,10 @@ static unsigned long shrink_balloon_pages(struct virtio_balloon *vb,
>  {
>  	unsigned long pages_freed = 0;
>  
> +	/* Balloon pages only gets shrunk when the pagecache depleted */
> +	if (conservative_shrinker && global_node_page_state(NR_FILE_PAGES))
> +		return 0;
> +
>  	/*
>  	 * One invocation of leak_balloon can deflate at most
>  	 * VIRTIO_BALLOON_ARRAY_PFNS_MAX balloon pages, so we call it
> @@ -837,7 +845,11 @@ static unsigned long virtio_balloon_shrinker_count(struct shrinker *shrinker,
>  					struct virtio_balloon, shrinker);
>  	unsigned long count;
>  
> -	count = vb->num_pages / VIRTIO_BALLOON_PAGES_PER_PAGE;
> +	if (conservative_shrinker && global_node_page_state(NR_FILE_PAGES))
> +		count = 0;
> +	else
> +		count = vb->num_pages / VIRTIO_BALLOON_PAGES_PER_PAGE;
> +
>  	count += vb->num_free_page_blocks * VIRTIO_BALLOON_HINT_BLOCK_PAGES;
>  
>  	return count;
> 

so dropping caches (echo 3 > /proc/sys/vm/drop_caches) will no longer
deflate the balloon when conservative_shrinker=true?

-- 
Thanks,

David / dhildenb
