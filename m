From: Stephen Rothwell <sfr@canb.auug.org.au>
Subject: Re: [PATCH 4/7] Moved the io struct up to the generic lg.h
Date: Thu, 9 Aug 2007 11:51:56 +1000
Message-ID: <20070809115156.ef5fdc6c.sfr__5453.40730245716$1186624542$gmane$org@canb.auug.org.au>
References: <20070809003211.373543702@goodmis.org>
	<20070809003343.664528532@goodmis.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4909588440680593922=="
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20070809003343.664528532@goodmis.org>
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

--===============4909588440680593922==
Content-Type: multipart/signed; protocol="application/pgp-signature";
	micalg="PGP-SHA1";
	boundary="Signature=_Thu__9_Aug_2007_11_51_56_+1000_ydFXW4+YlZArSwR/"

--Signature=_Thu__9_Aug_2007_11_51_56_+1000_ydFXW4+YlZArSwR/
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, 08 Aug 2007 20:32:15 -0400 Steven Rostedt <rostedt@goodmis.org>
wrote:
>
> diff --git a/drivers/lguest/i386/lg.h b/drivers/lguest/i386/lg.h
> index 64f0abe..c5ea14c 100644
> --- a/drivers/lguest/i386/lg.h
> +++ b/drivers/lguest/i386/lg.h
> @@ -20,6 +20,8 @@
>  #include <linux/err.h>
>  #include <asm/semaphore.h>
>  #include "irq_vectors.h"
> +/* some files include this, some include the parent */
> +#include "../lg.h"

Surely everything should just include the parent which allows for easier
consolidation over time. (as you are doing here)

> --- a/drivers/lguest/lg.h
> +++ b/drivers/lguest/lg.h
> @@ -1,3 +1,19 @@
> +#ifndef _LGUEST_LG_GENERIC
> +#define _LGUEST_LG_GENERIC

Maybe _LGUEST_LG_H?  and the arch ones could use _LGUEST_I386_LG_H etc.

--=20
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/

--Signature=_Thu__9_Aug_2007_11_51_56_+1000_ydFXW4+YlZArSwR/
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQFGunNATgG2atn1QN8RAlwdAJ98BwpBobUTR/kC+hw4rkxGHJm63gCfR6MZ
0bJEgxR+9e9+ea7NUGK3isQ=
=0GQf
-----END PGP SIGNATURE-----

--Signature=_Thu__9_Aug_2007_11_51_56_+1000_ydFXW4+YlZArSwR/--

--===============4909588440680593922==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linux-foundation.org/mailman/listinfo/virtualization
--===============4909588440680593922==--
