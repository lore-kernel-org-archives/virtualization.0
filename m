From: Stefano Garzarella <sgarzare@redhat.com>
Subject: Re: [PATCH net] vsock/virtio: postpone packet delivery to monitoring
 devices
Date: Fri, 24 Apr 2020 12:35:15 +0200
Message-ID: <20200424103515.v62vldnnmtz3r6dm@steredhat>
References: <20200421092527.41651-1-sgarzare@redhat.com>
 <20200421154246.GA47385@stefanha-x1.localdomain>
 <20200421161724.c3pnecltfz4jajww@steredhat>
 <20200422165420.GL47385@stefanha-x1.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20200422165420.GL47385@stefanha-x1.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: Stefan Hajnoczi <stefanha@gmail.com>, davem@davemloft.net, Gerard Garcia <ggarcia@abra.uab.cat>, kvm@vger.kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, Jakub Kicinski <kuba@kernel.org>
List-Id: virtualization@lists.linuxfoundation.org

On Wed, Apr 22, 2020 at 05:54:20PM +0100, Stefan Hajnoczi wrote:
> On Tue, Apr 21, 2020 at 06:17:24PM +0200, Stefano Garzarella wrote:
> > On Tue, Apr 21, 2020 at 04:42:46PM +0100, Stefan Hajnoczi wrote:
> > > On Tue, Apr 21, 2020 at 11:25:27AM +0200, Stefano Garzarella wrote:
> > > > We delivering packets to monitoring devices, before to check if
> > > > the virtqueue has enough space.
> > > 
> > > "We [are] delivering packets" and "before to check" -> "before
> > > checking".  Perhaps it can be rewritten as:
> > > 
> > >   Packets are delivered to monitoring devices before checking if the
> > >   virtqueue has enough space.
> > > 
> > 
> > Yeah, it is better :-)
> > 
> > > > 
> > > > If the virtqueue is full, the transmitting packet is queued up
> > > > and it will be sent in the next iteration. This causes the same
> > > > packet to be delivered multiple times to monitoring devices.
> > > > 
> > > > This patch fixes this issue, postponing the packet delivery
> > > > to monitoring devices, only when it is properly queued in the
> > > 
> > > s/,//
> > > 
> > > > virqueue.
> > > 
> > > s/virqueue/virtqueue/
> > > 
> > 
> > Thanks, I'll fix in the v2!
> > 
> > > > @@ -137,6 +135,11 @@ virtio_transport_send_pkt_work(struct work_struct *work)
> > > >  			break;
> > > >  		}
> > > >  
> > > > +		/* Deliver to monitoring devices all correctly transmitted
> > > > +		 * packets.
> > > > +		 */
> > > > +		virtio_transport_deliver_tap_pkt(pkt);
> > > > +
> > > 
> > > The device may see the tx packet and therefore receive a reply to it
> > > before we can call virtio_transport_deliver_tap_pkt().  Does this mean
> > > that replies can now appear in the packet capture before the transmitted
> > > packet?
> > 
> > hmm, you are right!
> > 
> > And the same thing can already happen in vhost-vsock where we call
> > virtio_transport_deliver_tap_pkt() after the vhost_add_used(), right?
> > 
> > The vhost-vsock case can be fixed in a simple way, but here do you think
> > we should serialize them? (e.g. mutex, spinlock)
> > 
> > In this case I'm worried about performance.
> > 
> > Or is there some virtqueue API to check availability?
> 
> Let's stick to the same semantics as Ethernet netdevs.  That way there
> are no surprises to anyone who is familiar with Linux packet captures.
> I don't know what those semantics are though, you'd need to check the
> code :).

IIUC, the packet is delivered to tap/monitoring devices before to call
the xmit() callback provided by the NIC driver.

At that point, if the packet is delayed/dropped/retransmitted by the driver
or the NIC, the monitoring application is not aware.

So, I think we can delivery it the first time that we see the packet,
before to queue it in the virtqueue (I should revert this change and fix
vhost-vsock), setting a flag in the 'struct virtio_vsock_pkt' to avoid
to delivery it multiple times.

I mean something like this:
--- a/net/vmw_vsock/virtio_transport_common.c
+++ b/net/vmw_vsock/virtio_transport_common.c
@@ -157,7 +157,11 @@ static struct sk_buff *virtio_transport_build_skb(void *opaque)

 void virtio_transport_deliver_tap_pkt(struct virtio_vsock_pkt *pkt)
 {
+       if (pkt->tap_delivered)
+               return;
+
        vsock_deliver_tap(virtio_transport_build_skb, pkt);
+       pkt->tap_delivered = true;
 }
 EXPORT_SYMBOL_GPL(virtio_transport_deliver_tap_pkt);


Let me know if you think it is a bad idea.

I'll send a v2 whit these changes.

Thanks,
Stefano
