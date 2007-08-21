From: Gregory Haskins <ghaskins@novell.com>
Subject: RE: [kvm-devel] [PATCH 00/10] PV-IO v3
Date: Tue, 21 Aug 2007 12:47:44 -0400
Message-ID: <1187714864.4363.358.camel__13019.5337035277$1187715160$gmane$org@ghaskins-t60p.haskins.net>
References: <20070816231357.8044.55943.stgit@ghaskins-t60p.haskins.net>
	<1187313953.6449.70.camel@localhost.localdomain>
	<1187328402.4363.110.camel@ghaskins-t60p.haskins.net>
	<1187336618.6449.106.camel@localhost.localdomain>
	<1187358614.4363.135.camel@ghaskins-t60p.haskins.net>
	<1187652496.19435.141.camel@localhost.localdomain>
	<64F9B87B6B770947A9F8391472E032160D464FEB@ehost011-8.exch011.intermedia.net>
	<1187683122.19435.171.camel@localhost.localdomain>
	<1187697638.4363.277.camel@ghaskins-t60p.haskins.net>
	<1187704038.19435.194.camel@localhost.localdomain>
	<1187705162.4363.323.camel@ghaskins-t60p.haskins.net>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1187705162.4363.323.camel@ghaskins-t60p.haskins.net>
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
Cc: kvm-devel@lists.sourceforge.net, Dor Laor <dor.laor@qumranet.com>, virtualization <virtualization@lists.linux-foundation.org>
List-Id: virtualization@lists.linuxfoundation.org

On Tue, 2007-08-21 at 10:06 -0400, Gregory Haskins wrote:
> On Tue, 2007-08-21 at 23:47 +1000, Rusty Russell wrote:
> > 
> > 	In the guest -> host direction, an interface like virtio is designed
> > for batching, with the explicit distinction between add_buf & sync.
> 
> Right.  IOQ has "iter_push()" and "signal()" as synonymous operations.

Hi Rusty,
  This reminded me of an area that I thought might have been missing in
virtio compared to IOQ.  That is, flexibility in the io-completion via
the distinction between "signal" and "sync".  sync() implies that its a
blocking call based on the full drain of the queue, correct?  the
ioq_signal() operation is purely a "kick".  You can, of course, still
implement synchronous functions with a higher layer construct such as
the ioq->wq.  For example:

void send_sync(struct ioq *ioq, struct sk_buff *skb)
{
	DECLARE_WAITQUEUE(wait, current);
   	struct ioq_iterator iter;

	ioq_iter_init(ioq, &iter, ioq_idxtype_inuse, IOQ_ITER_AUTOUPDATE);

	ioq_iter_seek(&iter, ioq_seek_head, 0, 0);

	/* Update the iter.desc->ptr with skb details */

	mb();
	iter.desc->valid = 1;
	iter.desc->sown  = 1; /* give ownership to the south */
	mb();

	ioq_iter_push(&iter, 0);

	add_wait_queue(&ioq->wq, &wait);
	set_current_state(TASK_UNINTERRUPTIBLE);

	/* Wait until we own it again */
	while (!iter.desc->sown)
		schedule();

	set_current_state(TASK_RUNNING);
	remove_wait_queue(&ioq->wq, &wait);
}

But really the goal behind this design was to allow for fine-grained
selection of how io-completion is notified.  E.g.  callback (e.g.
interrupt-driven) deferred reclaimation/reaping (see
ioqnet_tx_complete), sleeping-wait via ioq->wq, busy-wait, etc.

Is there a way to do something similar in virtio? (and forgive me if
there is..I still haven't seen the code).  And if not and people like
that idea, what would be a good way to add it to the interface?

Regards,
-Greg
