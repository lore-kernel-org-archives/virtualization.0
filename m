From: David Gibson <david@gibson.dropbear.id.au>
Subject: Re: [RFC V2] virtio: Add platform specific DMA API translation for
	virito devices
Date: Tue, 5 Jun 2018 11:52:36 +1000
Message-ID: <20180605015236.GJ5140__25062.3518987142$1528163468$gmane$org@umbus.fritz.box>
References: <20180522063317.20956-1-khandual@linux.vnet.ibm.com>
	<20180523213703-mutt-send-email-mst@kernel.org>
	<f77638ddef3af52dd71341083707c9e3745dd505.camel@kernel.crashing.org>
	<20180604085742.GQ4251@umbus>
	<d5df613d6347fe2f9bb6ea65bc6f6be05650ca6f.camel@kernel.crashing.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============6799053992896003359=="
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <d5df613d6347fe2f9bb6ea65bc6f6be05650ca6f.camel@kernel.crashing.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: robh@kernel.org, "Michael S. Tsirkin" <mst@redhat.com>, mpe@ellerman.id.au, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, hch@infradead.org, joe@perches.com, linuxppc-dev@lists.ozlabs.org, elfring@users.sourceforge.net, Anshuman Khandual <khandual@linux.vnet.ibm.com>
List-Id: virtualization@lists.linuxfoundation.org


--===============6799053992896003359==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="YZVh52eu0Ophig4D"
Content-Disposition: inline


--YZVh52eu0Ophig4D
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 04, 2018 at 07:48:54PM +1000, Benjamin Herrenschmidt wrote:
> On Mon, 2018-06-04 at 18:57 +1000, David Gibson wrote:
> >=20
> > > - First qemu doesn't know that the guest will switch to "secure mode"
> > > in advance. There is no difference between a normal and a secure
> > > partition until the partition does the magic UV call to "enter secure
> > > mode" and qemu doesn't see any of it. So who can set the flag here ?
> >=20
> > This seems weird to me.  As a rule HV calls should go through qemu -
> > or be allowed to go directly to KVM *by* qemu.
>=20
> It's not an HV call, it's a UV call, qemu won't see it, qemu isn't
> trusted. Now the UV *will* reflect that to the HV via some synthetized
> HV calls, and we *could* have those do a pass by qemu, however, so far,
> our entire design doesn't rely on *any* qemu knowledge whatsoever and
> it would be sad to add it just for that purpose.
>=20
> Additionally, this is rather orthogonal, see my other email, the
> problem we are trying to solve is *not* a qemu problem and it doesn't
> make sense to leak that into qemu.
>=20
> >   We generally reserve
> > the latter for hot path things.  Since this isn't a hot path, having
> > the call handled directly by the kernel seems wrong.
> >
> > Unless a "UV call" is something different I don't know about.
>=20
> Yes, a UV call goes to the Ultravisor, not the Hypervisor. The
> Hypervisor isn't trusted.

Ah, right.  Is that implemented in the host kernel, or in something
further above?

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--YZVh52eu0Ophig4D
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlsV7OIACgkQbDjKyiDZ
s5LDZw/+O2nYPWBGyN1jbpBcGO/3bosxPXKBX2ZQFxEyD9OqN+pUnaZf371hjSFR
d1XLmUvoZOSp4ErGc+UtEk+OsynoYq7OL2y8q9bAf7ZUiyE7s6Qcnt77F9BASHLV
HcYd55P9f9mJl5p8LTD3ZHOee+9aWfY0djF0FTtKgF2uSQsdRhMHF+9YVrh9hq0q
b6nsuYEJ97y0/jOdcxRI0n1SPZPzJZHH9zGogRU14iS/D8m8qKRXeJCzHTlGHIuL
KPlelYmqj7jc8O6xSkDLPv9p9HsKIxo8Ke2GwNNMuD+osBZb6lLO6fpi65PiL7k8
LcEqe3LfC4gQZtkmWyi/9hfFh68flJbP95+TPlqLLNoN6xog8h6qv+zUotIGPNss
5K9BHZiikGdnK7O5B2HB9aai0Tb6Zg3DkJyg81b8FKv5PmZvGRUyB3qRYEkZ4SxL
qAhebhropdXVmx6VYWodQsXumJNgnh6oTlncrZw4bHLXHWUzfDOgLjrVSZbfukUX
23Y+BDrkGFygDCeA+0PA/lYN4nm/LZtqWsqJvlVyiRMwCpmx+Hm/SqzNeXMjg1kB
vwwXndA/FfWFMzm0w1+l8JcravBxIcx1iLmanMnEs3d/++hUhKMvnGR0E+35cAw8
daSslcvU9Q45hN0M4tP3bZsYDHxo8bqMwouuFXO+jYrYsEhuF2o=
=JaZJ
-----END PGP SIGNATURE-----

--YZVh52eu0Ophig4D--

--===============6799053992896003359==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
--===============6799053992896003359==--
