From: Amos Kong <akong@redhat.com>
Subject: Re: [PATCH] virtio-spec: set mac address by a new vq command
Date: Thu, 17 Jan 2013 14:34:17 +0800
Message-ID: <20130117063417.GB12468@t430s.redhat.com>
References: <1358321604-11712-1-git-send-email-akong@redhat.com>
	<20130116091328.GA6931@stefanha-thinkpad.redhat.com>
	<20130116092223.GC12723@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20130116092223.GC12723@redhat.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: kvm@vger.kernel.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

On Wed, Jan 16, 2013 at 11:22:23AM +0200, Michael S. Tsirkin wrote:
> On Wed, Jan 16, 2013 at 10:13:28AM +0100, Stefan Hajnoczi wrote:
> > On Wed, Jan 16, 2013 at 03:33:24PM +0800, akong@redhat.com wrote:
> > > +\change_inserted -1930653948 1358320004
> > > +The command VIRTIO_NET_CTRL_MAC_ADDR_SET is used to set 
> > > +\begin_inset Quotes eld
> > > +\end_inset
> > > +
> > > +physical
> > > +\begin_inset Quotes erd
> > > +\end_inset
> > > +
> > > + address of the network card.
> > 
> > The "physical" address of the network card?  That term is not defined
> > anywhere in the specification.

I will replace it with 'the default MAC address'

> > Perhaps it's best to explain that the config space "mac" field and
> > VIRTIO_NET_CTRL_MAC_ADDR_SET both set the default MAC address which rx
> > filtering accepts.  (The MAC table is an additional set of MAC addresses
> > which rx filtering accepts.)
> > 
> > It would also be worth explaining that VIRTIO_NET_CTRL_MAC_ADDR_SET is
> > atomic whereas the config space "mac" field is not.  Therefore,
> > VIRTIO_NET_CTRL_MAC_ADDR_SET is preferred, especially while the NIC is
> > up.

Ok, will send a v2, thanks.

> > Stefan
 
> It's probably best to simply make the config space field
> read-only if the feature bit is acked.

It's reasonable.

diff --git a/hw/virtio-net.c b/hw/virtio-net.c
index c18e276..54c5eae 100644
--- a/hw/virtio-net.c
+++ b/hw/virtio-net.c
@@ -93,7 +93,8 @@ static void virtio_net_set_config(VirtIODevice
*vdev, const uint8_t *config)
 
     memcpy(&netcfg, config, sizeof(netcfg));
 
-    if (memcmp(netcfg.mac, n->mac, ETH_ALEN)) {
+    if (!(n->vdev.guest_features >> VIRTIO_NET_F_CTRL_MAC_ADDR & 1) &&
+        memcmp(netcfg.mac, n->mac, ETH_ALEN)) {
         memcpy(n->mac, netcfg.mac, ETH_ALEN);
         qemu_format_nic_info_str(&n->nic->nc, n->mac);
     }
