From: Rusty Russell <rusty@rustcorp.com.au>
Subject: Re: [PATCH][RESEND] Relax BUG_ON()s when enabling/disabling
	virt_ring interrupts
Date: Mon, 7 Jan 2008 15:29:53 +1100
Message-ID: <200801071529.53263.rusty@rustcorp.com.au>
References: <11995874312740-git-send-email-aliguori@us.ibm.com>
	<200801071427.31369.rusty@rustcorp.com.au>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <200801071427.31369.rusty@rustcorp.com.au>
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
To: virtualization@lists.linux-foundation.org
Cc: Anthony Liguori <aliguori@us.ibm.com>
List-Id: virtualization@lists.linuxfoundation.org

On Monday 07 January 2008 14:27:31 Rusty Russell wrote:
> +	/* Other side may have missed us turning off the interrupt,
> +	 * but we should preserve disable semantic for virtio users. */
> +	if (unlikely(!(vq->vring.avail->flags & VRING_AVAIL_F_NO_INTERRUPT))) {
> +		pr_debug("virtqueue interrupt after disable for %p\n", vq);
> +		return IRQ_HANDLED;
> +	}

Of course, this test is exactly backwards.

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

diff -r bdc6894568d1 drivers/virtio/virtio_ring.c
--- a/drivers/virtio/virtio_ring.c	Mon Jan 07 12:28:47 2008 +1100
+++ b/drivers/virtio/virtio_ring.c	Mon Jan 07 15:28:23 2008 +1100
@@ -265,6 +265,13 @@ irqreturn_t vring_interrupt(int irq, voi
 	if (unlikely(vq->broken))
 		return IRQ_HANDLED;
 
+	/* Other side may have missed us turning off the interrupt,
+	 * but we should preserve disable semantic for virtio users. */
+	if (unlikely(vq->vring.avail->flags & VRING_AVAIL_F_NO_INTERRUPT)) {
+		pr_debug("virtqueue interrupt after disable for %p\n", vq);
+		return IRQ_HANDLED;
+	}
+
 	pr_debug("virtqueue callback for %p (%p)\n", vq, vq->vq.callback);
 	if (vq->vq.callback)
 		vq->vq.callback(&vq->vq);
