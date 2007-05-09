From: Stephen Rothwell <sfr@canb.auug.org.au>
Subject: Re: [patch 3/9] lguest: the host code
Date: Wed, 9 May 2007 22:54:36 +1000
Message-ID: <20070509225436.1fb5dc2d.sfr@canb.auug.org.au>
References: <200705090951.l499pZF8020394@shell0.pdx.osdl.net>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
 micalg="PGP-SHA1";
 boundary="Signature=_Wed__9_May_2007_22_54_36_+1000_CqaM72uC/0=9vaPs"
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1758248AbXEIMyx@vger.kernel.org>
In-Reply-To: <200705090951.l499pZF8020394@shell0.pdx.osdl.net>
Sender: linux-kernel-owner@vger.kernel.org
To: akpm@linux-foundation.org
Cc: linux-kernel@vger.kernel.org, virtualization@lists.osdl.org, rusty@rustcorp.com.au, ak@suse.de, dada1@cosmosbay.com
List-Id: virtualization@lists.linuxfoundation.org

--Signature=_Wed__9_May_2007_22_54_36_+1000_CqaM72uC/0=9vaPs
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: 7bit

On Wed, 09 May 2007 02:51:35 -0700 akpm@linux-foundation.org wrote:
>
> +++ a/drivers/lguest/core.c
> @@ -0,0 +1,446 @@
> +/* World's simplest hypervisor, to test paravirt_ops and show
> + * unbelievers that virtualization is the future.  Plus, it's fun! */

This may have been asked before, but is there some reason this has no
copyright and license statement?

--
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/

--Signature=_Wed__9_May_2007_22_54_36_+1000_CqaM72uC/0=9vaPs
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQFGQcSRFdBgD/zoJvwRAtuRAJ9pb/uh9r+3SNJ9eTl8zmOyFEJFlwCdGDlG
HhD/khRnW2FQtfgWs3pgWVM=
=86jF
-----END PGP SIGNATURE-----

--Signature=_Wed__9_May_2007_22_54_36_+1000_CqaM72uC/0=9vaPs--
