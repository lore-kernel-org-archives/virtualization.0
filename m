From: Amos Kong <akong@redhat.com>
Subject: Re: [QEMU PATCH v4 1/3] virtio-net: remove layout assumptions for
	ctrl vq
Date: Tue, 22 Jan 2013 22:38:14 +0800
Message-ID: <20130122143814.GB4066__34004.9598752104$1358865563$gmane$org@t430s.nay.redhat.com>
References: <1358560468-10865-1-git-send-email-akong@redhat.com>
	<1358560468-10865-2-git-send-email-akong@redhat.com>
	<20130121160330.GC24473@stefanha-thinkpad.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20130121160330.GC24473@stefanha-thinkpad.redhat.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Stefan Hajnoczi <stefanha@gmail.com>
Cc: virtualization@lists.linux-foundation.org, stefanha@redhat.com, qemu-devel@nongnu.org, kvm@vger.kernel.org, mst@redhat.com
List-Id: virtualization@lists.linuxfoundation.org

On Mon, Jan 21, 2013 at 05:03:30PM +0100, Stefan Hajnoczi wrote:
> On Sat, Jan 19, 2013 at 09:54:26AM +0800, akong@redhat.com wrote:
> > From: "Michael S. Tsirkin" <mst@redhat.com>
> > 
> > Virtio-net code makes assumption about virtqueue descriptor layout
> > (e.g. sg[0] is the header, sg[1] is the data buffer).
> > 
> > This patch makes code not rely on the layout of descriptors.
> > 
> > Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> > Signed-off-by: Amos Kong <akong@redhat.com>
> > ---
> >  hw/virtio-net.c | 128 ++++++++++++++++++++++++++++++++------------------------
> >  1 file changed, 74 insertions(+), 54 deletions(-)
> > 
> > diff --git a/hw/virtio-net.c b/hw/virtio-net.c
> > index 3bb01b1..113e194 100644
> > --- a/hw/virtio-net.c
> > +++ b/hw/virtio-net.c
> > @@ -315,44 +315,44 @@ static void virtio_net_set_features(VirtIODevice *vdev, uint32_t features)
> >  }
> >  
> >  static int virtio_net_handle_rx_mode(VirtIONet *n, uint8_t cmd,
> > -                                     VirtQueueElement *elem)
> > +                                     struct iovec *iov, unsigned int iov_cnt)
> >  {
> >      uint8_t on;
> > +    size_t s;
> >  
> > -    if (elem->out_num != 2 || elem->out_sg[1].iov_len != sizeof(on)) {
> > -        error_report("virtio-net ctrl invalid rx mode command");
> > -        exit(1);
> > +    s = iov_to_buf(iov, iov_cnt, 0, &on, sizeof(on));
> > +    if (s != sizeof(on)) {
> > +        return VIRTIO_NET_ERR;
> >      }
> >  
> > -    on = ldub_p(elem->out_sg[1].iov_base);
> > -
> > -    if (cmd == VIRTIO_NET_CTRL_RX_MODE_PROMISC)
> > +    if (cmd == VIRTIO_NET_CTRL_RX_MODE_PROMISC) {
> >          n->promisc = on;
> > -    else if (cmd == VIRTIO_NET_CTRL_RX_MODE_ALLMULTI)
> > +    } else if (cmd == VIRTIO_NET_CTRL_RX_MODE_ALLMULTI) {
> >          n->allmulti = on;
> > -    else if (cmd == VIRTIO_NET_CTRL_RX_MODE_ALLUNI)
> > +    } else if (cmd == VIRTIO_NET_CTRL_RX_MODE_ALLUNI) {
> >          n->alluni = on;
> > -    else if (cmd == VIRTIO_NET_CTRL_RX_MODE_NOMULTI)
> > +    } else if (cmd == VIRTIO_NET_CTRL_RX_MODE_NOMULTI) {
> >          n->nomulti = on;
> > -    else if (cmd == VIRTIO_NET_CTRL_RX_MODE_NOUNI)
> > +    } else if (cmd == VIRTIO_NET_CTRL_RX_MODE_NOUNI) {
> >          n->nouni = on;
> > -    else if (cmd == VIRTIO_NET_CTRL_RX_MODE_NOBCAST)
> > +    } else if (cmd == VIRTIO_NET_CTRL_RX_MODE_NOBCAST) {
> >          n->nobcast = on;
> > -    else
> > +    } else {
> >          return VIRTIO_NET_ERR;
> > +    }
> >  
> >      return VIRTIO_NET_OK;
> >  }
> >  
> >  static int virtio_net_handle_mac(VirtIONet *n, uint8_t cmd,
> > -                                 VirtQueueElement *elem)
> > +                                 struct iovec *iov, unsigned int iov_cnt)
> >  {
> >      struct virtio_net_ctrl_mac mac_data;
> > +    size_t s;
> >  
> > -    if (cmd != VIRTIO_NET_CTRL_MAC_TABLE_SET || elem->out_num != 3 ||
> > -        elem->out_sg[1].iov_len < sizeof(mac_data) ||
> > -        elem->out_sg[2].iov_len < sizeof(mac_data))
> > +    if (cmd != VIRTIO_NET_CTRL_MAC_TABLE_SET) {
> >          return VIRTIO_NET_ERR;
> > +    }
> >  
> >      n->mac_table.in_use = 0;
> >      n->mac_table.first_multi = 0;
> > @@ -360,54 +360,71 @@ static int virtio_net_handle_mac(VirtIONet *n, uint8_t cmd,
> >      n->mac_table.multi_overflow = 0;
> >      memset(n->mac_table.macs, 0, MAC_TABLE_ENTRIES * ETH_ALEN);
> >  
> > -    mac_data.entries = ldl_p(elem->out_sg[1].iov_base);
> > +    s = iov_to_buf(iov, iov_cnt, 0, &mac_data.entries,
> > +                   sizeof(mac_data.entries));

Hi Stefan, can we adjust the endianness after each iov_to_buf() copy?


diff --git a/hw/virtio-net.c b/hw/virtio-net.c
index 72d7857..0088d6c 100644
--- a/hw/virtio-net.c
+++ b/hw/virtio-net.c
@@ -321,6 +321,7 @@ static int virtio_net_handle_rx_mode(VirtIONet *n, uint8_t cmd,
     size_t s;
 
     s = iov_to_buf(iov, iov_cnt, 0, &on, sizeof(on));
+    on = ldub_p(&on);
     if (s != sizeof(on)) {
         return VIRTIO_NET_ERR;
     }
@@ -362,7 +363,7 @@ static int virtio_net_handle_mac(VirtIONet *n, uint8_t cmd,
 
     s = iov_to_buf(iov, iov_cnt, 0, &mac_data.entries,
                    sizeof(mac_data.entries));
-
+    mac_data.entries = ldl_p(&mac_data.entries);
     if (s != sizeof(mac_data.entries)) {
         return VIRTIO_NET_ERR;
     }
@@ -389,7 +390,7 @@ static int virtio_net_handle_mac(VirtIONet *n, uint8_t cmd,
 
     s = iov_to_buf(iov, iov_cnt, 0, &mac_data.entries,
                    sizeof(mac_data.entries));
-
+    mac_data.entries = ldl_p(&mac_data.entries);
     if (s != sizeof(mac_data.entries)) {
         return VIRTIO_NET_ERR;
     }
@@ -421,6 +422,7 @@ static int virtio_net_handle_vlan_table(VirtIONet *n, uint8_t cmd,
     size_t s;
 
     s = iov_to_buf(iov, iov_cnt, 0, &vid, sizeof(vid));
+    vid = lduw_p(&vid);
     if (s != sizeof(vid)) {
         return VIRTIO_NET_ERR;
     }
@@ -458,6 +460,8 @@ static void virtio_net_handle_ctrl(VirtIODevice *vdev, VirtQueue *vq)
         iov = elem.out_sg;
         iov_cnt = elem.out_num;
         s = iov_to_buf(iov, iov_cnt, 0, &ctrl, sizeof(ctrl));
+        ctrl.class = ldub_p(&ctrl.class);
+        ctrl.cmd = ldub_p(&ctrl.class + sizeof(ctrl.class));
         iov_discard_front(&iov, &iov_cnt, sizeof(ctrl));
         if (s != sizeof(ctrl)) {
             status = VIRTIO_NET_ERR;
