From: Stephen Rothwell <sfr@canb.auug.org.au>
Subject: Re: [PATCH 5/5 -v2] Move the lguest files that are i386 specific
Date: Thu, 9 Aug 2007 15:42:21 +1000
Message-ID: <20070809154221.2175efd4.sfr__33111.630814574$1186638258$gmane$org@canb.auug.org.au>
References: <20070809043626.830486783@goodmis.org>
	<20070809044125.610944971@goodmis.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============9113775612027911919=="
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20070809044125.610944971@goodmis.org>
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
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Carsten Otte <cotte@de.ibm.com>, lguest <lguest@ozlabs.org>, Jes Sorensen <jes@sgi.com>, lkml@smtp2.linux-foundation.org, - Kernel Mailing List <linux-kernel@vger.kernel.org>, virtualization <virtualization@lists.linux-foundation.org>, Andrew Morton <akpm@linux-foundation.org>
List-Id: virtualization@lists.linuxfoundation.org

--===============9113775612027911919==
Content-Type: multipart/signed; protocol="application/pgp-signature";
	micalg="PGP-SHA1";
	boundary="Signature=_Thu__9_Aug_2007_15_42_21_+1000_5Kh/rGPsytsw17Gk"

--Signature=_Thu__9_Aug_2007_15_42_21_+1000_5Kh/rGPsytsw17Gk
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Steven,

On Thu, 09 Aug 2007 00:36:31 -0400 Steven Rostedt <rostedt@goodmis.org>
wrote:
>
> Well, some may be merged with x86_64 later, but for now we move them
> out of the way.  Later on we can start seeing how we can combine
> some of these files to be arch generic.
>=20
> Signed-off-by: Steven Rostedt <rostedt@goodmis.org>
> ---
>  drivers/lguest/Makefile                    |    7 +-
>  drivers/lguest/core.c                      |  771 -------------------
>  drivers/lguest/hypercalls.c                |  300 --------
>  drivers/lguest/i386/Makefile               |    7 +
>  drivers/lguest/i386/core.c                 |  771 +++++++++++++++++++
>  drivers/lguest/i386/hypercalls.c           |  300 ++++++++
>  drivers/lguest/i386/interrupts_and_traps.c |  440 +++++++++++
>  drivers/lguest/i386/lguest.c               | 1097 ++++++++++++++++++++++=
++++++
>  drivers/lguest/i386/lguest_asm.S           |   93 +++
>  drivers/lguest/i386/lguest_user.c          |  382 ++++++++++
>  drivers/lguest/i386/page_tables.c          |  680 +++++++++++++++++
>  drivers/lguest/i386/segments.c             |  229 ++++++
>  drivers/lguest/i386/switcher.S             |  347 +++++++++
>  drivers/lguest/interrupts_and_traps.c      |  440 -----------
>  drivers/lguest/lguest.c                    | 1097 ----------------------=
------
>  drivers/lguest/lguest_asm.S                |   93 ---
>  drivers/lguest/lguest_user.c               |  382 ----------
>  drivers/lguest/page_tables.c               |  680 -----------------
>  drivers/lguest/segments.c                  |  229 ------
>  drivers/lguest/switcher.S                  |  347 ---------
>  20 files changed, 4348 insertions(+), 4344 deletions(-)

if you add -C or -M to "git diff --stat" this looks much better:

$ git diff --stat -C HEAD^
 drivers/lguest/Makefile                          |    7 ++-----
 drivers/lguest/i386/Makefile                     |    7 +++++++
 drivers/lguest/{ =3D> i386}/core.c                 |    0=20
 drivers/lguest/{ =3D> i386}/hypercalls.c           |    0=20
 drivers/lguest/{ =3D> i386}/interrupts_and_traps.c |    0=20
 drivers/lguest/{ =3D> i386}/lguest.c               |    0=20
 drivers/lguest/{ =3D> i386}/lguest_asm.S           |    0=20
 drivers/lguest/{ =3D> i386}/lguest_user.c          |    0=20
 drivers/lguest/{ =3D> i386}/page_tables.c          |    0=20
 drivers/lguest/{ =3D> i386}/segments.c             |    0=20
 drivers/lguest/{ =3D> i386}/switcher.S             |    0=20
 11 files changed, 9 insertions(+), 5 deletions(-)

--=20
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/

--Signature=_Thu__9_Aug_2007_15_42_21_+1000_5Kh/rGPsytsw17Gk
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQFGuqlBTgG2atn1QN8RArhxAJ0cmG52QmMjq4Fty7ELF/Zlv+RS5wCgg+I2
s3VhlINPLGZiHjaCQkiUwdM=
=Yxzu
-----END PGP SIGNATURE-----

--Signature=_Thu__9_Aug_2007_15_42_21_+1000_5Kh/rGPsytsw17Gk--

--===============9113775612027911919==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linux-foundation.org/mailman/listinfo/virtualization
--===============9113775612027911919==--
