From: George Cherian <gcherian@caviumnetworks.com>
Subject: Re: [PATCH] ptr_ring: add barriers
Date: Wed, 6 Dec 2017 14:51:41 +0530
Message-ID: <7d1ce1b5-edba-b017-3131-37405f1b0c24__25903.2535869212$1513195085$gmane$org@caviumnetworks.com>
References: <1512501990-30029-1-git-send-email-mst@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1512501990-30029-1-git-send-email-mst@redhat.com>
Content-Language: en-US
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: "Michael S. Tsirkin" <mst@redhat.com>, linux-kernel@vger.kernel.org
Cc: George Cherian <george.cherian@cavium.com>, netdev@vger.kernel.org, virtualization@lists.linux-foundation.org, edumazet@google.com, davem@davemloft.net
List-Id: virtualization@lists.linuxfoundation.org

Hi Michael,


On 12/06/2017 12:59 AM, Michael S. Tsirkin wrote:
> Users of ptr_ring expect that it's safe to give the
> data structure a pointer and have it be available
> to consumers, but that actually requires an smb_wmb
> or a stronger barrier.
This is not the exact situation we are seeing.
Let me try to explain the situation

Affected on ARM64 platform.
1) tun_net_xmit calls skb_array_produce, which pushes the skb to the 
ptr_ring, this push is protected by a producer_lock.

2)Prior to this call the tun_net_xmit calls skb_orphan which calls the 
skb->destructor and sets skb->destructor and skb->sk as NULL.

2.a) These 2 writes are getting reordered

3) At the same time in the receive side (tun_ring_recv), which gets 
executed in another core calls skb_array_consume which pulls the skb 
from  ptr ring, this pull is protected by a consumer lock.

4) eventually calling the skb->destructor (sock_wfree) with stale values.

Also note that this issue is reproducible in a long run and doesn't 
happen immediately after the launch of multiple VM's (infact the 
particular test cases launches 56 VM's which does iperf back and forth)

> 
> In absence of such barriers and on architectures that reorder writes,
> consumer might read an un=initialized value from an skb pointer stored
> in the skb array.  This was observed causing crashes.
> 
> To fix, add memory barriers.  The barrier we use is a wmb, the
> assumption being that producers do not need to read the value so we do
> not need to order these reads.
It is not the case that producer is reading the value, but the consumer 
reading stale value. So we need to have a strict rmb in place .

> 
> Reported-by: George Cherian <george.cherian@cavium.com>
> Suggested-by: Jason Wang <jasowang@redhat.com>
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> ---
> 
> George, could you pls report whether this patch fixes
> the issue for you?
> 
> This seems to be needed in stable as well.
> 
> 
> 
> 
>   include/linux/ptr_ring.h | 9 +++++++++
>   1 file changed, 9 insertions(+)
> 
> diff --git a/include/linux/ptr_ring.h b/include/linux/ptr_ring.h
> index 37b4bb2..6866df4 100644
> --- a/include/linux/ptr_ring.h
> +++ b/include/linux/ptr_ring.h
> @@ -101,12 +101,18 @@ static inline bool ptr_ring_full_bh(struct ptr_ring *r)
>   
>   /* Note: callers invoking this in a loop must use a compiler barrier,
>    * for example cpu_relax(). Callers must hold producer_lock.
> + * Callers are responsible for making sure pointer that is being queued
> + * points to a valid data.
>    */
>   static inline int __ptr_ring_produce(struct ptr_ring *r, void *ptr)
>   {
>   	if (unlikely(!r->size) || r->queue[r->producer])
>   		return -ENOSPC;
>   
> +	/* Make sure the pointer we are storing points to a valid data. */
> +	/* Pairs with smp_read_barrier_depends in __ptr_ring_consume. */
> +	smp_wmb();
> +
>   	r->queue[r->producer++] = ptr;
>   	if (unlikely(r->producer >= r->size))
>   		r->producer = 0;
> @@ -275,6 +281,9 @@ static inline void *__ptr_ring_consume(struct ptr_ring *r)
>   	if (ptr)
>   		__ptr_ring_discard_one(r);
>   
> +	/* Make sure anyone accessing data through the pointer is up to date. */
> +	/* Pairs with smp_wmb in __ptr_ring_produce. */
> +	smp_read_barrier_depends();
>   	return ptr;
>   }
>   
> 
