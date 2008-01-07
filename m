From: Rusty Russell <rusty@rustcorp.com.au>
Subject: Re: [PATCH][RESEND] Relax BUG_ON()s when enabling/disabling
	virt_ring interrupts
Date: Mon, 7 Jan 2008 14:27:31 +1100
Message-ID: <200801071427.31369.rusty@rustcorp.com.au>
References: <11995874312740-git-send-email-aliguori@us.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <11995874312740-git-send-email-aliguori@us.ibm.com>
Content-Disposition: inline
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Anthony Liguori <aliguori@us.ibm.com>
Cc: virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

On Sunday 06 January 2008 13:43:51 Anthony Liguori wrote:
> Currently, the virt_ring->enable_cb and virt_ring->disable_cb functions
> enforce that they were called only when callbacks were disabled and enabled
> respectively.  However, in the current vring implementation, this isn't
> actually a bug.  What's more, the virtio_net driver does not guard against
> double enabling or double disabling.  All that needs to happen is for an rx
> notification to happen twice beforce the virtnet_poll function is invoked
> to trigger the BUG_ON.

BTW, my mailserver never received the this patch the first time.  Disturbing.

But this analysis isn't correct, AFAICT.  rx notification -> skb_recv_done
-> disable_cb.  So the second rx notification should not occur.  Certainly
that's a desirable semantic for virtio users (that disable disables).

Note, however, that the NO_INTERRUPT bit isn't synchronous: the host may be
about to deliver an interrupt and have missed the update.  This seems fair:
it's an optimization, not a hard requirement.  However, I'd prefer to fix
this by checking the bit in the actual interrupt handler, rather than
loosening the requirements which might catch real bugs.

I've managed to convince myself that no synchronization is needed here for
the case of SMP guests and the virtio_net driver (because disable_cb is
called from interrupt context, which have to be serialized so we don't
run the same interrupt handler for the same interrupt at the same time).

Concur?
Rusty.

virtio: handle interrupts after callbacks turned off

Anthony Liguori found double interrupt suppression in the virtio_net
driver, triggered by two skb_recv_done's in a row.  This is because
virtio_ring's interrupt suppression is a best-effort optimization: it
contains no synchronization so the host can miss it and still send
interrupts.

But it's certainly nicer for virtio users if calling disable_cb
actually disables callbacks, so we check for the race in the interrupt
routine.

Note: SMP guests might require syncronization here, but since
disable_cb is actually called from interrupt context, there has to be
some form of synchronization before the next same interrupt handler is
called (Linux guarantees that the same device's irq handler will never
run simultanously on multiple CPUs).

Signed-off-by: Rusty Russell <rusty@rustcorp.com.au>
---
 drivers/virtio/virtio_ring.c |    7 +++++++
 1 file changed, 7 insertions(+)

diff -r 7aea9c3fcd6b drivers/virtio/virtio_ring.c
--- a/drivers/virtio/virtio_ring.c	Sat Jan 05 11:30:17 2008 +1100
+++ b/drivers/virtio/virtio_ring.c	Mon Jan 07 11:39:46 2008 +1100
@@ -265,6 +265,13 @@ irqreturn_t vring_interrupt(int irq, voi
 	if (unlikely(vq->broken))
 		return IRQ_HANDLED;
 
+	/* Other side may have missed us turning off the interrupt,
+	 * but we should preserve disable semantic for virtio users. */
+	if (unlikely(!(vq->vring.avail->flags & VRING_AVAIL_F_NO_INTERRUPT))) {
+		pr_debug("virtqueue interrupt after disable for %p\n", vq);
+		return IRQ_HANDLED;
+	}
+
 	pr_debug("virtqueue callback for %p (%p)\n", vq, vq->vq.callback);
 	if (vq->vq.callback)
 		vq->vq.callback(&vq->vq);
