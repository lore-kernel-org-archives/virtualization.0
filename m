From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH v1 2/3] virtio_balloon: Fix memory leaks on errors in
 virtballoon_probe()
Date: Thu, 6 Feb 2020 03:36:40 -0500
Message-ID: <20200206033633-mutt-send-email-mst@kernel.org>
References: <20200205163402.42627-1-david@redhat.com>
 <20200205163402.42627-3-david@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20200205163402.42627-3-david@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
To: David Hildenbrand <david@redhat.com>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org, virtualization@lists.linux-foundation.org, Jason Wang <jasowang@redhat.com>, Wei Wang <wei.w.wang@intel.com>, Liang Li <liang.z.li@intel.com>
List-Id: virtualization@lists.linuxfoundation.org

On Wed, Feb 05, 2020 at 05:34:01PM +0100, David Hildenbrand wrote:
> We forget to put the inode and unmount the kernfs used for compaction.
> 
> Fixes: 71994620bb25 ("virtio_balloon: replace oom notifier with shrinker")
> Cc: "Michael S. Tsirkin" <mst@redhat.com>
> Cc: Jason Wang <jasowang@redhat.com>
> Cc: Wei Wang <wei.w.wang@intel.com>
> Cc: Liang Li <liang.z.li@intel.com>
> Signed-off-by: David Hildenbrand <david@redhat.com>

Applied, thanks!

> ---
>  drivers/virtio/virtio_balloon.c | 13 +++++++++----
>  1 file changed, 9 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/virtio/virtio_balloon.c b/drivers/virtio/virtio_balloon.c
> index abef2306c899..7e5d84caeb94 100644
> --- a/drivers/virtio/virtio_balloon.c
> +++ b/drivers/virtio/virtio_balloon.c
> @@ -901,8 +901,7 @@ static int virtballoon_probe(struct virtio_device *vdev)
>  	vb->vb_dev_info.inode = alloc_anon_inode(balloon_mnt->mnt_sb);
>  	if (IS_ERR(vb->vb_dev_info.inode)) {
>  		err = PTR_ERR(vb->vb_dev_info.inode);
> -		kern_unmount(balloon_mnt);
> -		goto out_del_vqs;
> +		goto out_kern_unmount;
>  	}
>  	vb->vb_dev_info.inode->i_mapping->a_ops = &balloon_aops;
>  #endif
> @@ -913,13 +912,13 @@ static int virtballoon_probe(struct virtio_device *vdev)
>  		 */
>  		if (virtqueue_get_vring_size(vb->free_page_vq) < 2) {
>  			err = -ENOSPC;
> -			goto out_del_vqs;
> +			goto out_iput;
>  		}
>  		vb->balloon_wq = alloc_workqueue("balloon-wq",
>  					WQ_FREEZABLE | WQ_CPU_INTENSIVE, 0);
>  		if (!vb->balloon_wq) {
>  			err = -ENOMEM;
> -			goto out_del_vqs;
> +			goto out_iput;
>  		}
>  		INIT_WORK(&vb->report_free_page_work, report_free_page_func);
>  		vb->cmd_id_received_cache = VIRTIO_BALLOON_CMD_ID_STOP;
> @@ -953,6 +952,12 @@ static int virtballoon_probe(struct virtio_device *vdev)
>  out_del_balloon_wq:
>  	if (virtio_has_feature(vdev, VIRTIO_BALLOON_F_FREE_PAGE_HINT))
>  		destroy_workqueue(vb->balloon_wq);
> +out_iput:
> +#ifdef CONFIG_BALLOON_COMPACTION
> +	iput(vb->vb_dev_info.inode);
> +out_kern_unmount:
> +	kern_unmount(balloon_mnt);
> +#endif
>  out_del_vqs:
>  	vdev->config->del_vqs(vdev);
>  out_free_vb:
> -- 
> 2.24.1
