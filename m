From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH net-next v6 1/4] net: vhost: lock the vqs one by one
Date: Sun, 22 Jul 2018 18:26:26 +0300
Message-ID: <20180722182448-mutt-send-email-mst__23037.3907172636$1532273070$gmane$org@kernel.org>
References: <1532196242-2998-1-git-send-email-xiangxia.m.yue@gmail.com>
	<1532196242-2998-2-git-send-email-xiangxia.m.yue@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <1532196242-2998-2-git-send-email-xiangxia.m.yue@gmail.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: xiangxia.m.yue@gmail.com
Cc: netdev@vger.kernel.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

On Sat, Jul 21, 2018 at 11:03:59AM -0700, xiangxia.m.yue@gmail.com wrote:
> From: Tonghao Zhang <xiangxia.m.yue@gmail.com>
> 
> This patch changes the way that lock all vqs
> at the same, to lock them one by one. It will
> be used for next patch to avoid the deadlock.
> 
> Signed-off-by: Tonghao Zhang <xiangxia.m.yue@gmail.com>
> Acked-by: Jason Wang <jasowang@redhat.com>
> Signed-off-by: Jason Wang <jasowang@redhat.com>
> ---
>  drivers/vhost/vhost.c | 24 +++++++-----------------
>  1 file changed, 7 insertions(+), 17 deletions(-)
> 
> diff --git a/drivers/vhost/vhost.c b/drivers/vhost/vhost.c
> index a502f1a..a1c06e7 100644
> --- a/drivers/vhost/vhost.c
> +++ b/drivers/vhost/vhost.c
> @@ -294,8 +294,11 @@ static void vhost_vq_meta_reset(struct vhost_dev *d)
>  {
>  	int i;
>  
> -	for (i = 0; i < d->nvqs; ++i)
> +	for (i = 0; i < d->nvqs; ++i) {
> +		mutex_lock(&d->vqs[i]->mutex);
>  		__vhost_vq_meta_reset(d->vqs[i]);
> +		mutex_unlock(&d->vqs[i]->mutex);
> +	}
>  }
>  
>  static void vhost_vq_reset(struct vhost_dev *dev,
> @@ -890,20 +893,6 @@ static inline void __user *__vhost_get_user(struct vhost_virtqueue *vq,
>  #define vhost_get_used(vq, x, ptr) \
>  	vhost_get_user(vq, x, ptr, VHOST_ADDR_USED)
>  
> -static void vhost_dev_lock_vqs(struct vhost_dev *d)
> -{
> -	int i = 0;
> -	for (i = 0; i < d->nvqs; ++i)
> -		mutex_lock_nested(&d->vqs[i]->mutex, i);
> -}
> -
> -static void vhost_dev_unlock_vqs(struct vhost_dev *d)
> -{
> -	int i = 0;
> -	for (i = 0; i < d->nvqs; ++i)
> -		mutex_unlock(&d->vqs[i]->mutex);
> -}
> -
>  static int vhost_new_umem_range(struct vhost_umem *umem,
>  				u64 start, u64 size, u64 end,
>  				u64 userspace_addr, int perm)
> @@ -953,7 +942,10 @@ static void vhost_iotlb_notify_vq(struct vhost_dev *d,
>  		if (msg->iova <= vq_msg->iova &&
>  		    msg->iova + msg->size - 1 > vq_msg->iova &&
>  		    vq_msg->type == VHOST_IOTLB_MISS) {
> +			mutex_lock(&node->vq->mutex);
>  			vhost_poll_queue(&node->vq->poll);
> +			mutex_unlock(&node->vq->mutex);
> +
>  			list_del(&node->node);
>  			kfree(node);
>  		}
> @@ -985,7 +977,6 @@ static int vhost_process_iotlb_msg(struct vhost_dev *dev,
>  	int ret = 0;
>  
>  	mutex_lock(&dev->mutex);
> -	vhost_dev_lock_vqs(dev);
>  	switch (msg->type) {
>  	case VHOST_IOTLB_UPDATE:
>  		if (!dev->iotlb) {
> @@ -1019,7 +1010,6 @@ static int vhost_process_iotlb_msg(struct vhost_dev *dev,
>  		break;
>  	}
>  
> -	vhost_dev_unlock_vqs(dev);
>  	mutex_unlock(&dev->mutex);
>  
>  	return ret;

I do prefer the finer-grained locking but I remember we
discussed something like this in the past and Jason saw issues
with such a locking.

Jason?

> -- 
> 1.8.3.1
