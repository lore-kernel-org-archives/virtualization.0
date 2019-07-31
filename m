From: Jason Gunthorpe <jgg@ziepe.ca>
Subject: Re: [PATCH V2 7/9] vhost: do not use RCU to synchronize MMU notifier
	with worker
Date: Wed, 31 Jul 2019 09:39:35 -0300
Message-ID: <20190731123935.GC3946__8690.60090496845$1564577573$gmane$org@ziepe.ca>
References: <20190731084655.7024-1-jasowang@redhat.com>
	<20190731084655.7024-8-jasowang@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20190731084655.7024-8-jasowang@redhat.com>
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
Cc: kvm@vger.kernel.org, mst@redhat.com, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, linux-mm@kvack.org
List-Id: virtualization@lists.linuxfoundation.org

On Wed, Jul 31, 2019 at 04:46:53AM -0400, Jason Wang wrote:
> We used to use RCU to synchronize MMU notifier with worker. This leads
> calling synchronize_rcu() in invalidate_range_start(). But on a busy
> system, there would be many factors that may slow down the
> synchronize_rcu() which makes it unsuitable to be called in MMU
> notifier.
> 
> A solution is SRCU but its overhead is obvious with the expensive full
> memory barrier. Another choice is to use seqlock, but it doesn't
> provide a synchronization method between readers and writers. The last
> choice is to use vq mutex, but it need to deal with the worst case
> that MMU notifier must be blocked and wait for the finish of swap in.
> 
> So this patch switches use a counter to track whether or not the map
> was used. The counter was increased when vq try to start or finish
> uses the map. This means, when it was even, we're sure there's no
> readers and MMU notifier is synchronized. When it was odd, it means
> there's a reader we need to wait it to be even again then we are
> synchronized. 

You just described a seqlock.

We've been talking about providing this as some core service from mmu
notifiers because nearly every use of this API needs it.

IMHO this gets the whole thing backwards, the common pattern is to
protect the 'shadow pte' data with a seqlock (usually open coded),
such that the mmu notififer side has the write side of that lock and
the read side is consumed by the thread accessing or updating the SPTE.


> Reported-by: Michael S. Tsirkin <mst@redhat.com>
> Fixes: 7f466032dc9e ("vhost: access vq metadata through kernel virtual address")
> Signed-off-by: Jason Wang <jasowang@redhat.com>
>  drivers/vhost/vhost.c | 145 ++++++++++++++++++++++++++----------------
>  drivers/vhost/vhost.h |   7 +-
>  2 files changed, 94 insertions(+), 58 deletions(-)
> 
> diff --git a/drivers/vhost/vhost.c b/drivers/vhost/vhost.c
> index cfc11f9ed9c9..db2c81cb1e90 100644
> +++ b/drivers/vhost/vhost.c
> @@ -324,17 +324,16 @@ static void vhost_uninit_vq_maps(struct vhost_virtqueue *vq)
>  
>  	spin_lock(&vq->mmu_lock);
>  	for (i = 0; i < VHOST_NUM_ADDRS; i++) {
> -		map[i] = rcu_dereference_protected(vq->maps[i],
> -				  lockdep_is_held(&vq->mmu_lock));
> +		map[i] = vq->maps[i];
>  		if (map[i]) {
>  			vhost_set_map_dirty(vq, map[i], i);
> -			rcu_assign_pointer(vq->maps[i], NULL);
> +			vq->maps[i] = NULL;
>  		}
>  	}
>  	spin_unlock(&vq->mmu_lock);
>  
> -	/* No need for synchronize_rcu() or kfree_rcu() since we are
> -	 * serialized with memory accessors (e.g vq mutex held).
> +	/* No need for synchronization since we are serialized with
> +	 * memory accessors (e.g vq mutex held).
>  	 */
>  
>  	for (i = 0; i < VHOST_NUM_ADDRS; i++)
> @@ -362,6 +361,44 @@ static bool vhost_map_range_overlap(struct vhost_uaddr *uaddr,
>  	return !(end < uaddr->uaddr || start > uaddr->uaddr - 1 + uaddr->size);
>  }
>  
> +static void inline vhost_vq_access_map_begin(struct vhost_virtqueue *vq)
> +{
> +	int ref = READ_ONCE(vq->ref);

Is a lock/single threaded supposed to be held for this?

> +
> +	smp_store_release(&vq->ref, ref + 1);
> +	/* Make sure ref counter is visible before accessing the map */
> +	smp_load_acquire(&vq->ref);

release/acquire semantics are intended to protect blocks of related
data, so reading something with acquire and throwing away the result
is nonsense.

> +}
> +
> +static void inline vhost_vq_access_map_end(struct vhost_virtqueue *vq)
> +{
> +	int ref = READ_ONCE(vq->ref);

If the write to vq->ref is not locked this algorithm won't work, if it
is locked the READ_ONCE is not needed.

> +	/* Make sure vq access is done before increasing ref counter */
> +	smp_store_release(&vq->ref, ref + 1);
> +}
> +
> +static void inline vhost_vq_sync_access(struct vhost_virtqueue *vq)
> +{
> +	int ref;
> +
> +	/* Make sure map change was done before checking ref counter */
> +	smp_mb();

This is probably smp_rmb after reading ref, and if you are setting ref
with smp_store_release then this should be smp_load_acquire() without
an explicit mb.

> +	ref = READ_ONCE(vq->ref);
> +	if (ref & 0x1) {
> +		/* When ref change, we are sure no reader can see
> +		 * previous map */
> +		while (READ_ONCE(vq->ref) == ref) {
> +			set_current_state(TASK_RUNNING);
> +			schedule();
> +		}
> +	}

This is basically read_seqcount_begin()' with a schedule instead of
cpu_relax


> +	/* Make sure ref counter was checked before any other
> +	 * operations that was dene on map. */
> +	smp_mb();

should be in a smp_load_acquire()

> +}
> +
>  static void vhost_invalidate_vq_start(struct vhost_virtqueue *vq,
>  				      int index,
>  				      unsigned long start,
> @@ -376,16 +413,15 @@ static void vhost_invalidate_vq_start(struct vhost_virtqueue *vq,
>  	spin_lock(&vq->mmu_lock);
>  	++vq->invalidate_count;
>  
> -	map = rcu_dereference_protected(vq->maps[index],
> -					lockdep_is_held(&vq->mmu_lock));
> +	map = vq->maps[index];
>  	if (map) {
>  		vhost_set_map_dirty(vq, map, index);
> -		rcu_assign_pointer(vq->maps[index], NULL);
> +		vq->maps[index] = NULL;
>  	}
>  	spin_unlock(&vq->mmu_lock);
>  
>  	if (map) {
> -		synchronize_rcu();
> +		vhost_vq_sync_access(vq);

What prevents racing with vhost_vq_access_map_end here?

>  		vhost_map_unprefetch(map);
>  	}
>  }

Overall I don't like it. 

We are trying to get rid of these botique mmu notifier patterns in
drivers. 

Jason
