From: Dmitry Fleytman <dmitry@daynix.com>
Subject: Re: [PATCH 1/2 V2] virtio-net: dynamic network offloads configuration
Date: Tue, 2 Apr 2013 09:56:51 +0300
Message-ID: <CAGHCxhfcTrmh2eqn=EAhi+GnK0qWwE3+OGVq4LdCaU6=2FQc9A@mail.gmail.com>
References: <1364464860-28961-1-git-send-email-dmitry@daynix.com>
	<1364464860-28961-2-git-send-email-dmitry@daynix.com>
	<20130328163945.GB30183@redhat.com>
	<CAGHCxhei9j0rNtp4xStouDA3NvgFpTLtt=2bkvYW-D18CzqUAQ@mail.gmail.com>
	<20130331075352.GF23484@redhat.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2731910690601972555=="
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20130331075352.GF23484@redhat.com>
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

--===============2731910690601972555==
Content-Type: multipart/alternative; boundary=e89a8f3ba4172286c204d95b3f7a

--e89a8f3ba4172286c204d95b3f7a
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On Sun, Mar 31, 2013 at 10:53 AM, Michael S. Tsirkin <mst@redhat.com> wrote=
:

> On Sat, Mar 30, 2013 at 09:47:58PM +0300, Dmitry Fleytman wrote:
> > Michael, thanks for review,
> > I'll rename command as you suggested, indeed it will be better.
> >
> > Not sure I understand a concept of compat macros.
> > Is there documentation available on this topic?
> >
> > Dmitry
>
> No, but it's simple. It's just lots of arrays of options we apply only
> one of them depending on -M. See e.g. pc_machine_init.
>
>
Do you mean something like this in PC_COMPAT_1_4:

diff --git a/hw/pc.h b/hw/pc.h
index 8e1dd4c..7ca4698 100644
--- a/hw/pc.h
+++ b/hw/pc.h
@@ -221,6 +221,10 @@ int e820_add_entry(uint64_t, uint64_t, uint32_t);
             .property =3D "vectors",\
             /* DEV_NVECTORS_UNSPECIFIED as a uint32_t string */\
             .value    =3D stringify(0xFFFFFFFF),\
+        },{ \
+            .driver   =3D "virtio-net-pci", \
+            .property =3D "ctrl_guest_offloads", \
+            .value    =3D "off", \
         },{\
             .driver   =3D "e1000",\
             .property =3D "romfile",\



> >
> > On Thu, Mar 28, 2013 at 6:39 PM, Michael S. Tsirkin <mst@redhat.com>
> wrote:
> >
> >     On Thu, Mar 28, 2013 at 12:00:59PM +0200, Dmitry Fleytman wrote:
> >     > From: Dmitry Fleytman <dfleytma@redhat.com>
> >     >
> >     > Virtio-net driver currently negotiates network offloads
> >     > on startup via features mechanism and have no ability to
> >     > change offloads state later.
> >     > This patch introduced a new control command that allows
> >     > to configure device network offloads state dynamically.
> >     > The patch also introduces a new feature flag
> >     > VIRTIO_NET_F_CTRL_GUEST_OFFLD.
> >     >
> >     > Signed-off-by: Dmitry Fleytman <dfleytma@redhat.com>
> >     > ---
> >     > =E1hw/virtio-net.c | 111
> >     ++++++++++++++++++++++++++++++++++++++++++++++++--------
> >     > =E1hw/virtio-net.h | =E119 ++++++++++
> >     > =E12 files changed, 115 insertions(+), 15 deletions(-)
> >     >
> >     > diff --git a/hw/virtio-net.c b/hw/virtio-net.c
> >     > index 5917740..a016823 100644
> >     > --- a/hw/virtio-net.c
> >     > +++ b/hw/virtio-net.c
> >     > @@ -360,6 +360,48 @@ static uint32_t
> virtio_net_bad_features(VirtIODevice
> >     *vdev)
> >     > =E1 =E1 =E1return features;
> >     > =E1}
> >     >
> >     > +static void virtio_net_apply_offloads(VirtIONet *n)
> >     > +{
> >     > + =E1 =E1tap_set_offload(qemu_get_subqueue(n->nic, 0)->peer,
> >     > + =E1 =E1 =E1 =E1 =E1 =E1 =E1 =E1 =E1 =E1!!(n->curr_offloads &
> >     VIRTIO_NET_OFFLOAD_GUEST_CSUM),
> >     > + =E1 =E1 =E1 =E1 =E1 =E1 =E1 =E1 =E1 =E1!!(n->curr_offloads &
> >     VIRTIO_NET_OFFLOAD_GUEST_TSO4),
> >     > + =E1 =E1 =E1 =E1 =E1 =E1 =E1 =E1 =E1 =E1!!(n->curr_offloads &
> >     VIRTIO_NET_OFFLOAD_GUEST_TSO6),
> >     > + =E1 =E1 =E1 =E1 =E1 =E1 =E1 =E1 =E1 =E1!!(n->curr_offloads &
> VIRTIO_NET_OFFLOAD_GUEST_ECN),
> >     > + =E1 =E1 =E1 =E1 =E1 =E1 =E1 =E1 =E1 =E1!!(n->curr_offloads &
> >     VIRTIO_NET_OFFLOAD_GUEST_UFO));
> >     > +}
> >     > +
> >     > +static uint32_t virtio_net_offloads_by_features(uint32_t feature=
s)
> >     > +{
> >     > + =E1 =E1uint32_t offloads =3D 0;
> >     > +
> >     > + =E1 =E1if ((1 << VIRTIO_NET_F_GUEST_CSUM) & features) {
> >     > + =E1 =E1 =E1 =E1offloads |=3D VIRTIO_NET_OFFLOAD_GUEST_CSUM;
> >     > + =E1 =E1}
> >     > +
> >     > + =E1 =E1if ((1 << VIRTIO_NET_F_GUEST_TSO4) & features) {
> >     > + =E1 =E1 =E1 =E1offloads |=3D VIRTIO_NET_OFFLOAD_GUEST_TSO4;
> >     > + =E1 =E1}
> >     > +
> >     > + =E1 =E1if ((1 << VIRTIO_NET_F_GUEST_TSO6) & features) {
> >     > + =E1 =E1 =E1 =E1offloads |=3D VIRTIO_NET_OFFLOAD_GUEST_TSO6;
> >     > + =E1 =E1}
> >     > +
> >     > + =E1 =E1if ((1 << VIRTIO_NET_F_GUEST_ECN) & features) {
> >     > + =E1 =E1 =E1 =E1offloads |=3D VIRTIO_NET_OFFLOAD_GUEST_ECN;
> >     > + =E1 =E1}
> >     > +
> >     > + =E1 =E1if ((1 << VIRTIO_NET_F_GUEST_UFO) & features) {
> >     > + =E1 =E1 =E1 =E1offloads |=3D VIRTIO_NET_OFFLOAD_GUEST_UFO;
> >     > + =E1 =E1}
> >     > +
> >     > + =E1 =E1return offloads;
> >     > +}
> >     > +
> >     > +static inline uint32_t virtio_net_supported_offloads(VirtIONet *=
n)
> >     > +{
> >     > + =E1 =E1return
> virtio_net_offloads_by_features(n->vdev.guest_features);
> >     > +}
> >     > +
> >     > =E1static void virtio_net_set_features(VirtIODevice *vdev, uint32=
_t
> >     features)
> >     > =E1{
> >     > =E1 =E1 =E1VirtIONet *n =3D to_virtio_net(vdev);
> >     > @@ -371,12 +413,8 @@ static void
> virtio_net_set_features(VirtIODevice
> >     *vdev, uint32_t features)
> >     > =E1 =E1 =E1virtio_net_set_mrg_rx_bufs(n, !!(features & (1 <<
> >     VIRTIO_NET_F_MRG_RXBUF)));
> >     >
> >     > =E1 =E1 =E1if (n->has_vnet_hdr) {
> >     > - =E1 =E1 =E1 =E1tap_set_offload(qemu_get_subqueue(n->nic, 0)->pe=
er,
> >     > - =E1 =E1 =E1 =E1 =E1 =E1 =E1 =E1 =E1 =E1 =E1 =E1(features >> VIR=
TIO_NET_F_GUEST_CSUM) & 1,
> >     > - =E1 =E1 =E1 =E1 =E1 =E1 =E1 =E1 =E1 =E1 =E1 =E1(features >> VIR=
TIO_NET_F_GUEST_TSO4) & 1,
> >     > - =E1 =E1 =E1 =E1 =E1 =E1 =E1 =E1 =E1 =E1 =E1 =E1(features >> VIR=
TIO_NET_F_GUEST_TSO6) & 1,
> >     > - =E1 =E1 =E1 =E1 =E1 =E1 =E1 =E1 =E1 =E1 =E1 =E1(features >> VIR=
TIO_NET_F_GUEST_ECN) =E1& 1,
> >     > - =E1 =E1 =E1 =E1 =E1 =E1 =E1 =E1 =E1 =E1 =E1 =E1(features >> VIR=
TIO_NET_F_GUEST_UFO) =E1&
> 1);
> >     > + =E1 =E1 =E1 =E1n->curr_offloads =3D
> virtio_net_offloads_by_features(features);
> >     > + =E1 =E1 =E1 =E1virtio_net_apply_offloads(n);
> >     > =E1 =E1 =E1}
> >     >
> >     > =E1 =E1 =E1for (i =3D 0; =E1i < n->max_queues; i++) {
> >     > @@ -422,6 +460,42 @@ static int
> virtio_net_handle_rx_mode(VirtIONet *n,
> >     uint8_t cmd,
> >     > =E1 =E1 =E1return VIRTIO_NET_OK;
> >     > =E1}
> >     >
> >     > +static int virtio_net_handle_offloads(VirtIONet *n, uint8_t cmd,
> >     > + =E1 =E1 =E1 =E1 =E1 =E1 =E1 =E1 =E1 =E1 =E1 =E1 =E1 =E1 =E1 =E1=
 =E1 =E1 struct iovec *iov, unsigned
> int
> >     iov_cnt)
> >     > +{
> >     > + =E1 =E1uint32_t offloads;
> >     > + =E1 =E1size_t s;
> >     > +
> >     > + =E1 =E1if (!((1 << VIRTIO_NET_F_CTRL_GUEST_OFFLD) & n->
> >     vdev.guest_features)) {
> >     > + =E1 =E1 =E1 =E1return VIRTIO_NET_ERR;
> >     > + =E1 =E1}
> >     > +
> >     > + =E1 =E1s =3D iov_to_buf(iov, iov_cnt, 0, &offloads, sizeof(offl=
oads));
> >     > + =E1 =E1if (s !=3D sizeof(offloads)) {
> >     > + =E1 =E1 =E1 =E1return VIRTIO_NET_ERR;
> >     > + =E1 =E1}
> >     > +
> >     > + =E1 =E1if (cmd =3D=3D VIRTIO_NET_CTRL_GUEST_OFFLOADS_SET) {
> >     > + =E1 =E1 =E1 =E1uint32_t supported_offloads;
> >     > +
> >     > + =E1 =E1 =E1 =E1if (!n->has_vnet_hdr) {
> >     > + =E1 =E1 =E1 =E1 =E1 =E1return VIRTIO_NET_ERR;
> >     > + =E1 =E1 =E1 =E1}
> >     > +
> >     > + =E1 =E1 =E1 =E1supported_offloads =3D virtio_net_supported_offl=
oads(n);
> >     > + =E1 =E1 =E1 =E1if (offloads & ~supported_offloads) {
> >     > + =E1 =E1 =E1 =E1 =E1 =E1return VIRTIO_NET_ERR;
> >     > + =E1 =E1 =E1 =E1}
> >     > +
> >     > + =E1 =E1 =E1 =E1n->curr_offloads =3D offloads;
> >     > + =E1 =E1 =E1 =E1virtio_net_apply_offloads(n);
> >     > +
> >     > + =E1 =E1 =E1 =E1return VIRTIO_NET_OK;
> >     > + =E1 =E1} else {
> >     > + =E1 =E1 =E1 =E1return VIRTIO_NET_ERR;
> >     > + =E1 =E1}
> >     > +}
> >     > +
> >     > =E1static int virtio_net_handle_mac(VirtIONet *n, uint8_t cmd,
> >     > =E1 =E1 =E1 =E1 =E1 =E1 =E1 =E1 =E1 =E1 =E1 =E1 =E1 =E1 =E1 =E1 =
=E1 struct iovec *iov, unsigned int
> >     iov_cnt)
> >     > =E1{
> >     > @@ -591,6 +665,8 @@ static void virtio_net_handle_ctrl(VirtIODevi=
ce
> >     *vdev, VirtQueue *vq)
> >     > =E1 =E1 =E1 =E1 =E1 =E1 =E1status =3D virtio_net_handle_vlan_tabl=
e(n, ctrl.cmd,
> iov,
> >     iov_cnt);
> >     > =E1 =E1 =E1 =E1 =E1} else if (ctrl.class =3D=3D VIRTIO_NET_CTRL_M=
Q) {
> >     > =E1 =E1 =E1 =E1 =E1 =E1 =E1status =3D virtio_net_handle_mq(n, ctr=
l.cmd, iov,
> iov_cnt);
> >     > + =E1 =E1 =E1 =E1} else if (ctrl.class =3D=3D VIRTIO_NET_CTRL_GUE=
ST_OFFLOADS) {
> >     > + =E1 =E1 =E1 =E1 =E1 =E1status =3D virtio_net_handle_offloads(n,=
 ctrl.cmd, iov,
> >     iov_cnt);
> >     > =E1 =E1 =E1 =E1 =E1}
> >     >
> >     > =E1 =E1 =E1 =E1 =E1s =3D iov_from_buf(elem.in_sg, elem.in_num, 0,=
 &status,
> sizeof
> >     (status));
> >     > @@ -1100,6 +1176,10 @@ static void virtio_net_save(QEMUFile *f,
> void
> >     *opaque)
> >     > =E1 =E1 =E1 =E1 =E1 =E1 =E1qemu_put_be32(f, n->vqs[i].tx_waiting)=
;
> >     > =E1 =E1 =E1 =E1 =E1}
> >     > =E1 =E1 =E1}
> >     > +
> >     > + =E1 =E1if ((1 << VIRTIO_NET_F_CTRL_GUEST_OFFLD) &
> n->vdev.guest_features) {
> >     > + =E1 =E1 =E1 =E1qemu_put_be32(f, n->curr_offloads);
> >     > + =E1 =E1}
> >     > =E1}
> >     >
> >     > =E1static int virtio_net_load(QEMUFile *f, void *opaque, int
> version_id)
> >     > @@ -1156,15 +1236,6 @@ static int virtio_net_load(QEMUFile *f, vo=
id
> >     *opaque, int version_id)
> >     > =E1 =E1 =E1 =E1 =E1 =E1 =E1error_report("virtio-net: saved image =
requires
> vnet_hdr=3D
> >     on");
> >     > =E1 =E1 =E1 =E1 =E1 =E1 =E1return -1;
> >     > =E1 =E1 =E1 =E1 =E1}
> >     > -
> >     > - =E1 =E1 =E1 =E1if (n->has_vnet_hdr) {
> >     > - =E1 =E1 =E1 =E1 =E1 =E1tap_set_offload(qemu_get_queue(n->nic)->=
peer,
> >     > - =E1 =E1 =E1 =E1 =E1 =E1 =E1 =E1 =E1 =E1(n->vdev.guest_features =
>>
> VIRTIO_NET_F_GUEST_CSUM)
> >     & 1,
> >     > - =E1 =E1 =E1 =E1 =E1 =E1 =E1 =E1 =E1 =E1(n->vdev.guest_features =
>>
> VIRTIO_NET_F_GUEST_TSO4)
> >     & 1,
> >     > - =E1 =E1 =E1 =E1 =E1 =E1 =E1 =E1 =E1 =E1(n->vdev.guest_features =
>>
> VIRTIO_NET_F_GUEST_TSO6)
> >     & 1,
> >     > - =E1 =E1 =E1 =E1 =E1 =E1 =E1 =E1 =E1 =E1(n->vdev.guest_features =
>>
> VIRTIO_NET_F_GUEST_ECN) =E1
> >     & 1,
> >     > - =E1 =E1 =E1 =E1 =E1 =E1 =E1 =E1 =E1 =E1(n->vdev.guest_features =
>>
> VIRTIO_NET_F_GUEST_UFO) =E1
> >     & 1);
> >     > - =E1 =E1 =E1 =E1}
> >     > =E1 =E1 =E1}
> >     >
> >     > =E1 =E1 =E1if (version_id >=3D 9) {
> >     > @@ -1198,6 +1269,16 @@ static int virtio_net_load(QEMUFile *f, vo=
id
> >     *opaque, int version_id)
> >     > =E1 =E1 =E1 =E1 =E1}
> >     > =E1 =E1 =E1}
> >     >
> >     > + =E1 =E1if ((1 << VIRTIO_NET_F_CTRL_GUEST_OFFLD) &
> n->vdev.guest_features) {
> >     > + =E1 =E1 =E1 =E1n->curr_offloads =3D qemu_get_be32(f);
> >     > + =E1 =E1} else {
> >     > + =E1 =E1 =E1 =E1n->curr_offloads =3D virtio_net_supported_offloa=
ds(n);
> >     > + =E1 =E1}
> >     > +
> >     > + =E1 =E1if (peer_has_vnet_hdr(n)) {
> >     > + =E1 =E1 =E1 =E1virtio_net_apply_offloads(n);
> >     > + =E1 =E1}
> >     > +
> >     > =E1 =E1 =E1virtio_net_set_queues(n);
> >     >
> >     > =E1 =E1 =E1/* Find the first multicast entry in the saved MAC fil=
ter */
> >     > diff --git a/hw/virtio-net.h b/hw/virtio-net.h
> >     > index 4d1a8cd..002d526 100644
> >     > --- a/hw/virtio-net.h
> >     > +++ b/hw/virtio-net.h
> >     > @@ -27,6 +27,8 @@
> >     > =E1/* The feature bitmap for virtio net */
> >     > =E1#define VIRTIO_NET_F_CSUM =E1 =E1 =E1 0 =E1 =E1 =E1 /* Host ha=
ndles pkts w/
> partial
> >     csum */
> >     > =E1#define VIRTIO_NET_F_GUEST_CSUM 1 =E1 =E1 =E1 /* Guest handles=
 pkts w/
> partial
> >     csum */
> >     > +#define VIRTIO_NET_F_CTRL_GUEST_OFFLD 2 /* Control channel offlo=
ad
> >
> >     It's very long anyway, so let's make it the full
> >     VIRTIO_NET_F_CTRL_GUEST_OFFLOADS to match the command name.
> >
> >     > + =E1 =E1 =E1 =E1 =E1 =E1 =E1 =E1 =E1 =E1 =E1 =E1 =E1 =E1 =E1 =E1=
 =E1 =E1 =E1 =E1 * configuration support
> */
> >     > =E1#define VIRTIO_NET_F_MAC =E1 =E1 =E1 =E15 =E1 =E1 =E1 /* Host =
has given MAC
> address. *
> >     /
> >     > =E1#define VIRTIO_NET_F_GSO =E1 =E1 =E1 =E16 =E1 =E1 =E1 /* Host =
handles pkts w/
> any GSO
> >     type */
> >     > =E1#define VIRTIO_NET_F_GUEST_TSO4 7 =E1 =E1 =E1 /* Guest can han=
dle TSOv4
> in. */
> >     > @@ -182,6 +184,7 @@ typedef struct VirtIONet {
> >     > =E1 =E1 =E1uint16_t max_queues;
> >     > =E1 =E1 =E1uint16_t curr_queues;
> >     > =E1 =E1 =E1size_t config_size;
> >     > + =E1 =E1uint32_t curr_offloads;
> >     > =E1} VirtIONet;
> >     >
> >     > =E1#define VIRTIO_NET_CTRL_MAC =E1 =E11
> >     > @@ -221,6 +224,21 @@ struct virtio_net_ctrl_mq {
> >     > =E1 #define VIRTIO_NET_CTRL_MQ_VQ_PAIRS_MIN =E1 =E1 =E1 =E11
> >     > =E1 #define VIRTIO_NET_CTRL_MQ_VQ_PAIRS_MAX =E1 =E1 =E1 =E10x8000
> >     >
> >     > +/*
> >     > + * Control network offloads
> >     > + *
> >     > + * Dynamic offloads are available with the
> >     > + * VIRTIO_NET_F_CTRL_GUEST_OFFLD feature bit.
> >     > + */
> >     > +#define VIRTIO_NET_CTRL_GUEST_OFFLOADS =E1 5
> >     > + #define VIRTIO_NET_CTRL_GUEST_OFFLOADS_SET =E1 =E1 =E1 =E10
> >     > +
> >     > +#define VIRTIO_NET_OFFLOAD_GUEST_CSUM =E1 =E1 =E1 1
> >     > +#define VIRTIO_NET_OFFLOAD_GUEST_TSO4 =E1 =E1 =E1 2
> >     > +#define VIRTIO_NET_OFFLOAD_GUEST_TSO6 =E1 =E1 =E1 4
> >     > +#define VIRTIO_NET_OFFLOAD_GUEST_ECN =E1 =E1 =E1 =E18
> >     > +#define VIRTIO_NET_OFFLOAD_GUEST_UFO =E1 =E1 =E1 16
> >     > +
> >     > =E1#define DEFINE_VIRTIO_NET_FEATURES(_state, _field) \
> >     > =E1 =E1 =E1 =E1 =E1DEFINE_VIRTIO_COMMON_FEATURES(_state, _field),=
 \
> >     > =E1 =E1 =E1 =E1 =E1DEFINE_PROP_BIT("csum", _state, _field, VIRTIO=
_NET_F_CSUM,
> >     true), \
> >     > @@ -241,6 +259,7 @@ struct virtio_net_ctrl_mq {
> >     > =E1 =E1 =E1 =E1 =E1DEFINE_PROP_BIT("ctrl_vlan", _state, _field,
> >     VIRTIO_NET_F_CTRL_VLAN, true), \
> >     > =E1 =E1 =E1 =E1 =E1DEFINE_PROP_BIT("ctrl_rx_extra", _state, _fiel=
d,
> >     VIRTIO_NET_F_CTRL_RX_EXTRA, true), \
> >     > =E1 =E1 =E1 =E1 =E1DEFINE_PROP_BIT("ctrl_mac_addr", _state, _fiel=
d,
> >     VIRTIO_NET_F_CTRL_MAC_ADDR, true), \
> >     > + =E1 =E1 =E1 =E1DEFINE_PROP_BIT("ctrl_gst_offld", _state, _field=
,
> >     VIRTIO_NET_F_CTRL_GUEST_OFFLD, true), \
> >     > =E1 =E1 =E1 =E1 =E1DEFINE_PROP_BIT("mq", _state, _field, VIRTIO_N=
ET_F_MQ,
> false)
> >     >
> >     > =E1#endif
> >
> >
> >     Looks good. Better to replace ctrl_gst_offld by ctrl_guest_offloads=
.
> >     Also need to patch hw/pc.h with compat macros so that
> >     the feature is disabled for old machine types.
> >
> >
> >     > --
> >     > 1.8.1.4
> >
> >
>

--e89a8f3ba4172286c204d95b3f7a
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><br><div class=3D"gmail_extra"><br><br><div class=3D"gmail=
_quote">On Sun, Mar 31, 2013 at 10:53 AM, Michael S. Tsirkin <span dir=3D"l=
tr">&lt;<a href=3D"mailto:mst@redhat.com" target=3D"_blank">mst@redhat.com<=
/a>&gt;</span> wrote:<br>

<blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-=
left-width:1px;border-left-color:rgb(204,204,204);border-left-style:solid;p=
adding-left:1ex"><div class=3D"im">On Sat, Mar 30, 2013 at 09:47:58PM +0300=
, Dmitry Fleytman wrote:<br>


&gt; Michael, thanks for review,<br>
&gt; I&#39;ll rename command as you suggested, indeed it will be better.<br=
>
&gt;<br>
&gt; Not sure I understand a concept of compat macros.<br>
&gt; Is there documentation available on this topic?<br>
&gt;<br>
&gt; Dmitry<br>
<br>
</div>No, but it&#39;s simple. It&#39;s just lots of arrays of options we a=
pply only<br>
one of them depending on -M. See e.g. pc_machine_init.<br>
<div class=3D"im"><br></div></blockquote><div><br></div><div style>Do you m=
ean something like this in PC_COMPAT_1_4:</div><div style><br></div><div st=
yle><div>diff --git a/hw/pc.h b/hw/pc.h</div><div>index 8e1dd4c..7ca4698 10=
0644</div>

<div>--- a/hw/pc.h</div><div>+++ b/hw/pc.h</div><div>@@ -221,6 +221,10 @@ i=
nt e820_add_entry(uint64_t, uint64_t, uint32_t);</div><div>=A0 =A0 =A0 =A0 =
=A0 =A0 =A0.property =3D &quot;vectors&quot;,\</div><div>=A0 =A0 =A0 =A0 =
=A0 =A0 =A0/* DEV_NVECTORS_UNSPECIFIED as a uint32_t string */\</div>

<div>=A0 =A0 =A0 =A0 =A0 =A0 =A0.value =A0 =A0=3D stringify(0xFFFFFFFF),\</=
div><div>+ =A0 =A0 =A0 =A0},{ \</div><div>+ =A0 =A0 =A0 =A0 =A0 =A0.driver =
=A0 =3D &quot;virtio-net-pci&quot;, \</div><div>+ =A0 =A0 =A0 =A0 =A0 =A0.p=
roperty =3D &quot;ctrl_guest_offloads&quot;, \</div><div>

+ =A0 =A0 =A0 =A0 =A0 =A0.value =A0 =A0=3D &quot;off&quot;, \</div><div>=A0=
 =A0 =A0 =A0 =A0},{\</div><div>=A0 =A0 =A0 =A0 =A0 =A0 =A0.driver =A0 =3D &=
quot;e1000&quot;,\</div><div>=A0 =A0 =A0 =A0 =A0 =A0 =A0.property =3D &quot=
;romfile&quot;,\</div><div><br></div></div><div>=A0<br></div>

<blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-=
left-width:1px;border-left-color:rgb(204,204,204);border-left-style:solid;p=
adding-left:1ex"><div class=3D"im">
&gt;<br>
&gt; On Thu, Mar 28, 2013 at 6:39 PM, Michael S. Tsirkin &lt;<a href=3D"mai=
lto:mst@redhat.com">mst@redhat.com</a>&gt; wrote:<br>
&gt;<br>
&gt; =A0 =A0 On Thu, Mar 28, 2013 at 12:00:59PM +0200, Dmitry Fleytman wrot=
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
&gt; =A0 =A0 &gt; VIRTIO_NET_F_CTRL_GUEST_OFFLD.<br>
&gt; =A0 =A0 &gt;<br>
&gt; =A0 =A0 &gt; Signed-off-by: Dmitry Fleytman &lt;<a href=3D"mailto:dfle=
ytma@redhat.com">dfleytma@redhat.com</a>&gt;<br>
&gt; =A0 =A0 &gt; ---<br>
</div>&gt; =A0 =A0 &gt; =E1hw/virtio-net.c | 111<br>
&gt; =A0 =A0 ++++++++++++++++++++++++++++++++++++++++++++++++--------<br>
&gt; =A0 =A0 &gt; =E1hw/virtio-net.h | =E119 ++++++++++<br>
&gt; =A0 =A0 &gt; =E12 files changed, 115 insertions(+), 15 deletions(-)<br=
>
<div class=3D"im">&gt; =A0 =A0 &gt;<br>
&gt; =A0 =A0 &gt; diff --git a/hw/virtio-net.c b/hw/virtio-net.c<br>
&gt; =A0 =A0 &gt; index 5917740..a016823 100644<br>
&gt; =A0 =A0 &gt; --- a/hw/virtio-net.c<br>
&gt; =A0 =A0 &gt; +++ b/hw/virtio-net.c<br>
&gt; =A0 =A0 &gt; @@ -360,6 +360,48 @@ static uint32_t virtio_net_bad_featu=
res(VirtIODevice<br>
&gt; =A0 =A0 *vdev)<br>
</div>&gt; =A0 =A0 &gt; =E1 =E1 =E1return features;<br>
&gt; =A0 =A0 &gt; =E1}<br>
<div class=3D"im">&gt; =A0 =A0 &gt;<br>
&gt; =A0 =A0 &gt; +static void virtio_net_apply_offloads(VirtIONet *n)<br>
&gt; =A0 =A0 &gt; +{<br>
</div>&gt; =A0 =A0 &gt; + =E1 =E1tap_set_offload(qemu_get_subqueue(n-&gt;ni=
c, 0)-&gt;peer,<br>
&gt; =A0 =A0 &gt; + =E1 =E1 =E1 =E1 =E1 =E1 =E1 =E1 =E1 =E1!!(n-&gt;curr_of=
floads &amp;<br>
&gt; =A0 =A0 VIRTIO_NET_OFFLOAD_GUEST_CSUM),<br>
&gt; =A0 =A0 &gt; + =E1 =E1 =E1 =E1 =E1 =E1 =E1 =E1 =E1 =E1!!(n-&gt;curr_of=
floads &amp;<br>
&gt; =A0 =A0 VIRTIO_NET_OFFLOAD_GUEST_TSO4),<br>
&gt; =A0 =A0 &gt; + =E1 =E1 =E1 =E1 =E1 =E1 =E1 =E1 =E1 =E1!!(n-&gt;curr_of=
floads &amp;<br>
&gt; =A0 =A0 VIRTIO_NET_OFFLOAD_GUEST_TSO6),<br>
&gt; =A0 =A0 &gt; + =E1 =E1 =E1 =E1 =E1 =E1 =E1 =E1 =E1 =E1!!(n-&gt;curr_of=
floads &amp; VIRTIO_NET_OFFLOAD_GUEST_ECN),<br>
&gt; =A0 =A0 &gt; + =E1 =E1 =E1 =E1 =E1 =E1 =E1 =E1 =E1 =E1!!(n-&gt;curr_of=
floads &amp;<br>
<div class=3D"im">&gt; =A0 =A0 VIRTIO_NET_OFFLOAD_GUEST_UFO));<br>
&gt; =A0 =A0 &gt; +}<br>
&gt; =A0 =A0 &gt; +<br>
&gt; =A0 =A0 &gt; +static uint32_t virtio_net_offloads_by_features(uint32_t=
 features)<br>
&gt; =A0 =A0 &gt; +{<br>
</div>&gt; =A0 =A0 &gt; + =E1 =E1uint32_t offloads =3D 0;<br>
&gt; =A0 =A0 &gt; +<br>
&gt; =A0 =A0 &gt; + =E1 =E1if ((1 &lt;&lt; VIRTIO_NET_F_GUEST_CSUM) &amp; f=
eatures) {<br>
&gt; =A0 =A0 &gt; + =E1 =E1 =E1 =E1offloads |=3D VIRTIO_NET_OFFLOAD_GUEST_C=
SUM;<br>
&gt; =A0 =A0 &gt; + =E1 =E1}<br>
&gt; =A0 =A0 &gt; +<br>
&gt; =A0 =A0 &gt; + =E1 =E1if ((1 &lt;&lt; VIRTIO_NET_F_GUEST_TSO4) &amp; f=
eatures) {<br>
&gt; =A0 =A0 &gt; + =E1 =E1 =E1 =E1offloads |=3D VIRTIO_NET_OFFLOAD_GUEST_T=
SO4;<br>
&gt; =A0 =A0 &gt; + =E1 =E1}<br>
&gt; =A0 =A0 &gt; +<br>
&gt; =A0 =A0 &gt; + =E1 =E1if ((1 &lt;&lt; VIRTIO_NET_F_GUEST_TSO6) &amp; f=
eatures) {<br>
&gt; =A0 =A0 &gt; + =E1 =E1 =E1 =E1offloads |=3D VIRTIO_NET_OFFLOAD_GUEST_T=
SO6;<br>
&gt; =A0 =A0 &gt; + =E1 =E1}<br>
&gt; =A0 =A0 &gt; +<br>
&gt; =A0 =A0 &gt; + =E1 =E1if ((1 &lt;&lt; VIRTIO_NET_F_GUEST_ECN) &amp; fe=
atures) {<br>
&gt; =A0 =A0 &gt; + =E1 =E1 =E1 =E1offloads |=3D VIRTIO_NET_OFFLOAD_GUEST_E=
CN;<br>
&gt; =A0 =A0 &gt; + =E1 =E1}<br>
&gt; =A0 =A0 &gt; +<br>
&gt; =A0 =A0 &gt; + =E1 =E1if ((1 &lt;&lt; VIRTIO_NET_F_GUEST_UFO) &amp; fe=
atures) {<br>
&gt; =A0 =A0 &gt; + =E1 =E1 =E1 =E1offloads |=3D VIRTIO_NET_OFFLOAD_GUEST_U=
FO;<br>
&gt; =A0 =A0 &gt; + =E1 =E1}<br>
&gt; =A0 =A0 &gt; +<br>
&gt; =A0 =A0 &gt; + =E1 =E1return offloads;<br>
<div class=3D"im">&gt; =A0 =A0 &gt; +}<br>
&gt; =A0 =A0 &gt; +<br>
&gt; =A0 =A0 &gt; +static inline uint32_t virtio_net_supported_offloads(Vir=
tIONet *n)<br>
&gt; =A0 =A0 &gt; +{<br>
</div>&gt; =A0 =A0 &gt; + =E1 =E1return virtio_net_offloads_by_features(n-&=
gt;vdev.guest_features);<br>
&gt; =A0 =A0 &gt; +}<br>
&gt; =A0 =A0 &gt; +<br>
&gt; =A0 =A0 &gt; =E1static void virtio_net_set_features(VirtIODevice *vdev=
, uint32_t<br>
&gt; =A0 =A0 features)<br>
&gt; =A0 =A0 &gt; =E1{<br>
&gt; =A0 =A0 &gt; =E1 =E1 =E1VirtIONet *n =3D to_virtio_net(vdev);<br>
<div class=3D"im">&gt; =A0 =A0 &gt; @@ -371,12 +413,8 @@ static void virtio=
_net_set_features(VirtIODevice<br>
&gt; =A0 =A0 *vdev, uint32_t features)<br>
</div>&gt; =A0 =A0 &gt; =E1 =E1 =E1virtio_net_set_mrg_rx_bufs(n, !!(feature=
s &amp; (1 &lt;&lt;<br>
&gt; =A0 =A0 VIRTIO_NET_F_MRG_RXBUF)));<br>
&gt; =A0 =A0 &gt;<br>
&gt; =A0 =A0 &gt; =E1 =E1 =E1if (n-&gt;has_vnet_hdr) {<br>
&gt; =A0 =A0 &gt; - =E1 =E1 =E1 =E1tap_set_offload(qemu_get_subqueue(n-&gt;=
nic, 0)-&gt;peer,<br>
&gt; =A0 =A0 &gt; - =E1 =E1 =E1 =E1 =E1 =E1 =E1 =E1 =E1 =E1 =E1 =E1(feature=
s &gt;&gt; VIRTIO_NET_F_GUEST_CSUM) &amp; 1,<br>
&gt; =A0 =A0 &gt; - =E1 =E1 =E1 =E1 =E1 =E1 =E1 =E1 =E1 =E1 =E1 =E1(feature=
s &gt;&gt; VIRTIO_NET_F_GUEST_TSO4) &amp; 1,<br>
&gt; =A0 =A0 &gt; - =E1 =E1 =E1 =E1 =E1 =E1 =E1 =E1 =E1 =E1 =E1 =E1(feature=
s &gt;&gt; VIRTIO_NET_F_GUEST_TSO6) &amp; 1,<br>
&gt; =A0 =A0 &gt; - =E1 =E1 =E1 =E1 =E1 =E1 =E1 =E1 =E1 =E1 =E1 =E1(feature=
s &gt;&gt; VIRTIO_NET_F_GUEST_ECN) =E1&amp; 1,<br>
&gt; =A0 =A0 &gt; - =E1 =E1 =E1 =E1 =E1 =E1 =E1 =E1 =E1 =E1 =E1 =E1(feature=
s &gt;&gt; VIRTIO_NET_F_GUEST_UFO) =E1&amp; 1);<br>
&gt; =A0 =A0 &gt; + =E1 =E1 =E1 =E1n-&gt;curr_offloads =3D virtio_net_offlo=
ads_by_features(features);<br>
&gt; =A0 =A0 &gt; + =E1 =E1 =E1 =E1virtio_net_apply_offloads(n);<br>
&gt; =A0 =A0 &gt; =E1 =E1 =E1}<br>
&gt; =A0 =A0 &gt;<br>
&gt; =A0 =A0 &gt; =E1 =E1 =E1for (i =3D 0; =E1i &lt; n-&gt;max_queues; i++)=
 {<br>
<div class=3D"im">&gt; =A0 =A0 &gt; @@ -422,6 +460,42 @@ static int virtio_=
net_handle_rx_mode(VirtIONet *n,<br>
&gt; =A0 =A0 uint8_t cmd,<br>
</div>&gt; =A0 =A0 &gt; =E1 =E1 =E1return VIRTIO_NET_OK;<br>
&gt; =A0 =A0 &gt; =E1}<br>
<div class=3D"im">&gt; =A0 =A0 &gt;<br>
&gt; =A0 =A0 &gt; +static int virtio_net_handle_offloads(VirtIONet *n, uint=
8_t cmd,<br>
</div>&gt; =A0 =A0 &gt; + =E1 =E1 =E1 =E1 =E1 =E1 =E1 =E1 =E1 =E1 =E1 =E1 =
=E1 =E1 =E1 =E1 =E1 =E1 struct iovec *iov, unsigned int<br>
&gt; =A0 =A0 iov_cnt)<br>
&gt; =A0 =A0 &gt; +{<br>
&gt; =A0 =A0 &gt; + =E1 =E1uint32_t offloads;<br>
&gt; =A0 =A0 &gt; + =E1 =E1size_t s;<br>
&gt; =A0 =A0 &gt; +<br>
&gt; =A0 =A0 &gt; + =E1 =E1if (!((1 &lt;&lt; VIRTIO_NET_F_CTRL_GUEST_OFFLD)=
 &amp; n-&gt;<br>
&gt; =A0 =A0 vdev.guest_features)) {<br>
&gt; =A0 =A0 &gt; + =E1 =E1 =E1 =E1return VIRTIO_NET_ERR;<br>
&gt; =A0 =A0 &gt; + =E1 =E1}<br>
&gt; =A0 =A0 &gt; +<br>
&gt; =A0 =A0 &gt; + =E1 =E1s =3D iov_to_buf(iov, iov_cnt, 0, &amp;offloads,=
 sizeof(offloads));<br>
&gt; =A0 =A0 &gt; + =E1 =E1if (s !=3D sizeof(offloads)) {<br>
&gt; =A0 =A0 &gt; + =E1 =E1 =E1 =E1return VIRTIO_NET_ERR;<br>
&gt; =A0 =A0 &gt; + =E1 =E1}<br>
&gt; =A0 =A0 &gt; +<br>
&gt; =A0 =A0 &gt; + =E1 =E1if (cmd =3D=3D VIRTIO_NET_CTRL_GUEST_OFFLOADS_SE=
T) {<br>
&gt; =A0 =A0 &gt; + =E1 =E1 =E1 =E1uint32_t supported_offloads;<br>
&gt; =A0 =A0 &gt; +<br>
&gt; =A0 =A0 &gt; + =E1 =E1 =E1 =E1if (!n-&gt;has_vnet_hdr) {<br>
&gt; =A0 =A0 &gt; + =E1 =E1 =E1 =E1 =E1 =E1return VIRTIO_NET_ERR;<br>
&gt; =A0 =A0 &gt; + =E1 =E1 =E1 =E1}<br>
&gt; =A0 =A0 &gt; +<br>
&gt; =A0 =A0 &gt; + =E1 =E1 =E1 =E1supported_offloads =3D virtio_net_suppor=
ted_offloads(n);<br>
&gt; =A0 =A0 &gt; + =E1 =E1 =E1 =E1if (offloads &amp; ~supported_offloads) =
{<br>
&gt; =A0 =A0 &gt; + =E1 =E1 =E1 =E1 =E1 =E1return VIRTIO_NET_ERR;<br>
&gt; =A0 =A0 &gt; + =E1 =E1 =E1 =E1}<br>
&gt; =A0 =A0 &gt; +<br>
&gt; =A0 =A0 &gt; + =E1 =E1 =E1 =E1n-&gt;curr_offloads =3D offloads;<br>
&gt; =A0 =A0 &gt; + =E1 =E1 =E1 =E1virtio_net_apply_offloads(n);<br>
&gt; =A0 =A0 &gt; +<br>
&gt; =A0 =A0 &gt; + =E1 =E1 =E1 =E1return VIRTIO_NET_OK;<br>
&gt; =A0 =A0 &gt; + =E1 =E1} else {<br>
&gt; =A0 =A0 &gt; + =E1 =E1 =E1 =E1return VIRTIO_NET_ERR;<br>
&gt; =A0 =A0 &gt; + =E1 =E1}<br>
&gt; =A0 =A0 &gt; +}<br>
&gt; =A0 =A0 &gt; +<br>
&gt; =A0 =A0 &gt; =E1static int virtio_net_handle_mac(VirtIONet *n, uint8_t=
 cmd,<br>
&gt; =A0 =A0 &gt; =E1 =E1 =E1 =E1 =E1 =E1 =E1 =E1 =E1 =E1 =E1 =E1 =E1 =E1 =
=E1 =E1 =E1 struct iovec *iov, unsigned int<br>
&gt; =A0 =A0 iov_cnt)<br>
&gt; =A0 =A0 &gt; =E1{<br>
<div class=3D"im">&gt; =A0 =A0 &gt; @@ -591,6 +665,8 @@ static void virtio_=
net_handle_ctrl(VirtIODevice<br>
&gt; =A0 =A0 *vdev, VirtQueue *vq)<br>
</div>&gt; =A0 =A0 &gt; =E1 =E1 =E1 =E1 =E1 =E1 =E1status =3D virtio_net_ha=
ndle_vlan_table(n, ctrl.cmd, iov,<br>
&gt; =A0 =A0 iov_cnt);<br>
&gt; =A0 =A0 &gt; =E1 =E1 =E1 =E1 =E1} else if (ctrl.class =3D=3D VIRTIO_NE=
T_CTRL_MQ) {<br>
&gt; =A0 =A0 &gt; =E1 =E1 =E1 =E1 =E1 =E1 =E1status =3D virtio_net_handle_m=
q(n, ctrl.cmd, iov, iov_cnt);<br>
&gt; =A0 =A0 &gt; + =E1 =E1 =E1 =E1} else if (ctrl.class =3D=3D VIRTIO_NET_=
CTRL_GUEST_OFFLOADS) {<br>
&gt; =A0 =A0 &gt; + =E1 =E1 =E1 =E1 =E1 =E1status =3D virtio_net_handle_off=
loads(n, ctrl.cmd, iov,<br>
&gt; =A0 =A0 iov_cnt);<br>
&gt; =A0 =A0 &gt; =E1 =E1 =E1 =E1 =E1}<br>
&gt; =A0 =A0 &gt;<br>
&gt; =A0 =A0 &gt; =E1 =E1 =E1 =E1 =E1s =3D iov_from_buf(elem.in_sg, elem.in=
_num, 0, &amp;status, sizeof<br>
<div class=3D"im">&gt; =A0 =A0 (status));<br>
&gt; =A0 =A0 &gt; @@ -1100,6 +1176,10 @@ static void virtio_net_save(QEMUFi=
le *f, void<br>
&gt; =A0 =A0 *opaque)<br>
</div>&gt; =A0 =A0 &gt; =E1 =E1 =E1 =E1 =E1 =E1 =E1qemu_put_be32(f, n-&gt;v=
qs[i].tx_waiting);<br>
&gt; =A0 =A0 &gt; =E1 =E1 =E1 =E1 =E1}<br>
&gt; =A0 =A0 &gt; =E1 =E1 =E1}<br>
&gt; =A0 =A0 &gt; +<br>
&gt; =A0 =A0 &gt; + =E1 =E1if ((1 &lt;&lt; VIRTIO_NET_F_CTRL_GUEST_OFFLD) &=
amp; n-&gt;vdev.guest_features) {<br>
&gt; =A0 =A0 &gt; + =E1 =E1 =E1 =E1qemu_put_be32(f, n-&gt;curr_offloads);<b=
r>
&gt; =A0 =A0 &gt; + =E1 =E1}<br>
&gt; =A0 =A0 &gt; =E1}<br>
&gt; =A0 =A0 &gt;<br>
&gt; =A0 =A0 &gt; =E1static int virtio_net_load(QEMUFile *f, void *opaque, =
int version_id)<br>
<div class=3D"im">&gt; =A0 =A0 &gt; @@ -1156,15 +1236,6 @@ static int virti=
o_net_load(QEMUFile *f, void<br>
&gt; =A0 =A0 *opaque, int version_id)<br>
</div>&gt; =A0 =A0 &gt; =E1 =E1 =E1 =E1 =E1 =E1 =E1error_report(&quot;virti=
o-net: saved image requires vnet_hdr=3D<br>
&gt; =A0 =A0 on&quot;);<br>
&gt; =A0 =A0 &gt; =E1 =E1 =E1 =E1 =E1 =E1 =E1return -1;<br>
&gt; =A0 =A0 &gt; =E1 =E1 =E1 =E1 =E1}<br>
&gt; =A0 =A0 &gt; -<br>
&gt; =A0 =A0 &gt; - =E1 =E1 =E1 =E1if (n-&gt;has_vnet_hdr) {<br>
&gt; =A0 =A0 &gt; - =E1 =E1 =E1 =E1 =E1 =E1tap_set_offload(qemu_get_queue(n=
-&gt;nic)-&gt;peer,<br>
&gt; =A0 =A0 &gt; - =E1 =E1 =E1 =E1 =E1 =E1 =E1 =E1 =E1 =E1(n-&gt;vdev.gues=
t_features &gt;&gt; VIRTIO_NET_F_GUEST_CSUM)<br>
&gt; =A0 =A0 &amp; 1,<br>
&gt; =A0 =A0 &gt; - =E1 =E1 =E1 =E1 =E1 =E1 =E1 =E1 =E1 =E1(n-&gt;vdev.gues=
t_features &gt;&gt; VIRTIO_NET_F_GUEST_TSO4)<br>
&gt; =A0 =A0 &amp; 1,<br>
&gt; =A0 =A0 &gt; - =E1 =E1 =E1 =E1 =E1 =E1 =E1 =E1 =E1 =E1(n-&gt;vdev.gues=
t_features &gt;&gt; VIRTIO_NET_F_GUEST_TSO6)<br>
&gt; =A0 =A0 &amp; 1,<br>
&gt; =A0 =A0 &gt; - =E1 =E1 =E1 =E1 =E1 =E1 =E1 =E1 =E1 =E1(n-&gt;vdev.gues=
t_features &gt;&gt; VIRTIO_NET_F_GUEST_ECN) =E1<br>
&gt; =A0 =A0 &amp; 1,<br>
&gt; =A0 =A0 &gt; - =E1 =E1 =E1 =E1 =E1 =E1 =E1 =E1 =E1 =E1(n-&gt;vdev.gues=
t_features &gt;&gt; VIRTIO_NET_F_GUEST_UFO) =E1<br>
&gt; =A0 =A0 &amp; 1);<br>
&gt; =A0 =A0 &gt; - =E1 =E1 =E1 =E1}<br>
&gt; =A0 =A0 &gt; =E1 =E1 =E1}<br>
&gt; =A0 =A0 &gt;<br>
&gt; =A0 =A0 &gt; =E1 =E1 =E1if (version_id &gt;=3D 9) {<br>
<div class=3D"im">&gt; =A0 =A0 &gt; @@ -1198,6 +1269,16 @@ static int virti=
o_net_load(QEMUFile *f, void<br>
&gt; =A0 =A0 *opaque, int version_id)<br>
</div>&gt; =A0 =A0 &gt; =E1 =E1 =E1 =E1 =E1}<br>
&gt; =A0 =A0 &gt; =E1 =E1 =E1}<br>
&gt; =A0 =A0 &gt;<br>
&gt; =A0 =A0 &gt; + =E1 =E1if ((1 &lt;&lt; VIRTIO_NET_F_CTRL_GUEST_OFFLD) &=
amp; n-&gt;vdev.guest_features) {<br>
&gt; =A0 =A0 &gt; + =E1 =E1 =E1 =E1n-&gt;curr_offloads =3D qemu_get_be32(f)=
;<br>
&gt; =A0 =A0 &gt; + =E1 =E1} else {<br>
&gt; =A0 =A0 &gt; + =E1 =E1 =E1 =E1n-&gt;curr_offloads =3D virtio_net_suppo=
rted_offloads(n);<br>
&gt; =A0 =A0 &gt; + =E1 =E1}<br>
&gt; =A0 =A0 &gt; +<br>
&gt; =A0 =A0 &gt; + =E1 =E1if (peer_has_vnet_hdr(n)) {<br>
&gt; =A0 =A0 &gt; + =E1 =E1 =E1 =E1virtio_net_apply_offloads(n);<br>
&gt; =A0 =A0 &gt; + =E1 =E1}<br>
&gt; =A0 =A0 &gt; +<br>
&gt; =A0 =A0 &gt; =E1 =E1 =E1virtio_net_set_queues(n);<br>
&gt; =A0 =A0 &gt;<br>
&gt; =A0 =A0 &gt; =E1 =E1 =E1/* Find the first multicast entry in the saved=
 MAC filter */<br>
<div class=3D"im">&gt; =A0 =A0 &gt; diff --git a/hw/virtio-net.h b/hw/virti=
o-net.h<br>
&gt; =A0 =A0 &gt; index 4d1a8cd..002d526 100644<br>
&gt; =A0 =A0 &gt; --- a/hw/virtio-net.h<br>
&gt; =A0 =A0 &gt; +++ b/hw/virtio-net.h<br>
&gt; =A0 =A0 &gt; @@ -27,6 +27,8 @@<br>
</div>&gt; =A0 =A0 &gt; =E1/* The feature bitmap for virtio net */<br>
&gt; =A0 =A0 &gt; =E1#define VIRTIO_NET_F_CSUM =E1 =E1 =E1 0 =E1 =E1 =E1 /*=
 Host handles pkts w/ partial<br>
&gt; =A0 =A0 csum */<br>
&gt; =A0 =A0 &gt; =E1#define VIRTIO_NET_F_GUEST_CSUM 1 =E1 =E1 =E1 /* Guest=
 handles pkts w/ partial<br>
<div class=3D"im">&gt; =A0 =A0 csum */<br>
&gt; =A0 =A0 &gt; +#define VIRTIO_NET_F_CTRL_GUEST_OFFLD 2 /* Control chann=
el offload<br>
&gt;<br>
&gt; =A0 =A0 It&#39;s very long anyway, so let&#39;s make it the full<br>
&gt; =A0 =A0 VIRTIO_NET_F_CTRL_GUEST_OFFLOADS to match the command name.<br=
>
&gt;<br>
</div>&gt; =A0 =A0 &gt; + =E1 =E1 =E1 =E1 =E1 =E1 =E1 =E1 =E1 =E1 =E1 =E1 =
=E1 =E1 =E1 =E1 =E1 =E1 =E1 =E1 * configuration support */<br>
&gt; =A0 =A0 &gt; =E1#define VIRTIO_NET_F_MAC =E1 =E1 =E1 =E15 =E1 =E1 =E1 =
/* Host has given MAC address. *<br>
&gt; =A0 =A0 /<br>
&gt; =A0 =A0 &gt; =E1#define VIRTIO_NET_F_GSO =E1 =E1 =E1 =E16 =E1 =E1 =E1 =
/* Host handles pkts w/ any GSO<br>
&gt; =A0 =A0 type */<br>
&gt; =A0 =A0 &gt; =E1#define VIRTIO_NET_F_GUEST_TSO4 7 =E1 =E1 =E1 /* Guest=
 can handle TSOv4 in. */<br>
<div class=3D"im">&gt; =A0 =A0 &gt; @@ -182,6 +184,7 @@ typedef struct Virt=
IONet {<br>
</div>&gt; =A0 =A0 &gt; =E1 =E1 =E1uint16_t max_queues;<br>
&gt; =A0 =A0 &gt; =E1 =E1 =E1uint16_t curr_queues;<br>
&gt; =A0 =A0 &gt; =E1 =E1 =E1size_t config_size;<br>
&gt; =A0 =A0 &gt; + =E1 =E1uint32_t curr_offloads;<br>
&gt; =A0 =A0 &gt; =E1} VirtIONet;<br>
&gt; =A0 =A0 &gt;<br>
&gt; =A0 =A0 &gt; =E1#define VIRTIO_NET_CTRL_MAC =E1 =E11<br>
<div class=3D"im">&gt; =A0 =A0 &gt; @@ -221,6 +224,21 @@ struct virtio_net_=
ctrl_mq {<br>
</div>&gt; =A0 =A0 &gt; =E1 #define VIRTIO_NET_CTRL_MQ_VQ_PAIRS_MIN =E1 =E1=
 =E1 =E11<br>
&gt; =A0 =A0 &gt; =E1 #define VIRTIO_NET_CTRL_MQ_VQ_PAIRS_MAX =E1 =E1 =E1 =
=E10x8000<br>
<div class=3D"im">&gt; =A0 =A0 &gt;<br>
&gt; =A0 =A0 &gt; +/*<br>
&gt; =A0 =A0 &gt; + * Control network offloads<br>
&gt; =A0 =A0 &gt; + *<br>
&gt; =A0 =A0 &gt; + * Dynamic offloads are available with the<br>
&gt; =A0 =A0 &gt; + * VIRTIO_NET_F_CTRL_GUEST_OFFLD feature bit.<br>
&gt; =A0 =A0 &gt; + */<br>
</div>&gt; =A0 =A0 &gt; +#define VIRTIO_NET_CTRL_GUEST_OFFLOADS =E1 5<br>
&gt; =A0 =A0 &gt; + #define VIRTIO_NET_CTRL_GUEST_OFFLOADS_SET =E1 =E1 =E1 =
=E10<br>
&gt; =A0 =A0 &gt; +<br>
&gt; =A0 =A0 &gt; +#define VIRTIO_NET_OFFLOAD_GUEST_CSUM =E1 =E1 =E1 1<br>
&gt; =A0 =A0 &gt; +#define VIRTIO_NET_OFFLOAD_GUEST_TSO4 =E1 =E1 =E1 2<br>
&gt; =A0 =A0 &gt; +#define VIRTIO_NET_OFFLOAD_GUEST_TSO6 =E1 =E1 =E1 4<br>
&gt; =A0 =A0 &gt; +#define VIRTIO_NET_OFFLOAD_GUEST_ECN =E1 =E1 =E1 =E18<br=
>
&gt; =A0 =A0 &gt; +#define VIRTIO_NET_OFFLOAD_GUEST_UFO =E1 =E1 =E1 16<br>
&gt; =A0 =A0 &gt; +<br>
&gt; =A0 =A0 &gt; =E1#define DEFINE_VIRTIO_NET_FEATURES(_state, _field) \<b=
r>
&gt; =A0 =A0 &gt; =E1 =E1 =E1 =E1 =E1DEFINE_VIRTIO_COMMON_FEATURES(_state, =
_field), \<br>
&gt; =A0 =A0 &gt; =E1 =E1 =E1 =E1 =E1DEFINE_PROP_BIT(&quot;csum&quot;, _sta=
te, _field, VIRTIO_NET_F_CSUM,<br>
<div class=3D"im">&gt; =A0 =A0 true), \<br>
&gt; =A0 =A0 &gt; @@ -241,6 +259,7 @@ struct virtio_net_ctrl_mq {<br>
</div>&gt; =A0 =A0 &gt; =E1 =E1 =E1 =E1 =E1DEFINE_PROP_BIT(&quot;ctrl_vlan&=
quot;, _state, _field,<br>
&gt; =A0 =A0 VIRTIO_NET_F_CTRL_VLAN, true), \<br>
&gt; =A0 =A0 &gt; =E1 =E1 =E1 =E1 =E1DEFINE_PROP_BIT(&quot;ctrl_rx_extra&qu=
ot;, _state, _field,<br>
&gt; =A0 =A0 VIRTIO_NET_F_CTRL_RX_EXTRA, true), \<br>
&gt; =A0 =A0 &gt; =E1 =E1 =E1 =E1 =E1DEFINE_PROP_BIT(&quot;ctrl_mac_addr&qu=
ot;, _state, _field,<br>
&gt; =A0 =A0 VIRTIO_NET_F_CTRL_MAC_ADDR, true), \<br>
&gt; =A0 =A0 &gt; + =E1 =E1 =E1 =E1DEFINE_PROP_BIT(&quot;ctrl_gst_offld&quo=
t;, _state, _field,<br>
&gt; =A0 =A0 VIRTIO_NET_F_CTRL_GUEST_OFFLD, true), \<br>
&gt; =A0 =A0 &gt; =E1 =E1 =E1 =E1 =E1DEFINE_PROP_BIT(&quot;mq&quot;, _state=
, _field, VIRTIO_NET_F_MQ, false)<br>
&gt; =A0 =A0 &gt;<br>
&gt; =A0 =A0 &gt; =E1#endif<br>
<div class=3D""><div class=3D"h5">&gt;<br>
&gt;<br>
&gt; =A0 =A0 Looks good. Better to replace ctrl_gst_offld by ctrl_guest_off=
loads.<br>
&gt; =A0 =A0 Also need to patch hw/pc.h with compat macros so that<br>
&gt; =A0 =A0 the feature is disabled for old machine types.<br>
&gt;<br>
&gt;<br>
&gt; =A0 =A0 &gt; --<br>
&gt; =A0 =A0 &gt; 1.8.1.4<br>
&gt;<br>
&gt;<br>
</div></div></blockquote></div><br></div></div>

--e89a8f3ba4172286c204d95b3f7a--

--===============2731910690601972555==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
--===============2731910690601972555==--
