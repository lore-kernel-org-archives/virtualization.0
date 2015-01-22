From: David Gibson <david@gibson.dropbear.id.au>
Subject: Re: [Qemu-devel] [PATCH RFC v6 07/20] virtio: allow virtio-1 queue
	layout
Date: Thu, 22 Jan 2015 13:06:09 +1100
Message-ID: <20150122020609.GI27371__36476.0090284564$1421893548$gmane$org@voom.fritz.box>
References: <1418304322-7546-1-git-send-email-cornelia.huck@de.ibm.com>
	<1418304322-7546-8-git-send-email-cornelia.huck@de.ibm.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============5354516412253109467=="
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1418304322-7546-8-git-send-email-cornelia.huck@de.ibm.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Cornelia Huck <cornelia.huck@de.ibm.com>
Cc: thuth@linux.vnet.ibm.com, mst@redhat.com, qemu-devel@nongnu.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org


--===============5354516412253109467==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="svExV93C05KqedWb"
Content-Disposition: inline


--svExV93C05KqedWb
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 11, 2014 at 02:25:09PM +0100, Cornelia Huck wrote:
> For virtio-1 devices, we allow a more complex queue layout that doesn't
> require descriptor table and rings on a physically-contigous memory area:
> add virtio_queue_set_rings() to allow transports to set this up.
>=20
> Signed-off-by: Cornelia Huck <cornelia.huck@de.ibm.com>
> ---
>  hw/virtio/virtio-mmio.c    |    3 +++
>  hw/virtio/virtio.c         |   53 ++++++++++++++++++++++++++++----------=
------
>  include/hw/virtio/virtio.h |    3 +++
>  3 files changed, 40 insertions(+), 19 deletions(-)
>=20
> diff --git a/hw/virtio/virtio-mmio.c b/hw/virtio/virtio-mmio.c
> index 43b7e02..0c9b63b 100644
> --- a/hw/virtio/virtio-mmio.c
> +++ b/hw/virtio/virtio-mmio.c
> @@ -244,8 +244,11 @@ static void virtio_mmio_write(void *opaque, hwaddr o=
ffset, uint64_t value,
>      case VIRTIO_MMIO_QUEUENUM:
>          DPRINTF("mmio_queue write %d max %d\n", (int)value, VIRTQUEUE_MA=
X_SIZE);
>          virtio_queue_set_num(vdev, vdev->queue_sel, value);
> +        /* Note: only call this function for legacy devices */

It's not clear to me if this is an assertion that this *does* only
call the function for legacy devices or a fixme, that it *should* only
call the function for legacy devices.

> +        virtio_queue_update_rings(vdev, vdev->queue_sel);
>          break;
>      case VIRTIO_MMIO_QUEUEALIGN:
> +        /* Note: this is only valid for legacy devices */
>          virtio_queue_set_align(vdev, vdev->queue_sel, value);
>          break;
>      case VIRTIO_MMIO_QUEUEPFN:
> diff --git a/hw/virtio/virtio.c b/hw/virtio/virtio.c
> index 8f69ffa..57190ba 100644
> --- a/hw/virtio/virtio.c
> +++ b/hw/virtio/virtio.c
> @@ -69,7 +69,6 @@ typedef struct VRing
>  struct VirtQueue
>  {
>      VRing vring;
> -    hwaddr pa;
>      uint16_t last_avail_idx;
>      /* Last used index value we have signalled on */
>      uint16_t signalled_used;
> @@ -92,15 +91,18 @@ struct VirtQueue
>  };
> =20
>  /* virt queue functions */
> -static void virtqueue_init(VirtQueue *vq)
> +void virtio_queue_update_rings(VirtIODevice *vdev, int n)

Perhaps something in the name to emphasise that this is only for <v1.0
devices?

>  {
> -    hwaddr pa =3D vq->pa;
> +    VRing *vring =3D &vdev->vq[n].vring;
> =20
> -    vq->vring.desc =3D pa;
> -    vq->vring.avail =3D pa + vq->vring.num * sizeof(VRingDesc);
> -    vq->vring.used =3D vring_align(vq->vring.avail +
> -                                 offsetof(VRingAvail, ring[vq->vring.num=
]),
> -                                 vq->vring.align);
> +    if (!vring->desc) {
> +        /* not yet setup -> nothing to do */
> +        return;
> +    }
> +    vring->avail =3D vring->desc + vring->num * sizeof(VRingDesc);
> +    vring->used =3D vring_align(vring->avail +
> +                              offsetof(VRingAvail, ring[vring->num]),
> +                              vring->align);

Would it make sense to implement this in terms of
virtio_queue_set_rings()?

>  }
> =20
>  static inline uint64_t vring_desc_addr(VirtIODevice *vdev, hwaddr desc_p=
a,
> @@ -605,7 +607,6 @@ void virtio_reset(void *opaque)
>          vdev->vq[i].vring.avail =3D 0;
>          vdev->vq[i].vring.used =3D 0;
>          vdev->vq[i].last_avail_idx =3D 0;
> -        vdev->vq[i].pa =3D 0;
>          vdev->vq[i].vector =3D VIRTIO_NO_VECTOR;
>          vdev->vq[i].signalled_used =3D 0;
>          vdev->vq[i].signalled_used_valid =3D false;
> @@ -708,13 +709,21 @@ void virtio_config_writel(VirtIODevice *vdev, uint3=
2_t addr, uint32_t data)
> =20
>  void virtio_queue_set_addr(VirtIODevice *vdev, int n, hwaddr addr)
>  {
> -    vdev->vq[n].pa =3D addr;
> -    virtqueue_init(&vdev->vq[n]);
> +    vdev->vq[n].vring.desc =3D addr;
> +    virtio_queue_update_rings(vdev, n);
>  }
> =20
>  hwaddr virtio_queue_get_addr(VirtIODevice *vdev, int n)
>  {
> -    return vdev->vq[n].pa;
> +    return vdev->vq[n].vring.desc;
> +}
> +
> +void virtio_queue_set_rings(VirtIODevice *vdev, int n, hwaddr desc,
> +                            hwaddr avail, hwaddr used)
> +{
> +    vdev->vq[n].vring.desc =3D desc;
> +    vdev->vq[n].vring.avail =3D avail;
> +    vdev->vq[n].vring.used =3D used;
>  }
> =20
>  void virtio_queue_set_num(VirtIODevice *vdev, int n, int num)
> @@ -728,7 +737,6 @@ void virtio_queue_set_num(VirtIODevice *vdev, int n, =
int num)
>          return;
>      }
>      vdev->vq[n].vring.num =3D num;
> -    virtqueue_init(&vdev->vq[n]);
>  }
> =20
>  int virtio_queue_get_num(VirtIODevice *vdev, int n)
> @@ -748,6 +756,11 @@ void virtio_queue_set_align(VirtIODevice *vdev, int =
n, int align)
>      BusState *qbus =3D qdev_get_parent_bus(DEVICE(vdev));
>      VirtioBusClass *k =3D VIRTIO_BUS_GET_CLASS(qbus);
> =20
> +    /* virtio-1 compliant devices cannot change the aligment */
> +    if (virtio_has_feature(vdev, VIRTIO_F_VERSION_1)) {
> +        error_report("tried to modify queue alignment for virtio-1 devic=
e");
> +        return;
> +    }
>      /* Check that the transport told us it was going to do this
>       * (so a buggy transport will immediately assert rather than
>       * silently failing to migrate this state)
> @@ -755,7 +768,7 @@ void virtio_queue_set_align(VirtIODevice *vdev, int n=
, int align)
>      assert(k->has_variable_vring_alignment);
> =20
>      vdev->vq[n].vring.align =3D align;
> -    virtqueue_init(&vdev->vq[n]);
> +    virtio_queue_update_rings(vdev, n);
>  }
> =20
>  void virtio_queue_notify_vq(VirtQueue *vq)
> @@ -949,7 +962,8 @@ void virtio_save(VirtIODevice *vdev, QEMUFile *f)
>          if (k->has_variable_vring_alignment) {
>              qemu_put_be32(f, vdev->vq[i].vring.align);
>          }
> -        qemu_put_be64(f, vdev->vq[i].pa);
> +        /* XXX virtio-1 devices */
> +        qemu_put_be64(f, vdev->vq[i].vring.desc);
>          qemu_put_be16s(f, &vdev->vq[i].last_avail_idx);
>          if (k->save_queue) {
>              k->save_queue(qbus->parent, i, f);
> @@ -1044,13 +1058,14 @@ int virtio_load(VirtIODevice *vdev, QEMUFile *f, =
int version_id)
>          if (k->has_variable_vring_alignment) {
>              vdev->vq[i].vring.align =3D qemu_get_be32(f);
>          }
> -        vdev->vq[i].pa =3D qemu_get_be64(f);
> +        vdev->vq[i].vring.desc =3D qemu_get_be64(f);
>          qemu_get_be16s(f, &vdev->vq[i].last_avail_idx);
>          vdev->vq[i].signalled_used_valid =3D false;
>          vdev->vq[i].notification =3D true;
> =20
> -        if (vdev->vq[i].pa) {
> -            virtqueue_init(&vdev->vq[i]);
> +        if (vdev->vq[i].vring.desc) {
> +            /* XXX virtio-1 devices */
> +            virtio_queue_update_rings(vdev, i);
>          } else if (vdev->vq[i].last_avail_idx) {
>              error_report("VQ %d address 0x0 "
>                           "inconsistent with Host index 0x%x",
> @@ -1084,7 +1099,7 @@ int virtio_load(VirtIODevice *vdev, QEMUFile *f, in=
t version_id)
>      }
> =20
>      for (i =3D 0; i < num; i++) {
> -        if (vdev->vq[i].pa) {
> +        if (vdev->vq[i].vring.desc) {
>              uint16_t nheads;
>              nheads =3D vring_avail_idx(&vdev->vq[i]) - vdev->vq[i].last_=
avail_idx;
>              /* Check it isn't doing strange things with descriptor numbe=
rs. */
> diff --git a/include/hw/virtio/virtio.h b/include/hw/virtio/virtio.h
> index 68c40db..b63ced3 100644
> --- a/include/hw/virtio/virtio.h
> +++ b/include/hw/virtio/virtio.h
> @@ -224,6 +224,9 @@ void virtio_queue_set_addr(VirtIODevice *vdev, int n,=
 hwaddr addr);
>  hwaddr virtio_queue_get_addr(VirtIODevice *vdev, int n);
>  void virtio_queue_set_num(VirtIODevice *vdev, int n, int num);
>  int virtio_queue_get_num(VirtIODevice *vdev, int n);
> +void virtio_queue_set_rings(VirtIODevice *vdev, int n, hwaddr desc,
> +                            hwaddr avail, hwaddr used);
> +void virtio_queue_update_rings(VirtIODevice *vdev, int n);
>  void virtio_queue_set_align(VirtIODevice *vdev, int n, int align);
>  void virtio_queue_notify(VirtIODevice *vdev, int n);
>  uint16_t virtio_queue_vector(VirtIODevice *vdev, int n);

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--svExV93C05KqedWb
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJUwFsRAAoJEGw4ysog2bOS47QQANWdt8BvEs8pXoVQqH64tLyn
cpbIaXntn8qW+RB1xuQjgC815PsycbQuSGFMLfGtb+4FlULVjRYN0gikPoneDyD4
bPIABwyFvPLGedKwIsbE9H8QlV0ZwRDegTuaqnBfbllCQBz0iOwzSnODur1fEMSQ
7P8Ij+AxfSa4Y7eHU1aMxnCYPu0gx4S2JaLok0TP36WYMesz9PEClR0LQZPt6f38
VUfzXEm5LLhUw4H8lxcNrsRvgPXW50v8+54pgfjeTl2wjWpQEo2KiPYGIEgFc/IT
ocZ+lhD+/NyHixA9vW7vgSaQIde/8gq+h6CayUESYZuQ4S955EgWtL2chaHFKuYd
vq4Ep8wp4jxvux/eC5kpjJ442VR49mu69ga6VNbb5nOSMDQ7k4jsEh0UA+jNZo2i
NRsOLRAT1s6xgBi2Nd7MNlDmJGcJkkHpKic+0w76EL57dkUNyWHoUcXdyjMfFkSj
McVjpt/0W3+gdaxCUzEwTgWI446eFkJ9FdKgIYavC0MadYIYxijgcbiTw0QzwC/m
fwIpeYcKKRnIY9wQG7YRSIXY1cweWBeELbPPdnssTVc/gaKMsJw/qcJsIRu1QKXs
l9YgJgTS+ZuRR8miVjoCKC1y5UGJPlDUK1UkrS9UItvzRvyG0PjCI9YkduzF06qv
qCGt9Pllu8y8nS8KYzwp
=iZ8V
-----END PGP SIGNATURE-----

--svExV93C05KqedWb--

--===============5354516412253109467==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
--===============5354516412253109467==--
