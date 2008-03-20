From: Paul TBBle Hampson <Paul.Hampson@Pobox.com>
Subject: Re: [Lguest] [kvm-devel] [RFC PATCH 1/5] lguest: mmap backing file
Date: Fri, 21 Mar 2008 01:32:21 +1100
Message-ID: <20080320143221.GA30431__14806.1167252765$1206024850$gmane$org@keitarou>
References: <200803201659.14344.rusty@rustcorp.com.au>
	<200803201705.44422.rusty@rustcorp.com.au>
	<47E26EE1.5030706@codemonkey.ws>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============5281784691580202257=="
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <47E26EE1.5030706@codemonkey.ws>
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
To: Anthony Liguori <anthony@codemonkey.ws>
Cc: kvm-devel <kvm-devel@lists.sourceforge.net>, lguest <lguest@ozlabs.org>, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org


--===============5281784691580202257==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="PNTmBPCT7hxwcZjr"
Content-Disposition: inline


--PNTmBPCT7hxwcZjr
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 20, 2008 at 09:04:17AM -0500, Anthony Liguori wrote:
> Rusty Russell wrote:
> >From: Paul TBBle Hampson <Paul.Hampson@Pobox.com>

> >This creates a file in $HOME/.lguest/ to directly back the RAM and DMA m=
emory
> >mappings created by map_zeroed_pages.

> I created a test program recently that measured the latency of a reads/wr=
ites to an mmap() file in /dev/shm and in a normal filesystem.  Even after =
unlinking the underlying file, the write latency was much better with a mma=
p()'d file in=20
> /dev/shm.

> /dev/shm is not really for general use.  I think we'll want to have our o=
wn tmpfs mount that we use to create VM images.  I also prefer to use a uni=
x socket for communication, unlink the file immediately after open, and the=
n pass the fd=20
> via SCM_RIGHTS to the other process.

The original motivations for the file-backed mmap (rather than the
/dev/zero mmap) were two-fold.

Firstly, to allow suspend and resume to be done to a guest, it would
need somewhere for its memory to survive. (ie. a guest could be
suspended externally immediately, and its state would be resumable from
that mmap file)

Secondly, heading towards some kind of common-page-sharing trick, where
each lguest could spot and share pages in common with other lguests.

Both of these assume the file is going to be visible in the filesystem
until the guest is shut down.

As to whether these are still interesting motivations, I withhold any
opinion in favour of those who know better. ^_^

--=20
-----------------------------------------------------------
Paul "TBBle" Hampson, B.Sc, LPI, MCSE
Very-later-year Asian Studies student, ANU
The Boss, Bubblesworth Pty Ltd (ABN: 51 095 284 361)
Paul.Hampson@Pobox.com

Of course Pacman didn't influence us as kids. If it did,
we'd be running around in darkened rooms, popping pills and
listening to repetitive music.
 -- Kristian Wilson, Nintendo, Inc, 1989

License: http://creativecommons.org/licenses/by/2.1/au/
-----------------------------------------------------------

--PNTmBPCT7hxwcZjr
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQFH4nV1exDuohKLFuARAjGJAJ991kl8R1HsWTN8yIWZPepJTPzl/QCgnfHx
j5N7N2YnL6a0eAqnBdEnpjA=
=xgaD
-----END PGP SIGNATURE-----

--PNTmBPCT7hxwcZjr--

--===============5281784691580202257==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linux-foundation.org/mailman/listinfo/virtualization
--===============5281784691580202257==--
