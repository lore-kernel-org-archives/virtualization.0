From: Stefan Hajnoczi <stefanha@gmail.com>
Subject: Re: [PATCH V2 RFC] fixup! virtio: convert to use DMA api
Date: Fri, 22 Apr 2016 10:33:02 +0100
Message-ID: <20160422093302.GC17359__34659.0160661892$1461317617$gmane$org@stefanha-x1.localdomain>
References: <1461245745-6710-1-git-send-email-mst@redhat.com>
	<20160421145653.GB11814@stefanha-x1.localdomain>
	<20160421181102-mutt-send-email-mst@redhat.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============3791582417279071990=="
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20160421181102-mutt-send-email-mst@redhat.com>
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
Cc: Wei Liu <wei.liu2@citrix.com>, kvm@vger.kernel.org, qemu-block@nongnu.org, David Woodhouse <dwmw2@infradead.org>, qemu-devel@nongnu.org, peterx@redhat.com, linux-kernel@vger.kernel.org, Christian Borntraeger <borntraeger@de.ibm.com>, Stefan Hajnoczi <stefanha@redhat.com>, Amit Shah <amit.shah@redhat.com>, pbonzini@redhat.com, virtualization@lists.linux-foundation.org, Andy Lutomirski <luto@kernel.org>
List-Id: virtualization@lists.linuxfoundation.org


--===============3791582417279071990==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="9Ek0hoCL9XbhcSqy"
Content-Disposition: inline


--9Ek0hoCL9XbhcSqy
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 21, 2016 at 06:11:40PM +0300, Michael S. Tsirkin wrote:
> On Thu, Apr 21, 2016 at 03:56:53PM +0100, Stefan Hajnoczi wrote:
> > On Thu, Apr 21, 2016 at 04:43:45PM +0300, Michael S. Tsirkin wrote:
> > > This adds a flag to enable/disable bypassing the IOMMU by
> > > virtio devices.
> > >=20
> > > This is on top of patch
> > > http://article.gmane.org/gmane.comp.emulators.qemu/403467
> > > virtio: convert to use DMA api
> > >=20
> > > Tested with patchset
> > > http://article.gmane.org/gmane.linux.kernel.virtualization/27545
> > > virtio-pci: iommu support (note: bit number has been kept at 34
> > > intentionally to match posted guest code. a non-RFC version will
> > > renumber bits to be contigious).
> > >=20
> > > changes from v1:
> > >     drop PASSTHROUGH flag
> > >=20
> > > The interaction between virtio and DMA API is messy.
> > >=20
> > > On most systems with virtio, physical addresses match bus addresses,
> > > and it doesn't particularly matter whether we use the DMA API.
> > >=20
> > > On some systems, including Xen and any system with a physical device
> > > that speaks virtio behind a physical IOMMU, we must use the DMA API
> > > for virtio DMA to work at all.
> > >=20
> > > Add a feature bit to detect that: VIRTIO_F_IOMMU_PLATFORM.
> > >=20
> > > If not there, we preserve historic behavior and bypass the DMA
> > > API unless within Xen guest. This is actually required for
> > > systems, including SPARC and PPC64, where virtio-pci devices are
> > > enumerated as though they are behind an IOMMU, but the virtio host
> > > ignores the IOMMU, so we must either pretend that the IOMMU isn't
> > > there or somehow map everything as the identity.
> > >=20
> > > Re: non-virtio devices.
> > >=20
> > > It turns out that on old QEMU hosts, only emulated devices which were
> > > part of QEMU use the IOMMU.  Should we want to bypass the IOMMU for s=
uch
> > > devices *only*, it would be rather easy to detect them by looking at
> > > subsystem vendor and device ID. Thus, no new interfaces are required
> > > except for virtio which always uses the same subsystem vendor and dev=
ice ID.
> > >=20
> > > Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> > > ---
> > >  include/hw/virtio/virtio-access.h              | 3 ++-
> > >  include/hw/virtio/virtio.h                     | 4 +++-
> > >  include/standard-headers/linux/virtio_config.h | 2 ++
> > >  3 files changed, 7 insertions(+), 2 deletions(-)
> > >=20
> > > diff --git a/include/hw/virtio/virtio-access.h b/include/hw/virtio/vi=
rtio-access.h
> > > index 967cc75..bb6f34e 100644
> > > --- a/include/hw/virtio/virtio-access.h
> > > +++ b/include/hw/virtio/virtio-access.h
> > > @@ -23,7 +23,8 @@ static inline AddressSpace *virtio_get_dma_as(VirtI=
ODevice *vdev)
> > >      BusState *qbus =3D qdev_get_parent_bus(DEVICE(vdev));
> > >      VirtioBusClass *k =3D VIRTIO_BUS_GET_CLASS(qbus);
> > > =20
> > > -    if (k->get_dma_as) {
> > > +    if (virtio_host_has_feature(vdev, VIRTIO_F_IOMMU_PLATFORM) &&
> > > +        k->get_dma_as) {
> > >          return k->get_dma_as(qbus->parent);
> > >      }
> > >      return &address_space_memory;
> > > diff --git a/include/hw/virtio/virtio.h b/include/hw/virtio/virtio.h
> > > index b12faa9..44f3788 100644
> > > --- a/include/hw/virtio/virtio.h
> > > +++ b/include/hw/virtio/virtio.h
> > > @@ -228,7 +228,9 @@ typedef struct VirtIORNGConf VirtIORNGConf;
> > >      DEFINE_PROP_BIT64("notify_on_empty", _state, _field,  \
> > >                        VIRTIO_F_NOTIFY_ON_EMPTY, true), \
> > >      DEFINE_PROP_BIT64("any_layout", _state, _field, \
> > > -                      VIRTIO_F_ANY_LAYOUT, true)
> > > +                      VIRTIO_F_ANY_LAYOUT, true), \
> > > +    DEFINE_PROP_BIT64("iommu_platform", _state, _field, \
> > > +                      VIRTIO_F_IOMMU_PLATFORM, false)
> >=20
> > Looks like the impact of this patch is that users who relied on
> > k->get_dma_as today may now have to explicitly add iommu_platform=3Don.
> > Are there any such users (e.g. Xen)?
>=20
> No because upstream this is ignored. This is an incremental patch
> on top of Jason's one.
>=20
> > Instead of breaking the command-line for these users you could invert
> > the flag's meaning ("iommu_bypass=3Don") and set it in the SPARC/PPC
> > machine types.
> >=20
> > Stefan
>=20
> I hope I made it clear that there are no such users.

Okay, thanks!

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--9Ek0hoCL9XbhcSqy
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQEcBAEBAgAGBQJXGe/OAAoJEJykq7OBq3PINBcH/00H3Ixr+1ELb0/AYbKmMttV
dqhSfPK4o+siFG0grmbXQ5EerrjAunXR2AJDAirK/bdt6DUDia8WiYoAOpphSb+j
5YZcfmUqeMsn63DPy67HSr6aDbaK31Bs/1PZh5Ap8gr3smguDLnbd1xJg62zUssG
xg4ZEzM2I8/ULsNyqw4evsQy5ugURKzF6DxwUElPgnPTLKsewjUeW3z4cnhJoVex
GF9sYNYh5NS9fYCr6Dr5pUPzTT+QPCvOfnHHxFE78Nj9IRWdWUk9woCZsS1Zsd6K
QjtxbvU9D02dXLuUcBPCl9ED+QIHV7ehGhNa0IAwIBtfeBMBUfJbORE0KTICc0w=
=yPLq
-----END PGP SIGNATURE-----

--9Ek0hoCL9XbhcSqy--

--===============3791582417279071990==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
--===============3791582417279071990==--
