From: Dmitry Fleytman <dmitry@daynix.com>
Subject: Re: [PATCH 2/2] virtio-net: dynamic network offloads configuration
Date: Wed, 27 Mar 2013 22:00:42 +0200
Message-ID: <CAGHCxhcVtns4eX_Tb5U4gm6nJX4g80b8LODyffR6ubat12ZXpQ@mail.gmail.com>
References: <1364391798-8058-1-git-send-email-dmitry@daynix.com>
	<1364391798-8058-3-git-send-email-dmitry@daynix.com>
	<20130327152629.GB29249@redhat.com>
	<CAGHCxhdoHtzpFn8+-S7OwWz7frfATzTh_d6SD6ZB+jKN2w2+VA@mail.gmail.com>
	<20130327181120.GC457@redhat.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1782993960447395892=="
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20130327181120.GC457@redhat.com>
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
Cc: Yan Vugenfirer <yan@daynix.com>, Dmitry Fleytman <dfleytma@redhat.com>, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

--===============1782993960447395892==
Content-Type: multipart/alternative; boundary=e89a8f83ac2d71277a04d8ed7f12

--e89a8f83ac2d71277a04d8ed7f12
Content-Type: text/plain; charset=ISO-8859-1

On Wed, Mar 27, 2013 at 8:11 PM, Michael S. Tsirkin <mst@redhat.com> wrote:

> On Wed, Mar 27, 2013 at 07:48:18PM +0200, Dmitry Fleytman wrote:
> > Michael, thanks for review.
> > See my comments inline.
> >
> > On Wed, Mar 27, 2013 at 5:26 PM, Michael S. Tsirkin <mst@redhat.com>
> wrote:
> >
> >     On Wed, Mar 27, 2013 at 03:43:18PM +0200, Dmitry Fleytman wrote:
> >     > From: Dmitry Fleytman <dfleytma@redhat.com>
> >     >
> >     > Virtio-net driver currently negotiates network offloads
> >     > on startup via features mechanism and have no ability to
> >     > change offloads state later.
> >     > This patch introduced a new control command that allows
> >     > to configure device network offloads state dynamically.
> >     > The patch also introduces a new feature flag
> >     > VIRTIO_NET_F_CTRL_OFFLD.
> >     >
> >     > Signed-off-by: Dmitry Fleytman <dfleytma@redhat.com>
> >     > ---
> >     >  hw/virtio-net.c | 110
> >     +++++++++++++++++++++++++++++++++++++++++++++++---------
> >     >  hw/virtio-net.h |  19 ++++++++++
> >     >  2 files changed, 113 insertions(+), 16 deletions(-)
> >     >
> >     > diff --git a/hw/virtio-net.c b/hw/virtio-net.c
> >     > index 4bb49eb..0c23126 100644
> >     > --- a/hw/virtio-net.c
> >     > +++ b/hw/virtio-net.c
> >     > @@ -21,7 +21,7 @@
> >     >  #include "hw/virtio-net.h"
> >     >  #include "hw/vhost_net.h"
> >     >
> >     > -#define VIRTIO_NET_VM_VERSION    11
> >     > +#define VIRTIO_NET_VM_VERSION    12
> >
> >     This will break cross-version migration, we do it differently now:
> >     - disable feature with old machine types
> >
> >     - only pass offloads around if feature set
> >
> >     - same for receive side
> >
> >
> >
> > [DF] Not sure I got your idea.
> > [DF] Current logic aimed ensure proper operation in all old <--> new
> migration
> > cases:
>
> AFAIK if you change VIRTIO_NET_VM_VERSION old host willl fail to parse
> it.
>
> Oh, it could be I missed this. I'll double-check.




>  > [DF] In case of old<-->new migration host doesn't expose
> > VIRTIO_NET_F_CTRL_OFFLD
>
> > [DF] offload feature so guest is unable to use it, after migration to a
> newer
> > host nothing changes.
> > [DF] In case of new<-->old migration all offloads negotiated on startup
> via
> > features will be enabled (old logic)
> > [DF] and guest will be unable to change offloads state via control
> channel
> > anymore.
> > [DF] The second case is a little bit problematic because some offloads
> that
> > were originally disabled
> > [DF] may become enabled after migration but it doesn't look like there
> is a
> > better solution.
> > [DF] Do I miss something?
> >
> >
> >     >
> >     >  #define MAC_TABLE_ENTRIES    64
> >     >  #define MAX_VLAN    (1 << 12)   /* Per 802.1Q definition */
> >     > @@ -360,6 +360,48 @@ static uint32_t
> virtio_net_bad_features(VirtIODevice
> >     *vdev)
> >     >      return features;
> >     >  }
> >     >
> >     > +static void virtio_net_apply_offloads(VirtIONet *n)
> >     > +{
> >     > +    tap_set_offload(qemu_get_subqueue(n->nic, 0)->peer,
> >     > +                    !!(n->curr_offloads &
> >     VIRTIO_NET_OFFLOAD_GUEST_CSUM),
> >     > +                    !!(n->curr_offloads &
> >     VIRTIO_NET_OFFLOAD_GUEST_TSO4),
> >     > +                    !!(n->curr_offloads &
> >     VIRTIO_NET_OFFLOAD_GUEST_TSO6),
> >     > +                    !!(n->curr_offloads &
> VIRTIO_NET_OFFLOAD_GUEST_ECN),
> >     > +                    !!(n->curr_offloads &
> >     VIRTIO_NET_OFFLOAD_GUEST_UFO));
> >     > +}
> >     > +
> >     > +static uint32_t virtio_net_offloads_by_features(uint32_t features)
> >     > +{
> >     > +    uint32_t offloads = 0;
> >     > +
> >     > +    if ((1 << VIRTIO_NET_F_GUEST_CSUM) & features) {
> >     > +        offloads |= VIRTIO_NET_OFFLOAD_GUEST_CSUM;
> >     > +    }
> >     > +
> >     > +    if ((1 << VIRTIO_NET_F_GUEST_TSO4) & features) {
> >     > +        offloads |= VIRTIO_NET_OFFLOAD_GUEST_TSO4;
> >     > +    }
> >     > +
> >     > +    if ((1 << VIRTIO_NET_F_GUEST_TSO6) & features) {
> >     > +        offloads |= VIRTIO_NET_OFFLOAD_GUEST_TSO6;
> >     > +    }
> >     > +
> >     > +    if ((1 << VIRTIO_NET_F_GUEST_ECN) & features) {
> >     > +        offloads |= VIRTIO_NET_OFFLOAD_GUEST_ECN;
> >     > +    }
> >     > +
> >     > +    if ((1 << VIRTIO_NET_F_GUEST_UFO) & features) {
> >     > +        offloads |= VIRTIO_NET_OFFLOAD_GUEST_UFO;
> >     > +    }
> >     > +
> >     > +    return offloads;
> >     > +}
> >     > +
> >     > +static inline uint32_t virtio_net_supported_offloads(VirtIONet *n)
> >     > +{
> >     > +    return
> virtio_net_offloads_by_features(n->vdev.guest_features);
> >     > +}
> >     > +
> >     >  static void virtio_net_set_features(VirtIODevice *vdev, uint32_t
> >     features)
> >     >  {
> >     >      VirtIONet *n = to_virtio_net(vdev);
> >     > @@ -371,12 +413,8 @@ static void
> virtio_net_set_features(VirtIODevice
> >     *vdev, uint32_t features)
> >     >      virtio_net_set_mrg_rx_bufs(n, !!(features & (1 <<
> >     VIRTIO_NET_F_MRG_RXBUF)));
> >     >
> >     >      if (n->has_vnet_hdr) {
> >     > -        tap_set_offload(qemu_get_subqueue(n->nic, 0)->peer,
> >     > -                        (features >> VIRTIO_NET_F_GUEST_CSUM) & 1,
> >     > -                        (features >> VIRTIO_NET_F_GUEST_TSO4) & 1,
> >     > -                        (features >> VIRTIO_NET_F_GUEST_TSO6) & 1,
> >     > -                        (features >> VIRTIO_NET_F_GUEST_ECN)  & 1,
> >     > -                        (features >> VIRTIO_NET_F_GUEST_UFO)  &
> 1);
> >     > +        n->curr_offloads =
> virtio_net_offloads_by_features(features);
> >     > +        virtio_net_apply_offloads(n);
> >     >      }
> >     >
> >     >      for (i = 0;  i < n->max_queues; i++) {
> >     > @@ -422,6 +460,42 @@ static int
> virtio_net_handle_rx_mode(VirtIONet *n,
> >     uint8_t cmd,
> >     >      return VIRTIO_NET_OK;
> >     >  }
> >     >
> >     > +static int virtio_net_handle_offloads(VirtIONet *n, uint8_t cmd,
> >     > +                                     struct iovec *iov, unsigned
> int
> >     iov_cnt)
> >     > +{
> >     > +    uint32_t offloads;
> >     > +    size_t s;
> >     > +
> >     > +    if (!((1 << VIRTIO_NET_F_CTRL_OFFLD) &
> n->vdev.guest_features)) {
> >     > +        return VIRTIO_NET_ERR;
> >     > +    }
> >     > +
> >     > +    s = iov_to_buf(iov, iov_cnt, 0, &offloads, sizeof(offloads));
> >     > +    if (s != sizeof(offloads)) {
> >     > +        return VIRTIO_NET_ERR;
> >     > +    }
> >     > +
> >     > +    if (cmd == VIRTIO_NET_CTRL_OFFLOADS_SET) {
> >     > +        uint32_t supported_offloads;
> >     > +
> >     > +        if (!n->has_vnet_hdr) {
> >     > +            return VIRTIO_NET_ERR;
> >     > +        }
> >     > +
> >     > +        supported_offloads = virtio_net_supported_offloads(n);
> >     > +        if (offloads & ~supported_offloads) {
> >     > +            return VIRTIO_NET_ERR;
> >     > +        }
> >     > +
> >     > +        n->curr_offloads = offloads;
> >     > +        virtio_net_apply_offloads(n);
> >
> >     In the spec you said that only features
> >     available in the offloads can be
> >     enabled. Probably a good idea to validate
> >     and error if that's not the case.
> >
> >
> > [DF] Not sure I understood correctly this part,
> > [DF] Isn't following check enough to ensure this:
> > [DF] > +        supported_offloads = virtio_net_supported_offloads(n);
> > [DF] > +        if (offloads & ~supported_offloads) {
> > [DF] > +            return VIRTIO_NET_ERR;
> >
> >
> >
> >     > +
> >     > +        return VIRTIO_NET_OK;
> >     > +    } else {
> >     > +        return VIRTIO_NET_ERR;
> >     > +    }
> >     > +}
> >     > +
> >     >  static int virtio_net_handle_mac(VirtIONet *n, uint8_t cmd,
> >     >                                   struct iovec *iov, unsigned int
> >     iov_cnt)
> >     >  {
> >     > @@ -590,6 +664,8 @@ static void virtio_net_handle_ctrl(VirtIODevice
> >     *vdev, VirtQueue *vq)
> >     >              status = virtio_net_handle_vlan_table(n, ctrl.cmd,
> iov,
> >     iov_cnt);
> >     >          } else if (ctrl.class == VIRTIO_NET_CTRL_MQ) {
> >     >              status = virtio_net_handle_mq(n, ctrl.cmd, &elem);
> >     > +        } else if (ctrl.class == VIRTIO_NET_CTRL_OFFLOADS) {
> >     > +            status = virtio_net_handle_offloads(n, ctrl.cmd, iov,
> >     iov_cnt);
> >     >          }
> >     >
> >     >          s = iov_from_buf(elem.in_sg, elem.in_num, 0, &status,
> sizeof
> >     (status));
> >     > @@ -1099,6 +1175,7 @@ static void virtio_net_save(QEMUFile *f, void
> >     *opaque)
> >     >              qemu_put_be32(f, n->vqs[i].tx_waiting);
> >     >          }
> >     >      }
> >     > +    qemu_put_be32(f, n->curr_offloads);
> >
> >     >  }
> >     >
> >     >  static int virtio_net_load(QEMUFile *f, void *opaque, int
> version_id)
> >     > @@ -1155,15 +1232,6 @@ static int virtio_net_load(QEMUFile *f, void
> >     *opaque, int version_id)
> >     >              error_report("virtio-net: saved image requires
> vnet_hdr=
> >     on");
> >     >              return -1;
> >     >          }
> >     > -
> >     > -        if (n->has_vnet_hdr) {
> >     > -            tap_set_offload(qemu_get_queue(n->nic)->peer,
> >     > -                    (n->vdev.guest_features >>
> VIRTIO_NET_F_GUEST_CSUM)
> >     & 1,
> >     > -                    (n->vdev.guest_features >>
> VIRTIO_NET_F_GUEST_TSO4)
> >     & 1,
> >     > -                    (n->vdev.guest_features >>
> VIRTIO_NET_F_GUEST_TSO6)
> >     & 1,
> >     > -                    (n->vdev.guest_features >>
> VIRTIO_NET_F_GUEST_ECN)
> >     & 1,
> >     > -                    (n->vdev.guest_features >>
> VIRTIO_NET_F_GUEST_UFO)
> >     & 1);
> >     > -        }
> >     >      }
> >     >
> >     >      if (version_id >= 9) {
> >     > @@ -1197,6 +1265,16 @@ static int virtio_net_load(QEMUFile *f, void
> >     *opaque, int version_id)
> >     >          }
> >     >      }
> >     >
> >     > +    if (version_id >= 11) {
> >     > +        n->curr_offloads = qemu_get_be32(f);
> >     > +    } else {
> >     > +        n->curr_offloads = virtio_net_supported_offloads(n);
> >     > +    }
> >     > +
> >     > +    if (n->has_vnet_hdr) {
> >     > +        virtio_net_apply_offloads(n);
> >     > +    }
> >     > +
> >     >      virtio_net_set_queues(n);
> >     >
> >     >      /* Find the first multicast entry in the saved MAC filter */
> >     > diff --git a/hw/virtio-net.h b/hw/virtio-net.h
> >     > index 4d1a8cd..649a4e8 100644
> >     > --- a/hw/virtio-net.h
> >     > +++ b/hw/virtio-net.h
> >     > @@ -27,6 +27,8 @@
> >     >  /* The feature bitmap for virtio net */
> >     >  #define VIRTIO_NET_F_CSUM       0       /* Host handles pkts w/
> partial
> >     csum */
> >     >  #define VIRTIO_NET_F_GUEST_CSUM 1       /* Guest handles pkts w/
> partial
> >     csum */
> >     > +#define VIRTIO_NET_F_CTRL_OFFLD 2       /* Control channel offload
> >     > +                                         * configuration support
> */
> >     >  #define VIRTIO_NET_F_MAC        5       /* Host has given MAC
> address. *
> >     /
> >     >  #define VIRTIO_NET_F_GSO        6       /* Host handles pkts w/
> any GSO
> >     type */
> >     >  #define VIRTIO_NET_F_GUEST_TSO4 7       /* Guest can handle TSOv4
> in. */
> >     > @@ -182,6 +184,7 @@ typedef struct VirtIONet {
> >     >      uint16_t max_queues;
> >     >      uint16_t curr_queues;
> >     >      size_t config_size;
> >     > +    uint32_t curr_offloads;
> >     >  } VirtIONet;
> >     >
> >     >  #define VIRTIO_NET_CTRL_MAC    1
> >     > @@ -221,6 +224,21 @@ struct virtio_net_ctrl_mq {
> >     >   #define VIRTIO_NET_CTRL_MQ_VQ_PAIRS_MIN        1
> >     >   #define VIRTIO_NET_CTRL_MQ_VQ_PAIRS_MAX        0x8000
> >     >
> >     > +/*
> >     > + * Control network offloads
> >     > + *
> >     > + * Dynamic offloads are available with the
> >     > + * VIRTIO_NET_F_CTRL_OFFLD feature bit.
> >     > + */
> >     > +#define VIRTIO_NET_CTRL_OFFLOADS   5
> >     > + #define VIRTIO_NET_CTRL_OFFLOADS_SET        0
> >     > +
> >     > +#define VIRTIO_NET_OFFLOAD_GUEST_CSUM       1
> >     > +#define VIRTIO_NET_OFFLOAD_GUEST_TSO4       2
> >     > +#define VIRTIO_NET_OFFLOAD_GUEST_TSO6       4
> >     > +#define VIRTIO_NET_OFFLOAD_GUEST_ECN        8
> >     > +#define VIRTIO_NET_OFFLOAD_GUEST_UFO       16
> >     > +
> >     >  #define DEFINE_VIRTIO_NET_FEATURES(_state, _field) \
> >     >          DEFINE_VIRTIO_COMMON_FEATURES(_state, _field), \
> >     >          DEFINE_PROP_BIT("csum", _state, _field, VIRTIO_NET_F_CSUM,
> >     true), \
> >     > @@ -241,6 +259,7 @@ struct virtio_net_ctrl_mq {
> >     >          DEFINE_PROP_BIT("ctrl_vlan", _state, _field,
> >     VIRTIO_NET_F_CTRL_VLAN, true), \
> >     >          DEFINE_PROP_BIT("ctrl_rx_extra", _state, _field,
> >     VIRTIO_NET_F_CTRL_RX_EXTRA, true), \
> >     >          DEFINE_PROP_BIT("ctrl_mac_addr", _state, _field,
> >     VIRTIO_NET_F_CTRL_MAC_ADDR, true), \
> >     > +        DEFINE_PROP_BIT("ctrl_offload", _state, _field,
> >     VIRTIO_NET_F_CTRL_OFFLD, true), \
> >     >          DEFINE_PROP_BIT("mq", _state, _field, VIRTIO_NET_F_MQ,
> false)
> >     >
> >     >  #endif
> >     > --
> >     > 1.8.1.4
> >
> >
>

--e89a8f83ac2d71277a04d8ed7f12
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div class=3D"gmail_extra">On Wed, Mar 27, 2013 at 8:11 PM=
, Michael S. Tsirkin <span dir=3D"ltr">&lt;<a href=3D"mailto:mst@redhat.com=
" target=3D"_blank">mst@redhat.com</a>&gt;</span> wrote:<br><div class=3D"g=
mail_quote">

<blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1p=
x #ccc solid;padding-left:1ex"><div class=3D"HOEnZb"><div class=3D"h5">On W=
ed, Mar 27, 2013 at 07:48:18PM +0200, Dmitry Fleytman wrote:<br>
&gt; Michael, thanks for review.<br>
&gt; See my comments inline.<br>
&gt;<br>
&gt; On Wed, Mar 27, 2013 at 5:26 PM, Michael S. Tsirkin &lt;<a href=3D"mai=
lto:mst@redhat.com">mst@redhat.com</a>&gt; wrote:<br>
&gt;<br>
&gt; =A0 =A0 On Wed, Mar 27, 2013 at 03:43:18PM +0200, Dmitry Fleytman wrot=
e:<br>
&gt; =A0 =A0 &gt; From: Dmitry Fleytman &lt;<a href=3D"mailto:dfleytma@redh=
at.com">dfleytma@redhat.com</a>&gt;<br>
&gt; =A0 =A0 &gt;<br>
&gt; =A0 =A0 &gt; Virtio-net driver currently negotiates network offloads<b=
r>
&gt; =A0 =A0 &gt; on startup via features mechanism and have no ability to<=
br>
&gt; =A0 =A0 &gt; change offloads state later.<br>
&gt; =A0 =A0 &gt; This patch introduced a new control command that allows<b=
r>
&gt; =A0 =A0 &gt; to configure device network offloads state dynamically.<b=
r>
&gt; =A0 =A0 &gt; The patch also introduces a new feature flag<br>
&gt; =A0 =A0 &gt; VIRTIO_NET_F_CTRL_OFFLD.<br>
&gt; =A0 =A0 &gt;<br>
&gt; =A0 =A0 &gt; Signed-off-by: Dmitry Fleytman &lt;<a href=3D"mailto:dfle=
ytma@redhat.com">dfleytma@redhat.com</a>&gt;<br>
&gt; =A0 =A0 &gt; ---<br>
&gt; =A0 =A0 &gt; =A0hw/virtio-net.c | 110<br>
&gt; =A0 =A0 +++++++++++++++++++++++++++++++++++++++++++++++---------<br>
&gt; =A0 =A0 &gt; =A0hw/virtio-net.h | =A019 ++++++++++<br>
&gt; =A0 =A0 &gt; =A02 files changed, 113 insertions(+), 16 deletions(-)<br=
>
&gt; =A0 =A0 &gt;<br>
&gt; =A0 =A0 &gt; diff --git a/hw/virtio-net.c b/hw/virtio-net.c<br>
&gt; =A0 =A0 &gt; index 4bb49eb..0c23126 100644<br>
&gt; =A0 =A0 &gt; --- a/hw/virtio-net.c<br>
&gt; =A0 =A0 &gt; +++ b/hw/virtio-net.c<br>
&gt; =A0 =A0 &gt; @@ -21,7 +21,7 @@<br>
&gt; =A0 =A0 &gt; =A0#include &quot;hw/virtio-net.h&quot;<br>
&gt; =A0 =A0 &gt; =A0#include &quot;hw/vhost_net.h&quot;<br>
&gt; =A0 =A0 &gt;<br>
&gt; =A0 =A0 &gt; -#define VIRTIO_NET_VM_VERSION =A0 =A011<br>
&gt; =A0 =A0 &gt; +#define VIRTIO_NET_VM_VERSION =A0 =A012<br>
&gt;<br>
&gt; =A0 =A0 This will break cross-version migration, we do it differently =
now:<br>
&gt; =A0 =A0 - disable feature with old machine types<br>
&gt;<br>
&gt; =A0 =A0 - only pass offloads around if feature set<br>
&gt;<br>
&gt; =A0 =A0 - same for receive side<br>
&gt;<br>
&gt;<br>
&gt;<br>
&gt; [DF] Not sure I got your idea.<br>
&gt; [DF] Current logic aimed ensure proper operation in all old &lt;--&gt;=
 new migration<br>
&gt; cases:<br>
<br>
</div></div>AFAIK if you change VIRTIO_NET_VM_VERSION old host willl fail t=
o parse<br>
it.<br>
<div class=3D"HOEnZb"><div class=3D"h5"><br></div></div></blockquote><div s=
tyle>Oh, it could be I missed this. I&#39;ll=A0double-check.</div><div><br>=
</div><div><br></div><div>=A0</div><blockquote class=3D"gmail_quote" style=
=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex">

<div class=3D"HOEnZb"><div class=3D"h5">
&gt; [DF] In case of old&lt;--&gt;new migration host doesn&#39;t expose=A0<=
br>
&gt; VIRTIO_NET_F_CTRL_OFFLD<br>
<br>
&gt; [DF] offload feature so guest is unable to use it, after migration to =
a newer<br>
&gt; host nothing changes.<br>
&gt; [DF] In case of new&lt;--&gt;old migration all offloads negotiated on =
startup via<br>
&gt; features will be enabled (old logic)<br>
&gt; [DF] and guest will be unable to change offloads state via control cha=
nnel<br>
&gt; anymore.<br>
&gt; [DF] The second case is a little bit problematic because some offloads=
 that<br>
&gt; were originally disabled<br>
&gt; [DF] may become enabled after migration but it doesn&#39;t look like t=
here is a<br>
&gt; better solution.<br>
&gt; [DF] Do I miss something?<br>
&gt; =A0<br>
&gt;<br>
&gt; =A0 =A0 &gt;<br>
&gt; =A0 =A0 &gt; =A0#define MAC_TABLE_ENTRIES =A0 =A064<br>
&gt; =A0 =A0 &gt; =A0#define MAX_VLAN =A0 =A0(1 &lt;&lt; 12) =A0 /* Per 802=
.1Q definition */<br>
&gt; =A0 =A0 &gt; @@ -360,6 +360,48 @@ static uint32_t virtio_net_bad_featu=
res(VirtIODevice<br>
&gt; =A0 =A0 *vdev)<br>
&gt; =A0 =A0 &gt; =A0 =A0 =A0return features;<br>
&gt; =A0 =A0 &gt; =A0}<br>
&gt; =A0 =A0 &gt;<br>
&gt; =A0 =A0 &gt; +static void virtio_net_apply_offloads(VirtIONet *n)<br>
&gt; =A0 =A0 &gt; +{<br>
&gt; =A0 =A0 &gt; + =A0 =A0tap_set_offload(qemu_get_subqueue(n-&gt;nic, 0)-=
&gt;peer,<br>
&gt; =A0 =A0 &gt; + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0!!(n-&gt;curr_of=
floads &amp;<br>
&gt; =A0 =A0 VIRTIO_NET_OFFLOAD_GUEST_CSUM),<br>
&gt; =A0 =A0 &gt; + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0!!(n-&gt;curr_of=
floads &amp;<br>
&gt; =A0 =A0 VIRTIO_NET_OFFLOAD_GUEST_TSO4),<br>
&gt; =A0 =A0 &gt; + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0!!(n-&gt;curr_of=
floads &amp;<br>
&gt; =A0 =A0 VIRTIO_NET_OFFLOAD_GUEST_TSO6),<br>
&gt; =A0 =A0 &gt; + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0!!(n-&gt;curr_of=
floads &amp; VIRTIO_NET_OFFLOAD_GUEST_ECN),<br>
&gt; =A0 =A0 &gt; + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0!!(n-&gt;curr_of=
floads &amp;<br>
&gt; =A0 =A0 VIRTIO_NET_OFFLOAD_GUEST_UFO));<br>
&gt; =A0 =A0 &gt; +}<br>
&gt; =A0 =A0 &gt; +<br>
&gt; =A0 =A0 &gt; +static uint32_t virtio_net_offloads_by_features(uint32_t=
 features)<br>
&gt; =A0 =A0 &gt; +{<br>
&gt; =A0 =A0 &gt; + =A0 =A0uint32_t offloads =3D 0;<br>
&gt; =A0 =A0 &gt; +<br>
&gt; =A0 =A0 &gt; + =A0 =A0if ((1 &lt;&lt; VIRTIO_NET_F_GUEST_CSUM) &amp; f=
eatures) {<br>
&gt; =A0 =A0 &gt; + =A0 =A0 =A0 =A0offloads |=3D VIRTIO_NET_OFFLOAD_GUEST_C=
SUM;<br>
&gt; =A0 =A0 &gt; + =A0 =A0}<br>
&gt; =A0 =A0 &gt; +<br>
&gt; =A0 =A0 &gt; + =A0 =A0if ((1 &lt;&lt; VIRTIO_NET_F_GUEST_TSO4) &amp; f=
eatures) {<br>
&gt; =A0 =A0 &gt; + =A0 =A0 =A0 =A0offloads |=3D VIRTIO_NET_OFFLOAD_GUEST_T=
SO4;<br>
&gt; =A0 =A0 &gt; + =A0 =A0}<br>
&gt; =A0 =A0 &gt; +<br>
&gt; =A0 =A0 &gt; + =A0 =A0if ((1 &lt;&lt; VIRTIO_NET_F_GUEST_TSO6) &amp; f=
eatures) {<br>
&gt; =A0 =A0 &gt; + =A0 =A0 =A0 =A0offloads |=3D VIRTIO_NET_OFFLOAD_GUEST_T=
SO6;<br>
&gt; =A0 =A0 &gt; + =A0 =A0}<br>
&gt; =A0 =A0 &gt; +<br>
&gt; =A0 =A0 &gt; + =A0 =A0if ((1 &lt;&lt; VIRTIO_NET_F_GUEST_ECN) &amp; fe=
atures) {<br>
&gt; =A0 =A0 &gt; + =A0 =A0 =A0 =A0offloads |=3D VIRTIO_NET_OFFLOAD_GUEST_E=
CN;<br>
&gt; =A0 =A0 &gt; + =A0 =A0}<br>
&gt; =A0 =A0 &gt; +<br>
&gt; =A0 =A0 &gt; + =A0 =A0if ((1 &lt;&lt; VIRTIO_NET_F_GUEST_UFO) &amp; fe=
atures) {<br>
&gt; =A0 =A0 &gt; + =A0 =A0 =A0 =A0offloads |=3D VIRTIO_NET_OFFLOAD_GUEST_U=
FO;<br>
&gt; =A0 =A0 &gt; + =A0 =A0}<br>
&gt; =A0 =A0 &gt; +<br>
&gt; =A0 =A0 &gt; + =A0 =A0return offloads;<br>
&gt; =A0 =A0 &gt; +}<br>
&gt; =A0 =A0 &gt; +<br>
&gt; =A0 =A0 &gt; +static inline uint32_t virtio_net_supported_offloads(Vir=
tIONet *n)<br>
&gt; =A0 =A0 &gt; +{<br>
&gt; =A0 =A0 &gt; + =A0 =A0return virtio_net_offloads_by_features(n-&gt;vde=
v.guest_features);<br>
&gt; =A0 =A0 &gt; +}<br>
&gt; =A0 =A0 &gt; +<br>
&gt; =A0 =A0 &gt; =A0static void virtio_net_set_features(VirtIODevice *vdev=
, uint32_t<br>
&gt; =A0 =A0 features)<br>
&gt; =A0 =A0 &gt; =A0{<br>
&gt; =A0 =A0 &gt; =A0 =A0 =A0VirtIONet *n =3D to_virtio_net(vdev);<br>
&gt; =A0 =A0 &gt; @@ -371,12 +413,8 @@ static void virtio_net_set_features(=
VirtIODevice<br>
&gt; =A0 =A0 *vdev, uint32_t features)<br>
&gt; =A0 =A0 &gt; =A0 =A0 =A0virtio_net_set_mrg_rx_bufs(n, !!(features &amp=
; (1 &lt;&lt;<br>
&gt; =A0 =A0 VIRTIO_NET_F_MRG_RXBUF)));<br>
&gt; =A0 =A0 &gt;<br>
&gt; =A0 =A0 &gt; =A0 =A0 =A0if (n-&gt;has_vnet_hdr) {<br>
&gt; =A0 =A0 &gt; - =A0 =A0 =A0 =A0tap_set_offload(qemu_get_subqueue(n-&gt;=
nic, 0)-&gt;peer,<br>
&gt; =A0 =A0 &gt; - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0(feature=
s &gt;&gt; VIRTIO_NET_F_GUEST_CSUM) &amp; 1,<br>
&gt; =A0 =A0 &gt; - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0(feature=
s &gt;&gt; VIRTIO_NET_F_GUEST_TSO4) &amp; 1,<br>
&gt; =A0 =A0 &gt; - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0(feature=
s &gt;&gt; VIRTIO_NET_F_GUEST_TSO6) &amp; 1,<br>
&gt; =A0 =A0 &gt; - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0(feature=
s &gt;&gt; VIRTIO_NET_F_GUEST_ECN) =A0&amp; 1,<br>
&gt; =A0 =A0 &gt; - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0(feature=
s &gt;&gt; VIRTIO_NET_F_GUEST_UFO) =A0&amp; 1);<br>
&gt; =A0 =A0 &gt; + =A0 =A0 =A0 =A0n-&gt;curr_offloads =3D virtio_net_offlo=
ads_by_features(features);<br>
&gt; =A0 =A0 &gt; + =A0 =A0 =A0 =A0virtio_net_apply_offloads(n);<br>
&gt; =A0 =A0 &gt; =A0 =A0 =A0}<br>
&gt; =A0 =A0 &gt;<br>
&gt; =A0 =A0 &gt; =A0 =A0 =A0for (i =3D 0; =A0i &lt; n-&gt;max_queues; i++)=
 {<br>
&gt; =A0 =A0 &gt; @@ -422,6 +460,42 @@ static int virtio_net_handle_rx_mode=
(VirtIONet *n,<br>
&gt; =A0 =A0 uint8_t cmd,<br>
&gt; =A0 =A0 &gt; =A0 =A0 =A0return VIRTIO_NET_OK;<br>
&gt; =A0 =A0 &gt; =A0}<br>
&gt; =A0 =A0 &gt;<br>
&gt; =A0 =A0 &gt; +static int virtio_net_handle_offloads(VirtIONet *n, uint=
8_t cmd,<br>
&gt; =A0 =A0 &gt; + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 struct iovec *iov, unsigned int<br>
&gt; =A0 =A0 iov_cnt)<br>
&gt; =A0 =A0 &gt; +{<br>
&gt; =A0 =A0 &gt; + =A0 =A0uint32_t offloads;<br>
&gt; =A0 =A0 &gt; + =A0 =A0size_t s;<br>
&gt; =A0 =A0 &gt; +<br>
&gt; =A0 =A0 &gt; + =A0 =A0if (!((1 &lt;&lt; VIRTIO_NET_F_CTRL_OFFLD) &amp;=
 n-&gt;vdev.guest_features)) {<br>
&gt; =A0 =A0 &gt; + =A0 =A0 =A0 =A0return VIRTIO_NET_ERR;<br>
&gt; =A0 =A0 &gt; + =A0 =A0}<br>
&gt; =A0 =A0 &gt; +<br>
&gt; =A0 =A0 &gt; + =A0 =A0s =3D iov_to_buf(iov, iov_cnt, 0, &amp;offloads,=
 sizeof(offloads));<br>
&gt; =A0 =A0 &gt; + =A0 =A0if (s !=3D sizeof(offloads)) {<br>
&gt; =A0 =A0 &gt; + =A0 =A0 =A0 =A0return VIRTIO_NET_ERR;<br>
&gt; =A0 =A0 &gt; + =A0 =A0}<br>
&gt; =A0 =A0 &gt; +<br>
&gt; =A0 =A0 &gt; + =A0 =A0if (cmd =3D=3D VIRTIO_NET_CTRL_OFFLOADS_SET) {<b=
r>
&gt; =A0 =A0 &gt; + =A0 =A0 =A0 =A0uint32_t supported_offloads;<br>
&gt; =A0 =A0 &gt; +<br>
&gt; =A0 =A0 &gt; + =A0 =A0 =A0 =A0if (!n-&gt;has_vnet_hdr) {<br>
&gt; =A0 =A0 &gt; + =A0 =A0 =A0 =A0 =A0 =A0return VIRTIO_NET_ERR;<br>
&gt; =A0 =A0 &gt; + =A0 =A0 =A0 =A0}<br>
&gt; =A0 =A0 &gt; +<br>
&gt; =A0 =A0 &gt; + =A0 =A0 =A0 =A0supported_offloads =3D virtio_net_suppor=
ted_offloads(n);<br>
&gt; =A0 =A0 &gt; + =A0 =A0 =A0 =A0if (offloads &amp; ~supported_offloads) =
{<br>
&gt; =A0 =A0 &gt; + =A0 =A0 =A0 =A0 =A0 =A0return VIRTIO_NET_ERR;<br>
&gt; =A0 =A0 &gt; + =A0 =A0 =A0 =A0}<br>
&gt; =A0 =A0 &gt; +<br>
&gt; =A0 =A0 &gt; + =A0 =A0 =A0 =A0n-&gt;curr_offloads =3D offloads;<br>
&gt; =A0 =A0 &gt; + =A0 =A0 =A0 =A0virtio_net_apply_offloads(n);<br>
&gt;<br>
&gt; =A0 =A0 In the spec you said that only features<br>
&gt; =A0 =A0 available in the offloads can be<br>
&gt; =A0 =A0 enabled. Probably a good idea to validate<br>
&gt; =A0 =A0 and error if that&#39;s not the case.<br>
&gt;<br>
&gt;<br>
&gt; [DF] Not sure I understood correctly this part,<br>
&gt; [DF] Isn&#39;t following check enough to ensure this:<br>
&gt; [DF]=A0&gt; + =A0 =A0 =A0 =A0supported_offloads =3D virtio_net_support=
ed_offloads(n);<br>
&gt; [DF] &gt; + =A0 =A0 =A0 =A0if (offloads &amp; ~supported_offloads) {<b=
r>
&gt; [DF] &gt; + =A0 =A0 =A0 =A0 =A0 =A0return VIRTIO_NET_ERR;<br>
&gt;<br>
&gt;<br>
&gt;<br>
&gt; =A0 =A0 &gt; +<br>
&gt; =A0 =A0 &gt; + =A0 =A0 =A0 =A0return VIRTIO_NET_OK;<br>
&gt; =A0 =A0 &gt; + =A0 =A0} else {<br>
&gt; =A0 =A0 &gt; + =A0 =A0 =A0 =A0return VIRTIO_NET_ERR;<br>
&gt; =A0 =A0 &gt; + =A0 =A0}<br>
&gt; =A0 =A0 &gt; +}<br>
&gt; =A0 =A0 &gt; +<br>
&gt; =A0 =A0 &gt; =A0static int virtio_net_handle_mac(VirtIONet *n, uint8_t=
 cmd,<br>
&gt; =A0 =A0 &gt; =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 struct iovec *iov, unsigned int<br>
&gt; =A0 =A0 iov_cnt)<br>
&gt; =A0 =A0 &gt; =A0{<br>
&gt; =A0 =A0 &gt; @@ -590,6 +664,8 @@ static void virtio_net_handle_ctrl(Vi=
rtIODevice<br>
&gt; =A0 =A0 *vdev, VirtQueue *vq)<br>
&gt; =A0 =A0 &gt; =A0 =A0 =A0 =A0 =A0 =A0 =A0status =3D virtio_net_handle_v=
lan_table(n, ctrl.cmd, iov,<br>
&gt; =A0 =A0 iov_cnt);<br>
&gt; =A0 =A0 &gt; =A0 =A0 =A0 =A0 =A0} else if (ctrl.class =3D=3D VIRTIO_NE=
T_CTRL_MQ) {<br>
&gt; =A0 =A0 &gt; =A0 =A0 =A0 =A0 =A0 =A0 =A0status =3D virtio_net_handle_m=
q(n, ctrl.cmd, &amp;elem);<br>
&gt; =A0 =A0 &gt; + =A0 =A0 =A0 =A0} else if (ctrl.class =3D=3D VIRTIO_NET_=
CTRL_OFFLOADS) {<br>
&gt; =A0 =A0 &gt; + =A0 =A0 =A0 =A0 =A0 =A0status =3D virtio_net_handle_off=
loads(n, ctrl.cmd, iov,<br>
&gt; =A0 =A0 iov_cnt);<br>
&gt; =A0 =A0 &gt; =A0 =A0 =A0 =A0 =A0}<br>
&gt; =A0 =A0 &gt;<br>
&gt; =A0 =A0 &gt; =A0 =A0 =A0 =A0 =A0s =3D iov_from_buf(elem.in_sg, elem.in=
_num, 0, &amp;status, sizeof<br>
&gt; =A0 =A0 (status));<br>
&gt; =A0 =A0 &gt; @@ -1099,6 +1175,7 @@ static void virtio_net_save(QEMUFil=
e *f, void<br>
&gt; =A0 =A0 *opaque)<br>
&gt; =A0 =A0 &gt; =A0 =A0 =A0 =A0 =A0 =A0 =A0qemu_put_be32(f, n-&gt;vqs[i].=
tx_waiting);<br>
&gt; =A0 =A0 &gt; =A0 =A0 =A0 =A0 =A0}<br>
&gt; =A0 =A0 &gt; =A0 =A0 =A0}<br>
&gt; =A0 =A0 &gt; + =A0 =A0qemu_put_be32(f, n-&gt;curr_offloads);<br>
&gt;<br>
&gt; =A0 =A0 &gt; =A0}<br>
&gt; =A0 =A0 &gt;<br>
&gt; =A0 =A0 &gt; =A0static int virtio_net_load(QEMUFile *f, void *opaque, =
int version_id)<br>
&gt; =A0 =A0 &gt; @@ -1155,15 +1232,6 @@ static int virtio_net_load(QEMUFil=
e *f, void<br>
&gt; =A0 =A0 *opaque, int version_id)<br>
&gt; =A0 =A0 &gt; =A0 =A0 =A0 =A0 =A0 =A0 =A0error_report(&quot;virtio-net:=
 saved image requires vnet_hdr=3D<br>
&gt; =A0 =A0 on&quot;);<br>
&gt; =A0 =A0 &gt; =A0 =A0 =A0 =A0 =A0 =A0 =A0return -1;<br>
&gt; =A0 =A0 &gt; =A0 =A0 =A0 =A0 =A0}<br>
&gt; =A0 =A0 &gt; -<br>
&gt; =A0 =A0 &gt; - =A0 =A0 =A0 =A0if (n-&gt;has_vnet_hdr) {<br>
&gt; =A0 =A0 &gt; - =A0 =A0 =A0 =A0 =A0 =A0tap_set_offload(qemu_get_queue(n=
-&gt;nic)-&gt;peer,<br>
&gt; =A0 =A0 &gt; - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0(n-&gt;vdev.gues=
t_features &gt;&gt; VIRTIO_NET_F_GUEST_CSUM)<br>
&gt; =A0 =A0 &amp; 1,<br>
&gt; =A0 =A0 &gt; - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0(n-&gt;vdev.gues=
t_features &gt;&gt; VIRTIO_NET_F_GUEST_TSO4)<br>
&gt; =A0 =A0 &amp; 1,<br>
&gt; =A0 =A0 &gt; - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0(n-&gt;vdev.gues=
t_features &gt;&gt; VIRTIO_NET_F_GUEST_TSO6)<br>
&gt; =A0 =A0 &amp; 1,<br>
&gt; =A0 =A0 &gt; - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0(n-&gt;vdev.gues=
t_features &gt;&gt; VIRTIO_NET_F_GUEST_ECN) =A0<br>
&gt; =A0 =A0 &amp; 1,<br>
&gt; =A0 =A0 &gt; - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0(n-&gt;vdev.gues=
t_features &gt;&gt; VIRTIO_NET_F_GUEST_UFO) =A0<br>
&gt; =A0 =A0 &amp; 1);<br>
&gt; =A0 =A0 &gt; - =A0 =A0 =A0 =A0}<br>
&gt; =A0 =A0 &gt; =A0 =A0 =A0}<br>
&gt; =A0 =A0 &gt;<br>
&gt; =A0 =A0 &gt; =A0 =A0 =A0if (version_id &gt;=3D 9) {<br>
&gt; =A0 =A0 &gt; @@ -1197,6 +1265,16 @@ static int virtio_net_load(QEMUFil=
e *f, void<br>
&gt; =A0 =A0 *opaque, int version_id)<br>
&gt; =A0 =A0 &gt; =A0 =A0 =A0 =A0 =A0}<br>
&gt; =A0 =A0 &gt; =A0 =A0 =A0}<br>
&gt; =A0 =A0 &gt;<br>
&gt; =A0 =A0 &gt; + =A0 =A0if (version_id &gt;=3D 11) {<br>
&gt; =A0 =A0 &gt; + =A0 =A0 =A0 =A0n-&gt;curr_offloads =3D qemu_get_be32(f)=
;<br>
&gt; =A0 =A0 &gt; + =A0 =A0} else {<br>
&gt; =A0 =A0 &gt; + =A0 =A0 =A0 =A0n-&gt;curr_offloads =3D virtio_net_suppo=
rted_offloads(n);<br>
&gt; =A0 =A0 &gt; + =A0 =A0}<br>
&gt; =A0 =A0 &gt; +<br>
&gt; =A0 =A0 &gt; + =A0 =A0if (n-&gt;has_vnet_hdr) {<br>
&gt; =A0 =A0 &gt; + =A0 =A0 =A0 =A0virtio_net_apply_offloads(n);<br>
&gt; =A0 =A0 &gt; + =A0 =A0}<br>
&gt; =A0 =A0 &gt; +<br>
&gt; =A0 =A0 &gt; =A0 =A0 =A0virtio_net_set_queues(n);<br>
&gt; =A0 =A0 &gt;<br>
&gt; =A0 =A0 &gt; =A0 =A0 =A0/* Find the first multicast entry in the saved=
 MAC filter */<br>
&gt; =A0 =A0 &gt; diff --git a/hw/virtio-net.h b/hw/virtio-net.h<br>
&gt; =A0 =A0 &gt; index 4d1a8cd..649a4e8 100644<br>
&gt; =A0 =A0 &gt; --- a/hw/virtio-net.h<br>
&gt; =A0 =A0 &gt; +++ b/hw/virtio-net.h<br>
&gt; =A0 =A0 &gt; @@ -27,6 +27,8 @@<br>
&gt; =A0 =A0 &gt; =A0/* The feature bitmap for virtio net */<br>
&gt; =A0 =A0 &gt; =A0#define VIRTIO_NET_F_CSUM =A0 =A0 =A0 0 =A0 =A0 =A0 /*=
 Host handles pkts w/ partial<br>
&gt; =A0 =A0 csum */<br>
&gt; =A0 =A0 &gt; =A0#define VIRTIO_NET_F_GUEST_CSUM 1 =A0 =A0 =A0 /* Guest=
 handles pkts w/ partial<br>
&gt; =A0 =A0 csum */<br>
&gt; =A0 =A0 &gt; +#define VIRTIO_NET_F_CTRL_OFFLD 2 =A0 =A0 =A0 /* Control=
 channel offload<br>
&gt; =A0 =A0 &gt; + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 * configuration support */<br>
&gt; =A0 =A0 &gt; =A0#define VIRTIO_NET_F_MAC =A0 =A0 =A0 =A05 =A0 =A0 =A0 =
/* Host has given MAC address. *<br>
&gt; =A0 =A0 /<br>
&gt; =A0 =A0 &gt; =A0#define VIRTIO_NET_F_GSO =A0 =A0 =A0 =A06 =A0 =A0 =A0 =
/* Host handles pkts w/ any GSO<br>
&gt; =A0 =A0 type */<br>
&gt; =A0 =A0 &gt; =A0#define VIRTIO_NET_F_GUEST_TSO4 7 =A0 =A0 =A0 /* Guest=
 can handle TSOv4 in. */<br>
&gt; =A0 =A0 &gt; @@ -182,6 +184,7 @@ typedef struct VirtIONet {<br>
&gt; =A0 =A0 &gt; =A0 =A0 =A0uint16_t max_queues;<br>
&gt; =A0 =A0 &gt; =A0 =A0 =A0uint16_t curr_queues;<br>
&gt; =A0 =A0 &gt; =A0 =A0 =A0size_t config_size;<br>
&gt; =A0 =A0 &gt; + =A0 =A0uint32_t curr_offloads;<br>
&gt; =A0 =A0 &gt; =A0} VirtIONet;<br>
&gt; =A0 =A0 &gt;<br>
&gt; =A0 =A0 &gt; =A0#define VIRTIO_NET_CTRL_MAC =A0 =A01<br>
&gt; =A0 =A0 &gt; @@ -221,6 +224,21 @@ struct virtio_net_ctrl_mq {<br>
&gt; =A0 =A0 &gt; =A0 #define VIRTIO_NET_CTRL_MQ_VQ_PAIRS_MIN =A0 =A0 =A0 =
=A01<br>
&gt; =A0 =A0 &gt; =A0 #define VIRTIO_NET_CTRL_MQ_VQ_PAIRS_MAX =A0 =A0 =A0 =
=A00x8000<br>
&gt; =A0 =A0 &gt;<br>
&gt; =A0 =A0 &gt; +/*<br>
&gt; =A0 =A0 &gt; + * Control network offloads<br>
&gt; =A0 =A0 &gt; + *<br>
&gt; =A0 =A0 &gt; + * Dynamic offloads are available with the<br>
&gt; =A0 =A0 &gt; + * VIRTIO_NET_F_CTRL_OFFLD feature bit.<br>
&gt; =A0 =A0 &gt; + */<br>
&gt; =A0 =A0 &gt; +#define VIRTIO_NET_CTRL_OFFLOADS =A0 5<br>
&gt; =A0 =A0 &gt; + #define VIRTIO_NET_CTRL_OFFLOADS_SET =A0 =A0 =A0 =A00<b=
r>
&gt; =A0 =A0 &gt; +<br>
&gt; =A0 =A0 &gt; +#define VIRTIO_NET_OFFLOAD_GUEST_CSUM =A0 =A0 =A0 1<br>
&gt; =A0 =A0 &gt; +#define VIRTIO_NET_OFFLOAD_GUEST_TSO4 =A0 =A0 =A0 2<br>
&gt; =A0 =A0 &gt; +#define VIRTIO_NET_OFFLOAD_GUEST_TSO6 =A0 =A0 =A0 4<br>
&gt; =A0 =A0 &gt; +#define VIRTIO_NET_OFFLOAD_GUEST_ECN =A0 =A0 =A0 =A08<br=
>
&gt; =A0 =A0 &gt; +#define VIRTIO_NET_OFFLOAD_GUEST_UFO =A0 =A0 =A0 16<br>
&gt; =A0 =A0 &gt; +<br>
&gt; =A0 =A0 &gt; =A0#define DEFINE_VIRTIO_NET_FEATURES(_state, _field) \<b=
r>
&gt; =A0 =A0 &gt; =A0 =A0 =A0 =A0 =A0DEFINE_VIRTIO_COMMON_FEATURES(_state, =
_field), \<br>
&gt; =A0 =A0 &gt; =A0 =A0 =A0 =A0 =A0DEFINE_PROP_BIT(&quot;csum&quot;, _sta=
te, _field, VIRTIO_NET_F_CSUM,<br>
&gt; =A0 =A0 true), \<br>
&gt; =A0 =A0 &gt; @@ -241,6 +259,7 @@ struct virtio_net_ctrl_mq {<br>
&gt; =A0 =A0 &gt; =A0 =A0 =A0 =A0 =A0DEFINE_PROP_BIT(&quot;ctrl_vlan&quot;,=
 _state, _field,<br>
&gt; =A0 =A0 VIRTIO_NET_F_CTRL_VLAN, true), \<br>
&gt; =A0 =A0 &gt; =A0 =A0 =A0 =A0 =A0DEFINE_PROP_BIT(&quot;ctrl_rx_extra&qu=
ot;, _state, _field,<br>
&gt; =A0 =A0 VIRTIO_NET_F_CTRL_RX_EXTRA, true), \<br>
&gt; =A0 =A0 &gt; =A0 =A0 =A0 =A0 =A0DEFINE_PROP_BIT(&quot;ctrl_mac_addr&qu=
ot;, _state, _field,<br>
&gt; =A0 =A0 VIRTIO_NET_F_CTRL_MAC_ADDR, true), \<br>
&gt; =A0 =A0 &gt; + =A0 =A0 =A0 =A0DEFINE_PROP_BIT(&quot;ctrl_offload&quot;=
, _state, _field,<br>
&gt; =A0 =A0 VIRTIO_NET_F_CTRL_OFFLD, true), \<br>
&gt; =A0 =A0 &gt; =A0 =A0 =A0 =A0 =A0DEFINE_PROP_BIT(&quot;mq&quot;, _state=
, _field, VIRTIO_NET_F_MQ, false)<br>
&gt; =A0 =A0 &gt;<br>
&gt; =A0 =A0 &gt; =A0#endif<br>
&gt; =A0 =A0 &gt; --<br>
&gt; =A0 =A0 &gt; 1.8.1.4<br>
&gt;<br>
&gt;<br>
</div></div></blockquote></div><br></div></div>

--e89a8f83ac2d71277a04d8ed7f12--

--===============1782993960447395892==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
--===============1782993960447395892==--
