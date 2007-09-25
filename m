From: Rusty Russell <rusty@rustcorp.com.au>
Subject: Re: [kvm-devel] [PATCH 2/3] virtio ring implementation
Date: Tue, 25 Sep 2007 23:32:36 +1000
Message-ID: <1190727156.27805.332.camel__8371.19177817858$1190727310$gmane$org@localhost.localdomain>
References: <1190625194.27805.199.camel@localhost.localdomain>
	<1190625256.27805.201.camel@localhost.localdomain>
	<1190625307.27805.203.camel@localhost.localdomain>
	<46F7BF41.9060705@qumranet.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <46F7BF41.9060705@qumranet.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: dor.laor@qumranet.com
Cc: kvm-devel <kvm-devel@lists.sourceforge.net>, virtualization <virtualization@lists.linux-foundation.org>
List-Id: virtualization@lists.linuxfoundation.org

On Mon, 2007-09-24 at 15:44 +0200, Dor Laor wrote:
> Rusty Russell wrote: 
> > +irqreturn_t vring_interrupt(int irq, void *_vq)
> > +{
> > +       struct vring_virtqueue *vq = to_vvq(_vq);
> > +
> > +       pr_debug("virtqueue interrupt for %p\n", vq);
> > +
> > +       if (unlikely(vq->broken))
> > +               return IRQ_HANDLED;
> > +
> > +       if (more_used(vq)) {
> > +               pr_debug("virtqueue callback for %p (%p)\n",
> > +                        vq, vq->vq.callback);
> > +               if (!vq->vq.callback)
> > +                       return IRQ_NONE;
> > +               if (!vq->vq.callback(&vq->vq))
> > +                       vq->vring.avail->flags |=
> > VRING_AVAIL_F_NO_INTERRUPT;
> > +       } else
> > +               pr_debug("virtqueue %p no more used\n", vq);
> > +
> > +       return IRQ_HANDLED;
> > +}
> > +
> > 
> Seems like there is a problem with shared irq line, the interrupt
> handler always returns IRQ_HANDLED (except for the trivial case
> were the callback is null).

To reply for a second time, this time with thought.  Sorry.

Yes, this code is wrong.  It should be:

irqreturn_t vring_interrupt(int irq, void *_vq)
{
	struct vring_virtqueue *vq = to_vvq(_vq);

	if (!more_used(vq)) {
		pr_debug("virtqueue interrupt with no work for %p\n", vq);
		return IRQ_NONE;
	}

	if (unlikely(vq->broken))
		return IRQ_HANDLED;

	pr_debug("virtqueue callback for %p (%p)\n", vq, vq->vq.callback);
	if (vq->vq.callback && !vq->vq.callback(&vq->vq))
		vq->vring.avail->flags |= VRING_AVAIL_F_NO_INTERRUPT;

	return IRQ_HANDLED;
}

Cheers,
Rusty.
