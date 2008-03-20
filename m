From: Paul TBBle Hampson <Paul.Hampson@Pobox.com>
Subject: Re: [Lguest] [RFC PATCH 1/5] lguest: mmap backing file
Date: Fri, 21 Mar 2008 01:07:13 +1100
Message-ID: <20080320140713.GA29956__38644.3611736924$1206024783$gmane$org@keitarou>
References: <200803201659.14344.rusty@rustcorp.com.au>
	<200803201705.44422.rusty@rustcorp.com.au>
	<1206000960.6873.124.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============7480462389846130678=="
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1206000960.6873.124.camel@localhost.localdomain>
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
To: Tim Post <echo@echoreply.us>
Cc: kvm-devel <kvm-devel@lists.sourceforge.net>, lguest <lguest@ozlabs.org>, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org


--===============7480462389846130678==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="gBBFr7Ir9EOA20Yy"
Content-Disposition: inline


--gBBFr7Ir9EOA20Yy
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 20, 2008 at 04:16:00PM +0800, Tim Post wrote:
> On Thu, 2008-03-20 at 17:05 +1100, Rusty Russell wrote:
>> +       snprintf(memfile_path, PATH_MAX, "%s/.lguest",
>> getenv("HOME") ?: "");

> Hi Rusty,

> Is that safe if being run via setuid/gid or shared root? It might be
> better to just look it up in /etc/passwd against the real UID,
> considering that anyone can change (or null) that env string.

> Of course its also practical to just say "DON'T RUN LGUEST AS
> SETUID/GID". Even if you say that, someone will do it. You might also
> add beware of sudoers.

> For people (like myself and lab mates) who are forced to share machines,
> it could breed a whole new strain of practical jokes :)

I'm not sure I see the risk here. Surely not "anyone" can modify your      =
                                                                           =
                                                                           =
             =20
environment variables out from under you?                                  =
                                                                           =
                                                                           =
             =20
                                                                           =
                                                                           =
                                                                           =
             =20
Are you worried that other root users are going to point root's .lguest    =
                                                                           =
                                                                           =
             =20
directory somewhere else, but not the non-root user's directory?           =
                                                                           =
                                                                           =
             =20
                                                                           =
                                                                           =
                                                                           =
             =20
I fear I'm missing something here...                                       =
                                                                           =
                                                                           =
             =20
                                                                           =
                                                                           =
                                                                           =
             =20
There _is_ an issue I hadn't thought of at the time, which is if your      =
                                                                           =
                                                                           =
             =20
$HOME is on shared media, and you clash PIDs between lguest launchers on   =
                                                                           =
                                                                           =
             =20
two machines sharing that media as $HOME, you're going to clash            =
                                                                           =
                                                                           =
             =20
memfiles, specifically truncating the earlier memfile.                     =
                                                                           =
                                                                           =
             =20

(Sorry for the double-up, lguest list. I hit send too quickly)

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

--gBBFr7Ir9EOA20Yy
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD4DBQFH4m+RexDuohKLFuARAlzhAJUc5jeCyCpUdzjYxaAQwBnw/locAKCZQfQp
mbMjP2rNLBDGDDI4KaDY5A==
=6A3A
-----END PGP SIGNATURE-----

--gBBFr7Ir9EOA20Yy--

--===============7480462389846130678==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linux-foundation.org/mailman/listinfo/virtualization
--===============7480462389846130678==--
