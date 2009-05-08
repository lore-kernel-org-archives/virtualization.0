From: Michael Ellerman <michael@ellerman.id.au>
Subject: Re: [PATCH] msi-x: let drivers retry when not enough vectors
Date: Fri, 08 May 2009 10:28:36 +1000
Message-ID: <1241742516.7109.16.camel@concordia>
References: <20090507082841.GA31751@redhat.com>
	<20090507095302.GI8112@parisc-linux.org>
	<200905071819.54426.sheng@linux.intel.com>
	<200905080925.01398.rusty@rustcorp.com.au>
Reply-To: michael@ellerman.id.au
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4591804011825951886=="
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <200905080925.01398.rusty@rustcorp.com.au>
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
To: Rusty Russell <rusty@rustcorp.com.au>
Cc: kvm@vger.kernel.org, Matthew Wilcox <matthew@wil.cx>, linux-pci@vger.kernel.org, "Michael S. Tsirkin" <mst@redhat.com>, linux-kernel@vger.kernel.org, jbarnes@virtuousgeek.org, virtualization@lists.linux-foundation.org, Matthew Wilcox <willy@linux.intel.com>
List-Id: virtualization@lists.linuxfoundation.org


--===============4591804011825951886==
Content-Type: multipart/signed; micalg="pgp-sha1"; protocol="application/pgp-signature"; boundary="=-/akGyiadmsixOdSIW8XY"


--=-/akGyiadmsixOdSIW8XY
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Fri, 2009-05-08 at 09:25 +0930, Rusty Russell wrote:
> On Thu, 7 May 2009 07:49:53 pm Sheng Yang wrote:
> > On Thursday 07 May 2009 17:53:02 Matthew Wilcox wrote:
> > > Here's a good example.  Let's suppose you have a driver which support=
s
> > > two different models of cards, one has 16 MSI-X interrupts, the other
> > > has 10.  You can call pci_enable_msix() asking for 16 vectors.  If yo=
ur
> > > card is model A, you get 16 interrupts.  If your card is model B, it =
says
> > > "you can have 10".
>=20
> Sheng is absolutely right, that's a horrid API.

It's not horrid, though it is tricky - but only for drivers that care,
you can still do:

if (pci_enable_msix(..))
	bail;

> If it actually enabled that number and returned it, it might make sense (=
cf.=20
> write() returning less bytes than you give it). =20

It could do that, but I think that would be worse. The driver, on
finding out it can only get a certain number of MSIs might need to make
a decision about how it allocates those - eg. in a network driver,
sharing them between TX/RX/management.

And in practice most of the drivers just bail if they can't get what
they asked for, so enabling less than they wanted would just mean they
have to go and disable them.

> But overloading the return=20
> value to save an explicit call is just ugly; it's not worth saving a few =
lines=20
> of code at cost of making all the drivers subtle and tricksy.

Looking at just this patch, I would agree, but unfortunately it's not
that simple. The first limitation on the number of MSIs the driver can
have is the number the device supports, that's what this patch does. But
there are others, and they come out of the arch code, or even the
firmware. So to implement pci_how_many_msis(), we'd need a parallel API
all the way down to the arch code, or a flag to all the existing
routines saying "don't really allocate, just find out". That would be
horrid IMHO.

cheers

--=-/akGyiadmsixOdSIW8XY
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEABECAAYFAkoDfLQACgkQdSjSd0sB4dKP6gCcD77E8GPOKSKErBgbfgInhswb
qfgAn3qcahKew9DjeMPe2YkLEp6TFW6+
=QBPB
-----END PGP SIGNATURE-----

--=-/akGyiadmsixOdSIW8XY--


--===============4591804011825951886==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linux-foundation.org/mailman/listinfo/virtualization
--===============4591804011825951886==--
