From: Dmitry Fleytman <dmitry@daynix.com>
Subject: Re: [PATCH 1/2 V2] virtio-net: dynamic network offloads configuration
Date: Sat, 30 Mar 2013 21:47:58 +0300
Message-ID: <CAGHCxhei9j0rNtp4xStouDA3NvgFpTLtt=2bkvYW-D18CzqUAQ@mail.gmail.com>
References: <1364464860-28961-1-git-send-email-dmitry@daynix.com>
	<1364464860-28961-2-git-send-email-dmitry@daynix.com>
	<20130328163945.GB30183@redhat.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============8306782242370790020=="
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20130328163945.GB30183@redhat.com>
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
Cc: Yan Vugenfirer <yan@daynix.com>, Dmitry Fleytman <dfleytma@redhat.com>, virtualization <virtualization@lists.linux-foundation.org>
List-Id: virtualization@lists.linuxfoundation.org

--===============8306782242370790020==
Content-Type: multipart/alternative; boundary=bcaec5396512c3391804d928d47f

--bcaec5396512c3391804d928d47f
Content-Type: text/plain; charset=ISO-8859-1

Michael, thanks for review,
I'll rename command as you suggested, indeed it will be better.

Not sure I understand a concept of compat macros.
Is there documentation available on this topic?

Dmitry


On Thu, Mar 28, 2013 at 6:39 PM, Michael S. Tsirkin <mst@redhat.com> wrote:

> On Thu, Mar 28, 2013 at 12:00:59PM +0200, Dmitry Fleytman wrote:
> > From: Dmitry Fleytman <dfleytma@redhat.com>
> >
> > Virtio-net driver currently negotiates network offloads
> > on startup via features mechanism and have no ability to
> > change offloads state later.
> > This patch introduced a new control command that allows
> > to configure device network offloads state dynamically.
> > The patch also introduces a new feature flag
> > VIRTIO_NET_F_CTRL_GUEST_OFFLD.
> >
> > Signed-off-by: Dmitry Fleytman <dfleytma@redhat.com>
> > ---
> >  hw/virtio-net.c | 111
> ++++++++++++++++++++++++++++++++++++++++++++++++--------
> >  hw/virtio-net.h |  19 ++++++++++
> >  2 files changed, 115 insertions(+), 15 deletions(-)
> >
> > diff --git a/hw/virtio-net.c b/hw/virtio-net.c
> > index 5917740..a016823 100644
> > --- a/hw/virtio-net.c
> > +++ b/hw/virtio-net.c
> > @@ -360,6 +360,48 @@ static uint32_t
> virtio_net_bad_features(VirtIODevice *vdev)
> >      return features;
> >  }
> >
> > +static void virtio_net_apply_offloads(VirtIONet *n)
> > +{
> > +    tap_set_offload(qemu_get_subqueue(n->nic, 0)->peer,
> > +                    !!(n->curr_offloads &
> VIRTIO_NET_OFFLOAD_GUEST_CSUM),
> > +                    !!(n->curr_offloads &
> VIRTIO_NET_OFFLOAD_GUEST_TSO4),
> > +                    !!(n->curr_offloads &
> VIRTIO_NET_OFFLOAD_GUEST_TSO6),
> > +                    !!(n->curr_offloads & VIRTIO_NET_OFFLOAD_GUEST_ECN),
> > +                    !!(n->curr_offloads &
> VIRTIO_NET_OFFLOAD_GUEST_UFO));
> > +}
> > +
> > +static uint32_t virtio_net_offloads_by_features(uint32_t features)
> > +{
> > +    uint32_t offloads = 0;
> > +
> > +    if ((1 << VIRTIO_NET_F_GUEST_CSUM) & features) {
> > +        offloads |= VIRTIO_NET_OFFLOAD_GUEST_CSUM;
> > +    }
> > +
> > +    if ((1 << VIRTIO_NET_F_GUEST_TSO4) & features) {
> > +        offloads |= VIRTIO_NET_OFFLOAD_GUEST_TSO4;
> > +    }
> > +
> > +    if ((1 << VIRTIO_NET_F_GUEST_TSO6) & features) {
> > +        offloads |= VIRTIO_NET_OFFLOAD_GUEST_TSO6;
> > +    }
> > +
> > +    if ((1 << VIRTIO_NET_F_GUEST_ECN) & features) {
> > +        offloads |= VIRTIO_NET_OFFLOAD_GUEST_ECN;
> > +    }
> > +
> > +    if ((1 << VIRTIO_NET_F_GUEST_UFO) & features) {
> > +        offloads |= VIRTIO_NET_OFFLOAD_GUEST_UFO;
> > +    }
> > +
> > +    return offloads;
> > +}
> > +
> > +static inline uint32_t virtio_net_supported_offloads(VirtIONet *n)
> > +{
> > +    return virtio_net_offloads_by_features(n->vdev.guest_features);
> > +}
> > +
> >  static void virtio_net_set_features(VirtIODevice *vdev, uint32_t
> features)
> >  {
> >      VirtIONet *n = to_virtio_net(vdev);
> > @@ -371,12 +413,8 @@ static void virtio_net_set_features(VirtIODevice
> *vdev, uint32_t features)
> >      virtio_net_set_mrg_rx_bufs(n, !!(features & (1 <<
> VIRTIO_NET_F_MRG_RXBUF)));
> >
> >      if (n->has_vnet_hdr) {
> > -        tap_set_offload(qemu_get_subqueue(n->nic, 0)->peer,
> > -                        (features >> VIRTIO_NET_F_GUEST_CSUM) & 1,
> > -                        (features >> VIRTIO_NET_F_GUEST_TSO4) & 1,
> > -                        (features >> VIRTIO_NET_F_GUEST_TSO6) & 1,
> > -                        (features >> VIRTIO_NET_F_GUEST_ECN)  & 1,
> > -                        (features >> VIRTIO_NET_F_GUEST_UFO)  & 1);
> > +        n->curr_offloads = virtio_net_offloads_by_features(features);
> > +        virtio_net_apply_offloads(n);
> >      }
> >
> >      for (i = 0;  i < n->max_queues; i++) {
> > @@ -422,6 +460,42 @@ static int virtio_net_handle_rx_mode(VirtIONet *n,
> uint8_t cmd,
> >      return VIRTIO_NET_OK;
> >  }
> >
> > +static int virtio_net_handle_offloads(VirtIONet *n, uint8_t cmd,
> > +                                     struct iovec *iov, unsigned int
> iov_cnt)
> > +{
> > +    uint32_t offloads;
> > +    size_t s;
> > +
> > +    if (!((1 << VIRTIO_NET_F_CTRL_GUEST_OFFLD) &
> n->vdev.guest_features)) {
> > +        return VIRTIO_NET_ERR;
> > +    }
> > +
> > +    s = iov_to_buf(iov, iov_cnt, 0, &offloads, sizeof(offloads));
> > +    if (s != sizeof(offloads)) {
> > +        return VIRTIO_NET_ERR;
> > +    }
> > +
> > +    if (cmd == VIRTIO_NET_CTRL_GUEST_OFFLOADS_SET) {
> > +        uint32_t supported_offloads;
> > +
> > +        if (!n->has_vnet_hdr) {
> > +            return VIRTIO_NET_ERR;
> > +        }
> > +
> > +        supported_offloads = virtio_net_supported_offloads(n);
> > +        if (offloads & ~supported_offloads) {
> > +            return VIRTIO_NET_ERR;
> > +        }
> > +
> > +        n->curr_offloads = offloads;
> > +        virtio_net_apply_offloads(n);
> > +
> > +        return VIRTIO_NET_OK;
> > +    } else {
> > +        return VIRTIO_NET_ERR;
> > +    }
> > +}
> > +
> >  static int virtio_net_handle_mac(VirtIONet *n, uint8_t cmd,
> >                                   struct iovec *iov, unsigned int
> iov_cnt)
> >  {
> > @@ -591,6 +665,8 @@ static void virtio_net_handle_ctrl(VirtIODevice
> *vdev, VirtQueue *vq)
> >              status = virtio_net_handle_vlan_table(n, ctrl.cmd, iov,
> iov_cnt);
> >          } else if (ctrl.class == VIRTIO_NET_CTRL_MQ) {
> >              status = virtio_net_handle_mq(n, ctrl.cmd, iov, iov_cnt);
> > +        } else if (ctrl.class == VIRTIO_NET_CTRL_GUEST_OFFLOADS) {
> > +            status = virtio_net_handle_offloads(n, ctrl.cmd, iov,
> iov_cnt);
> >          }
> >
> >          s = iov_from_buf(elem.in_sg, elem.in_num, 0, &status,
> sizeof(status));
> > @@ -1100,6 +1176,10 @@ static void virtio_net_save(QEMUFile *f, void
> *opaque)
> >              qemu_put_be32(f, n->vqs[i].tx_waiting);
> >          }
> >      }
> > +
> > +    if ((1 << VIRTIO_NET_F_CTRL_GUEST_OFFLD) & n->vdev.guest_features) {
> > +        qemu_put_be32(f, n->curr_offloads);
> > +    }
> >  }
> >
> >  static int virtio_net_load(QEMUFile *f, void *opaque, int version_id)
> > @@ -1156,15 +1236,6 @@ static int virtio_net_load(QEMUFile *f, void
> *opaque, int version_id)
> >              error_report("virtio-net: saved image requires
> vnet_hdr=on");
> >              return -1;
> >          }
> > -
> > -        if (n->has_vnet_hdr) {
> > -            tap_set_offload(qemu_get_queue(n->nic)->peer,
> > -                    (n->vdev.guest_features >> VIRTIO_NET_F_GUEST_CSUM)
> & 1,
> > -                    (n->vdev.guest_features >> VIRTIO_NET_F_GUEST_TSO4)
> & 1,
> > -                    (n->vdev.guest_features >> VIRTIO_NET_F_GUEST_TSO6)
> & 1,
> > -                    (n->vdev.guest_features >> VIRTIO_NET_F_GUEST_ECN)
>  & 1,
> > -                    (n->vdev.guest_features >> VIRTIO_NET_F_GUEST_UFO)
>  & 1);
> > -        }
> >      }
> >
> >      if (version_id >= 9) {
> > @@ -1198,6 +1269,16 @@ static int virtio_net_load(QEMUFile *f, void
> *opaque, int version_id)
> >          }
> >      }
> >
> > +    if ((1 << VIRTIO_NET_F_CTRL_GUEST_OFFLD) & n->vdev.guest_features) {
> > +        n->curr_offloads = qemu_get_be32(f);
> > +    } else {
> > +        n->curr_offloads = virtio_net_supported_offloads(n);
> > +    }
> > +
> > +    if (peer_has_vnet_hdr(n)) {
> > +        virtio_net_apply_offloads(n);
> > +    }
> > +
> >      virtio_net_set_queues(n);
> >
> >      /* Find the first multicast entry in the saved MAC filter */
> > diff --git a/hw/virtio-net.h b/hw/virtio-net.h
> > index 4d1a8cd..002d526 100644
> > --- a/hw/virtio-net.h
> > +++ b/hw/virtio-net.h
> > @@ -27,6 +27,8 @@
> >  /* The feature bitmap for virtio net */
> >  #define VIRTIO_NET_F_CSUM       0       /* Host handles pkts w/ partial
> csum */
> >  #define VIRTIO_NET_F_GUEST_CSUM 1       /* Guest handles pkts w/
> partial csum */
> > +#define VIRTIO_NET_F_CTRL_GUEST_OFFLD 2 /* Control channel offload
>
> It's very long anyway, so let's make it the full
> VIRTIO_NET_F_CTRL_GUEST_OFFLOADS to match the command name.
>
> > +                                         * configuration support */
> >  #define VIRTIO_NET_F_MAC        5       /* Host has given MAC address.
> */
> >  #define VIRTIO_NET_F_GSO        6       /* Host handles pkts w/ any GSO
> type */
> >  #define VIRTIO_NET_F_GUEST_TSO4 7       /* Guest can handle TSOv4 in. */
> > @@ -182,6 +184,7 @@ typedef struct VirtIONet {
> >      uint16_t max_queues;
> >      uint16_t curr_queues;
> >      size_t config_size;
> > +    uint32_t curr_offloads;
> >  } VirtIONet;
> >
> >  #define VIRTIO_NET_CTRL_MAC    1
> > @@ -221,6 +224,21 @@ struct virtio_net_ctrl_mq {
> >   #define VIRTIO_NET_CTRL_MQ_VQ_PAIRS_MIN        1
> >   #define VIRTIO_NET_CTRL_MQ_VQ_PAIRS_MAX        0x8000
> >
> > +/*
> > + * Control network offloads
> > + *
> > + * Dynamic offloads are available with the
> > + * VIRTIO_NET_F_CTRL_GUEST_OFFLD feature bit.
> > + */
> > +#define VIRTIO_NET_CTRL_GUEST_OFFLOADS   5
> > + #define VIRTIO_NET_CTRL_GUEST_OFFLOADS_SET        0
> > +
> > +#define VIRTIO_NET_OFFLOAD_GUEST_CSUM       1
> > +#define VIRTIO_NET_OFFLOAD_GUEST_TSO4       2
> > +#define VIRTIO_NET_OFFLOAD_GUEST_TSO6       4
> > +#define VIRTIO_NET_OFFLOAD_GUEST_ECN        8
> > +#define VIRTIO_NET_OFFLOAD_GUEST_UFO       16
> > +
> >  #define DEFINE_VIRTIO_NET_FEATURES(_state, _field) \
> >          DEFINE_VIRTIO_COMMON_FEATURES(_state, _field), \
> >          DEFINE_PROP_BIT("csum", _state, _field, VIRTIO_NET_F_CSUM,
> true), \
> > @@ -241,6 +259,7 @@ struct virtio_net_ctrl_mq {
> >          DEFINE_PROP_BIT("ctrl_vlan", _state, _field,
> VIRTIO_NET_F_CTRL_VLAN, true), \
> >          DEFINE_PROP_BIT("ctrl_rx_extra", _state, _field,
> VIRTIO_NET_F_CTRL_RX_EXTRA, true), \
> >          DEFINE_PROP_BIT("ctrl_mac_addr", _state, _field,
> VIRTIO_NET_F_CTRL_MAC_ADDR, true), \
> > +        DEFINE_PROP_BIT("ctrl_gst_offld", _state, _field,
> VIRTIO_NET_F_CTRL_GUEST_OFFLD, true), \
> >          DEFINE_PROP_BIT("mq", _state, _field, VIRTIO_NET_F_MQ, false)
> >
> >  #endif
>
>
> Looks good. Better to replace ctrl_gst_offld by ctrl_guest_offloads.
> Also need to patch hw/pc.h with compat macros so that
> the feature is disabled for old machine types.
>
>
> > --
> > 1.8.1.4
>

--bcaec5396512c3391804d928d47f
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Michael, thanks for review,<div>I&#39;ll rename command as=
 you suggested, indeed it will be better.</div><div><br></div><div>Not sure=
 I understand a concept of compat macros.</div><div>Is there documentation =
available on this topic?</div>

<div><br></div><div>Dmitry<br><div class=3D"gmail_extra"><br><br><div class=
=3D"gmail_quote">On Thu, Mar 28, 2013 at 6:39 PM, Michael S. Tsirkin <span =
dir=3D"ltr">&lt;<a href=3D"mailto:mst@redhat.com" target=3D"_blank">mst@red=
hat.com</a>&gt;</span> wrote:<br>

<blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1p=
x #ccc solid;padding-left:1ex"><div class=3D"HOEnZb"><div class=3D"h5">On T=
hu, Mar 28, 2013 at 12:00:59PM +0200, Dmitry Fleytman wrote:<br>
&gt; From: Dmitry Fleytman &lt;<a href=3D"mailto:dfleytma@redhat.com">dfley=
tma@redhat.com</a>&gt;<br>
&gt;<br>
&gt; Virtio-net driver currently negotiates network offloads<br>
&gt; on startup via features mechanism and have no ability to<br>
&gt; change offloads state later.<br>
&gt; This patch introduced a new control command that allows<br>
&gt; to configure device network offloads state dynamically.<br>
&gt; The patch also introduces a new feature flag<br>
&gt; VIRTIO_NET_F_CTRL_GUEST_OFFLD.<br>
&gt;<br>
&gt; Signed-off-by: Dmitry Fleytman &lt;<a href=3D"mailto:dfleytma@redhat.c=
om">dfleytma@redhat.com</a>&gt;<br>
&gt; ---<br>
&gt; =A0hw/virtio-net.c | 111 +++++++++++++++++++++++++++++++++++++++++++++=
+++--------<br>
&gt; =A0hw/virtio-net.h | =A019 ++++++++++<br>
&gt; =A02 files changed, 115 insertions(+), 15 deletions(-)<br>
&gt;<br>
&gt; diff --git a/hw/virtio-net.c b/hw/virtio-net.c<br>
&gt; index 5917740..a016823 100644<br>
&gt; --- a/hw/virtio-net.c<br>
&gt; +++ b/hw/virtio-net.c<br>
&gt; @@ -360,6 +360,48 @@ static uint32_t virtio_net_bad_features(VirtIODev=
ice *vdev)<br>
&gt; =A0 =A0 =A0return features;<br>
&gt; =A0}<br>
&gt;<br>
&gt; +static void virtio_net_apply_offloads(VirtIONet *n)<br>
&gt; +{<br>
&gt; + =A0 =A0tap_set_offload(qemu_get_subqueue(n-&gt;nic, 0)-&gt;peer,<br>
&gt; + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0!!(n-&gt;curr_offloads &amp; =
VIRTIO_NET_OFFLOAD_GUEST_CSUM),<br>
&gt; + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0!!(n-&gt;curr_offloads &amp; =
VIRTIO_NET_OFFLOAD_GUEST_TSO4),<br>
&gt; + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0!!(n-&gt;curr_offloads &amp; =
VIRTIO_NET_OFFLOAD_GUEST_TSO6),<br>
&gt; + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0!!(n-&gt;curr_offloads &amp; =
VIRTIO_NET_OFFLOAD_GUEST_ECN),<br>
&gt; + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0!!(n-&gt;curr_offloads &amp; =
VIRTIO_NET_OFFLOAD_GUEST_UFO));<br>
&gt; +}<br>
&gt; +<br>
&gt; +static uint32_t virtio_net_offloads_by_features(uint32_t features)<br=
>
&gt; +{<br>
&gt; + =A0 =A0uint32_t offloads =3D 0;<br>
&gt; +<br>
&gt; + =A0 =A0if ((1 &lt;&lt; VIRTIO_NET_F_GUEST_CSUM) &amp; features) {<br=
>
&gt; + =A0 =A0 =A0 =A0offloads |=3D VIRTIO_NET_OFFLOAD_GUEST_CSUM;<br>
&gt; + =A0 =A0}<br>
&gt; +<br>
&gt; + =A0 =A0if ((1 &lt;&lt; VIRTIO_NET_F_GUEST_TSO4) &amp; features) {<br=
>
&gt; + =A0 =A0 =A0 =A0offloads |=3D VIRTIO_NET_OFFLOAD_GUEST_TSO4;<br>
&gt; + =A0 =A0}<br>
&gt; +<br>
&gt; + =A0 =A0if ((1 &lt;&lt; VIRTIO_NET_F_GUEST_TSO6) &amp; features) {<br=
>
&gt; + =A0 =A0 =A0 =A0offloads |=3D VIRTIO_NET_OFFLOAD_GUEST_TSO6;<br>
&gt; + =A0 =A0}<br>
&gt; +<br>
&gt; + =A0 =A0if ((1 &lt;&lt; VIRTIO_NET_F_GUEST_ECN) &amp; features) {<br>
&gt; + =A0 =A0 =A0 =A0offloads |=3D VIRTIO_NET_OFFLOAD_GUEST_ECN;<br>
&gt; + =A0 =A0}<br>
&gt; +<br>
&gt; + =A0 =A0if ((1 &lt;&lt; VIRTIO_NET_F_GUEST_UFO) &amp; features) {<br>
&gt; + =A0 =A0 =A0 =A0offloads |=3D VIRTIO_NET_OFFLOAD_GUEST_UFO;<br>
&gt; + =A0 =A0}<br>
&gt; +<br>
&gt; + =A0 =A0return offloads;<br>
&gt; +}<br>
&gt; +<br>
&gt; +static inline uint32_t virtio_net_supported_offloads(VirtIONet *n)<br=
>
&gt; +{<br>
&gt; + =A0 =A0return virtio_net_offloads_by_features(n-&gt;vdev.guest_featu=
res);<br>
&gt; +}<br>
&gt; +<br>
&gt; =A0static void virtio_net_set_features(VirtIODevice *vdev, uint32_t fe=
atures)<br>
&gt; =A0{<br>
&gt; =A0 =A0 =A0VirtIONet *n =3D to_virtio_net(vdev);<br>
&gt; @@ -371,12 +413,8 @@ static void virtio_net_set_features(VirtIODevice =
*vdev, uint32_t features)<br>
&gt; =A0 =A0 =A0virtio_net_set_mrg_rx_bufs(n, !!(features &amp; (1 &lt;&lt;=
 VIRTIO_NET_F_MRG_RXBUF)));<br>
&gt;<br>
&gt; =A0 =A0 =A0if (n-&gt;has_vnet_hdr) {<br>
&gt; - =A0 =A0 =A0 =A0tap_set_offload(qemu_get_subqueue(n-&gt;nic, 0)-&gt;p=
eer,<br>
&gt; - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0(features &gt;&gt; VI=
RTIO_NET_F_GUEST_CSUM) &amp; 1,<br>
&gt; - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0(features &gt;&gt; VI=
RTIO_NET_F_GUEST_TSO4) &amp; 1,<br>
&gt; - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0(features &gt;&gt; VI=
RTIO_NET_F_GUEST_TSO6) &amp; 1,<br>
&gt; - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0(features &gt;&gt; VI=
RTIO_NET_F_GUEST_ECN) =A0&amp; 1,<br>
&gt; - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0(features &gt;&gt; VI=
RTIO_NET_F_GUEST_UFO) =A0&amp; 1);<br>
&gt; + =A0 =A0 =A0 =A0n-&gt;curr_offloads =3D virtio_net_offloads_by_featur=
es(features);<br>
&gt; + =A0 =A0 =A0 =A0virtio_net_apply_offloads(n);<br>
&gt; =A0 =A0 =A0}<br>
&gt;<br>
&gt; =A0 =A0 =A0for (i =3D 0; =A0i &lt; n-&gt;max_queues; i++) {<br>
&gt; @@ -422,6 +460,42 @@ static int virtio_net_handle_rx_mode(VirtIONet *n=
, uint8_t cmd,<br>
&gt; =A0 =A0 =A0return VIRTIO_NET_OK;<br>
&gt; =A0}<br>
&gt;<br>
&gt; +static int virtio_net_handle_offloads(VirtIONet *n, uint8_t cmd,<br>
&gt; + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 struct iovec *iov, unsigned int iov_cnt)<br>
&gt; +{<br>
&gt; + =A0 =A0uint32_t offloads;<br>
&gt; + =A0 =A0size_t s;<br>
&gt; +<br>
&gt; + =A0 =A0if (!((1 &lt;&lt; VIRTIO_NET_F_CTRL_GUEST_OFFLD) &amp; n-&gt;=
vdev.guest_features)) {<br>
&gt; + =A0 =A0 =A0 =A0return VIRTIO_NET_ERR;<br>
&gt; + =A0 =A0}<br>
&gt; +<br>
&gt; + =A0 =A0s =3D iov_to_buf(iov, iov_cnt, 0, &amp;offloads, sizeof(offlo=
ads));<br>
&gt; + =A0 =A0if (s !=3D sizeof(offloads)) {<br>
&gt; + =A0 =A0 =A0 =A0return VIRTIO_NET_ERR;<br>
&gt; + =A0 =A0}<br>
&gt; +<br>
&gt; + =A0 =A0if (cmd =3D=3D VIRTIO_NET_CTRL_GUEST_OFFLOADS_SET) {<br>
&gt; + =A0 =A0 =A0 =A0uint32_t supported_offloads;<br>
&gt; +<br>
&gt; + =A0 =A0 =A0 =A0if (!n-&gt;has_vnet_hdr) {<br>
&gt; + =A0 =A0 =A0 =A0 =A0 =A0return VIRTIO_NET_ERR;<br>
&gt; + =A0 =A0 =A0 =A0}<br>
&gt; +<br>
&gt; + =A0 =A0 =A0 =A0supported_offloads =3D virtio_net_supported_offloads(=
n);<br>
&gt; + =A0 =A0 =A0 =A0if (offloads &amp; ~supported_offloads) {<br>
&gt; + =A0 =A0 =A0 =A0 =A0 =A0return VIRTIO_NET_ERR;<br>
&gt; + =A0 =A0 =A0 =A0}<br>
&gt; +<br>
&gt; + =A0 =A0 =A0 =A0n-&gt;curr_offloads =3D offloads;<br>
&gt; + =A0 =A0 =A0 =A0virtio_net_apply_offloads(n);<br>
&gt; +<br>
&gt; + =A0 =A0 =A0 =A0return VIRTIO_NET_OK;<br>
&gt; + =A0 =A0} else {<br>
&gt; + =A0 =A0 =A0 =A0return VIRTIO_NET_ERR;<br>
&gt; + =A0 =A0}<br>
&gt; +}<br>
&gt; +<br>
&gt; =A0static int virtio_net_handle_mac(VirtIONet *n, uint8_t cmd,<br>
&gt; =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 st=
ruct iovec *iov, unsigned int iov_cnt)<br>
&gt; =A0{<br>
&gt; @@ -591,6 +665,8 @@ static void virtio_net_handle_ctrl(VirtIODevice *v=
dev, VirtQueue *vq)<br>
&gt; =A0 =A0 =A0 =A0 =A0 =A0 =A0status =3D virtio_net_handle_vlan_table(n, =
ctrl.cmd, iov, iov_cnt);<br>
&gt; =A0 =A0 =A0 =A0 =A0} else if (ctrl.class =3D=3D VIRTIO_NET_CTRL_MQ) {<=
br>
&gt; =A0 =A0 =A0 =A0 =A0 =A0 =A0status =3D virtio_net_handle_mq(n, ctrl.cmd=
, iov, iov_cnt);<br>
&gt; + =A0 =A0 =A0 =A0} else if (ctrl.class =3D=3D VIRTIO_NET_CTRL_GUEST_OF=
FLOADS) {<br>
&gt; + =A0 =A0 =A0 =A0 =A0 =A0status =3D virtio_net_handle_offloads(n, ctrl=
.cmd, iov, iov_cnt);<br>
&gt; =A0 =A0 =A0 =A0 =A0}<br>
&gt;<br>
&gt; =A0 =A0 =A0 =A0 =A0s =3D iov_from_buf(elem.in_sg, elem.in_num, 0, &amp=
;status, sizeof(status));<br>
&gt; @@ -1100,6 +1176,10 @@ static void virtio_net_save(QEMUFile *f, void *=
opaque)<br>
&gt; =A0 =A0 =A0 =A0 =A0 =A0 =A0qemu_put_be32(f, n-&gt;vqs[i].tx_waiting);<=
br>
&gt; =A0 =A0 =A0 =A0 =A0}<br>
&gt; =A0 =A0 =A0}<br>
&gt; +<br>
&gt; + =A0 =A0if ((1 &lt;&lt; VIRTIO_NET_F_CTRL_GUEST_OFFLD) &amp; n-&gt;vd=
ev.guest_features) {<br>
&gt; + =A0 =A0 =A0 =A0qemu_put_be32(f, n-&gt;curr_offloads);<br>
&gt; + =A0 =A0}<br>
&gt; =A0}<br>
&gt;<br>
&gt; =A0static int virtio_net_load(QEMUFile *f, void *opaque, int version_i=
d)<br>
&gt; @@ -1156,15 +1236,6 @@ static int virtio_net_load(QEMUFile *f, void *o=
paque, int version_id)<br>
&gt; =A0 =A0 =A0 =A0 =A0 =A0 =A0error_report(&quot;virtio-net: saved image =
requires vnet_hdr=3Don&quot;);<br>
&gt; =A0 =A0 =A0 =A0 =A0 =A0 =A0return -1;<br>
&gt; =A0 =A0 =A0 =A0 =A0}<br>
&gt; -<br>
&gt; - =A0 =A0 =A0 =A0if (n-&gt;has_vnet_hdr) {<br>
&gt; - =A0 =A0 =A0 =A0 =A0 =A0tap_set_offload(qemu_get_queue(n-&gt;nic)-&gt=
;peer,<br>
&gt; - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0(n-&gt;vdev.guest_features &g=
t;&gt; VIRTIO_NET_F_GUEST_CSUM) &amp; 1,<br>
&gt; - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0(n-&gt;vdev.guest_features &g=
t;&gt; VIRTIO_NET_F_GUEST_TSO4) &amp; 1,<br>
&gt; - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0(n-&gt;vdev.guest_features &g=
t;&gt; VIRTIO_NET_F_GUEST_TSO6) &amp; 1,<br>
&gt; - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0(n-&gt;vdev.guest_features &g=
t;&gt; VIRTIO_NET_F_GUEST_ECN) =A0&amp; 1,<br>
&gt; - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0(n-&gt;vdev.guest_features &g=
t;&gt; VIRTIO_NET_F_GUEST_UFO) =A0&amp; 1);<br>
&gt; - =A0 =A0 =A0 =A0}<br>
&gt; =A0 =A0 =A0}<br>
&gt;<br>
&gt; =A0 =A0 =A0if (version_id &gt;=3D 9) {<br>
&gt; @@ -1198,6 +1269,16 @@ static int virtio_net_load(QEMUFile *f, void *o=
paque, int version_id)<br>
&gt; =A0 =A0 =A0 =A0 =A0}<br>
&gt; =A0 =A0 =A0}<br>
&gt;<br>
&gt; + =A0 =A0if ((1 &lt;&lt; VIRTIO_NET_F_CTRL_GUEST_OFFLD) &amp; n-&gt;vd=
ev.guest_features) {<br>
&gt; + =A0 =A0 =A0 =A0n-&gt;curr_offloads =3D qemu_get_be32(f);<br>
&gt; + =A0 =A0} else {<br>
&gt; + =A0 =A0 =A0 =A0n-&gt;curr_offloads =3D virtio_net_supported_offloads=
(n);<br>
&gt; + =A0 =A0}<br>
&gt; +<br>
&gt; + =A0 =A0if (peer_has_vnet_hdr(n)) {<br>
&gt; + =A0 =A0 =A0 =A0virtio_net_apply_offloads(n);<br>
&gt; + =A0 =A0}<br>
&gt; +<br>
&gt; =A0 =A0 =A0virtio_net_set_queues(n);<br>
&gt;<br>
&gt; =A0 =A0 =A0/* Find the first multicast entry in the saved MAC filter *=
/<br>
&gt; diff --git a/hw/virtio-net.h b/hw/virtio-net.h<br>
&gt; index 4d1a8cd..002d526 100644<br>
&gt; --- a/hw/virtio-net.h<br>
&gt; +++ b/hw/virtio-net.h<br>
&gt; @@ -27,6 +27,8 @@<br>
&gt; =A0/* The feature bitmap for virtio net */<br>
&gt; =A0#define VIRTIO_NET_F_CSUM =A0 =A0 =A0 0 =A0 =A0 =A0 /* Host handles=
 pkts w/ partial csum */<br>
&gt; =A0#define VIRTIO_NET_F_GUEST_CSUM 1 =A0 =A0 =A0 /* Guest handles pkts=
 w/ partial csum */<br>
&gt; +#define VIRTIO_NET_F_CTRL_GUEST_OFFLD 2 /* Control channel offload<br=
>
<br>
</div></div>It&#39;s very long anyway, so let&#39;s make it the full<br>
VIRTIO_NET_F_CTRL_GUEST_OFFLOADS to match the command name.<br>
<div><div class=3D"h5"><br>
&gt; + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 * configuration support */<br>
&gt; =A0#define VIRTIO_NET_F_MAC =A0 =A0 =A0 =A05 =A0 =A0 =A0 /* Host has g=
iven MAC address. */<br>
&gt; =A0#define VIRTIO_NET_F_GSO =A0 =A0 =A0 =A06 =A0 =A0 =A0 /* Host handl=
es pkts w/ any GSO type */<br>
&gt; =A0#define VIRTIO_NET_F_GUEST_TSO4 7 =A0 =A0 =A0 /* Guest can handle T=
SOv4 in. */<br>
&gt; @@ -182,6 +184,7 @@ typedef struct VirtIONet {<br>
&gt; =A0 =A0 =A0uint16_t max_queues;<br>
&gt; =A0 =A0 =A0uint16_t curr_queues;<br>
&gt; =A0 =A0 =A0size_t config_size;<br>
&gt; + =A0 =A0uint32_t curr_offloads;<br>
&gt; =A0} VirtIONet;<br>
&gt;<br>
&gt; =A0#define VIRTIO_NET_CTRL_MAC =A0 =A01<br>
&gt; @@ -221,6 +224,21 @@ struct virtio_net_ctrl_mq {<br>
&gt; =A0 #define VIRTIO_NET_CTRL_MQ_VQ_PAIRS_MIN =A0 =A0 =A0 =A01<br>
&gt; =A0 #define VIRTIO_NET_CTRL_MQ_VQ_PAIRS_MAX =A0 =A0 =A0 =A00x8000<br>
&gt;<br>
&gt; +/*<br>
&gt; + * Control network offloads<br>
&gt; + *<br>
&gt; + * Dynamic offloads are available with the<br>
&gt; + * VIRTIO_NET_F_CTRL_GUEST_OFFLD feature bit.<br>
&gt; + */<br>
&gt; +#define VIRTIO_NET_CTRL_GUEST_OFFLOADS =A0 5<br>
&gt; + #define VIRTIO_NET_CTRL_GUEST_OFFLOADS_SET =A0 =A0 =A0 =A00<br>
&gt; +<br>
&gt; +#define VIRTIO_NET_OFFLOAD_GUEST_CSUM =A0 =A0 =A0 1<br>
&gt; +#define VIRTIO_NET_OFFLOAD_GUEST_TSO4 =A0 =A0 =A0 2<br>
&gt; +#define VIRTIO_NET_OFFLOAD_GUEST_TSO6 =A0 =A0 =A0 4<br>
&gt; +#define VIRTIO_NET_OFFLOAD_GUEST_ECN =A0 =A0 =A0 =A08<br>
&gt; +#define VIRTIO_NET_OFFLOAD_GUEST_UFO =A0 =A0 =A0 16<br>
&gt; +<br>
&gt; =A0#define DEFINE_VIRTIO_NET_FEATURES(_state, _field) \<br>
&gt; =A0 =A0 =A0 =A0 =A0DEFINE_VIRTIO_COMMON_FEATURES(_state, _field), \<br=
>
&gt; =A0 =A0 =A0 =A0 =A0DEFINE_PROP_BIT(&quot;csum&quot;, _state, _field, V=
IRTIO_NET_F_CSUM, true), \<br>
&gt; @@ -241,6 +259,7 @@ struct virtio_net_ctrl_mq {<br>
&gt; =A0 =A0 =A0 =A0 =A0DEFINE_PROP_BIT(&quot;ctrl_vlan&quot;, _state, _fie=
ld, VIRTIO_NET_F_CTRL_VLAN, true), \<br>
&gt; =A0 =A0 =A0 =A0 =A0DEFINE_PROP_BIT(&quot;ctrl_rx_extra&quot;, _state, =
_field, VIRTIO_NET_F_CTRL_RX_EXTRA, true), \<br>
&gt; =A0 =A0 =A0 =A0 =A0DEFINE_PROP_BIT(&quot;ctrl_mac_addr&quot;, _state, =
_field, VIRTIO_NET_F_CTRL_MAC_ADDR, true), \<br>
&gt; + =A0 =A0 =A0 =A0DEFINE_PROP_BIT(&quot;ctrl_gst_offld&quot;, _state, _=
field, VIRTIO_NET_F_CTRL_GUEST_OFFLD, true), \<br>
&gt; =A0 =A0 =A0 =A0 =A0DEFINE_PROP_BIT(&quot;mq&quot;, _state, _field, VIR=
TIO_NET_F_MQ, false)<br>
&gt;<br>
&gt; =A0#endif<br>
<br>
<br>
</div></div>Looks good. Better to replace ctrl_gst_offld by ctrl_guest_offl=
oads.<br>
Also need to patch hw/pc.h with compat macros so that<br>
the feature is disabled for old machine types.<br>
<span class=3D"HOEnZb"><font color=3D"#888888"><br>
<br>
&gt; --<br>
&gt; 1.8.1.4<br>
</font></span></blockquote></div><br></div></div></div>

--bcaec5396512c3391804d928d47f--

--===============8306782242370790020==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
--===============8306782242370790020==--
