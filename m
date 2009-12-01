From: Adam Litke <agl@us.ibm.com>
Subject: Re: virtio: Add memory statistics reporting to the balloon driver (V4)
Date: Tue, 01 Dec 2009 08:49:45 -0600
Message-ID: <1259678985.2816.0.camel__30771.5048002594$1259679138$gmane$org@aglitke>
References: <1259597655.30369.2.camel@aglitke>
	<200912011254.22861.rusty@rustcorp.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <200912011254.22861.rusty@rustcorp.com.au>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Rusty Russell <rusty@rustcorp.com.au>
Cc: linux-kernel@vger.kernel.org, Anthony Liguori <anthony@codemonkey.ws>, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

Thanks Rusty.

Acked-by: Adam Litke <agl@us.ibm.com>

On Tue, 2009-12-01 at 12:54 +1030, Rusty Russell wrote:
> On Tue, 1 Dec 2009 02:44:15 am Adam Litke wrote:
> > Changes since V3:
> 
> OK, I applied this.  And here's the fixes I applied afterwards (to save YA
> round trip: please ack and I'll fold them together)
> 
> virtio: balloon fixes
> 
> 1) Tag and val args to update_stat() are no longer __le.
> 2) pages_to_bytes() should promote to u64 so we don't truncate.
> 3) Fix two checkpatch.pl warnings.
> 
> Signed-off-by: Rusty Russell <rusty@rustcorp.com.au>
> ---
>  drivers/virtio/virtio_balloon.c |    8 +++++---
>  include/linux/virtio_balloon.h  |    3 +--
>  2 files changed, 6 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/virtio/virtio_balloon.c b/drivers/virtio/virtio_balloon.c
> --- a/drivers/virtio/virtio_balloon.c
> +++ b/drivers/virtio/virtio_balloon.c
> @@ -158,14 +158,15 @@ static void leak_balloon(struct virtio_b
>  }
> 
>  static inline void update_stat(struct virtio_balloon *vb, int idx,
> -				__le16 tag, __le64 val)
> +			       u16 tag, u64 val)
>  {
>  	BUG_ON(idx >= VIRTIO_BALLOON_S_NR);
>  	vb->stats[idx].tag = tag;
>  	vb->stats[idx].val = val;
>  }
> 
> -#define pages_to_bytes(x) ((x) << PAGE_SHIFT)
> +#define pages_to_bytes(x) ((u64)(x) << PAGE_SHIFT)
> +
>  static void update_balloon_stats(struct virtio_balloon *vb)
>  {
>  	unsigned long events[NR_VM_EVENT_ITEMS];
> @@ -296,7 +297,8 @@ static int virtballoon_probe(struct virt
>  		 * use it to signal us later.
>  		 */
>  		sg_init_one(&sg, vb->stats, sizeof vb->stats);
> -		if (vb->stats_vq->vq_ops->add_buf(vb->stats_vq, &sg, 1, 0, vb) < 0)
> +		if (vb->stats_vq->vq_ops->add_buf(vb->stats_vq,
> +						  &sg, 1, 0, vb) < 0)
>  			BUG();
>  		vb->stats_vq->vq_ops->kick(vb->stats_vq);
>  	}
> diff --git a/include/linux/virtio_balloon.h b/include/linux/virtio_balloon.h
> --- a/include/linux/virtio_balloon.h
> +++ b/include/linux/virtio_balloon.h
> @@ -28,8 +28,7 @@ struct virtio_balloon_config
>  #define VIRTIO_BALLOON_S_MEMTOT   5   /* Total amount of memory */
>  #define VIRTIO_BALLOON_S_NR       6
> 
> -struct virtio_balloon_stat
> -{
> +struct virtio_balloon_stat {
>  	u16 tag;
>  	u64 val;
>  } __attribute__((packed));
> 
> 


-- 
Thanks,
Adam
