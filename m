From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH 2/2] virtio-net: dynamic network offloads configuration
Date: Wed, 27 Mar 2013 20:11:20 +0200
Message-ID: <20130327181120.GC457@redhat.com>
References: <1364391798-8058-1-git-send-email-dmitry@daynix.com>
	<1364391798-8058-3-git-send-email-dmitry@daynix.com>
	<20130327152629.GB29249@redhat.com>
	<CAGHCxhdoHtzpFn8+-S7OwWz7frfATzTh_d6SD6ZB+jKN2w2+VA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <CAGHCxhdoHtzpFn8+-S7OwWz7frfATzTh_d6SD6ZB+jKN2w2+VA@mail.gmail.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Dmitry Fleytman <dmitry@daynix.com>
Cc: Yan Vugenfirer <yan@daynix.com>, Dmitry Fleytman <dfleytma@redhat.com>, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

On Wed, Mar 27, 2013 at 07:48:18PM +0200, Dmitry Fleytman wrote:
> Michael, thanks for review.
> See my comments inline.
> =

> On Wed, Mar 27, 2013 at 5:26 PM, Michael S. Tsirkin <mst@redhat.com> wrot=
e:
> =

>     On Wed, Mar 27, 2013 at 03:43:18PM +0200, Dmitry Fleytman wrote:
>     > From: Dmitry Fleytman <dfleytma@redhat.com>
>     >
>     > Virtio-net driver currently negotiates network offloads
>     > on startup via features mechanism and have no ability to
>     > change offloads state later.
>     > This patch introduced a new control command that allows
>     > to configure device network offloads state dynamically.
>     > The patch also introduces a new feature flag
>     > VIRTIO_NET_F_CTRL_OFFLD.
>     >
>     > Signed-off-by: Dmitry Fleytman <dfleytma@redhat.com>
>     > ---
>     > =A0hw/virtio-net.c | 110
>     +++++++++++++++++++++++++++++++++++++++++++++++---------
>     > =A0hw/virtio-net.h | =A019 ++++++++++
>     > =A02 files changed, 113 insertions(+), 16 deletions(-)
>     >
>     > diff --git a/hw/virtio-net.c b/hw/virtio-net.c
>     > index 4bb49eb..0c23126 100644
>     > --- a/hw/virtio-net.c
>     > +++ b/hw/virtio-net.c
>     > @@ -21,7 +21,7 @@
>     > =A0#include "hw/virtio-net.h"
>     > =A0#include "hw/vhost_net.h"
>     >
>     > -#define VIRTIO_NET_VM_VERSION =A0 =A011
>     > +#define VIRTIO_NET_VM_VERSION =A0 =A012
> =

>     This will break cross-version migration, we do it differently now:
>     - disable feature with old machine types
> =

>     - only pass offloads around if feature set
> =

>     - same for receive side
> =

> =

> =

> [DF] Not sure I got your idea.
> [DF] Current logic aimed ensure proper operation in all old <--> new migr=
ation
> cases:

AFAIK if you change VIRTIO_NET_VM_VERSION old host willl fail to parse
it.

> [DF] In case of old<-->new migration host doesn't expose=A0
> VIRTIO_NET_F_CTRL_OFFLD

> [DF] offload feature so guest is unable to use it, after migration to a n=
ewer
> host nothing changes.
> [DF] In case of new<-->old migration all offloads negotiated on startup v=
ia
> features will be enabled (old logic)
> [DF] and guest will be unable to change offloads state via control channel
> anymore.
> [DF] The second case is a little bit problematic because some offloads th=
at
> were originally disabled
> [DF] may become enabled after migration but it doesn't look like there is=
 a
> better solution.
> [DF] Do I miss something?
> =A0
> =

>     >
>     > =A0#define MAC_TABLE_ENTRIES =A0 =A064
>     > =A0#define MAX_VLAN =A0 =A0(1 << 12) =A0 /* Per 802.1Q definition */
>     > @@ -360,6 +360,48 @@ static uint32_t virtio_net_bad_features(VirtIO=
Device
>     *vdev)
>     > =A0 =A0 =A0return features;
>     > =A0}
>     >
>     > +static void virtio_net_apply_offloads(VirtIONet *n)
>     > +{
>     > + =A0 =A0tap_set_offload(qemu_get_subqueue(n->nic, 0)->peer,
>     > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0!!(n->curr_offloads &
>     VIRTIO_NET_OFFLOAD_GUEST_CSUM),
>     > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0!!(n->curr_offloads &
>     VIRTIO_NET_OFFLOAD_GUEST_TSO4),
>     > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0!!(n->curr_offloads &
>     VIRTIO_NET_OFFLOAD_GUEST_TSO6),
>     > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0!!(n->curr_offloads & VIRT=
IO_NET_OFFLOAD_GUEST_ECN),
>     > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0!!(n->curr_offloads &
>     VIRTIO_NET_OFFLOAD_GUEST_UFO));
>     > +}
>     > +
>     > +static uint32_t virtio_net_offloads_by_features(uint32_t features)
>     > +{
>     > + =A0 =A0uint32_t offloads =3D 0;
>     > +
>     > + =A0 =A0if ((1 << VIRTIO_NET_F_GUEST_CSUM) & features) {
>     > + =A0 =A0 =A0 =A0offloads |=3D VIRTIO_NET_OFFLOAD_GUEST_CSUM;
>     > + =A0 =A0}
>     > +
>     > + =A0 =A0if ((1 << VIRTIO_NET_F_GUEST_TSO4) & features) {
>     > + =A0 =A0 =A0 =A0offloads |=3D VIRTIO_NET_OFFLOAD_GUEST_TSO4;
>     > + =A0 =A0}
>     > +
>     > + =A0 =A0if ((1 << VIRTIO_NET_F_GUEST_TSO6) & features) {
>     > + =A0 =A0 =A0 =A0offloads |=3D VIRTIO_NET_OFFLOAD_GUEST_TSO6;
>     > + =A0 =A0}
>     > +
>     > + =A0 =A0if ((1 << VIRTIO_NET_F_GUEST_ECN) & features) {
>     > + =A0 =A0 =A0 =A0offloads |=3D VIRTIO_NET_OFFLOAD_GUEST_ECN;
>     > + =A0 =A0}
>     > +
>     > + =A0 =A0if ((1 << VIRTIO_NET_F_GUEST_UFO) & features) {
>     > + =A0 =A0 =A0 =A0offloads |=3D VIRTIO_NET_OFFLOAD_GUEST_UFO;
>     > + =A0 =A0}
>     > +
>     > + =A0 =A0return offloads;
>     > +}
>     > +
>     > +static inline uint32_t virtio_net_supported_offloads(VirtIONet *n)
>     > +{
>     > + =A0 =A0return virtio_net_offloads_by_features(n->vdev.guest_featu=
res);
>     > +}
>     > +
>     > =A0static void virtio_net_set_features(VirtIODevice *vdev, uint32_t
>     features)
>     > =A0{
>     > =A0 =A0 =A0VirtIONet *n =3D to_virtio_net(vdev);
>     > @@ -371,12 +413,8 @@ static void virtio_net_set_features(VirtIODevi=
ce
>     *vdev, uint32_t features)
>     > =A0 =A0 =A0virtio_net_set_mrg_rx_bufs(n, !!(features & (1 <<
>     VIRTIO_NET_F_MRG_RXBUF)));
>     >
>     > =A0 =A0 =A0if (n->has_vnet_hdr) {
>     > - =A0 =A0 =A0 =A0tap_set_offload(qemu_get_subqueue(n->nic, 0)->peer,
>     > - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0(features >> VIRTI=
O_NET_F_GUEST_CSUM) & 1,
>     > - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0(features >> VIRTI=
O_NET_F_GUEST_TSO4) & 1,
>     > - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0(features >> VIRTI=
O_NET_F_GUEST_TSO6) & 1,
>     > - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0(features >> VIRTI=
O_NET_F_GUEST_ECN) =A0& 1,
>     > - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0(features >> VIRTI=
O_NET_F_GUEST_UFO) =A0& 1);
>     > + =A0 =A0 =A0 =A0n->curr_offloads =3D virtio_net_offloads_by_featur=
es(features);
>     > + =A0 =A0 =A0 =A0virtio_net_apply_offloads(n);
>     > =A0 =A0 =A0}
>     >
>     > =A0 =A0 =A0for (i =3D 0; =A0i < n->max_queues; i++) {
>     > @@ -422,6 +460,42 @@ static int virtio_net_handle_rx_mode(VirtIONet=
 *n,
>     uint8_t cmd,
>     > =A0 =A0 =A0return VIRTIO_NET_OK;
>     > =A0}
>     >
>     > +static int virtio_net_handle_offloads(VirtIONet *n, uint8_t cmd,
>     > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 struct iovec *iov, unsigned int
>     iov_cnt)
>     > +{
>     > + =A0 =A0uint32_t offloads;
>     > + =A0 =A0size_t s;
>     > +
>     > + =A0 =A0if (!((1 << VIRTIO_NET_F_CTRL_OFFLD) & n->vdev.guest_featu=
res)) {
>     > + =A0 =A0 =A0 =A0return VIRTIO_NET_ERR;
>     > + =A0 =A0}
>     > +
>     > + =A0 =A0s =3D iov_to_buf(iov, iov_cnt, 0, &offloads, sizeof(offloa=
ds));
>     > + =A0 =A0if (s !=3D sizeof(offloads)) {
>     > + =A0 =A0 =A0 =A0return VIRTIO_NET_ERR;
>     > + =A0 =A0}
>     > +
>     > + =A0 =A0if (cmd =3D=3D VIRTIO_NET_CTRL_OFFLOADS_SET) {
>     > + =A0 =A0 =A0 =A0uint32_t supported_offloads;
>     > +
>     > + =A0 =A0 =A0 =A0if (!n->has_vnet_hdr) {
>     > + =A0 =A0 =A0 =A0 =A0 =A0return VIRTIO_NET_ERR;
>     > + =A0 =A0 =A0 =A0}
>     > +
>     > + =A0 =A0 =A0 =A0supported_offloads =3D virtio_net_supported_offloa=
ds(n);
>     > + =A0 =A0 =A0 =A0if (offloads & ~supported_offloads) {
>     > + =A0 =A0 =A0 =A0 =A0 =A0return VIRTIO_NET_ERR;
>     > + =A0 =A0 =A0 =A0}
>     > +
>     > + =A0 =A0 =A0 =A0n->curr_offloads =3D offloads;
>     > + =A0 =A0 =A0 =A0virtio_net_apply_offloads(n);
> =

>     In the spec you said that only features
>     available in the offloads can be
>     enabled. Probably a good idea to validate
>     and error if that's not the case.
> =

> =

> [DF] Not sure I understood correctly this part,
> [DF] Isn't following check enough to ensure this:
> [DF]=A0> + =A0 =A0 =A0 =A0supported_offloads =3D virtio_net_supported_off=
loads(n);
> [DF] > + =A0 =A0 =A0 =A0if (offloads & ~supported_offloads) {
> [DF] > + =A0 =A0 =A0 =A0 =A0 =A0return VIRTIO_NET_ERR;
> =

> =

> =

>     > +
>     > + =A0 =A0 =A0 =A0return VIRTIO_NET_OK;
>     > + =A0 =A0} else {
>     > + =A0 =A0 =A0 =A0return VIRTIO_NET_ERR;
>     > + =A0 =A0}
>     > +}
>     > +
>     > =A0static int virtio_net_handle_mac(VirtIONet *n, uint8_t cmd,
>     > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 struct iovec *iov, unsigned int
>     iov_cnt)
>     > =A0{
>     > @@ -590,6 +664,8 @@ static void virtio_net_handle_ctrl(VirtIODevice
>     *vdev, VirtQueue *vq)
>     > =A0 =A0 =A0 =A0 =A0 =A0 =A0status =3D virtio_net_handle_vlan_table(=
n, ctrl.cmd, iov,
>     iov_cnt);
>     > =A0 =A0 =A0 =A0 =A0} else if (ctrl.class =3D=3D VIRTIO_NET_CTRL_MQ)=
 {
>     > =A0 =A0 =A0 =A0 =A0 =A0 =A0status =3D virtio_net_handle_mq(n, ctrl.=
cmd, &elem);
>     > + =A0 =A0 =A0 =A0} else if (ctrl.class =3D=3D VIRTIO_NET_CTRL_OFFLO=
ADS) {
>     > + =A0 =A0 =A0 =A0 =A0 =A0status =3D virtio_net_handle_offloads(n, c=
trl.cmd, iov,
>     iov_cnt);
>     > =A0 =A0 =A0 =A0 =A0}
>     >
>     > =A0 =A0 =A0 =A0 =A0s =3D iov_from_buf(elem.in_sg, elem.in_num, 0, &=
status, sizeof
>     (status));
>     > @@ -1099,6 +1175,7 @@ static void virtio_net_save(QEMUFile *f, void
>     *opaque)
>     > =A0 =A0 =A0 =A0 =A0 =A0 =A0qemu_put_be32(f, n->vqs[i].tx_waiting);
>     > =A0 =A0 =A0 =A0 =A0}
>     > =A0 =A0 =A0}
>     > + =A0 =A0qemu_put_be32(f, n->curr_offloads);
> =

>     > =A0}
>     >
>     > =A0static int virtio_net_load(QEMUFile *f, void *opaque, int versio=
n_id)
>     > @@ -1155,15 +1232,6 @@ static int virtio_net_load(QEMUFile *f, void
>     *opaque, int version_id)
>     > =A0 =A0 =A0 =A0 =A0 =A0 =A0error_report("virtio-net: saved image re=
quires vnet_hdr=3D
>     on");
>     > =A0 =A0 =A0 =A0 =A0 =A0 =A0return -1;
>     > =A0 =A0 =A0 =A0 =A0}
>     > -
>     > - =A0 =A0 =A0 =A0if (n->has_vnet_hdr) {
>     > - =A0 =A0 =A0 =A0 =A0 =A0tap_set_offload(qemu_get_queue(n->nic)->pe=
er,
>     > - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0(n->vdev.guest_features >>=
 VIRTIO_NET_F_GUEST_CSUM)
>     & 1,
>     > - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0(n->vdev.guest_features >>=
 VIRTIO_NET_F_GUEST_TSO4)
>     & 1,
>     > - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0(n->vdev.guest_features >>=
 VIRTIO_NET_F_GUEST_TSO6)
>     & 1,
>     > - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0(n->vdev.guest_features >>=
 VIRTIO_NET_F_GUEST_ECN) =A0
>     & 1,
>     > - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0(n->vdev.guest_features >>=
 VIRTIO_NET_F_GUEST_UFO) =A0
>     & 1);
>     > - =A0 =A0 =A0 =A0}
>     > =A0 =A0 =A0}
>     >
>     > =A0 =A0 =A0if (version_id >=3D 9) {
>     > @@ -1197,6 +1265,16 @@ static int virtio_net_load(QEMUFile *f, void
>     *opaque, int version_id)
>     > =A0 =A0 =A0 =A0 =A0}
>     > =A0 =A0 =A0}
>     >
>     > + =A0 =A0if (version_id >=3D 11) {
>     > + =A0 =A0 =A0 =A0n->curr_offloads =3D qemu_get_be32(f);
>     > + =A0 =A0} else {
>     > + =A0 =A0 =A0 =A0n->curr_offloads =3D virtio_net_supported_offloads=
(n);
>     > + =A0 =A0}
>     > +
>     > + =A0 =A0if (n->has_vnet_hdr) {
>     > + =A0 =A0 =A0 =A0virtio_net_apply_offloads(n);
>     > + =A0 =A0}
>     > +
>     > =A0 =A0 =A0virtio_net_set_queues(n);
>     >
>     > =A0 =A0 =A0/* Find the first multicast entry in the saved MAC filte=
r */
>     > diff --git a/hw/virtio-net.h b/hw/virtio-net.h
>     > index 4d1a8cd..649a4e8 100644
>     > --- a/hw/virtio-net.h
>     > +++ b/hw/virtio-net.h
>     > @@ -27,6 +27,8 @@
>     > =A0/* The feature bitmap for virtio net */
>     > =A0#define VIRTIO_NET_F_CSUM =A0 =A0 =A0 0 =A0 =A0 =A0 /* Host hand=
les pkts w/ partial
>     csum */
>     > =A0#define VIRTIO_NET_F_GUEST_CSUM 1 =A0 =A0 =A0 /* Guest handles p=
kts w/ partial
>     csum */
>     > +#define VIRTIO_NET_F_CTRL_OFFLD 2 =A0 =A0 =A0 /* Control channel o=
ffload
>     > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 * configuration support */
>     > =A0#define VIRTIO_NET_F_MAC =A0 =A0 =A0 =A05 =A0 =A0 =A0 /* Host ha=
s given MAC address. *
>     /
>     > =A0#define VIRTIO_NET_F_GSO =A0 =A0 =A0 =A06 =A0 =A0 =A0 /* Host ha=
ndles pkts w/ any GSO
>     type */
>     > =A0#define VIRTIO_NET_F_GUEST_TSO4 7 =A0 =A0 =A0 /* Guest can handl=
e TSOv4 in. */
>     > @@ -182,6 +184,7 @@ typedef struct VirtIONet {
>     > =A0 =A0 =A0uint16_t max_queues;
>     > =A0 =A0 =A0uint16_t curr_queues;
>     > =A0 =A0 =A0size_t config_size;
>     > + =A0 =A0uint32_t curr_offloads;
>     > =A0} VirtIONet;
>     >
>     > =A0#define VIRTIO_NET_CTRL_MAC =A0 =A01
>     > @@ -221,6 +224,21 @@ struct virtio_net_ctrl_mq {
>     > =A0 #define VIRTIO_NET_CTRL_MQ_VQ_PAIRS_MIN =A0 =A0 =A0 =A01
>     > =A0 #define VIRTIO_NET_CTRL_MQ_VQ_PAIRS_MAX =A0 =A0 =A0 =A00x8000
>     >
>     > +/*
>     > + * Control network offloads
>     > + *
>     > + * Dynamic offloads are available with the
>     > + * VIRTIO_NET_F_CTRL_OFFLD feature bit.
>     > + */
>     > +#define VIRTIO_NET_CTRL_OFFLOADS =A0 5
>     > + #define VIRTIO_NET_CTRL_OFFLOADS_SET =A0 =A0 =A0 =A00
>     > +
>     > +#define VIRTIO_NET_OFFLOAD_GUEST_CSUM =A0 =A0 =A0 1
>     > +#define VIRTIO_NET_OFFLOAD_GUEST_TSO4 =A0 =A0 =A0 2
>     > +#define VIRTIO_NET_OFFLOAD_GUEST_TSO6 =A0 =A0 =A0 4
>     > +#define VIRTIO_NET_OFFLOAD_GUEST_ECN =A0 =A0 =A0 =A08
>     > +#define VIRTIO_NET_OFFLOAD_GUEST_UFO =A0 =A0 =A0 16
>     > +
>     > =A0#define DEFINE_VIRTIO_NET_FEATURES(_state, _field) \
>     > =A0 =A0 =A0 =A0 =A0DEFINE_VIRTIO_COMMON_FEATURES(_state, _field), \
>     > =A0 =A0 =A0 =A0 =A0DEFINE_PROP_BIT("csum", _state, _field, VIRTIO_N=
ET_F_CSUM,
>     true), \
>     > @@ -241,6 +259,7 @@ struct virtio_net_ctrl_mq {
>     > =A0 =A0 =A0 =A0 =A0DEFINE_PROP_BIT("ctrl_vlan", _state, _field,
>     VIRTIO_NET_F_CTRL_VLAN, true), \
>     > =A0 =A0 =A0 =A0 =A0DEFINE_PROP_BIT("ctrl_rx_extra", _state, _field,
>     VIRTIO_NET_F_CTRL_RX_EXTRA, true), \
>     > =A0 =A0 =A0 =A0 =A0DEFINE_PROP_BIT("ctrl_mac_addr", _state, _field,
>     VIRTIO_NET_F_CTRL_MAC_ADDR, true), \
>     > + =A0 =A0 =A0 =A0DEFINE_PROP_BIT("ctrl_offload", _state, _field,
>     VIRTIO_NET_F_CTRL_OFFLD, true), \
>     > =A0 =A0 =A0 =A0 =A0DEFINE_PROP_BIT("mq", _state, _field, VIRTIO_NET=
_F_MQ, false)
>     >
>     > =A0#endif
>     > --
>     > 1.8.1.4
> =

> =
