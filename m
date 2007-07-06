From: Rusty Russell <rusty@rustcorp.com.au>
Subject: Re: [PATCH 2/3] Virtio draft IV: the block driver
Date: Fri, 06 Jul 2007 10:33:20 +1000
Message-ID: <1183682000.6005.108.camel__20621.041491586$1183682119$gmane$org@localhost.localdomain>
References: <1183522348.6110.37.camel@localhost.localdomain>
	<1183522765.6110.40.camel@localhost.localdomain>
	<200707050932.50110.borntraeger@de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <200707050932.50110.borntraeger@de.ibm.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Christian Borntraeger <borntraeger@de.ibm.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, Ingo Molnar <mingo@elte.hu>, lkml - Kernel Mailing List <linux-kernel@vger.kernel.org>, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

On Thu, 2007-07-05 at 09:32 +0200, Christian Borntraeger wrote:
> Am Mittwoch, 4. Juli 2007 schrieb Rusty Russell:
> > +		vbr = mempool_alloc(vblk->pool, GFP_ATOMIC);
> > +		if (!vbr)
> > +			goto stop;
> [...]
> > +		BUG_ON(req->nr_phys_segments > ARRAY_SIZE(vblk->sg));
> > +		vbr->req = req;
> > +		if (!do_req(q, vblk, vbr))
> > +			goto stop;
> [...]
> > +stop:
> > +	/* Queue full?  Wait. */
> > +	blk_stop_queue(q);
> > +	mempool_free(vbr, vblk->pool);
> 
> 
> Hmm, can mempool_free really handle NULL as its first argument? (first goto). 

Good point.  Any objections to fixing that?

Cheers,
Rusty.
===
Christian Borntraeger points out that mempool_free() doesn't noop when
handed NULL.  This is inconsistent with the other free-like functions
in the kernel.

Signed-off-by: Rusty Russell <rusty@rustcorp.com.au>

diff -r a306f0a8de5e mm/mempool.c
--- a/mm/mempool.c	Fri Jul 06 10:28:39 2007 +1000
+++ b/mm/mempool.c	Fri Jul 06 10:29:40 2007 +1000
@@ -263,6 +263,9 @@ void mempool_free(void *element, mempool
 {
 	unsigned long flags;
 
+	if (unlikely(element == NULL))
+		return;
+
 	smp_mb();
 	if (pool->curr_nr < pool->min_nr) {
 		spin_lock_irqsave(&pool->lock, flags);
