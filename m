From: Michael Ellerman <michael@ellerman.id.au>
Subject: Re: Extending virtio_console to support multiple ports
Date: Thu, 27 Aug 2009 15:04:45 +1000
Message-ID: <1251349485.6267.6.camel__41965.8881765374$1251349540$gmane$org@concordia>
References: <1251181044-3696-1-git-send-email-amit.shah@redhat.com>
	<20090826112718.GA11117@amit-x200.redhat.com>
	<20090826154552.GA31910@amit-x200.redhat.com>
Reply-To: michael@ellerman.id.au
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============5207284759936701909=="
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20090826154552.GA31910@amit-x200.redhat.com>
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
To: Amit Shah <amit.shah@redhat.com>
Cc: Ryan Arnold <rsa@us.ibm.com>, kvm@vger.kernel.org, linuxppc-dev@ozlabs.org, linux-kernel@vger.kernel.org, miltonm@bga.com, qemu-devel@nongnu.org, borntraeger@de.ibm.com, brueckner@linux.vnet.ibm.com, virtualization@lists.linux-foundation.org, alan@linux.intel.com
List-Id: virtualization@lists.linuxfoundation.org


--===============5207284759936701909==
Content-Type: multipart/signed; micalg="pgp-sha1"; protocol="application/pgp-signature"; boundary="=-zDgknRdlrvhso4zVsYgt"


--=-zDgknRdlrvhso4zVsYgt
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Wed, 2009-08-26 at 21:15 +0530, Amit Shah wrote:
> [cc'ing some people who have made some commits in hvc_console.c]
>=20
> On (Wed) Aug 26 2009 [16:57:18], Amit Shah wrote:
> > On (Tue) Aug 25 2009 [11:47:20], Amit Shah wrote:
> > >=20
> > > Hello all,
> > >=20
> > > Here is a new iteration of the patch series that implements a
> > > transport for guest and host communications.
> > >=20
> > > The code has been updated to reuse the virtio-console device instead
> > > of creating a new virtio-serial device.
> >=20
> > And the problem now is that hvc calls the put_chars function with
> > spinlocks held and we now allocate pages in send_buf(), called from
> > put_chars.
> >=20
> > A few solutions:
>=20
> [snip]
>=20
> > - Convert hvc's usage of spinlocks to mutexes. I've no idea how this
> >   will play out; I'm no expert here. But I did try doing this and so fa=
r
> >   it all looks OK. No lockups, lockdep warnings, nothing. I have full
> >   debugging enabled. But this doesn't mean it's right.
>=20
> So just to test this further I added the capability to have more than
> one hvc console spawn from virtio_console, created two consoles and did
> a 'cat' of a file in each of the virtio-consoles. It's been running for
> half an hour now without any badness. No spew in debug logs too.
>=20
> I also checked the code in hvc_console.c that takes the spin_locks.
> Nothing there that runs from (or needs to run from) interrupt context.
> So the change to mutexes does seem reasonable. Also, the spinlock code
> was added really long back -- git blame shows Linus' first git commit
> introduced them in the git history, so it's pure legacy baggage.

I won't tell Ryan you called his code "pure legacy baggage" if you
don't ;)

http://git.kernel.org/?p=3Dlinux/kernel/git/torvalds/old-2.6-bkcvs.git;a=3D=
commitdiff;h=3Dd450b4ae023fb4be175389c18f4f87677da03020


cheers

--=-zDgknRdlrvhso4zVsYgt
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEABECAAYFAkqWE+oACgkQdSjSd0sB4dJ77QCglGJ1hqEa1QKiDnJYj5Wd7qZ3
BZgAoIKPSyPRRk69t+vlctG7SDLv/SSX
=lH9C
-----END PGP SIGNATURE-----

--=-zDgknRdlrvhso4zVsYgt--


--===============5207284759936701909==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linux-foundation.org/mailman/listinfo/virtualization
--===============5207284759936701909==--
