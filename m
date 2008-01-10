From: Christian Borntraeger <borntraeger@de.ibm.com>
Subject: Re: virtio_net and SMP guests
Date: Thu, 10 Jan 2008 16:39:15 +0100
Message-ID: <200801101639.15995.borntraeger__13252.4692606696$1199979720$gmane$org@de.ibm.com>
References: <200712141312.05562.borntraeger@de.ibm.com>
	<200712181751.24692.rusty@rustcorp.com.au>
	<200801101337.40433.borntraeger@de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <200801101337.40433.borntraeger@de.ibm.com>
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
Cc: kvm-devel <kvm-devel@lists.sourceforge.net>, Anthony Liguori <aliguori@us.ibm.com>, Dor Laor <dor.laor@qumranet.com>
List-Id: virtualization@lists.linuxfoundation.org

Am Donnerstag, 10. Januar 2008 schrieb Christian Borntraeger:
> Am Dienstag, 18. Dezember 2007 schrieb Rusty Russell:
> > To me this points to doing interrupt suppression a different way.  If we
> > have a ->disable_cb() virtio function, and call it before we call
> > netif_rx_schedule, does that fix it?
> 
> The fix looks good and I agree with it.
> 
> There is one problem that I try to find for some days, but the following 
> BUG_ON triggers:
> 
> static void vring_disable_cb(struct virtqueue *_vq)
> {
>         struct vring_virtqueue *vq = to_vvq(_vq);
> 
>         START_USE(vq);
> ---->   BUG_ON(vq->vring.avail->flags & VRING_AVAIL_F_NO_INTERRUPT);
>         vq->vring.avail->flags |= VRING_AVAIL_F_NO_INTERRUPT;
>         END_USE(vq);
> }

Ok, I found it:

static int virtnet_open(struct net_device *dev)
{
        struct virtnet_info *vi = netdev_priv(dev);
        try_fill_recv(vi);
        /* If we didn't even get one input buffer, we're useless. */
        if (vi->num == 0)
                return -ENOMEM;
					---> int for new packet
					static void skb_recv_done(struct virtqueue *rvq)
					{
        					struct virtnet_info *vi = rvq->vdev->priv;
					        /* Suppress further interrupts. */
					        rvq->vq_ops->disable_cb(rvq);
					        netif_rx_schedule(vi->dev, &vi->napi);
					}
					- poll is not yet possible, no softirq
					- return from interrupt
        napi_enable(&vi->napi);
	vi->rvq->vq_ops->disable_cb(vi->rvq);
					---> BUG: its already disabled

Christian
