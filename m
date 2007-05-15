From: Stephen Rothwell <sfr@canb.auug.org.au>
Subject: Re: [PATCH 1/6] lguest: host code tidyups
Date: Tue, 15 May 2007 21:42:35 +1000
Message-ID: <20070515214235.b0625699.sfr__36640.270430553$1179229434$gmane$org@canb.auug.org.au>
References: <1179191827.10836.24.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0760259244979305272=="
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1179191827.10836.24.camel@localhost.localdomain>
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
Cc: hch <hch@infradead.org>, Andrew Morton <akpm@linux-foundation.org>, lkml - Kernel Mailing List <linux-kernel@vger.kernel.org>, Al Viro <viro@zeniv.linux.org.uk>, virtualization <virtualization@lists.linux-foundation.org>
List-Id: virtualization@lists.linuxfoundation.org

--===============0760259244979305272==
Content-Type: multipart/signed; protocol="application/pgp-signature";
	micalg="PGP-SHA1";
	boundary="Signature=_Tue__15_May_2007_21_42_35_+1000_vPSON/bHz0.hQQG_"

--Signature=_Tue__15_May_2007_21_42_35_+1000_vPSON/bHz0.hQQG_
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: 7bit

On Tue, 15 May 2007 11:17:07 +1000 Rusty Russell <rusty@rustcorp.com.au> wrote:
>
> @@ -420,7 +421,7 @@ static int __init init(void)
>  	lock_cpu_hotplug();
>  	if (cpu_has_pge) { /* We have a broader idea of "global". */
>  		cpu_had_pge = 1;
> -		on_each_cpu(adjust_pge, 0, 0, 1);
> +		on_each_cpu(adjust_pge, (void *)0, 0, 1);

Sorry?  What ever happened to a simple NULL?

--
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/

--Signature=_Tue__15_May_2007_21_42_35_+1000_vPSON/bHz0.hQQG_
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQFGSZyyFdBgD/zoJvwRAjZ6AJ9gk5CB7+LxR0nzjv9+ayJ8VXjSJwCfYrft
XaX8ZE5zfW6q98PmPJTJJdU=
=hwQS
-----END PGP SIGNATURE-----

--Signature=_Tue__15_May_2007_21_42_35_+1000_vPSON/bHz0.hQQG_--

--===============0760259244979305272==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linux-foundation.org/mailman/listinfo/virtualization
--===============0760259244979305272==--
