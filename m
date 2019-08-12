From: David Gibson <david@gibson.dropbear.id.au>
Subject: Re: [RFC PATCH] virtio_ring: Use DMA API if guest memory is encrypted
Date: Mon, 12 Aug 2019 19:51:56 +1000
Message-ID: <20190812095156.GD3947__30261.0183529154$1565618086$gmane$org@umbus.fritz.box>
References: <87zhrj8kcp.fsf@morokweng.localdomain>
	<20190810143038-mutt-send-email-mst@kernel.org>
	<20190810220702.GA5964@ram.ibm.com> <20190811055607.GA12488@lst.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4976469161546026162=="
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20190811055607.GA12488@lst.de>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Christoph Hellwig <hch@lst.de>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Alexey Kardashevskiy <aik@linux.ibm.com>, Ram Pai <linuxram@us.ibm.com>, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, Paul Mackerras <paulus@ozlabs.org>, iommu@lists.linux-foundation.org, linuxppc-devel@lists.ozlabs.org
List-Id: virtualization@lists.linuxfoundation.org


--===============4976469161546026162==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="NtwzykIc2mflq5ck"
Content-Disposition: inline


--NtwzykIc2mflq5ck
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Aug 11, 2019 at 07:56:07AM +0200, Christoph Hellwig wrote:
> sev_active() is gone now in linux-next, at least as a global API.
>=20
> And once again this is entirely going in the wrong direction.  The only
> way using the DMA API is going to work at all is if the device is ready
> for it.  So we need a flag on the virtio device, exposed by the
> hypervisor (or hardware for hw virtio devices) that says:  hey, I'm real,
> don't take a shortcut.

There still seems to be a failure to understand each other here.  The
limitation here simply *is not* a property of the device.  In fact,
it's effectively a property of the memory the virtio device would be
trying to access (because it's in secure mode it can't be directly
accessed via the hypervisor).  There absolutely are cases where this
is a device property (a physical virtio device being the obvious one),
but this isn't one of them.

Unfortunately, we're kind of stymied by the feature negotiation model
of virtio.  AIUI the hypervisor / device presents a bunch of feature
bits of which the guest / driver selects a subset.

AFAICT we already kind of abuse this for the VIRTIO_F_IOMMU_PLATFORM,
because to handle for cases where it *is* a device limitation, we
assume that if the hypervisor presents VIRTIO_F_IOMMU_PLATFORM then
the guest *must* select it.

What we actually need here is for the hypervisor to present
VIRTIO_F_IOMMU_PLATFORM as available, but not required.  Then we need
a way for the platform core code to communicate to the virtio driver
that *it* requires the IOMMU to be used, so that the driver can select
or not the feature bit on that basis.

> And that means on power and s390 qemu will always have to set thos if
> you want to be ready for the ultravisor and co games.  It's not like we
> haven't been through this a few times before, have we?

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--NtwzykIc2mflq5ck
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAl1RNrcACgkQbDjKyiDZ
s5IeEA//dnRJ6mVj+RhQveMWMmeAiLbWMfnm//uTigHRNS3wsKGZnHuzpbBnRoCc
lEX8grJ+aGO69ZFe4N41Fad605IFGUjnxTtQn6kMx85m7F6z1+Bdi0B4H/k9iZ77
jr/rVpXQ9lv93Sns8vg9rZloaLf3xt1ZBN7hjecvVNSN5esttOlczRXSCq8m3rGE
2wYsyLox6y/juyLl/f+MOADagIb5ca652DrmInAaER3HgNnMmZGjr+gAjgvzNWRC
iYF3i/T/+NQLSS2IgG3eo9kzz3TF9FxmbtpqCynyr/JOUOf+M6vN9IZnr6MDSspR
OnUgRJLIOVjAUcG5EDwfoZQIbuJ7rJZ68/q75aJpMWpfrAsEiKPVD42lhDRtPzuT
fyT2lVp0ZF+VfSL4lc7nFq/yEG8YCJO2ZtgulzCFo72mPieeMZj3UyBOn0eJZ6Ui
lAOZHKgkDuhvNYXigewhujz+kTJ2UlV0ioZ0fOs9ohqOMd3t9RcIn2HIhI1j+2hN
drDFJUL6roSn+3rMA8MxCqeumTjFXGEGa9K+MIrVHpCnfgLgxV3Z2Z/gy8TNdetk
qobrJcniwJGse95D0BXoU6FDLRTOBsyNXa1ruMT0srHClrFIVRkGGr8fveJvUo/z
9pxHx2HQa0ePV1VCTj0h9YficujWGsF+RwC57aQOeCUFqLYz+0c=
=pHtB
-----END PGP SIGNATURE-----

--NtwzykIc2mflq5ck--

--===============4976469161546026162==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
--===============4976469161546026162==--
