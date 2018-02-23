From: Cornelia Huck <cohuck@redhat.com>
Subject: Re: [PATCH] virtio_ring: fix num_free handling in error case
Date: Fri, 23 Feb 2018 13:47:26 +0100
Message-ID: <20180223134726.3db96065.cohuck@redhat.com>
References: <20180223114130.16332-1-tiwei.bie@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20180223114130.16332-1-tiwei.bie@intel.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Tiwei Bie <tiwei.bie@intel.com>
Cc: mst@redhat.com, linux-kernel@vger.kernel.org, stable@vger.kernel.org, virtualization@lists.linux-foundation.org, Andy Lutomirski <luto@kernel.org>
List-Id: virtualization@lists.linuxfoundation.org

On Fri, 23 Feb 2018 19:41:30 +0800
Tiwei Bie <tiwei.bie@intel.com> wrote:

> The vq->vq.num_free hasn't been changed when error happens,
> so it shouldn't be changed when handling the error.
> 
> Fixes: 780bc7903a32 ("virtio_ring: Support DMA APIs")
> Cc: Andy Lutomirski <luto@kernel.org>
> Cc: Michael S. Tsirkin <mst@redhat.com>
> Cc: stable@vger.kernel.org
> Signed-off-by: Tiwei Bie <tiwei.bie@intel.com>
> ---
>  drivers/virtio/virtio_ring.c | 2 --
>  1 file changed, 2 deletions(-)
> 
> diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
> index eb30f3e09a47..71458f493cf8 100644
> --- a/drivers/virtio/virtio_ring.c
> +++ b/drivers/virtio/virtio_ring.c
> @@ -428,8 +428,6 @@ static inline int virtqueue_add(struct virtqueue *_vq,
>  		i = virtio16_to_cpu(_vq->vdev, vq->vring.desc[i].next);
>  	}
>  
> -	vq->vq.num_free += total_sg;
> -
>  	if (indirect)
>  		kfree(desc);
>  

Reviewed-by: Cornelia Huck <cohuck@redhat.com>
