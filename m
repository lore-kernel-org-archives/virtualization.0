From: Stefan Hajnoczi <stefanha@redhat.com>
Subject: Re: [PATCH V2 RFC] fixup! virtio: convert to use DMA api
Date: Thu, 21 Apr 2016 15:56:53 +0100
Message-ID: <20160421145653.GB11814__43516.5398791016$1461250633$gmane$org@stefanha-x1.localdomain>
References: <1461245745-6710-1-git-send-email-mst@redhat.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============3621000497571588317=="
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1461245745-6710-1-git-send-email-mst@redhat.com>
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
Cc: Wei Liu <wei.liu2@citrix.com>, kvm@vger.kernel.org, qemu-block@nongnu.org, Christian Borntraeger <borntraeger@de.ibm.com>, qemu-devel@nongnu.org, peterx@redhat.com, linux-kernel@vger.kernel.org, Amit Shah <amit.shah@redhat.com>, Andy Lutomirski <luto@kernel.org>, pbonzini@redhat.com, virtualization@lists.linux-foundation.org, David Woodhouse <dwmw2@infradead.org>
List-Id: virtualization@lists.linuxfoundation.org


--===============3621000497571588317==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="eAbsdosE1cNLO4uF"
Content-Disposition: inline


--eAbsdosE1cNLO4uF
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 21, 2016 at 04:43:45PM +0300, Michael S. Tsirkin wrote:
> This adds a flag to enable/disable bypassing the IOMMU by
> virtio devices.
>=20
> This is on top of patch
> http://article.gmane.org/gmane.comp.emulators.qemu/403467
> virtio: convert to use DMA api
>=20
> Tested with patchset
> http://article.gmane.org/gmane.linux.kernel.virtualization/27545
> virtio-pci: iommu support (note: bit number has been kept at 34
> intentionally to match posted guest code. a non-RFC version will
> renumber bits to be contigious).
>=20
> changes from v1:
>     drop PASSTHROUGH flag
>=20
> The interaction between virtio and DMA API is messy.
>=20
> On most systems with virtio, physical addresses match bus addresses,
> and it doesn't particularly matter whether we use the DMA API.
>=20
> On some systems, including Xen and any system with a physical device
> that speaks virtio behind a physical IOMMU, we must use the DMA API
> for virtio DMA to work at all.
>=20
> Add a feature bit to detect that: VIRTIO_F_IOMMU_PLATFORM.
>=20
> If not there, we preserve historic behavior and bypass the DMA
> API unless within Xen guest. This is actually required for
> systems, including SPARC and PPC64, where virtio-pci devices are
> enumerated as though they are behind an IOMMU, but the virtio host
> ignores the IOMMU, so we must either pretend that the IOMMU isn't
> there or somehow map everything as the identity.
>=20
> Re: non-virtio devices.
>=20
> It turns out that on old QEMU hosts, only emulated devices which were
> part of QEMU use the IOMMU.  Should we want to bypass the IOMMU for such
> devices *only*, it would be rather easy to detect them by looking at
> subsystem vendor and device ID. Thus, no new interfaces are required
> except for virtio which always uses the same subsystem vendor and device =
ID.
>=20
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> ---
>  include/hw/virtio/virtio-access.h              | 3 ++-
>  include/hw/virtio/virtio.h                     | 4 +++-
>  include/standard-headers/linux/virtio_config.h | 2 ++
>  3 files changed, 7 insertions(+), 2 deletions(-)
>=20
> diff --git a/include/hw/virtio/virtio-access.h b/include/hw/virtio/virtio=
-access.h
> index 967cc75..bb6f34e 100644
> --- a/include/hw/virtio/virtio-access.h
> +++ b/include/hw/virtio/virtio-access.h
> @@ -23,7 +23,8 @@ static inline AddressSpace *virtio_get_dma_as(VirtIODev=
ice *vdev)
>      BusState *qbus =3D qdev_get_parent_bus(DEVICE(vdev));
>      VirtioBusClass *k =3D VIRTIO_BUS_GET_CLASS(qbus);
> =20
> -    if (k->get_dma_as) {
> +    if (virtio_host_has_feature(vdev, VIRTIO_F_IOMMU_PLATFORM) &&
> +        k->get_dma_as) {
>          return k->get_dma_as(qbus->parent);
>      }
>      return &address_space_memory;
> diff --git a/include/hw/virtio/virtio.h b/include/hw/virtio/virtio.h
> index b12faa9..44f3788 100644
> --- a/include/hw/virtio/virtio.h
> +++ b/include/hw/virtio/virtio.h
> @@ -228,7 +228,9 @@ typedef struct VirtIORNGConf VirtIORNGConf;
>      DEFINE_PROP_BIT64("notify_on_empty", _state, _field,  \
>                        VIRTIO_F_NOTIFY_ON_EMPTY, true), \
>      DEFINE_PROP_BIT64("any_layout", _state, _field, \
> -                      VIRTIO_F_ANY_LAYOUT, true)
> +                      VIRTIO_F_ANY_LAYOUT, true), \
> +    DEFINE_PROP_BIT64("iommu_platform", _state, _field, \
> +                      VIRTIO_F_IOMMU_PLATFORM, false)

Looks like the impact of this patch is that users who relied on
k->get_dma_as today may now have to explicitly add iommu_platform=3Don.
Are there any such users (e.g. Xen)?

Instead of breaking the command-line for these users you could invert
the flag's meaning ("iommu_bypass=3Don") and set it in the SPARC/PPC
machine types.

Stefan

--eAbsdosE1cNLO4uF
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQEcBAEBAgAGBQJXGOo1AAoJEJykq7OBq3PI7lwH/2t5PRCwZwvZeBX4nAsVWabI
bYmZTMkQ8hIUXkhdc0GF+bq7+ToxRHLcpI+jxkO6czY69ws/ynVozNireneLk0Hy
mOPQcTz/vvTLLGCAMS/gilEwDIjyaC+5/F2uwwVoEIj6Ug99WqXMrk3fpl27WGdc
W8MotOICwLU+/1zRm4CZ8a09d+LZXNQ3L3J8Lb3nvRkiTtPszsTrmEfe8TNxhuf2
eWR20e4l8E27di+vja0lRlF080HbWTfwGbf1I6WMZmFMkF1Mdoa00pD23JD/AVqE
kWcSMHMHR/3gwBW6oLJzuvrzizcF7frx0VxI6dCFJvzHAR/tczB/jpnMq6BEnSo=
=+QU1
-----END PGP SIGNATURE-----

--eAbsdosE1cNLO4uF--

--===============3621000497571588317==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
--===============3621000497571588317==--
