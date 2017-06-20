From: Rik van Riel <riel@redhat.com>
Subject: Re: [PATCH v11 4/6] mm: function to offer a page block on the free
	list
Date: Tue, 20 Jun 2017 15:51:00 -0400
Message-ID: <1497988260.20270.109.camel__30606.2574185946$1497988278$gmane$org@redhat.com>
References: <1497004901-30593-1-git-send-email-wei.w.wang@intel.com>
	<1497004901-30593-5-git-send-email-wei.w.wang@intel.com>
	<b92af473-f00e-b956-ea97-eb4626601789@intel.com>
	<1497977049.20270.100.camel@redhat.com>
	<7b626551-6d1b-c8d5-4ef7-e357399e78dc@redhat.com>
	<1497979740.20270.102.camel@redhat.com>
	<20170620212107-mutt-send-email-mst@kernel.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0965947465023077605=="
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20170620212107-mutt-send-email-mst@kernel.org>
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
Cc: aarcange@redhat.com, amit.shah@redhat.com, kvm@vger.kernel.org, linux-kernel@vger.kernel.org, liliang.opensource@gmail.com, qemu-devel@nongnu.org, virtualization@lists.linux-foundation.org, linux-mm@kvack.org, Dave Hansen <dave.hansen@intel.com>, cornelia.huck@de.ibm.com, pbonzini@redhat.com, akpm@linux-foundation.org, Nitesh Narayan Lal <nilal@redhat.com>, mgorman@techsingularity.net
List-Id: virtualization@lists.linuxfoundation.org


--===============0965947465023077605==
Content-Type: multipart/signed; micalg="pgp-sha256";
	protocol="application/pgp-signature"; boundary="=-/CdBXLQWUXqNPsXR1B2X"


--=-/CdBXLQWUXqNPsXR1B2X
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, 2017-06-20 at 21:26 +0300, Michael S. Tsirkin wrote:
> On Tue, Jun 20, 2017 at 01:29:00PM -0400, Rik van Riel wrote:
> > I agree with that.=C2=A0=C2=A0Let me go into some more detail of
> > what Nitesh is implementing:
> >=20
> > 1) In arch_free_page, the being-freed page is added
> > =C2=A0=C2=A0=C2=A0to a per-cpu set of freed pages.
> > 2) Once that set is full, arch_free_pages goes into a
> > =C2=A0=C2=A0=C2=A0slow path, which:
> > =C2=A0=C2=A0=C2=A02a) Iterates over the set of freed pages, and
> > =C2=A0=C2=A0=C2=A02b) Checks whether they are still free, and
> > =C2=A0=C2=A0=C2=A02c) Adds the still free pages to a list that is
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0to be passed to the hyperviso=
r, to be MADV_FREEd.
> > =C2=A0=C2=A0=C2=A02d) Makes that hypercall.
> >=20
> > Meanwhile all arch_alloc_pages has to do is make sure it
> > does not allocate a page while it is currently being
> > MADV_FREEd on the hypervisor side.
> >=20
> > The code Wei is working on looks like it could be=C2=A0
> > suitable for steps (2c) and (2d) above. Nitesh already
> > has code for steps 1 through 2b.
>=20
> So my question is this: Wei posted these numbers for balloon
> inflation times:
> inflating 7GB of an 8GB idle guest:
>=20
> 	1) allocating pages (6.5%)
> 	2) sending PFNs to host (68.3%)
> 	3) address translation (6.1%)
> 	4) madvise (19%)
>=20
> 	It takes about 4126ms for the inflating process to complete.
>=20
> It seems that this is an excessive amount of time to stay
> under a lock. What are your estimates for Nitesh's work?

That depends on the batch size used for step
(2c), and is something that we should be able
to tune for decent performance.

What seems to matter is that things are batched.
There are many ways to achieve that.

--=20
All rights reversed
--=-/CdBXLQWUXqNPsXR1B2X
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAABCAAGBQJZSXykAAoJEM553pKExN6DC2QH/1E5nvrRR1z6XeXLr/emhHbH
E20L0/z3rCW/tIsMGlRNV3kkcsblKiS2KlWYNqNwQqSDnLvHLAC5e8fh/zme7k2m
hjvCl+Icj5aatmo+JdncpkygC89MnC6DETFrkrs2wobgoXigMUgwONH6PF0Yhx0a
EjDSYwPbyjZJAa1VSDT146xPLSrapQ3jrNUhWCVrxGzl4d6TiNinLhjG61fECxMR
sJ4qXDGrr1z/jWNrkJT2IZOZrD/V5t4O2a/16LeHzMai1xv3opRkbmffnz9YLiWJ
kLjjO64QlgrtL1oOcpFpyktTGbjLG3QPiq1lDJ6YEsvoLjkr1H0hcpaWLB3I2FI=
=6M0R
-----END PGP SIGNATURE-----

--=-/CdBXLQWUXqNPsXR1B2X--


--===============0965947465023077605==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
--===============0965947465023077605==--
