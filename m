From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH v3 11/27] x86/power/64: Adapt assembly for PIE support
Date: Thu, 24 May 2018 13:03:41 +0200
Message-ID: <20180524110341.GB20225__7011.02954703874$1527160238$gmane$org@amd>
References: <20180523195421.180248-1-thgarnie@google.com>
	<20180523195421.180248-12-thgarnie@google.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2563417709249932146=="
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20180523195421.180248-12-thgarnie@google.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Thomas Garnier <thgarnie@google.com>
Cc: Kate Stewart <kstewart@linuxfoundation.org>, Nicolas Pitre <nicolas.pitre@linaro.org>, x86@kernel.org, Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>, Petr Mladek <pmladek@suse.com>, Len Brown <len.brown@intel.com>, Peter Zijlstra <peterz@infradead.org>, Yonghong Song <yhs@fb.com>, Christopher Li <sparse@chrisli.org>, Dave Hansen <dave.hansen@linux.intel.com>, Dominik Brodowski <linux@dominikbrodowski.net>, linux-kernel@vger.kernel.org, Masahiro Yamada <yamada.masahiro@socionext.com>, Jan Beulich <JBeulich@suse.com>, "H . Peter Anvin" <hpa@zytor.com>, kernel-hardening@lists.openwall.com, Christoph Lameter <cl@linux.com>, Alok Kataria <akataria@vmware.com>, linux-doc@vger.kernel.org, linux-arch@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>, Herbert Xu <herbert@gondor.apana.org.au>, Baoquan He <bhe@redhat.com>, David Woodhouse <dwmw@amazon.co.uk>, Boris
List-Id: virtualization@lists.linuxfoundation.org


--===============2563417709249932146==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="KFztAG8eRSV9hGtP"
Content-Disposition: inline


--KFztAG8eRSV9hGtP
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed 2018-05-23 12:54:05, Thomas Garnier wrote:
> Change the assembly code to use only relative references of symbols for t=
he
> kernel to be PIE compatible.
>=20
> Position Independent Executable (PIE) support will allow to extended the
> KASLR randomization range below the -2G memory limit.
>=20
> Signed-off-by: Thomas Garnier <thgarnie@google.com>

Again, was this tested?

> diff --git a/arch/x86/power/hibernate_asm_64.S b/arch/x86/power/hibernate=
_asm_64.S
> index ce8da3a0412c..6fdd7bbc3c33 100644
> --- a/arch/x86/power/hibernate_asm_64.S
> +++ b/arch/x86/power/hibernate_asm_64.S
> @@ -24,7 +24,7 @@
>  #include <asm/frame.h>
> =20
>  ENTRY(swsusp_arch_suspend)
> -	movq	$saved_context, %rax
> +	leaq	saved_context(%rip), %rax
>  	movq	%rsp, pt_regs_sp(%rax)
>  	movq	%rbp, pt_regs_bp(%rax)
>  	movq	%rsi, pt_regs_si(%rax)
> @@ -115,7 +115,7 @@ ENTRY(restore_registers)
>  	movq	%rax, %cr4;  # turn PGE back on
> =20
>  	/* We don't restore %rax, it must be 0 anyway */
> -	movq	$saved_context, %rax
> +	leaq	saved_context(%rip), %rax
>  	movq	pt_regs_sp(%rax), %rsp
>  	movq	pt_regs_bp(%rax), %rbp
>  	movq	pt_regs_si(%rax), %rsi

--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--KFztAG8eRSV9hGtP
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlsGnA0ACgkQMOfwapXb+vK3PwCgjIuOx9YZTN3evFcQKm9c41TU
Q4sAoLZgV0pIcRgoHsgk/ecLa/CLhuIR
=YTGF
-----END PGP SIGNATURE-----

--KFztAG8eRSV9hGtP--

--===============2563417709249932146==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
--===============2563417709249932146==--
