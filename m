From: David Gibson <david@gibson.dropbear.id.au>
Subject: Re: [RFC PATCH] virtio_ring: Use DMA API if guest memory is encrypted
Date: Mon, 25 Mar 2019 11:57:10 +1100
Message-ID: <20190325005710.GC29295@umbus>
References: <87zhrj8kcp.fsf@morokweng.localdomain>
	<87womn8inf.fsf@morokweng.localdomain>
	<20190129134750-mutt-send-email-mst@kernel.org>
	<877eefxvyb.fsf@morokweng.localdomain>
	<20190204144048-mutt-send-email-mst@kernel.org>
	<87ef71seve.fsf@morokweng.localdomain>
	<20190320171027-mutt-send-email-mst@kernel.org>
	<87tvfvbwpb.fsf@morokweng.localdomain>
	<20190323165456-mutt-send-email-mst@kernel.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============6805751237993055165=="
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20190323165456-mutt-send-email-mst@kernel.org>
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
Cc: Mike Anderson <andmike@linux.ibm.com>, Jean-Philippe Brucker <jean-philippe.brucker@arm.com>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Alexey Kardashevskiy <aik@linux.ibm.com>, Ram Pai <linuxram@us.ibm.com>, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, Paul Mackerras <paulus@ozlabs.org>, iommu@lists.linux-foundation.org, linuxppc-dev@lists.ozlabs.org, Christoph Hellwig <hch@lst.de>
List-Id: virtualization@lists.linuxfoundation.org


--===============6805751237993055165==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="Fig2xvG2VGoz8o/s"
Content-Disposition: inline


--Fig2xvG2VGoz8o/s
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Mar 23, 2019 at 05:01:35PM -0400, Michael S. Tsirkin wrote:
> On Thu, Mar 21, 2019 at 09:05:04PM -0300, Thiago Jung Bauermann wrote:
> > Michael S. Tsirkin <mst@redhat.com> writes:
[snip]
> > >> > Is there any justification to doing that beyond someone putting
> > >> > out slow code in the past?
> > >>
> > >> The definition of the ACCESS_PLATFORM flag is generic and captures t=
he
> > >> notion of memory access restrictions for the device. Unfortunately, =
on
> > >> powerpc pSeries guests it also implies that the IOMMU is turned on
> > >
> > > IIUC that's really because on pSeries IOMMU is *always* turned on.
> > > Platform has no way to say what you want it to say
> > > which is bypass the iommu for the specific device.
> >=20
> > Yes, that's correct. pSeries guests running on KVM are in a gray area
> > where theoretically they use an IOMMU but in practice KVM ignores it.
> > It's unfortunate but it's the reality on the ground today. :-/

Um.. I'm not sure what you mean by this.  As far as I'm concerned
there is always a guest-visible (paravirtualized) IOMMU, and that will
be backed onto the host IOMMU when necessary.

[Actually there is an IOMMU bypass hack that's used by the guest
 firmware, but I don't think we want to expose that]

> Well it's not just the reality, virt setups need something that
> emulated IOMMUs don't provide. That is not uncommon, e.g.
> intel's VTD has a "cache mode" field which AFAIK is only used for virt.

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--Fig2xvG2VGoz8o/s
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlyYJ2YACgkQbDjKyiDZ
s5JZyQ//SS59QY9yMVjm5dIHKUEs9Bci33j39MzpLz+QZ/rSLpgkKSlPhWZLhu70
Sk2aNBu5ILbZaomcSttinaObyDh3IuicBnwqBFvAVWoSdKrrzSPFwHOTC3w5Ncdw
pkFfxcvfr5jUzh/p3RQuBATbMJfP+/mZC+KaKseXGX2vDte2T4IqZa6SXyEdjLTO
n9I7zE4D51jmPoCbOen1E65FMRQ7MkLOXsm2GCYYL9HfgdtzDzvQ8GsG4BABUGZg
BREjDrJ5abIgeaygU69uSGbtJSOIeW1xN9SE1S6DhYj323A0VA2W9HsQCZEvjkrz
4Ix5hSqOhwLhkhstH4oJAwTsXO+mDb0UIrgt8BnqnUw4OLyDDf1ukf/qf0lQgTSW
k9c15llwqGFj9uUttu5ZcsCswYbgpug0JjNQn9ebBP9yoQIEZEerX3FBnmF8vwp2
FgGP6eFM9XnnZPNiuO1AsYSL41G8Tvhjh+cGO6MWyYm4qczY1MoPLwYoihAc+ocr
SJLZG99l77d344c1eTZeIWFZoYcq/1ZYbcfVVsFRGt8WJ+kM2YrN6zTD4+tS9zwA
gq0AHzBZUZjln8CDA2HETxgvnXSI6ieyoO3zWu1EF5y/zL3wolKVvREKCeNbcvfI
bT/RnjLgXMRSvCCxUbWPADa6lDGNtZ4STlnUf10vq7jAFlHgT+4=
=YCYB
-----END PGP SIGNATURE-----

--Fig2xvG2VGoz8o/s--

--===============6805751237993055165==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
--===============6805751237993055165==--
