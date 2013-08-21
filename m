From: Christoph Lameter <cl@linux.com>
Subject: Re: [PATCH-v3 1/4] idr: Percpu ida
Date: Wed, 21 Aug 2013 18:25:58 +0000
Message-ID: <00000140a2203fca-f2e76962-a285-4e93-b200-bb05d6501f24-000000@email.amazonses.com>
References: <1376694549-20609-1-git-send-email-nab@linux-iscsi.org>
	<1376694549-20609-2-git-send-email-nab@linux-iscsi.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1376694549-20609-2-git-send-email-nab@linux-iscsi.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: "Nicholas A. Bellinger" <nab@linux-iscsi.org>
Cc: Jens Axboe <axboe@kernel.dk>, Andi Kleen <andi@firstfloor.org>, kvm-devel <kvm@vger.kernel.org>, "Michael S. Tsirkin" <mst@redhat.com>, lkml <linux-kernel@vger.kernel.org>, lf-virt <virtualization@lists.linux-foundation.org>, Kent Overstreet <kmo@daterainc.com>, target-devel <target-devel@vger.kernel.org>, Oleg Nesterov <oleg@redhat.com>, Tejun Heo <tj@kernel.org>, Ingo Molnar <mingo@redhat.com>, Andrew Morton <akpm@linux-foundation.org>
List-Id: virtualization@lists.linuxfoundation.org

On Fri, 16 Aug 2013, Nicholas A. Bellinger wrote:

> +	spinlock_t			lock;

Remove the spinlock.

> +	unsigned			nr_free;
> +	unsigned			freelist[];
> +};
> +
> +static inline void move_tags(unsigned *dst, unsigned *dst_nr,
> +			     unsigned *src, unsigned *src_nr,
> +			     unsigned nr)
> +{
> +	*src_nr -= nr;
> +	memcpy(dst + *dst_nr, src + *src_nr, sizeof(unsigned) * nr);
> +	*dst_nr += nr;
> +}
> +

> +static inline unsigned alloc_local_tag(struct percpu_ida *pool,
> +				       struct percpu_ida_cpu *tags)

Pass the __percpu offset and not the tags pointer.

> +{
> +	int tag = -ENOSPC;
> +
> +	spin_lock(&tags->lock);

Interupts are already disabled. Drop the spinlock.

> +	if (tags->nr_free)
> +		tag = tags->freelist[--tags->nr_free];

You can keep this or avoid address calculation through segment prefixes.
F.e.

if (__this_cpu_read(tags->nrfree) {
	int n = __this_cpu_dec_return(tags->nr_free);
	tag =  __this_cpu_read(tags->freelist[n]);
}

> +	spin_unlock(&tags->lock);

Drop.

> + * Returns a tag - an integer in the range [0..nr_tags) (passed to
> + * tag_pool_init()), or otherwise -ENOSPC on allocation failure.
> + *
> + * Safe to be called from interrupt context (assuming it isn't passed
> + * __GFP_WAIT, of course).
> + *
> + * Will not fail if passed __GFP_WAIT.
> + */
> +int percpu_ida_alloc(struct percpu_ida *pool, gfp_t gfp)
> +{
> +	DEFINE_WAIT(wait);
> +	struct percpu_ida_cpu *tags;
> +	unsigned long flags;
> +	int tag;
> +
> +	local_irq_save(flags);
> +	tags = this_cpu_ptr(pool->tag_cpu);

You could drop this_cpu_ptr if you pass pool->tag_cpu to alloc_local_tag.

> +/**
> + * percpu_ida_free - free a tag
> + * @pool: pool @tag was allocated from
> + * @tag: a tag previously allocated with percpu_ida_alloc()
> + *
> + * Safe to be called from interrupt context.
> + */
> +void percpu_ida_free(struct percpu_ida *pool, unsigned tag)
> +{
> +	struct percpu_ida_cpu *tags;
> +	unsigned long flags;
> +	unsigned nr_free;
> +
> +	BUG_ON(tag >= pool->nr_tags);
> +
> +	local_irq_save(flags);
> +	tags = this_cpu_ptr(pool->tag_cpu);
> +
> +	spin_lock(&tags->lock);

No need for spinlocking
> +	tags->freelist[tags->nr_free++] = tag;

nr_free = __this_cpu_inc_return(pool->tag_cpu.nr_free) ?

__this_cpu_write(pool->tag_cpu.freelist[nr_free], tag)
