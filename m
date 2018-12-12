From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH net V2 3/4] Revert "net: vhost: lock the vqs one by one"
Date: Wed, 12 Dec 2018 09:24:31 -0500
Message-ID: <20181212092102-mutt-send-email-mst__37452.0700694577$1544624552$gmane$org@kernel.org>
References: <20181212100819.21295-1-jasowang@redhat.com>
	<20181212100819.21295-4-jasowang@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20181212100819.21295-4-jasowang@redhat.com>
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

On Wed, Dec 12, 2018 at 06:08:18PM +0800, Jason Wang wrote:
> This reverts commit 78139c94dc8c96a478e67dab3bee84dc6eccb5fd. We don't
> protect device IOTLB with vq mutex, which will lead e.g use after free
> for device IOTLB entries. And since we've switched to use
> mutex_trylock() in previous patch, it's safe to revert it without
> having deadlock.
> 
> Fixes: commit 78139c94dc8c ("net: vhost: lock the vqs one by one")
> Cc: Tonghao Zhang <xiangxia.m.yue@gmail.com>
> Signed-off-by: Jason Wang <jasowang@redhat.com>


Acked-by: Michael S. Tsirkin <mst@redhat.com>

I'd try to put this in 4.20 if we can
and it's needed for -stable I think.

Also looks like we should allow iotlb entries per vq
to improve locking. What do you think?

> ---
>  drivers/vhost/vhost.c | 21 +++++++++++++++++----
>  1 file changed, 17 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/vhost/vhost.c b/drivers/vhost/vhost.c
> index 5915f240275a..55e5aa662ad5 100644
> --- a/drivers/vhost/vhost.c
> +++ b/drivers/vhost/vhost.c
> @@ -295,11 +295,8 @@ static void vhost_vq_meta_reset(struct vhost_dev *d)
>  {
>  	int i;
>  
> -	for (i = 0; i < d->nvqs; ++i) {
> -		mutex_lock(&d->vqs[i]->mutex);
> +	for (i = 0; i < d->nvqs; ++i)
>  		__vhost_vq_meta_reset(d->vqs[i]);
> -		mutex_unlock(&d->vqs[i]->mutex);
> -	}
>  }
>  
>  static void vhost_vq_reset(struct vhost_dev *dev,
> @@ -895,6 +892,20 @@ static inline void __user *__vhost_get_user(struct vhost_virtqueue *vq,
>  #define vhost_get_used(vq, x, ptr) \
>  	vhost_get_user(vq, x, ptr, VHOST_ADDR_USED)
>  
> +static void vhost_dev_lock_vqs(struct vhost_dev *d)
> +{
> +	int i = 0;
> +	for (i = 0; i < d->nvqs; ++i)
> +		mutex_lock_nested(&d->vqs[i]->mutex, i);
> +}
> +
> +static void vhost_dev_unlock_vqs(struct vhost_dev *d)
> +{
> +	int i = 0;
> +	for (i = 0; i < d->nvqs; ++i)
> +		mutex_unlock(&d->vqs[i]->mutex);
> +}
> +
>  static int vhost_new_umem_range(struct vhost_umem *umem,
>  				u64 start, u64 size, u64 end,
>  				u64 userspace_addr, int perm)
> @@ -976,6 +987,7 @@ static int vhost_process_iotlb_msg(struct vhost_dev *dev,
>  	int ret = 0;
>  
>  	mutex_lock(&dev->mutex);
> +	vhost_dev_lock_vqs(dev);
>  	switch (msg->type) {
>  	case VHOST_IOTLB_UPDATE:
>  		if (!dev->iotlb) {
> @@ -1009,6 +1021,7 @@ static int vhost_process_iotlb_msg(struct vhost_dev *dev,
>  		break;
>  	}
>  
> +	vhost_dev_unlock_vqs(dev);
>  	mutex_unlock(&dev->mutex);
>  
>  	return ret;
> -- 
> 2.17.1
