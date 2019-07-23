From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH 2/6] vhost: validate MMU notifier registration
Date: Tue, 23 Jul 2019 05:17:45 -0400
Message-ID: <20190723042428-mutt-send-email-mst__9106.44940320111$1563873479$gmane$org@kernel.org>
References: <20190723075718.6275-1-jasowang@redhat.com>
	<20190723075718.6275-3-jasowang@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20190723075718.6275-3-jasowang@redhat.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Jason Wang <jasowang@redhat.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, kvm@vger.kernel.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

On Tue, Jul 23, 2019 at 03:57:14AM -0400, Jason Wang wrote:
> The return value of mmu_notifier_register() is not checked in
> vhost_vring_set_num_addr(). This will cause an out of sync between mm
> and MMU notifier thus a double free. To solve this, introduce a
> boolean flag to track whether MMU notifier is registered and only do
> unregistering when it was true.
> 
> Reported-and-tested-by:
> syzbot+e58112d71f77113ddb7b@syzkaller.appspotmail.com
> Fixes: 7f466032dc9e ("vhost: access vq metadata through kernel virtual address")
> Signed-off-by: Jason Wang <jasowang@redhat.com>

Right. This fixes the bug.
But it's not great that simple things like
setting vq address put pressure on memory allocator.
Also, if we get a single during processing
notifier register will fail, disabling optimization permanently.

In fact, see below:


> ---
>  drivers/vhost/vhost.c | 19 +++++++++++++++----
>  drivers/vhost/vhost.h |  1 +
>  2 files changed, 16 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/vhost/vhost.c b/drivers/vhost/vhost.c
> index 34c0d970bcbc..058191d5efad 100644
> --- a/drivers/vhost/vhost.c
> +++ b/drivers/vhost/vhost.c
> @@ -630,6 +630,7 @@ void vhost_dev_init(struct vhost_dev *dev,
>  	dev->iov_limit = iov_limit;
>  	dev->weight = weight;
>  	dev->byte_weight = byte_weight;
> +	dev->has_notifier = false;
>  	init_llist_head(&dev->work_list);
>  	init_waitqueue_head(&dev->wait);
>  	INIT_LIST_HEAD(&dev->read_list);
> @@ -731,6 +732,7 @@ long vhost_dev_set_owner(struct vhost_dev *dev)
>  	if (err)
>  		goto err_mmu_notifier;
>  #endif
> +	dev->has_notifier = true;
>  
>  	return 0;
>  

I just noticed that set owner now fails if we get a signal.
Userspace could retry in theory but it does not:
this is userspace abi breakage since it used to only
fail on invalid input.

> @@ -960,7 +962,11 @@ void vhost_dev_cleanup(struct vhost_dev *dev)
>  	}
>  	if (dev->mm) {
>  #if VHOST_ARCH_CAN_ACCEL_UACCESS
> -		mmu_notifier_unregister(&dev->mmu_notifier, dev->mm);
> +		if (dev->has_notifier) {
> +			mmu_notifier_unregister(&dev->mmu_notifier,
> +						dev->mm);
> +			dev->has_notifier = false;
> +		}
>  #endif
>  		mmput(dev->mm);
>  	}
> @@ -2065,8 +2071,10 @@ static long vhost_vring_set_num_addr(struct vhost_dev *d,
>  	/* Unregister MMU notifer to allow invalidation callback
>  	 * can access vq->uaddrs[] without holding a lock.
>  	 */
> -	if (d->mm)
> +	if (d->has_notifier) {
>  		mmu_notifier_unregister(&d->mmu_notifier, d->mm);
> +		d->has_notifier = false;
> +	}
>  
>  	vhost_uninit_vq_maps(vq);
>  #endif
> @@ -2086,8 +2094,11 @@ static long vhost_vring_set_num_addr(struct vhost_dev *d,
>  	if (r == 0)
>  		vhost_setup_vq_uaddr(vq);
>  
> -	if (d->mm)
> -		mmu_notifier_register(&d->mmu_notifier, d->mm);
> +	if (d->mm) {
> +		r = mmu_notifier_register(&d->mmu_notifier, d->mm);
> +		if (!r)
> +			d->has_notifier = true;
> +	}
>  #endif
>  
>  	mutex_unlock(&vq->mutex);
> diff --git a/drivers/vhost/vhost.h b/drivers/vhost/vhost.h
> index 819296332913..a62f56a4cf72 100644
> --- a/drivers/vhost/vhost.h
> +++ b/drivers/vhost/vhost.h
> @@ -214,6 +214,7 @@ struct vhost_dev {
>  	int iov_limit;
>  	int weight;
>  	int byte_weight;
> +	bool has_notifier;
>  };
>  
>  bool vhost_exceeds_weight(struct vhost_virtqueue *vq, int pkts, int total_len);
> -- 
> 2.18.1
