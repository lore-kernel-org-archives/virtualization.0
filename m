From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH 1/2 V2] virtio-net: dynamic network offloads configuration
Date: Tue, 2 Apr 2013 13:53:32 +0300
Message-ID: <20130402105332.GA21572@redhat.com>
References: <1364464860-28961-1-git-send-email-dmitry@daynix.com>
	<1364464860-28961-2-git-send-email-dmitry@daynix.com>
	<20130328163945.GB30183@redhat.com>
	<CAGHCxhei9j0rNtp4xStouDA3NvgFpTLtt=2bkvYW-D18CzqUAQ@mail.gmail.com>
	<20130331075352.GF23484@redhat.com>
	<CAGHCxhfcTrmh2eqn=EAhi+GnK0qWwE3+OGVq4LdCaU6=2FQc9A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <CAGHCxhfcTrmh2eqn=EAhi+GnK0qWwE3+OGVq4LdCaU6=2FQc9A@mail.gmail.com>
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
Cc: Yan Vugenfirer <yan@daynix.com>, Dmitry Fleytman <dfleytma@redhat.com>, virtualization <virtualization@lists.linux-foundation.org>
List-Id: virtualization@lists.linuxfoundation.org

On Tue, Apr 02, 2013 at 09:56:51AM +0300, Dmitry Fleytman wrote:
> =

> =

> =

> On Sun, Mar 31, 2013 at 10:53 AM, Michael S. Tsirkin <mst@redhat.com> wro=
te:
> =

>     On Sat, Mar 30, 2013 at 09:47:58PM +0300, Dmitry Fleytman wrote:
>     > Michael, thanks for review,
>     > I'll rename command as you suggested, indeed it will be better.
>     >
>     > Not sure I understand a concept of compat macros.
>     > Is there documentation available on this topic?
>     >
>     > Dmitry
> =

>     No, but it's simple. It's just lots of arrays of options we apply only
>     one of them depending on -M. See e.g. pc_machine_init.
> =

> =

> =

> Do you mean something like this in PC_COMPAT_1_4:
> =

> diff --git a/hw/pc.h b/hw/pc.h
> index 8e1dd4c..7ca4698 100644
> --- a/hw/pc.h
> +++ b/hw/pc.h
> @@ -221,6 +221,10 @@ int e820_add_entry(uint64_t, uint64_t, uint32_t);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0.property =3D "vectors",\
> =A0 =A0 =A0 =A0 =A0 =A0 =A0/* DEV_NVECTORS_UNSPECIFIED as a uint32_t stri=
ng */\
> =A0 =A0 =A0 =A0 =A0 =A0 =A0.value =A0 =A0=3D stringify(0xFFFFFFFF),\
> + =A0 =A0 =A0 =A0},{ \
> + =A0 =A0 =A0 =A0 =A0 =A0.driver =A0 =3D "virtio-net-pci", \
> + =A0 =A0 =A0 =A0 =A0 =A0.property =3D "ctrl_guest_offloads", \
> + =A0 =A0 =A0 =A0 =A0 =A0.value =A0 =A0=3D "off", \
> =A0 =A0 =A0 =A0 =A0},{\
> =A0 =A0 =A0 =A0 =A0 =A0 =A0.driver =A0 =3D "e1000",\
> =A0 =A0 =A0 =A0 =A0 =A0 =A0.property =3D "romfile",\
> =


Exactly.

> =

>     >
>     > On Thu, Mar 28, 2013 at 6:39 PM, Michael S. Tsirkin <mst@redhat.com>
>     wrote:
>     >
>     > =A0 =A0 On Thu, Mar 28, 2013 at 12:00:59PM +0200, Dmitry Fleytman w=
rote:
>     > =A0 =A0 > From: Dmitry Fleytman <dfleytma@redhat.com>
>     > =A0 =A0 >
>     > =A0 =A0 > Virtio-net driver currently negotiates network offloads
>     > =A0 =A0 > on startup via features mechanism and have no ability to
>     > =A0 =A0 > change offloads state later.
>     > =A0 =A0 > This patch introduced a new control command that allows
>     > =A0 =A0 > to configure device network offloads state dynamically.
>     > =A0 =A0 > The patch also introduces a new feature flag
>     > =A0 =A0 > VIRTIO_NET_F_CTRL_GUEST_OFFLD.
>     > =A0 =A0 >
>     > =A0 =A0 > Signed-off-by: Dmitry Fleytman <dfleytma@redhat.com>
>     > =A0 =A0 > ---
>     > =A0 =A0 > =E1hw/virtio-net.c | 111
>     > =A0 =A0 ++++++++++++++++++++++++++++++++++++++++++++++++--------
>     > =A0 =A0 > =E1hw/virtio-net.h | =E119 ++++++++++
>     > =A0 =A0 > =E12 files changed, 115 insertions(+), 15 deletions(-)
>     > =A0 =A0 >
>     > =A0 =A0 > diff --git a/hw/virtio-net.c b/hw/virtio-net.c
>     > =A0 =A0 > index 5917740..a016823 100644
>     > =A0 =A0 > --- a/hw/virtio-net.c
>     > =A0 =A0 > +++ b/hw/virtio-net.c
>     > =A0 =A0 > @@ -360,6 +360,48 @@ static uint32_t virtio_net_bad_featu=
res
>     (VirtIODevice
>     > =A0 =A0 *vdev)
>     > =A0 =A0 > =E1 =E1 =E1return features;
>     > =A0 =A0 > =E1}
>     > =A0 =A0 >
>     > =A0 =A0 > +static void virtio_net_apply_offloads(VirtIONet *n)
>     > =A0 =A0 > +{
>     > =A0 =A0 > + =E1 =E1tap_set_offload(qemu_get_subqueue(n->nic, 0)->pe=
er,
>     > =A0 =A0 > + =E1 =E1 =E1 =E1 =E1 =E1 =E1 =E1 =E1 =E1!!(n->curr_offlo=
ads &
>     > =A0 =A0 VIRTIO_NET_OFFLOAD_GUEST_CSUM),
>     > =A0 =A0 > + =E1 =E1 =E1 =E1 =E1 =E1 =E1 =E1 =E1 =E1!!(n->curr_offlo=
ads &
>     > =A0 =A0 VIRTIO_NET_OFFLOAD_GUEST_TSO4),
>     > =A0 =A0 > + =E1 =E1 =E1 =E1 =E1 =E1 =E1 =E1 =E1 =E1!!(n->curr_offlo=
ads &
>     > =A0 =A0 VIRTIO_NET_OFFLOAD_GUEST_TSO6),
>     > =A0 =A0 > + =E1 =E1 =E1 =E1 =E1 =E1 =E1 =E1 =E1 =E1!!(n->curr_offlo=
ads &
>     VIRTIO_NET_OFFLOAD_GUEST_ECN),
>     > =A0 =A0 > + =E1 =E1 =E1 =E1 =E1 =E1 =E1 =E1 =E1 =E1!!(n->curr_offlo=
ads &
>     > =A0 =A0 VIRTIO_NET_OFFLOAD_GUEST_UFO));
>     > =A0 =A0 > +}
>     > =A0 =A0 > +
>     > =A0 =A0 > +static uint32_t virtio_net_offloads_by_features(uint32_t=
 features)
>     > =A0 =A0 > +{
>     > =A0 =A0 > + =E1 =E1uint32_t offloads =3D 0;
>     > =A0 =A0 > +
>     > =A0 =A0 > + =E1 =E1if ((1 << VIRTIO_NET_F_GUEST_CSUM) & features) {
>     > =A0 =A0 > + =E1 =E1 =E1 =E1offloads |=3D VIRTIO_NET_OFFLOAD_GUEST_C=
SUM;
>     > =A0 =A0 > + =E1 =E1}
>     > =A0 =A0 > +
>     > =A0 =A0 > + =E1 =E1if ((1 << VIRTIO_NET_F_GUEST_TSO4) & features) {
>     > =A0 =A0 > + =E1 =E1 =E1 =E1offloads |=3D VIRTIO_NET_OFFLOAD_GUEST_T=
SO4;
>     > =A0 =A0 > + =E1 =E1}
>     > =A0 =A0 > +
>     > =A0 =A0 > + =E1 =E1if ((1 << VIRTIO_NET_F_GUEST_TSO6) & features) {
>     > =A0 =A0 > + =E1 =E1 =E1 =E1offloads |=3D VIRTIO_NET_OFFLOAD_GUEST_T=
SO6;
>     > =A0 =A0 > + =E1 =E1}
>     > =A0 =A0 > +
>     > =A0 =A0 > + =E1 =E1if ((1 << VIRTIO_NET_F_GUEST_ECN) & features) {
>     > =A0 =A0 > + =E1 =E1 =E1 =E1offloads |=3D VIRTIO_NET_OFFLOAD_GUEST_E=
CN;
>     > =A0 =A0 > + =E1 =E1}
>     > =A0 =A0 > +
>     > =A0 =A0 > + =E1 =E1if ((1 << VIRTIO_NET_F_GUEST_UFO) & features) {
>     > =A0 =A0 > + =E1 =E1 =E1 =E1offloads |=3D VIRTIO_NET_OFFLOAD_GUEST_U=
FO;
>     > =A0 =A0 > + =E1 =E1}
>     > =A0 =A0 > +
>     > =A0 =A0 > + =E1 =E1return offloads;
>     > =A0 =A0 > +}
>     > =A0 =A0 > +
>     > =A0 =A0 > +static inline uint32_t virtio_net_supported_offloads(Vir=
tIONet *n)
>     > =A0 =A0 > +{
>     > =A0 =A0 > + =E1 =E1return virtio_net_offloads_by_features(n->
>     vdev.guest_features);
>     > =A0 =A0 > +}
>     > =A0 =A0 > +
>     > =A0 =A0 > =E1static void virtio_net_set_features(VirtIODevice *vdev=
, uint32_t
>     > =A0 =A0 features)
>     > =A0 =A0 > =E1{
>     > =A0 =A0 > =E1 =E1 =E1VirtIONet *n =3D to_virtio_net(vdev);
>     > =A0 =A0 > @@ -371,12 +413,8 @@ static void virtio_net_set_features
>     (VirtIODevice
>     > =A0 =A0 *vdev, uint32_t features)
>     > =A0 =A0 > =E1 =E1 =E1virtio_net_set_mrg_rx_bufs(n, !!(features & (1=
 <<
>     > =A0 =A0 VIRTIO_NET_F_MRG_RXBUF)));
>     > =A0 =A0 >
>     > =A0 =A0 > =E1 =E1 =E1if (n->has_vnet_hdr) {
>     > =A0 =A0 > - =E1 =E1 =E1 =E1tap_set_offload(qemu_get_subqueue(n->nic=
, 0)->peer,
>     > =A0 =A0 > - =E1 =E1 =E1 =E1 =E1 =E1 =E1 =E1 =E1 =E1 =E1 =E1(feature=
s >> VIRTIO_NET_F_GUEST_CSUM) & 1,
>     > =A0 =A0 > - =E1 =E1 =E1 =E1 =E1 =E1 =E1 =E1 =E1 =E1 =E1 =E1(feature=
s >> VIRTIO_NET_F_GUEST_TSO4) & 1,
>     > =A0 =A0 > - =E1 =E1 =E1 =E1 =E1 =E1 =E1 =E1 =E1 =E1 =E1 =E1(feature=
s >> VIRTIO_NET_F_GUEST_TSO6) & 1,
>     > =A0 =A0 > - =E1 =E1 =E1 =E1 =E1 =E1 =E1 =E1 =E1 =E1 =E1 =E1(feature=
s >> VIRTIO_NET_F_GUEST_ECN) =E1& 1,
>     > =A0 =A0 > - =E1 =E1 =E1 =E1 =E1 =E1 =E1 =E1 =E1 =E1 =E1 =E1(feature=
s >> VIRTIO_NET_F_GUEST_UFO) =E1&
>     1);
>     > =A0 =A0 > + =E1 =E1 =E1 =E1n->curr_offloads =3D virtio_net_offloads=
_by_features
>     (features);
>     > =A0 =A0 > + =E1 =E1 =E1 =E1virtio_net_apply_offloads(n);
>     > =A0 =A0 > =E1 =E1 =E1}
>     > =A0 =A0 >
>     > =A0 =A0 > =E1 =E1 =E1for (i =3D 0; =E1i < n->max_queues; i++) {
>     > =A0 =A0 > @@ -422,6 +460,42 @@ static int virtio_net_handle_rx_mode=
(VirtIONet
>     *n,
>     > =A0 =A0 uint8_t cmd,
>     > =A0 =A0 > =E1 =E1 =E1return VIRTIO_NET_OK;
>     > =A0 =A0 > =E1}
>     > =A0 =A0 >
>     > =A0 =A0 > +static int virtio_net_handle_offloads(VirtIONet *n, uint=
8_t cmd,
>     > =A0 =A0 > + =E1 =E1 =E1 =E1 =E1 =E1 =E1 =E1 =E1 =E1 =E1 =E1 =E1 =E1=
 =E1 =E1 =E1 =E1 struct iovec *iov, unsigned
>     int
>     > =A0 =A0 iov_cnt)
>     > =A0 =A0 > +{
>     > =A0 =A0 > + =E1 =E1uint32_t offloads;
>     > =A0 =A0 > + =E1 =E1size_t s;
>     > =A0 =A0 > +
>     > =A0 =A0 > + =E1 =E1if (!((1 << VIRTIO_NET_F_CTRL_GUEST_OFFLD) & n->
>     > =A0 =A0 vdev.guest_features)) {
>     > =A0 =A0 > + =E1 =E1 =E1 =E1return VIRTIO_NET_ERR;
>     > =A0 =A0 > + =E1 =E1}
>     > =A0 =A0 > +
>     > =A0 =A0 > + =E1 =E1s =3D iov_to_buf(iov, iov_cnt, 0, &offloads, siz=
eof(offloads));
>     > =A0 =A0 > + =E1 =E1if (s !=3D sizeof(offloads)) {
>     > =A0 =A0 > + =E1 =E1 =E1 =E1return VIRTIO_NET_ERR;
>     > =A0 =A0 > + =E1 =E1}
>     > =A0 =A0 > +
>     > =A0 =A0 > + =E1 =E1if (cmd =3D=3D VIRTIO_NET_CTRL_GUEST_OFFLOADS_SE=
T) {
>     > =A0 =A0 > + =E1 =E1 =E1 =E1uint32_t supported_offloads;
>     > =A0 =A0 > +
>     > =A0 =A0 > + =E1 =E1 =E1 =E1if (!n->has_vnet_hdr) {
>     > =A0 =A0 > + =E1 =E1 =E1 =E1 =E1 =E1return VIRTIO_NET_ERR;
>     > =A0 =A0 > + =E1 =E1 =E1 =E1}
>     > =A0 =A0 > +
>     > =A0 =A0 > + =E1 =E1 =E1 =E1supported_offloads =3D virtio_net_suppor=
ted_offloads(n);
>     > =A0 =A0 > + =E1 =E1 =E1 =E1if (offloads & ~supported_offloads) {
>     > =A0 =A0 > + =E1 =E1 =E1 =E1 =E1 =E1return VIRTIO_NET_ERR;
>     > =A0 =A0 > + =E1 =E1 =E1 =E1}
>     > =A0 =A0 > +
>     > =A0 =A0 > + =E1 =E1 =E1 =E1n->curr_offloads =3D offloads;
>     > =A0 =A0 > + =E1 =E1 =E1 =E1virtio_net_apply_offloads(n);
>     > =A0 =A0 > +
>     > =A0 =A0 > + =E1 =E1 =E1 =E1return VIRTIO_NET_OK;
>     > =A0 =A0 > + =E1 =E1} else {
>     > =A0 =A0 > + =E1 =E1 =E1 =E1return VIRTIO_NET_ERR;
>     > =A0 =A0 > + =E1 =E1}
>     > =A0 =A0 > +}
>     > =A0 =A0 > +
>     > =A0 =A0 > =E1static int virtio_net_handle_mac(VirtIONet *n, uint8_t=
 cmd,
>     > =A0 =A0 > =E1 =E1 =E1 =E1 =E1 =E1 =E1 =E1 =E1 =E1 =E1 =E1 =E1 =E1 =
=E1 =E1 =E1 struct iovec *iov, unsigned int
>     > =A0 =A0 iov_cnt)
>     > =A0 =A0 > =E1{
>     > =A0 =A0 > @@ -591,6 +665,8 @@ static void virtio_net_handle_ctrl(Vi=
rtIODevice
>     > =A0 =A0 *vdev, VirtQueue *vq)
>     > =A0 =A0 > =E1 =E1 =E1 =E1 =E1 =E1 =E1status =3D virtio_net_handle_v=
lan_table(n, ctrl.cmd,
>     iov,
>     > =A0 =A0 iov_cnt);
>     > =A0 =A0 > =E1 =E1 =E1 =E1 =E1} else if (ctrl.class =3D=3D VIRTIO_NE=
T_CTRL_MQ) {
>     > =A0 =A0 > =E1 =E1 =E1 =E1 =E1 =E1 =E1status =3D virtio_net_handle_m=
q(n, ctrl.cmd, iov,
>     iov_cnt);
>     > =A0 =A0 > + =E1 =E1 =E1 =E1} else if (ctrl.class =3D=3D VIRTIO_NET_=
CTRL_GUEST_OFFLOADS) {
>     > =A0 =A0 > + =E1 =E1 =E1 =E1 =E1 =E1status =3D virtio_net_handle_off=
loads(n, ctrl.cmd, iov,
>     > =A0 =A0 iov_cnt);
>     > =A0 =A0 > =E1 =E1 =E1 =E1 =E1}
>     > =A0 =A0 >
>     > =A0 =A0 > =E1 =E1 =E1 =E1 =E1s =3D iov_from_buf(elem.in_sg, elem.in=
_num, 0, &status,
>     sizeof
>     > =A0 =A0 (status));
>     > =A0 =A0 > @@ -1100,6 +1176,10 @@ static void virtio_net_save(QEMUFi=
le *f,
>     void
>     > =A0 =A0 *opaque)
>     > =A0 =A0 > =E1 =E1 =E1 =E1 =E1 =E1 =E1qemu_put_be32(f, n->vqs[i].tx_=
waiting);
>     > =A0 =A0 > =E1 =E1 =E1 =E1 =E1}
>     > =A0 =A0 > =E1 =E1 =E1}
>     > =A0 =A0 > +
>     > =A0 =A0 > + =E1 =E1if ((1 << VIRTIO_NET_F_CTRL_GUEST_OFFLD) & n->
>     vdev.guest_features) {
>     > =A0 =A0 > + =E1 =E1 =E1 =E1qemu_put_be32(f, n->curr_offloads);
>     > =A0 =A0 > + =E1 =E1}
>     > =A0 =A0 > =E1}
>     > =A0 =A0 >
>     > =A0 =A0 > =E1static int virtio_net_load(QEMUFile *f, void *opaque, =
int
>     version_id)
>     > =A0 =A0 > @@ -1156,15 +1236,6 @@ static int virtio_net_load(QEMUFil=
e *f, void
>     > =A0 =A0 *opaque, int version_id)
>     > =A0 =A0 > =E1 =E1 =E1 =E1 =E1 =E1 =E1error_report("virtio-net: save=
d image requires
>     vnet_hdr=3D
>     > =A0 =A0 on");
>     > =A0 =A0 > =E1 =E1 =E1 =E1 =E1 =E1 =E1return -1;
>     > =A0 =A0 > =E1 =E1 =E1 =E1 =E1}
>     > =A0 =A0 > -
>     > =A0 =A0 > - =E1 =E1 =E1 =E1if (n->has_vnet_hdr) {
>     > =A0 =A0 > - =E1 =E1 =E1 =E1 =E1 =E1tap_set_offload(qemu_get_queue(n=
->nic)->peer,
>     > =A0 =A0 > - =E1 =E1 =E1 =E1 =E1 =E1 =E1 =E1 =E1 =E1(n->vdev.guest_f=
eatures >>
>     VIRTIO_NET_F_GUEST_CSUM)
>     > =A0 =A0 & 1,
>     > =A0 =A0 > - =E1 =E1 =E1 =E1 =E1 =E1 =E1 =E1 =E1 =E1(n->vdev.guest_f=
eatures >>
>     VIRTIO_NET_F_GUEST_TSO4)
>     > =A0 =A0 & 1,
>     > =A0 =A0 > - =E1 =E1 =E1 =E1 =E1 =E1 =E1 =E1 =E1 =E1(n->vdev.guest_f=
eatures >>
>     VIRTIO_NET_F_GUEST_TSO6)
>     > =A0 =A0 & 1,
>     > =A0 =A0 > - =E1 =E1 =E1 =E1 =E1 =E1 =E1 =E1 =E1 =E1(n->vdev.guest_f=
eatures >>
>     VIRTIO_NET_F_GUEST_ECN) =E1
>     > =A0 =A0 & 1,
>     > =A0 =A0 > - =E1 =E1 =E1 =E1 =E1 =E1 =E1 =E1 =E1 =E1(n->vdev.guest_f=
eatures >>
>     VIRTIO_NET_F_GUEST_UFO) =E1
>     > =A0 =A0 & 1);
>     > =A0 =A0 > - =E1 =E1 =E1 =E1}
>     > =A0 =A0 > =E1 =E1 =E1}
>     > =A0 =A0 >
>     > =A0 =A0 > =E1 =E1 =E1if (version_id >=3D 9) {
>     > =A0 =A0 > @@ -1198,6 +1269,16 @@ static int virtio_net_load(QEMUFil=
e *f, void
>     > =A0 =A0 *opaque, int version_id)
>     > =A0 =A0 > =E1 =E1 =E1 =E1 =E1}
>     > =A0 =A0 > =E1 =E1 =E1}
>     > =A0 =A0 >
>     > =A0 =A0 > + =E1 =E1if ((1 << VIRTIO_NET_F_CTRL_GUEST_OFFLD) & n->
>     vdev.guest_features) {
>     > =A0 =A0 > + =E1 =E1 =E1 =E1n->curr_offloads =3D qemu_get_be32(f);
>     > =A0 =A0 > + =E1 =E1} else {
>     > =A0 =A0 > + =E1 =E1 =E1 =E1n->curr_offloads =3D virtio_net_supporte=
d_offloads(n);
>     > =A0 =A0 > + =E1 =E1}
>     > =A0 =A0 > +
>     > =A0 =A0 > + =E1 =E1if (peer_has_vnet_hdr(n)) {
>     > =A0 =A0 > + =E1 =E1 =E1 =E1virtio_net_apply_offloads(n);
>     > =A0 =A0 > + =E1 =E1}
>     > =A0 =A0 > +
>     > =A0 =A0 > =E1 =E1 =E1virtio_net_set_queues(n);
>     > =A0 =A0 >
>     > =A0 =A0 > =E1 =E1 =E1/* Find the first multicast entry in the saved=
 MAC filter */
>     > =A0 =A0 > diff --git a/hw/virtio-net.h b/hw/virtio-net.h
>     > =A0 =A0 > index 4d1a8cd..002d526 100644
>     > =A0 =A0 > --- a/hw/virtio-net.h
>     > =A0 =A0 > +++ b/hw/virtio-net.h
>     > =A0 =A0 > @@ -27,6 +27,8 @@
>     > =A0 =A0 > =E1/* The feature bitmap for virtio net */
>     > =A0 =A0 > =E1#define VIRTIO_NET_F_CSUM =E1 =E1 =E1 0 =E1 =E1 =E1 /*=
 Host handles pkts w/
>     partial
>     > =A0 =A0 csum */
>     > =A0 =A0 > =E1#define VIRTIO_NET_F_GUEST_CSUM 1 =E1 =E1 =E1 /* Guest=
 handles pkts w/
>     partial
>     > =A0 =A0 csum */
>     > =A0 =A0 > +#define VIRTIO_NET_F_CTRL_GUEST_OFFLD 2 /* Control chann=
el offload
>     >
>     > =A0 =A0 It's very long anyway, so let's make it the full
>     > =A0 =A0 VIRTIO_NET_F_CTRL_GUEST_OFFLOADS to match the command name.
>     >
>     > =A0 =A0 > + =E1 =E1 =E1 =E1 =E1 =E1 =E1 =E1 =E1 =E1 =E1 =E1 =E1 =E1=
 =E1 =E1 =E1 =E1 =E1 =E1 * configuration support *
>     /
>     > =A0 =A0 > =E1#define VIRTIO_NET_F_MAC =E1 =E1 =E1 =E15 =E1 =E1 =E1 =
/* Host has given MAC
>     address. *
>     > =A0 =A0 /
>     > =A0 =A0 > =E1#define VIRTIO_NET_F_GSO =E1 =E1 =E1 =E16 =E1 =E1 =E1 =
/* Host handles pkts w/
>     any GSO
>     > =A0 =A0 type */
>     > =A0 =A0 > =E1#define VIRTIO_NET_F_GUEST_TSO4 7 =E1 =E1 =E1 /* Guest=
 can handle TSOv4
>     in. */
>     > =A0 =A0 > @@ -182,6 +184,7 @@ typedef struct VirtIONet {
>     > =A0 =A0 > =E1 =E1 =E1uint16_t max_queues;
>     > =A0 =A0 > =E1 =E1 =E1uint16_t curr_queues;
>     > =A0 =A0 > =E1 =E1 =E1size_t config_size;
>     > =A0 =A0 > + =E1 =E1uint32_t curr_offloads;
>     > =A0 =A0 > =E1} VirtIONet;
>     > =A0 =A0 >
>     > =A0 =A0 > =E1#define VIRTIO_NET_CTRL_MAC =E1 =E11
>     > =A0 =A0 > @@ -221,6 +224,21 @@ struct virtio_net_ctrl_mq {
>     > =A0 =A0 > =E1 #define VIRTIO_NET_CTRL_MQ_VQ_PAIRS_MIN =E1 =E1 =E1 =
=E11
>     > =A0 =A0 > =E1 #define VIRTIO_NET_CTRL_MQ_VQ_PAIRS_MAX =E1 =E1 =E1 =
=E10x8000
>     > =A0 =A0 >
>     > =A0 =A0 > +/*
>     > =A0 =A0 > + * Control network offloads
>     > =A0 =A0 > + *
>     > =A0 =A0 > + * Dynamic offloads are available with the
>     > =A0 =A0 > + * VIRTIO_NET_F_CTRL_GUEST_OFFLD feature bit.
>     > =A0 =A0 > + */
>     > =A0 =A0 > +#define VIRTIO_NET_CTRL_GUEST_OFFLOADS =E1 5
>     > =A0 =A0 > + #define VIRTIO_NET_CTRL_GUEST_OFFLOADS_SET =E1 =E1 =E1 =
=E10
>     > =A0 =A0 > +
>     > =A0 =A0 > +#define VIRTIO_NET_OFFLOAD_GUEST_CSUM =E1 =E1 =E1 1
>     > =A0 =A0 > +#define VIRTIO_NET_OFFLOAD_GUEST_TSO4 =E1 =E1 =E1 2
>     > =A0 =A0 > +#define VIRTIO_NET_OFFLOAD_GUEST_TSO6 =E1 =E1 =E1 4
>     > =A0 =A0 > +#define VIRTIO_NET_OFFLOAD_GUEST_ECN =E1 =E1 =E1 =E18
>     > =A0 =A0 > +#define VIRTIO_NET_OFFLOAD_GUEST_UFO =E1 =E1 =E1 16
>     > =A0 =A0 > +
>     > =A0 =A0 > =E1#define DEFINE_VIRTIO_NET_FEATURES(_state, _field) \
>     > =A0 =A0 > =E1 =E1 =E1 =E1 =E1DEFINE_VIRTIO_COMMON_FEATURES(_state, =
_field), \
>     > =A0 =A0 > =E1 =E1 =E1 =E1 =E1DEFINE_PROP_BIT("csum", _state, _field=
, VIRTIO_NET_F_CSUM,
>     > =A0 =A0 true), \
>     > =A0 =A0 > @@ -241,6 +259,7 @@ struct virtio_net_ctrl_mq {
>     > =A0 =A0 > =E1 =E1 =E1 =E1 =E1DEFINE_PROP_BIT("ctrl_vlan", _state, _=
field,
>     > =A0 =A0 VIRTIO_NET_F_CTRL_VLAN, true), \
>     > =A0 =A0 > =E1 =E1 =E1 =E1 =E1DEFINE_PROP_BIT("ctrl_rx_extra", _stat=
e, _field,
>     > =A0 =A0 VIRTIO_NET_F_CTRL_RX_EXTRA, true), \
>     > =A0 =A0 > =E1 =E1 =E1 =E1 =E1DEFINE_PROP_BIT("ctrl_mac_addr", _stat=
e, _field,
>     > =A0 =A0 VIRTIO_NET_F_CTRL_MAC_ADDR, true), \
>     > =A0 =A0 > + =E1 =E1 =E1 =E1DEFINE_PROP_BIT("ctrl_gst_offld", _state=
, _field,
>     > =A0 =A0 VIRTIO_NET_F_CTRL_GUEST_OFFLD, true), \
>     > =A0 =A0 > =E1 =E1 =E1 =E1 =E1DEFINE_PROP_BIT("mq", _state, _field, =
VIRTIO_NET_F_MQ,
>     false)
>     > =A0 =A0 >
>     > =A0 =A0 > =E1#endif
>     >
>     >
>     > =A0 =A0 Looks good. Better to replace ctrl_gst_offld by ctrl_guest_=
offloads.
>     > =A0 =A0 Also need to patch hw/pc.h with compat macros so that
>     > =A0 =A0 the feature is disabled for old machine types.
>     >
>     >
>     > =A0 =A0 > --
>     > =A0 =A0 > 1.8.1.4
>     >
>     >
> =

> =
