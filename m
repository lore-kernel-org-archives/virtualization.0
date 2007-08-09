From: Stephen Rothwell <sfr@canb.auug.org.au>
Subject: Re: [PATCH 4/5 -v2] Added generic lg.h in the include/linux
 directory
Date: Thu, 9 Aug 2007 15:31:33 +1000
Message-ID: <20070809153133.d5dff7b6.sfr__37684.3982412995$1186637725$gmane$org@canb.auug.org.au>
References: <20070809043626.830486783@goodmis.org>
	<20070809044125.459178259@goodmis.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1991016793430957947=="
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20070809044125.459178259@goodmis.org>
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

--===============1991016793430957947==
Content-Type: multipart/signed; protocol="application/pgp-signature";
	micalg="PGP-SHA1";
	boundary="Signature=_Thu__9_Aug_2007_15_31_33_+1000_cLTAAr6tbZXREfb."

--Signature=_Thu__9_Aug_2007_15_31_33_+1000_cLTAAr6tbZXREfb.
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Steven,

I am just being pedantic here (and I should have beaten up on Rusty
before now ...  :-)

On Thu, 09 Aug 2007 00:36:30 -0400 Steven Rostedt <rostedt@goodmis.org>
wrote:
>
> --- a/include/asm-i386/lg.h
> +++ b/include/asm-i386/lg.h
> @@ -1,5 +1,5 @@
> -#ifndef _LGUEST_H
> -#define _LGUEST_H
> +#ifndef _I386_LGUEST_H
> +#define _I386_LGUEST_H

Maybe _ASM_LG_H or _I386_LG_H ? And there is a comment on the #endif at
the end of the file that should match.

> +++ b/include/linux/lg.h
> @@ -0,0 +1,30 @@
> +#ifndef _LINUX_LGUEST_H
> +#define _LINUX_LGUEST_H

Maybe _LINUX_LG_H ?

Also (this is for Rusty) include/linux/lguest.h is protected by
_ASM_LGUEST_H ...

--=20
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/

--Signature=_Thu__9_Aug_2007_15_31_33_+1000_cLTAAr6tbZXREfb.
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQFGuqa6TgG2atn1QN8RAmJPAJ4gcct+revTVWqW6yTxblm3Jt4MawCfRMih
BHtkczFmBmKURUW89aQUUHM=
=dKUJ
-----END PGP SIGNATURE-----

--Signature=_Thu__9_Aug_2007_15_31_33_+1000_cLTAAr6tbZXREfb.--

--===============1991016793430957947==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linux-foundation.org/mailman/listinfo/virtualization
--===============1991016793430957947==--
