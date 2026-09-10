Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFB553AEF51;
	Thu, 10 Sep 2026 08:31:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789029105; cv=none; b=b85azHDKbDkaj+c/eilC06ko8X2ADKN88aarFxN0irmP+vTBZQrlArkOMUeODHIhccCAjIrtU72ldFJMzfQtoLF331eWC+lD84HaZNnpkUbFFUifIsSDg9CLPHTiuznvdjakJSRxEsJRUBi4F8LZGWMeCzZdBsJBu/3zXXhi6m8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789029105; c=relaxed/simple;
	bh=oH57KK8uwOpt+q19tA/dGcXMsq1CU/m0u5KjaXNlYl4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rjpuFyc4JegrNkeAusQf7BJeV8cU1uhINpeFjDakPJPbogccHkU5W6kXmnqpYtCrFAYtCVdTv3MLmiz2OIMpN5WBsbUuMt5X2gJmZ//7nGOc8toS3NGSfkIHQktMa9gRgdds52vzYejQJr+H4wnVKCnKdxzaR2N2v0mtyJIsILU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Es9kxPtS; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Es9kxPtS"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 16D671F000FF;
	Thu, 10 Sep 2026 08:31:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789029103;
	bh=9cR2txGyC7hZ49ejFrxQhSQyUnrI0Q1sWnkbjpwbCtA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=Es9kxPtS55Hy7OsFUILeQFymIS5K0P9YigfU3e1Yv2z8+OhRki9yMVMVuOuJ9Ks/j
	 m5kG5FgQzpPNXhlBmdDwPdgleGvgw4qtC3Bhovupoq5NPFPDf+nlNhh2BfhG+D7pda
	 FC9EuOnbg32glBn8w6TGAQxO5Am8mlUn/w/guQKoShjZ77nkslbO7zMiTgscQBPr4L
	 OxT8o8nu5b/YJ0Mm6A1YXz6Ra3+Pge4OhJVsSJ5CnxAr3WPNKbzTSy+K/MhdLkbYt3
	 oih3fntLu+DOoEWgIslKeMfPAS0wRCmFXPaUANmRBp1Ead7Qi/PzXkb/g7jWz2F0Nr
	 sEcf1990GkizQ==
Date: Thu, 10 Sep 2026 10:31:38 +0200
From: Joel Granados <joel.granados@kernel.org>
To: Zack Rusin <zack.rusin@broadcom.com>
Cc: Borislav Petkov <bp@alien8.de>, Ajay Kaher <ajay.kaher@broadcom.com>, 
	Alexey Makhalov <alexey.makhalov@broadcom.com>, x86@kernel.org, Petr Mladek <pmladek@suse.com>, 
	Baoquan He <baoquan.he@linux.dev>, Thomas Gleixner <tglx@kernel.org>, 
	Ingo Molnar <mingo@redhat.com>, Dave Hansen <dave.hansen@linux.intel.com>, 
	"H . Peter Anvin" <hpa@zytor.com>, virtualization@lists.linux.dev, 
	bcm-kernel-feedback-list@broadcom.com, linux-kernel@vger.kernel.org, 
	John Ogness <john.ogness@linutronix.de>, Steven Rostedt <rostedt@goodmis.org>, 
	Sergey Senozhatsky <senozhatsky@chromium.org>, Kees Cook <kees@kernel.org>, 
	Andrew Morton <akpm@linux-foundation.org>, Mike Rapoport <rppt@kernel.org>, 
	Pasha Tatashin <pasha.tatashin@soleen.com>, Pratyush Yadav <pratyush@kernel.org>, 
	Dave Young <ruirui.yang@linux.dev>, Jonathan Corbet <corbet@lwn.net>, Bo Gan <bo.gan@broadcom.com>, 
	Brennan Lamoreaux <brennan.lamoreaux@broadcom.com>, kexec@lists.infradead.org, linux-doc@vger.kernel.org
Subject: Re: [PATCH v1 2/4] x86/vmware: Add the vmware_record_panic_msg sysctl
Message-ID: <4e73yd2ofpdzl6rptzvd74no3hnyfblknoq7wzxlw7f3zjbz7c@srfabx6lsusj>
References: <cover.1788414671.git.zack.rusin@broadcom.com>
 <03e5c9855e9578b00abf8da69764f1b468597218.1788414671.git.zack.rusin@broadcom.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="xiixfssqgqvtj5o7"
Content-Disposition: inline
In-Reply-To: <03e5c9855e9578b00abf8da69764f1b468597218.1788414671.git.zack.rusin@broadcom.com>


--xiixfssqgqvtj5o7
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 08, 2026 at 02:07:14PM -0400, Zack Rusin wrote:
> Full panic text is useful on ordinary guests. Encrypted guests should
> export it only when an administrator opts in. Reporting a crash does not
> require transferring the log.
>=20
> Enable panic recording by default for ordinary VMware guests and disable
> it when guest memory encryption is active. Expose the policy as the
> boolean kernel.vmware_record_panic_msg sysctl and document that it
> controls only the vmware.log transfer.
>=20
> Register the sysctl only after the panic buffer and dumper are ready, and
> only when sysctl support is built. A registration failure leaves the
> internal default in force.
>=20
> Signed-off-by: Zack Rusin <zack.rusin@broadcom.com>
> ---
>  Documentation/admin-guide/sysctl/kernel.rst | 14 +++++++++++++
>  arch/x86/kernel/cpu/vmware.c                | 23 +++++++++++++++++++++
>  2 files changed, 37 insertions(+)
>=20
> diff --git a/Documentation/admin-guide/sysctl/kernel.rst b/Documentation/=
admin-guide/sysctl/kernel.rst
> index b6328cd0f43e..4577e935ddcf 100644
> --- a/Documentation/admin-guide/sysctl/kernel.rst
> +++ b/Documentation/admin-guide/sysctl/kernel.rst
> @@ -1690,6 +1690,20 @@ entry will default to 2 instead of 0.
>  =3D =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> =20
> =20
> +vmware_record_panic_msg
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +
> +Controls whether panic kmsg data is written to the host's ``vmware.log``.
> +This setting does not control the separate VMware guest-crash event.
> +
> +=3D =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +0 Do not write panic kmsg data to ``vmware.log``. This is the
> +  default for encrypted guests.
> +1 Write panic kmsg data to ``vmware.log``. This is the default for
> +  ordinary guests.
> +=3D =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

This seems like it can be represented in a boolean value. Any reason why
you did not use proc_dobool for your handler? Would it make sense to
have vmware_record_panic_msg as a boolean?

Best

> +
> +
>  warn_limit
>  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> =20
> diff --git a/arch/x86/kernel/cpu/vmware.c b/arch/x86/kernel/cpu/vmware.c
> index bf59653d6e07..3848811550e9 100644
> --- a/arch/x86/kernel/cpu/vmware.c
> +++ b/arch/x86/kernel/cpu/vmware.c
> @@ -31,6 +31,7 @@
>  #include <linux/efi.h>
>  #include <linux/reboot.h>
>  #include <linux/static_call.h>
> +#include <linux/sysctl.h>
>  #include <linux/wordpart.h>
>  #include <linux/sched/cputime.h>
>  #include <asm/div64.h>
> @@ -255,6 +256,19 @@ static int vmware_log_rpc(const char *buffer, size_t=
 length)
>  }
> =20
>  static struct page *vmware_panic_page;
> +static int vmware_record_panic_msg;
> +
> +static const struct ctl_table vmware_panic_sysctls[] =3D {
> +	{
> +		.procname	=3D "vmware_record_panic_msg",
> +		.data		=3D &vmware_record_panic_msg,
> +		.maxlen		=3D sizeof(vmware_record_panic_msg),
> +		.mode		=3D 0644,
> +		.proc_handler	=3D proc_dointvec_minmax,
> +		.extra1		=3D SYSCTL_ZERO,
> +		.extra2		=3D SYSCTL_ONE,
> +	},
> +};
> =20
>  static void vmware_panic_log_dump(struct kmsg_dumper *dumper,
>  				  struct kmsg_dump_detail *detail)
> @@ -263,6 +277,9 @@ static void vmware_panic_log_dump(struct kmsg_dumper =
*dumper,
>  	char *buffer =3D page_address(vmware_panic_page);
>  	size_t length =3D 0;
> =20
> +	if (!READ_ONCE(vmware_record_panic_msg))
> +		return;
> +
>  	memcpy(buffer, VMWARE_LOG_PREFIX, VMWARE_LOG_PREFIX_LEN);
>  	kmsg_dump_rewind(&iter);
>  	(void)kmsg_dump_get_buffer(&iter, true,
> @@ -283,6 +300,9 @@ static int __init vmware_panic_log_init(void)
>  	if (!hypervisor_is_type(X86_HYPER_VMWARE))
>  		return 0;
> =20
> +	vmware_record_panic_msg =3D
> +		!cc_platform_has(CC_ATTR_GUEST_MEM_ENCRYPT);
> +
>  	vmware_panic_page =3D alloc_page(GFP_KERNEL);
>  	if (!vmware_panic_page) {
>  		pr_err("failed to allocate panic log buffer\n");
> @@ -295,6 +315,9 @@ static int __init vmware_panic_log_init(void)
>  		__free_page(vmware_panic_page);
>  		vmware_panic_page =3D NULL;
>  	}
> +	if (vmware_panic_page && IS_ENABLED(CONFIG_SYSCTL) &&
> +	    !register_sysctl("kernel", vmware_panic_sysctls))
> +		pr_err("failed to register panic log sysctl\n");
> =20
>  	return 0;
>  }
> --=20
> 2.53.0
>=20

--xiixfssqgqvtj5o7
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEErkcJVyXmMSXOyyeQupfNUreWQU8FAmqiaukACgkQupfNUreW
QU+hBwv7BUPdw+1A6g/8FaJQhp+DUve6X7M2spaDjh1f9BHHbZb/KPAOVO5m4AtF
/aowgx9K9H/WzUdWN/dowHicF95lzhLY3uRo1r8KjkOR/ua4ae6IhTXNqYz2s73T
38wmYvOE1s6s2Ppee9Q9XEUfWLssbSiO9SGUwL6V1pJLFqO2YIC4hqwxiTQa9CrJ
0n7SuzrUkNdromDUugsmDcCkAI35dHC3YsAJCmG4qiEPP/TJbhoK5DNHxAKend77
vtDmeOZ2SQx3bp1t6tfjANJUUVzLV7RemZ3mTqE/M6bK22OkNpUmVBR97yJFGx3F
lVhq18Vfmgo2kIuf1wYVkbooD0WZBYIbGWURjAG5VDb0F+QCcRCcY8altL4JoUfZ
87+jFw7ZW6pSmkoPwbfHv6KI+hVIEOTJh7UuSIOyGHLThtOTVncw45G79kcC7Rpi
R2KXavaDOLV/8+uuJyAmJfZlaJ0QIuU+9uxvhvsYVyDF5WszAkji43yJ8Mu86Zt5
waTRn0nA
=IjZN
-----END PGP SIGNATURE-----

--xiixfssqgqvtj5o7--
