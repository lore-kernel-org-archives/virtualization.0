From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH v1 1/3] virtio-balloon: Fix memory leak when unloading
 while hinting is in progress
Date: Thu, 6 Feb 2020 03:36:26 -0500
Message-ID: <20200206033617-mutt-send-email-mst@kernel.org>
References: <20200205163402.42627-1-david@redhat.com>
 <20200205163402.42627-2-david@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20200205163402.42627-2-david@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
To: David Hildenbrand <david@redhat.com>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org, virtualization@lists.linux-foundation.org, Jason Wang <jasowang@redhat.com>, Wei Wang <wei.w.wang@intel.com>, Liang Li <liang.z.li@intel.com>
List-Id: virtualization@lists.linuxfoundation.org

On Wed, Feb 05, 2020 at 05:34:00PM +0100, David Hildenbrand wrote:
> When unloading the driver while hinting is in progress, we will not
> release the free page blocks back to MM, resulting in a memory leak.
> 
> Fixes: 86a559787e6f ("virtio-balloon: VIRTIO_BALLOON_F_FREE_PAGE_HINT")
> Cc: "Michael S. Tsirkin" <mst@redhat.com>
> Cc: Jason Wang <jasowang@redhat.com>
> Cc: Wei Wang <wei.w.wang@intel.com>
> Cc: Liang Li <liang.z.li@intel.com>
> Signed-off-by: David Hildenbrand <david@redhat.com>

Applied, thanks!

> ---
>  drivers/virtio/virtio_balloon.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/drivers/virtio/virtio_balloon.c b/drivers/virtio/virtio_balloon.c
> index 8e400ece9273..abef2306c899 100644
> --- a/drivers/virtio/virtio_balloon.c
> +++ b/drivers/virtio/virtio_balloon.c
> @@ -968,6 +968,10 @@ static void remove_common(struct virtio_balloon *vb)
>  		leak_balloon(vb, vb->num_pages);
>  	update_balloon_size(vb);
>  
> +	/* There might be free pages that are being reported: release them. */
> +	if (virtio_has_feature(vb->vdev, VIRTIO_BALLOON_F_FREE_PAGE_HINT))
> +		return_free_pages_to_mm(vb, ULONG_MAX);
> +
>  	/* Now we reset the device so we can clean up the queues. */
>  	vb->vdev->config->reset(vb->vdev);
>  
> -- 
> 2.24.1
