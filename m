From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH -next] vdpasim: remove unused variable 'ret'
Date: Tue, 5 May 2020 20:35:58 -0400
Message-ID: <20200505203544-mutt-send-email-mst@kernel.org>
References: <20200410115422.42308-1-yuehaibing@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20200410115422.42308-1-yuehaibing@huawei.com>
Sender: linux-kernel-owner@vger.kernel.org
To: YueHaibing <yuehaibing@huawei.com>
Cc: jasowang@redhat.com, virtualization@lists.linux-foundation.org, linux-kernel@vger.kernel.org
List-Id: virtualization@lists.linuxfoundation.org

On Fri, Apr 10, 2020 at 07:54:22PM +0800, YueHaibing wrote:
> drivers/vdpa/vdpa_sim/vdpa_sim.c:92:6: warning:
>  variable ‘ret’ set but not used [-Wunused-but-set-variable]
> 
> Signed-off-by: YueHaibing <yuehaibing@huawei.com>
> ---

Either this, or BUG_ON.  Jason?

>  drivers/vdpa/vdpa_sim/vdpa_sim.c | 15 +++++++--------
>  1 file changed, 7 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/vdpa/vdpa_sim/vdpa_sim.c b/drivers/vdpa/vdpa_sim/vdpa_sim.c
> index 7957d2d41fc4..01c456f7c1f7 100644
> --- a/drivers/vdpa/vdpa_sim/vdpa_sim.c
> +++ b/drivers/vdpa/vdpa_sim/vdpa_sim.c
> @@ -89,15 +89,14 @@ static struct vdpasim *dev_to_sim(struct device *dev)
>  static void vdpasim_queue_ready(struct vdpasim *vdpasim, unsigned int idx)
>  {
>  	struct vdpasim_virtqueue *vq = &vdpasim->vqs[idx];
> -	int ret;
>  
> -	ret = vringh_init_iotlb(&vq->vring, vdpasim_features,
> -				VDPASIM_QUEUE_MAX, false,
> -				(struct vring_desc *)(uintptr_t)vq->desc_addr,
> -				(struct vring_avail *)
> -				(uintptr_t)vq->driver_addr,
> -				(struct vring_used *)
> -				(uintptr_t)vq->device_addr);
> +	vringh_init_iotlb(&vq->vring, vdpasim_features,
> +			  VDPASIM_QUEUE_MAX, false,
> +			  (struct vring_desc *)(uintptr_t)vq->desc_addr,
> +			  (struct vring_avail *)
> +			  (uintptr_t)vq->driver_addr,
> +			  (struct vring_used *)
> +			  (uintptr_t)vq->device_addr);
>  }
>  
>  static void vdpasim_vq_reset(struct vdpasim_virtqueue *vq)
> -- 
> 2.17.1
> 
