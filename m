From: Jesse Barnes <jbarnes@virtuousgeek.org>
Subject: Re: [PATCH RFC] virtio-pci: flexible configuration layout
Date: Thu, 3 Nov 2011 07:59:29 -0700
Message-ID: <20111103075929.7084a9b8@jbarnes-desktop>
References: <87wrbkvh3v.fsf@rustcorp.com.au>
	<20111101114542.GA13434@redhat.com>
	<1320150813.3847.24.camel@lappy>
	<20111101124223.GA14060@redhat.com>
	<8739e7uy87.fsf@rustcorp.com.au>
	<20111102233110.GA20289@redhat.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============8937544216161764216=="
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20111102233110.GA20289@redhat.com>
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
Cc: Krishna Kumar <krkumar2@in.ibm.com>, kvm@vger.kernel.org, Pawel Moll <pawel.moll@arm.com>, Wang Sheng-Hui <shhuiw@gmail.com>, Alexey Kardashevskiy <aik@ozlabs.ru>, lkml - Kernel Mailing List <linux-kernel@vger.kernel.org>, virtualization@lists.linux-foundation.org, Christian Borntraeger <borntraeger@de.ibm.com>, Sasha Levin <levinsasha928@gmail.com>, Amit Shah <amit.shah@redhat.com>, Linus Torvalds <torvalds@linux-foundation.org>
List-Id: virtualization@lists.linuxfoundation.org

--===============8937544216161764216==
Content-Type: multipart/signed; micalg=PGP-SHA1;
 boundary="Sig_/cLAB+/J+csYW9IhYbynAGSD"; protocol="application/pgp-signature"

--Sig_/cLAB+/J+csYW9IhYbynAGSD
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Thu, 3 Nov 2011 01:31:11 +0200
"Michael S. Tsirkin" <mst@redhat.com> wrote:

> Add a flexible mechanism to specify virtio configuration layout, using
> pci vendor-specific capability.  A separate capability is used for each
> of common, device specific and data-path accesses.
>=20
> Warning: compiled only.
> This patch also needs to be split up, pci_iomap changes
> also need arch updates for non-x86.
>=20
> We also will need to update the spec.
>=20
> See the first chunk for layout documentation.
>=20
> Posting here for early feedback.
>=20
> In particular:
>=20
> Do we need to require offset to be aligned?
> Does iowrite16 work with unaligned accesses on all architectures?
> Does using ioread/write as we do add overhead as compared to
> plain PIO accesses?
>=20
> Jesse - are you OK with the pci_iomap_range API proposed here
> (see last chunks)?
> I noticed lots of architectures duplicate the implementation
> of pci_iomap - makes sense to clean that up?

Probably makes sense to have a weak version at least for arches that
just do the same thing.  But some arches really do need separate
versions because they wrap read/write as well...

Given the arch constraints, it's probably not possible to get rid of
the min/max args in favor of a simple offset/len pair like we have for
ioremap.  But if we could that would be even better.

--=20
Jesse Barnes, Intel Open Source Technology Center

--Sig_/cLAB+/J+csYW9IhYbynAGSD
Content-Type: application/pgp-signature; name=signature.asc
Content-Disposition: attachment; filename=signature.asc

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iQIcBAEBAgAGBQJOsqxRAAoJEIEoDkX4Qk9hydAQAL5DtOBhMdJnrk6Cc5Gy3AC1
x8IL2oQqYgnec3bqpmu1SZs3rEhk8ziaGNxktHfgWCn89+Bn/BkWZ+8X+yaYiJ8M
d1c28YKPWhk3Rg/qR1ovKsfdGpr7fO2SsqIXEQfUuDGeI5gUXCqmAPYzJ3CYPf5X
rKm7qaX8qIe1VvKYJdyFyykWwFatruVkgmjITPsoQDGcevNu/avQ5LgnfaTiHubn
ElqXw79t3rob98t+/cSdMqKjgSA8j8VRQKsNuSC6eVnXt8HFxK1tSb/ukOLGhL9E
6ksez87qITUbn9yosUMl9XCz/76Q+13PkHUzIejoWT6X/FSoff+8MBTEoRbdeS8l
XGVTSlpZAekDDjx9gIndQ2alnILekehAr23zNmI3kuUMjvNVAeaJwE2J7UcCrNNA
/6bC1UOJ6IebNWdYLHnVyUxKo3x/uFcDUg6ZnjD1H5dosB68Dp57z0CJpWAlgMJa
oiZSfttbTTQPLMySpkaa/M9kXaP6m5spyE1dCrs7jJi1Vc84FT5GS/W9STT0Rv8W
crWXyXxn7/F61denRZhsMa1dRLYHqM/ZSXLS8ejwYCGBhSh/ayg5VgA2PX9BDZjX
GkAdTu7uDNgyxU2oozN4fqcpmfTpLTeBAdRUVEmgTGsLSEpb20tUVcmGlGRovWy4
8seBBsW5K7jezz0HD9oy
=7URv
-----END PGP SIGNATURE-----

--Sig_/cLAB+/J+csYW9IhYbynAGSD--

--===============8937544216161764216==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
--===============8937544216161764216==--
