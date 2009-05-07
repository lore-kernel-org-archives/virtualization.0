From: Michael Ellerman <michael@ellerman.id.au>
Subject: Re: [PATCH] msi-x: let drivers retry when not enough vectors
Date: Thu, 07 May 2009 20:23:50 +1000
Message-ID: <1241691830.24385.6.camel__8268.22183230451$1241707757$gmane$org@concordia>
References: <20090507082841.GA31751@redhat.com>
	<200905071651.24970.sheng@linux.intel.com>
	<20090507092731.GH8112@parisc-linux.org>
	<200905071740.16190.sheng@linux.intel.com>
	<20090507095302.GI8112@parisc-linux.org>
Reply-To: michael@ellerman.id.au
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============7157387208510878120=="
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20090507095302.GI8112@parisc-linux.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Mime-version: 1.0
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Matthew Wilcox <matthew@wil.cx>
Cc: kvm@vger.kernel.org, "Michael S. Tsirkin" <mst@redhat.com>, linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, jbarnes@virtuousgeek.org, virtualization@lists.linux-foundation.org, Matthew Wilcox <willy@linux.intel.com>
List-Id: virtualization@lists.linuxfoundation.org


--===============7157387208510878120==
Content-Type: multipart/signed; micalg="pgp-sha1"; protocol="application/pgp-signature"; boundary="=-m2R9BftWir2uHsr+ok1d"


--=-m2R9BftWir2uHsr+ok1d
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Thu, 2009-05-07 at 03:53 -0600, Matthew Wilcox wrote:
> On Thu, May 07, 2009 at 05:40:15PM +0800, Sheng Yang wrote:
> > It's indeed weird. Why the semantic of pci_enable_msix can be changed t=
o=20
> > "enable msix, or tell me how many vector do you have"? You can simply c=
all=20
> > pci_msix_table_size() to get what you want, also without any more work,=
 no? I=20
> > can't understand...
>=20
> Here's a good example.  Let's suppose you have a driver which supports
> two different models of cards, one has 16 MSI-X interrupts, the other
> has 10.  You can call pci_enable_msix() asking for 16 vectors.  If your
> card is model A, you get 16 interrupts.  If your card is model B, it says
> "you can have 10".
>=20
> This is less work in the driver (since it must implement falling back to
> a smaller number of interrupts *anyway*) than interrogating the card to
> find out how many interrupts there are, then requesting the right number,
> and still having the fallback path which is going to be less tested.

Not to mention that there's no guarantee that you'll get as many
interrupts as the device supports, so you should really be coding to
cope with that anyway. Like the example in MSI-HOWTO.txt:

197 static int foo_driver_enable_msix(struct foo_adapter *adapter, int nvec=
)
198 {
199         while (nvec >=3D FOO_DRIVER_MINIMUM_NVEC) {
200                 rc =3D pci_enable_msix(adapter->pdev,
201                                      adapter->msix_entries, nvec);
202                 if (rc > 0)
203                         nvec =3D rc;
204                 else
205                         return rc;
206         }
207=20
208         return -ENOSPC;
209 }

So I agree, this patch is an improvement.

cheers

--=-m2R9BftWir2uHsr+ok1d
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEABECAAYFAkoCtrYACgkQdSjSd0sB4dL2gwCgrXfph8c4uRWAhCra5/I9baEu
gk4An1J3CXjRtaSME8/2wFqVcq3Tqq97
=jczb
-----END PGP SIGNATURE-----

--=-m2R9BftWir2uHsr+ok1d--


--===============7157387208510878120==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linux-foundation.org/mailman/listinfo/virtualization
--===============7157387208510878120==--
