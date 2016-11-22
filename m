From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH 2/2] virtio_ring: fix complaint by sparse
Date: Tue, 22 Nov 2016 17:04:37 +0200
Message-ID: <20161122170346-mutt-send-email-mst__49522.0533725389$1479827092$gmane$org@kernel.org>
References: <1479793910-120188-1-git-send-email-arei.gonglei@huawei.com>
	<1479793910-120188-3-git-send-email-arei.gonglei@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <1479793910-120188-3-git-send-email-arei.gonglei@huawei.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Gonglei <arei.gonglei@huawei.com>
Cc: thuth@redhat.com, david@gibson.dropbear.id.au, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

On Tue, Nov 22, 2016 at 01:51:50PM +0800, Gonglei wrote:
>  # make C=2 CF="-D__CHECK_ENDIAN__" ./drivers/virtio/
> 
> drivers/virtio/virtio_ring.c:423:19: warning: incorrect type in assignment (different base types)
> drivers/virtio/virtio_ring.c:423:19:    expected unsigned int [unsigned] [assigned] i
> drivers/virtio/virtio_ring.c:423:19:    got restricted __virtio16 [usertype] next
> drivers/virtio/virtio_ring.c:423:19: warning: incorrect type in assignment (different base types)
> drivers/virtio/virtio_ring.c:423:19:    expected unsigned int [unsigned] [assigned] i
> drivers/virtio/virtio_ring.c:423:19:    got restricted __virtio16 [usertype] next
> drivers/virtio/virtio_ring.c:423:19: warning: incorrect type in assignment (different base types)
> drivers/virtio/virtio_ring.c:423:19:    expected unsigned int [unsigned] [assigned] i
> drivers/virtio/virtio_ring.c:423:19:    got restricted __virtio16 [usertype] next
> drivers/virtio/virtio_ring.c:604:39: warning: incorrect type in initializer (different base types)
> drivers/virtio/virtio_ring.c:604:39:    expected unsigned short [unsigned] [usertype] nextflag
> drivers/virtio/virtio_ring.c:604:39:    got restricted __virtio16
> drivers/virtio/virtio_ring.c:612:33: warning: restricted __virtio16 degrades to integer
> 
> Signed-off-by: Gonglei <arei.gonglei@huawei.com>
> ---
>  drivers/virtio/virtio_ring.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
> index 489bfc6..d2863c3 100644
> --- a/drivers/virtio/virtio_ring.c
> +++ b/drivers/virtio/virtio_ring.c
> @@ -420,7 +420,7 @@ static inline int virtqueue_add(struct virtqueue *_vq,
>  		if (i == err_idx)
>  			break;
>  		vring_unmap_one(vq, &desc[i]);
> -		i = vq->vring.desc[i].next;
> +		i = virtio16_to_cpu(_vq->vdev, vq->vring.desc[i].next);
>  	}
>  
>  	vq->vq.num_free += total_sg;
> @@ -601,7 +601,7 @@ bool virtqueue_kick(struct virtqueue *vq)
>  static void detach_buf(struct vring_virtqueue *vq, unsigned int head)
>  {
>  	unsigned int i, j;
> -	u16 nextflag = cpu_to_virtio16(vq->vq.vdev, VRING_DESC_F_NEXT);
> +	__virtio16 nextflag = cpu_to_virtio16(vq->vq.vdev, VRING_DESC_F_NEXT);
>  
>  	/* Clear data ptr. */
>  	vq->desc_state[head].data = NULL;
> -- 
> 1.8.3.1
> 

Wow are you saying endian-ness is all wrong for the next field?
How do things ever work then?

-- 
MST
