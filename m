From: David Gibson <david@gibson.dropbear.id.au>
Subject: Re: [PATCH 2/2] virtio_ring: Use DMA API if memory is encrypted
Date: Mon, 14 Oct 2019 15:52:35 +1100
Message-ID: <20191014045235.GO4080__43573.0877494038$1571029709$gmane$org@umbus.fritz.box>
References: <1570843519-8696-1-git-send-email-linuxram@us.ibm.com>
	<1570843519-8696-2-git-send-email-linuxram@us.ibm.com>
	<1570843519-8696-3-git-send-email-linuxram@us.ibm.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4701519198395875555=="
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1570843519-8696-3-git-send-email-linuxram@us.ibm.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Ram Pai <linuxram@us.ibm.com>
Cc: andmike@us.ibm.com, sukadev@linux.vnet.ibm.com, b.zolnierkie@samsung.com, mpe@ellerman.id.au, aik@linux.ibm.com, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, paulus@ozlabs.org, iommu@lists.linux-foundation.org, paul.burton@mips.com, benh@kernel.crashing.org, m.szyprowski@samsung.com, linuxppc-dev@lists.ozlabs.org, hch@lst.de, robin.murphy@arm.com
List-Id: virtualization@lists.linuxfoundation.org


--===============4701519198395875555==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="8N0TQpGUCeEQshoq"
Content-Disposition: inline


--8N0TQpGUCeEQshoq
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 11, 2019 at 06:25:19PM -0700, Ram Pai wrote:
> From: Thiago Jung Bauermann <bauerman@linux.ibm.com>
>=20
> Normally, virtio enables DMA API with VIRTIO_F_IOMMU_PLATFORM, which must
> be set by both device and guest driver. However, as a hack, when DMA API
> returns physical addresses, guest driver can use the DMA API; even though
> device does not set VIRTIO_F_IOMMU_PLATFORM and just uses physical
> addresses.
>=20
> Doing this works-around POWER secure guests for which only the bounce
> buffer is accessible to the device, but which don't set
> VIRTIO_F_IOMMU_PLATFORM due to a set of hypervisor and architectural bugs.
> To guard against platform changes, breaking any of these assumptions down
> the road, we check at probe time and fail if that's not the case.
>=20
> cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> cc: David Gibson <david@gibson.dropbear.id.au>
> cc: Michael Ellerman <mpe@ellerman.id.au>
> cc: Paul Mackerras <paulus@ozlabs.org>
> cc: Michael Roth <mdroth@linux.vnet.ibm.com>
> cc: Alexey Kardashevskiy <aik@linux.ibm.com>
> cc: Jason Wang <jasowang@redhat.com>
> cc: Christoph Hellwig <hch@lst.de>
> Suggested-by: Michael S. Tsirkin <mst@redhat.com>
> Signed-off-by: Ram Pai <linuxram@us.ibm.com>
> Signed-off-by: Thiago Jung Bauermann <bauerman@linux.ibm.com>

Reviewed-by: David Gibson <david@gibson.dropbear.id.au>

I don't know that this is the most elegant solution possible.  But
it's simple, gets the job done and pretty unlikely to cause mysterious
breakage down the road.

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--8N0TQpGUCeEQshoq
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAl2j/xMACgkQbDjKyiDZ
s5KZJw/7BRxGaRXVs4GwonOJMnJpzq+0zo4Rex4IzZu98y/3bSw1XB+cNfhAwGdo
00Qpp0+AGxMNUmcXy+ilSprBokq1gDBh1hbq2ap/1yoK/fcW2L5ZuyoT5m9d1AMR
4sExuhtQpr7ZMAHHC5Q99jOi44i4BNixlNI62OwtYwOoSvGz1dar6PthN/D6zZ1N
k5ViBzqOY4CIoK/Onqlf47P0ZbgP2XP7rfri0m+PbY0ipOw7E+8zMl4NMIu+dGeU
RQm5e1v8wX/5MUS50gAL+lW/QUxsneaCs3WLCXvHqSJL+shLJnV8Bnomgw+zsBCb
lkLKb+MqdRLt+OMjmIzAtJ2Sza6CU5cpvOAWmIeTlxiwEdD5qrVzAryhFU204vwP
J4ovQSOyR4geqNF3uzTvvVhdme9dNLHkwp7h9PnFwVQEYK6/BlUXxi6WXQXbcthz
PDIj5YdYOwnHLsAv0uaEqRb8/n8ULgyLMfMI4EJOomafMlXF+VD0UPsOEC5glAJ4
TQ6Q0MMzMJ48BhOhwoAZDEYCJYPSXDaKKxEPgvr+uY+VeGTMuMUC8W8VyKFfEZr2
jKpt2P6u/9cPgZWI02Ve5xbRDHJ38cW74JxnTK21zEiF5m14JTYxU6lTTyPQZhFe
DWvkWwsvDz0JvMt8z5DU+FZZbYAnax5XWnEqIl2urw/ChF6DHOY=
=kf/I
-----END PGP SIGNATURE-----

--8N0TQpGUCeEQshoq--

--===============4701519198395875555==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
--===============4701519198395875555==--
