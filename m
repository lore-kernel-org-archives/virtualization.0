From: Stefan Hajnoczi <stefanha@redhat.com>
Subject: Re: [QEMU PATCH v2] virtio-net: introduce a new macaddr control
Date: Wed, 16 Jan 2013 09:59:14 +0100
Message-ID: <20130116085914.GC6693@stefanha-thinkpad.hitronhub.home>
References: <1358315821-29519-1-git-send-email-akong@redhat.com>
	<1358317007-29972-1-git-send-email-akong@redhat.com>
	<1793480.zqgr4LeT19@jason-thinkpad-t430s>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <1793480.zqgr4LeT19@jason-thinkpad-t430s>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Jason Wang <jasowang@redhat.com>
Cc: mst@redhat.com, qemu-devel@nongnu.org, kvm@vger.kernel.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

On Wed, Jan 16, 2013 at 02:37:34PM +0800, Jason Wang wrote:
> On Wednesday, January 16, 2013 02:16:47 PM akong@redhat.com wrote:
> > From: Amos Kong <akong@redhat.com>
> > 
> > In virtio-net guest driver, currently we write MAC address to
> > pci config space byte by byte, this means that we have an
> > intermediate step where mac is wrong. This patch introduced
> > a new control command to set MAC address in one time.
> > 
> > VIRTIO_NET_F_CTRL_MAC_ADDR is a new feature bit for compatibility.
> > 
> > Signed-off-by: Amos Kong <akong@redhat.com>
> > ---
> > V2: check guest's iov_len before memcpy
> > ---
> >  hw/virtio-net.c | 10 ++++++++++
> >  hw/virtio-net.h |  9 ++++++++-
> >  2 files changed, 18 insertions(+), 1 deletion(-)
> > 
> > diff --git a/hw/virtio-net.c b/hw/virtio-net.c
> > index dc7c6d6..d05f98f 100644
> > --- a/hw/virtio-net.c
> > +++ b/hw/virtio-net.c
> > @@ -247,6 +247,7 @@ static uint32_t virtio_net_get_features(VirtIODevice
> > *vdev, uint32_t features) VirtIONet *n = to_virtio_net(vdev);
> > 
> >      features |= (1 << VIRTIO_NET_F_MAC);
> > +    features |= (1 << VIRTIO_NET_F_CTRL_MAC_ADDR);
> > 
> >      if (!peer_has_vnet_hdr(n)) {
> >          features &= ~(0x1 << VIRTIO_NET_F_CSUM);
> > @@ -282,6 +283,7 @@ static uint32_t virtio_net_bad_features(VirtIODevice
> > *vdev) /* Linux kernel 2.6.25.  It understood MAC (as everyone must), * but
> > also these: */
> >      features |= (1 << VIRTIO_NET_F_MAC);
> > +    features |= (1 << VIRTIO_NET_F_CTRL_MAC_ADDR);
> >      features |= (1 << VIRTIO_NET_F_CSUM);
> >      features |= (1 << VIRTIO_NET_F_HOST_TSO4);
> >      features |= (1 << VIRTIO_NET_F_HOST_TSO6);
> > @@ -349,6 +351,14 @@ static int virtio_net_handle_mac(VirtIONet *n, uint8_t
> > cmd, {
> >      struct virtio_net_ctrl_mac mac_data;
> > 
> > +    if (cmd == VIRTIO_NET_CTRL_MAC_ADDR_SET && elem->out_num == 2 &&
> > +        elem->out_sg[1].iov_len == ETH_ALEN) {
> > +        /* Set MAC address */
> > +        memcpy(n->mac, elem->out_sg[1].iov_base, elem->out_sg[1].iov_len);
> > +        qemu_format_nic_info_str(&n->nic->nc, n->mac);
> > +        return VIRTIO_NET_OK;
> > +    }
> > +
> >      if (cmd != VIRTIO_NET_CTRL_MAC_TABLE_SET || elem->out_num != 3 ||
> >          elem->out_sg[1].iov_len < sizeof(mac_data) ||
> >          elem->out_sg[2].iov_len < sizeof(mac_data))
> > diff --git a/hw/virtio-net.h b/hw/virtio-net.h
> > index d46fb98..9394cc0 100644
> > --- a/hw/virtio-net.h
> > +++ b/hw/virtio-net.h
> > @@ -44,6 +44,8 @@
> >  #define VIRTIO_NET_F_CTRL_VLAN  19      /* Control channel VLAN filtering
> > */ #define VIRTIO_NET_F_CTRL_RX_EXTRA 20   /* Extra RX mode control support
> > */
> > 
> > +#define VIRTIO_NET_F_CTRL_MAC_ADDR   23 /* Set MAC address */
> > +
> 
> I wonder whether we need a DEFINE_PROP_BIT to disable and compat this feature. 
> Consider we may migrate from a new version to an old version.

I agree, migration needs to be handled.  The bit should never change
while the device is initialized and running.  We should also never start
rejecting or ignoring the command if it was available before.

Stefan
