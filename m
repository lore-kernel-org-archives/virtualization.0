From: Kent Overstreet <kmo@daterainc.com>
Subject: Re: [PATCH-v3 1/4] idr: Percpu ida
Date: Mon, 26 Aug 2013 13:23:54 -0700
Message-ID: <20130826202354.GB13621__8699.52631551332$1377548638$gmane$org@kmo-pixel>
References: <1376694549-20609-1-git-send-email-nab@linux-iscsi.org>
	<1376694549-20609-2-git-send-email-nab@linux-iscsi.org>
	<00000140a2203fca-f2e76962-a285-4e93-b200-bb05d6501f24-000000@email.amazonses.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <00000140a2203fca-f2e76962-a285-4e93-b200-bb05d6501f24-000000@email.amazonses.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Christoph Lameter <cl@linux.com>
Cc: Jens Axboe <axboe@kernel.dk>, Andi Kleen <andi@firstfloor.org>, kvm-devel <kvm@vger.kernel.org>, "Michael S. Tsirkin" <mst@redhat.com>, lkml <linux-kernel@vger.kernel.org>, lf-virt <virtualization@lists.linux-foundation.org>, target-devel <target-devel@vger.kernel.org>, Oleg Nesterov <oleg@redhat.com>, Tejun Heo <tj@kernel.org>, Ingo Molnar <mingo@redhat.com>, Andrew Morton <akpm@linux-foundation.org>
List-Id: virtualization@lists.linuxfoundation.org

On Wed, Aug 21, 2013 at 06:25:58PM +0000, Christoph Lameter wrote:
> On Fri, 16 Aug 2013, Nicholas A. Bellinger wrote:
> 
> > +	spinlock_t			lock;
> 
> Remove the spinlock.

As Andrew noted, the spinlock is needed because of tag stealing. (You
don't think I'd stick a spinlock on a percpu data structure without a
real reason, would you?)

> > +	unsigned			nr_free;
> > +	unsigned			freelist[];
> > +};
> > +
> > +static inline void move_tags(unsigned *dst, unsigned *dst_nr,
> > +			     unsigned *src, unsigned *src_nr,
> > +			     unsigned nr)
> > +{
> > +	*src_nr -= nr;
> > +	memcpy(dst + *dst_nr, src + *src_nr, sizeof(unsigned) * nr);
> > +	*dst_nr += nr;
> > +}
> > +
> 
> > +static inline unsigned alloc_local_tag(struct percpu_ida *pool,
> > +				       struct percpu_ida_cpu *tags)
> 
> Pass the __percpu offset and not the tags pointer.

Why? It just changes where the this_cpu_ptr

> 
> > +{
> > +	int tag = -ENOSPC;
> > +
> > +	spin_lock(&tags->lock);
> 
> Interupts are already disabled. Drop the spinlock.
> 
> > +	if (tags->nr_free)
> > +		tag = tags->freelist[--tags->nr_free];
> 
> You can keep this or avoid address calculation through segment prefixes.
> F.e.
> 
> if (__this_cpu_read(tags->nrfree) {
> 	int n = __this_cpu_dec_return(tags->nr_free);
> 	tag =  __this_cpu_read(tags->freelist[n]);
> }

Can you explain what the point of that change would be? It sounds like
it's preferable to do it that way and avoid this_cpu_ptr() for some
reason, but you're not explaining why.
