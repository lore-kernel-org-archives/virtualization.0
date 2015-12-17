From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH] virtio: use smp_load_acquire/smp_store_release
Date: Thu, 17 Dec 2015 16:47:32 +0200
Message-ID: <20151217164428-mutt-send-email-mst@redhat.com>
References: <1450347930-16275-1-git-send-email-mst@redhat.com>
	<20151217105827.GB6375@twins.programming.kicks-ass.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20151217105827.GB6375@twins.programming.kicks-ass.net>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Peter Zijlstra <peterz@infradead.org>
Cc: qemu-devel@nongnu.org, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

On Thu, Dec 17, 2015 at 11:58:27AM +0100, Peter Zijlstra wrote:
> On Thu, Dec 17, 2015 at 12:29:03PM +0200, Michael S. Tsirkin wrote:
> > +static inline __virtio16 virtio_load_acquire(bool weak_barriers, __virtio16 *p)
> > +{
> > +	if (!weak_barriers) {
> > +		rmb();
> > +		return READ_ONCE(*p);
> > +	}
> > +#ifdef CONFIG_SMP
> > +	return smp_load_acquire(p);
> > +#else
> > +	dma_rmb();
> > +	return READ_ONCE(*p);
> > +#endif
> > +}
> 
> This too is wrong. Look for example at arm.
> 
> dma_rmb() is dmb(osh), while the smp_mb() used by smp_load_acquire() is
> dmb(ish). They order completely different types of memory accesses.
> 
> Also, load_acquire() is first load, then barrier, and an ACQUIRE barrier
> at that, not a READ barrier.

Yes - it just so happens that READ barrier is enough for where I use it
for virtio.

I really just need virtio_load_acquire that fences reads,
I don't care what happens to writes.

Given the confusion, maybe virtio_load_acquire is a bad name though.
Donnu what a good name would be.

virtio_load_acquire_rmb and virtio_store_release_wmb?


> So your #else branch should look something like:
> 
> 	var = READ_ONCE(*p);
> 	dma_mb();
> 	return var;
> 
