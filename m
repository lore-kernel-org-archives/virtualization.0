From: Blaisorblade <blaisorblade@yahoo.it>
Subject: Re: [uml-devel] [PATCH 1/5] um/... convert #include "linux/..." to
	#include	 <linux/...>
Date: Tue, 21 Aug 2007 19:09:17 +0200
Message-ID: <200708211909.23027.blaisorblade@yahoo.it>
References: <1187561903.4200.138.camel@localhost>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2657067245559378831=="
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1187561903.4200.138.camel@localhost>
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
To: user-mode-linux-devel@lists.sourceforge.net
Cc: Miklos Szeredi <mszeredi@suse.cz>, Maxim Krasnyansky <maxk@qualcomm.com>, Jeff Dike <jdike@karaya.com>, kernel-janitors@vger.kernel.org, Jason Lunz <lunz@falooley.org>, Jan Beulich <jbeulich@novell.com>, vtun@office.satix.net, Jens Axboe <jens.axboe@oracle.com>, Stephen Hemminger <shemminger@linux-foundation.org>, Nick Piggin <npiggin@suse.de>, Davide Brini <davide.brini@unibo.it>, Fernando Luis Vazquez Cao <fernando@oss.ntt.co.jp>, virtualization@lists.osdl.org, Ingo Molnar <mingo@elte.hu>, Alexey Dobriyan <adobriyan@gmail.com>, Peter Zijlstra <a.p.zijlstra@chello.nl>, Jeff Dike <jdike@addtoit.com>, Eduard-Gabriel Munteanu <maxdamage@aladin.ro>, Chris Wright <chrisw@sous-sol.org>, user-mode-linux-user@lists.sourceforge.net, Jeff Dike <jdike@linux.intel.com>, Arnaldo
List-Id: virtualization@lists.linuxfoundation.org

--===============2657067245559378831==
Content-Type: multipart/signed; boundary="nextPart3465391.6hmGNNrzUM";
	protocol="application/pgp-signature"; micalg=pgp-sha1
Content-Transfer-Encoding: 7bit

--nextPart3465391.6hmGNNrzUM
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

On luned=EC 20 agosto 2007, Joe Perches wrote:
> (untested)
>
> There are several files that
> #include "linux/file" not #include <linux/file>
> #include "asm/file" not #include <asm/file>
>
> Here's a little script that converts them:
>
> egrep -i -r -l --include=3D*.[ch] \
> "^[[:space:]]*\#[[:space:]]*include[[:space:]]*\"(linux|asm)/(.*)\"" * \
>
> | xargs sed -i -e
> | 's/^[[:space:]]*#[[:space:]]*include[[:space:]]*"\(linux\|asm\)\/\(.*\)=
"/
> |#include <\1\/\2>/g'
>
> Signed-off-by: Joe Perches <joe@perches.com>

Wait, this patch may or may not be sane (Jeff will tell more I guess). Sinc=
e=20
we use two different sets of headers (the host ones from userspace and the=
=20
guest ones from Linux), this peculiar style has been used till now to make=
=20
clear the difference (#include <file> is used for host headers) - at least=
=20
that's what I think (I've never asked to Jeff, but I silently deduced this=
=20
and followed this practice).
=2D-=20
"Doh!" (cit.), I've made another another mistake!
Paolo Giarrusso, aka Blaisorblade
Linux registered user n. 292729
http://www.user-mode-linux.org/~blaisorblade

--nextPart3465391.6hmGNNrzUM
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQBGyxxCqH9OHC+5NscRAuz6AKCgps1/TLX24DaQmwmgVPtM2urAhwCffaU0
OughA/pR1xKW0+WDdsnzZu8=
=caGC
-----END PGP SIGNATURE-----

--nextPart3465391.6hmGNNrzUM--

--===============2657067245559378831==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linux-foundation.org/mailman/listinfo/virtualization
--===============2657067245559378831==--
