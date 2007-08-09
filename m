From: Stephen Rothwell <sfr@canb.auug.org.au>
Subject: Re: [PATCH 2/7] Added generic lg.h in lguest directory.
Date: Thu, 9 Aug 2007 11:45:28 +1000
Message-ID: <20070809114528.da47fd77.sfr__31580.2207835533$1186624040$gmane$org@canb.auug.org.au>
References: <20070809003211.373543702@goodmis.org>
	<20070809003343.310187242@goodmis.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============7794450398248819036=="
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20070809003343.310187242@goodmis.org>
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

--===============7794450398248819036==
Content-Type: multipart/signed; protocol="application/pgp-signature";
	micalg="PGP-SHA1";
	boundary="Signature=_Thu__9_Aug_2007_11_45_28_+1000__.5Xh9pSJ57R84Bw"

--Signature=_Thu__9_Aug_2007_11_45_28_+1000__.5Xh9pSJ57R84Bw
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, 08 Aug 2007 20:32:13 -0400 Steven Rostedt <rostedt@goodmis.org>
wrote:
>
> Add a generic lg.h file to call the architecture specific one.

Please combine this with the previous patch so that the tree will build
at each step.

--=20
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/

--Signature=_Thu__9_Aug_2007_11_45_28_+1000__.5Xh9pSJ57R84Bw
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQFGunG9TgG2atn1QN8RAioJAJ9p5h6gDXW4eWXWRwDPs8xk3E9t+wCfQq0c
d67gd6OOfnFFWOLocv8GUr4=
=cjeU
-----END PGP SIGNATURE-----

--Signature=_Thu__9_Aug_2007_11_45_28_+1000__.5Xh9pSJ57R84Bw--

--===============7794450398248819036==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linux-foundation.org/mailman/listinfo/virtualization
--===============7794450398248819036==--
