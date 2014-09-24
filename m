From: Ben Hutchings <ben@decadent.org.uk>
Subject: Re: [PATCH RFC] virtio_pci: fix virtio spec compliance on restore
Date: Wed, 24 Sep 2014 02:27:27 +0100
Message-ID: <1411522047.3659.10.camel__36258.4635419354$1411522087$gmane$org@decadent.org.uk>
References: <1411468217-18130-1-git-send-email-mst@redhat.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============5447402397550615220=="
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1411468217-18130-1-git-send-email-mst@redhat.com>
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
Cc: Amit Shah <amit.shah@redhat.com>, linux-kernel@vger.kernel.org, stable@vger.kernel.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org


--===============5447402397550615220==
Content-Type: multipart/signed; micalg="pgp-sha512";
	protocol="application/pgp-signature"; boundary="=-mq3v38JDLSng1LxLnV2N"


--=-mq3v38JDLSng1LxLnV2N
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, 2014-09-23 at 13:32 +0300, Michael S. Tsirkin wrote:
> On restore, virtio pci does the following:
> + set features
> + init vqs etc - device can be used at this point!
> + set ACKNOWLEDGE,DRIVER and DRIVER_OK status bits
>=20
> This is in violation of the virtio spec, which
> requires the following order:
> - ACKNOWLEDGE
> - DRIVER
> - init vqs
> - DRIVER_OK
>
> Cc: stable@vger.kernel.org
> Cc: Amit Shah <amit.shah@redhat.com>
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
[...]

What concrete problem does this fix, such that it should be applied to
stable branches?

Ben.

--=20
Ben Hutchings
Everything should be made as simple as possible, but not simpler.
                                                           - Albert Einstei=
n

--=-mq3v38JDLSng1LxLnV2N
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIVAwUAVCIeD+e/yOyVhhEJAQrGfg/9G+X39+ucRMByTRkTaDvgAVIVGbBn2dOt
qPHPZBSlEKC3syUF9i9CiYoeKAprCjeIeAXebSArUa/xzk9PRDOPucuBrod4Fqa7
cIzfu9Z8DBs2ArqNjmb4H/8E8v4a0zFhf4oHswT39IhrjJyJBMjr10FfYfikQLWU
8EE/epJGqmFwNgG56DwlSoqD80sGoLO18Z/YzSUQNeLnpH6w5jgdRim39AMejG5s
eRgSmFZLWhI/kobrr1u/9kx+FoAg5KY98OfNOPz4tRevttB2wPRtuO6KAkjd4ViE
ZABAWckDJ3H0IADAquchMTwnbcss1enflJu9/sW9aJ5tq8ptU8rT4+GiPFuU+1na
peZMDmidhLH2HBhJg8c+osHGpsGPSdZ1c/Hv7M/6/3hS/J0HoDQsBItiv2DElaUX
AWYfp7ipTtl9mqU3EqHFOVx3femG81Nya55irwkcIZGyBq4Iei0GxQc7n1TNvFc9
2POqqhfVeHBEAI+yoUisIlVXUtraKuSACjK6XyRo8kZEH2iQ2/NCUFOOfdABTHyZ
54cPxOuMHY9jvCoj1hOSXrX6AHNGUq0MePRyrNrd3MuLsve8fdG0mU3IAUjRRmAJ
eWUp9Z9dz0kA9kwwTg3pvL300BZ0h8eMC8b5SkbgEj418qmsZrwXFfPGuXO1pATx
wegeHNn+jF4=
=id0T
-----END PGP SIGNATURE-----

--=-mq3v38JDLSng1LxLnV2N--

--===============5447402397550615220==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
--===============5447402397550615220==--
