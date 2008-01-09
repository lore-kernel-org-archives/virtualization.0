From: Dor Laor <dor.laor@gmail.com>
Subject: Re: [PATCH] Increase the tx queue to 512 descriptors to fix
	performance problem.
Date: Wed, 09 Jan 2008 16:38:47 +0200
Message-ID: <1199889527.4382.28.camel__11785.4029442698$1199889627$gmane$org@localhost.localdomain>
References: <1199885016.4382.22.camel@localhost.localdomain>
	<4784DA51.7080507@us.ibm.com>
Reply-To: dor.laor@qumranet.com
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <4784DA51.7080507@us.ibm.com>
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
Cc: kvm-devel <kvm-devel@lists.sourceforge.net>, "virtualization@lists.linux-foundation.org" <virtualization@lists.linux-foundation.org>
List-Id: virtualization@lists.linuxfoundation.org


On Wed, 2008-01-09 at 08:29 -0600, Anthony Liguori wrote:
> Dor Laor wrote:
> > Now that we have a host timer based tx wakeup it waits for 64
> > packets or timeout before processing them.
> > This might cause the guest to run out of tx buffers while the host
> > holds them up.
> >   
> 
> There's a proper fix that Rusty added last night.

This is with his latest patch, without it I got a lot of
"printk("Unlikely: restart svq failed\n");"
+ The performance is much better now.

> 
> > This is a temporal solution to quickly bring back performance to 800mbps.
> > But a better fix will soon be sent (its not the only problem).
> >   
> 
> How are you doing performance testing?

Not really, this was just to stabilize the module.
It needs some more work, disable/enable of the device is broken.

> 
> Regards,
> 
> Anthony Liguori
> 
> > Signed-off-by: Dor Laor <dor.laor@qumranet.com>
> > ---
> >  qemu/hw/virtio-net.c |    2 +-
> >  1 files changed, 1 insertions(+), 1 deletions(-)
> >
> > diff --git a/qemu/hw/virtio-net.c b/qemu/hw/virtio-net.c
> > index 777fe2c..3d07b65 100644
> > --- a/qemu/hw/virtio-net.c
> > +++ b/qemu/hw/virtio-net.c
> > @@ -293,7 +293,7 @@ void *virtio_net_init(PCIBus *bus, NICInfo *nd, int devfn)
> >      n->vdev.update_config = virtio_net_update_config;
> >      n->vdev.get_features = virtio_net_get_features;
> >      n->rx_vq = virtio_add_queue(&n->vdev, 512, virtio_net_handle_rx);
> > -    n->tx_vq = virtio_add_queue(&n->vdev, 128, virtio_net_handle_tx);
> > +    n->tx_vq = virtio_add_queue(&n->vdev, 512, virtio_net_handle_tx);
> >      n->can_receive = 0;
> >      memcpy(n->mac, nd->macaddr, 6);
> >      n->vc = qemu_new_vlan_client(nd->vlan, virtio_net_receive,
> >   
> 
