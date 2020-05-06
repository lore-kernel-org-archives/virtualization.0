From: Mike Stunes <mstunes@vmware.com>
Subject: Re: [PATCH v3 64/75] x86/sev-es: Cache CPUID results for improved
 performance
Date: Wed, 6 May 2020 18:08:50 +0000
Message-ID: <ADD6202C-6743-4C05-B9C9-952BC45C215D@vmware.com>
References: <20200428151725.31091-1-joro@8bytes.org>
 <20200428151725.31091-65-joro@8bytes.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20200428151725.31091-65-joro@8bytes.org>
Content-Language: en-US
Content-ID: <29358357CB8991418C23B508C7813EE3@namprd05.prod.outlook.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Joerg Roedel <joro@8bytes.org>
Cc: "x86@kernel.org" <x86@kernel.org>, "hpa@zytor.com" <hpa@zytor.com>, Andy Lutomirski <luto@kernel.org>, Dave Hansen <dave.hansen@linux.intel.com>, Peter Zijlstra <peterz@infradead.org>, Thomas Hellstrom <thellstrom@vmware.com>, Jiri Slaby <jslaby@suse.cz>, Dan Williams <dan.j.williams@intel.com>, Tom Lendacky <thomas.lendacky@amd.com>, Juergen Gross <jgross@suse.com>, Kees Cook <keescook@chromium.org>, David Rientjes <rientjes@google.com>, Cfir Cohen <cfir@google.com>, Erdem Aktas <erdemaktas@google.com>, Masami Hiramatsu <mhiramat@kernel.org>, Joerg Roedel <jroedel@suse.de>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>, "virtualization@lists.linux-foundation.org" <virtualization@l>
List-Id: virtualization@lists.linuxfoundation.org



> On Apr 28, 2020, at 8:17 AM, Joerg Roedel <joro@8bytes.org> wrote:
>=20
> From: Mike Stunes <mstunes@vmware.com>
>=20
> To avoid a future VMEXIT for a subsequent CPUID function, cache the
> results returned by CPUID into an xarray.
>=20
> [tl: coding standard changes, register zero extension]
>=20
> Signed-off-by: Mike Stunes <mstunes@vmware.com>
> Signed-off-by: Tom Lendacky <thomas.lendacky@amd.com>
> [ jroedel@suse.de: - Wrapped cache handling into vc_handle_cpuid_cached()
>                   - Used lower_32_bits() where applicable
> 		   - Moved cache_index out of struct es_em_ctxt ]
> Co-developed-by: Joerg Roedel <jroedel@suse.de>
> Signed-off-by: Joerg Roedel <jroedel@suse.de>
> ---
> arch/x86/kernel/sev-es-shared.c |  12 ++--
> arch/x86/kernel/sev-es.c        | 119 +++++++++++++++++++++++++++++++-
> 2 files changed, 124 insertions(+), 7 deletions(-)
>=20
> diff --git a/arch/x86/kernel/sev-es.c b/arch/x86/kernel/sev-es.c
> index 03095bc7b563..0303834d4811 100644
> --- a/arch/x86/kernel/sev-es.c
> +++ b/arch/x86/kernel/sev-es.c
> @@ -744,6 +758,91 @@ static enum es_result vc_handle_mmio(struct ghcb *gh=
cb,
> 	return ret;
> }
>=20
> +static unsigned long sev_es_get_cpuid_cache_index(struct es_em_ctxt *ctx=
t)
> +{
> +	unsigned long hi, lo;
> +
> +	/* Don't attempt to cache until the xarray is initialized */
> +	if (!sev_es_cpuid_cache_initialized)
> +		return ULONG_MAX;
> +
> +	lo =3D lower_32_bits(ctxt->regs->ax);
> +
> +	/*
> +	 * CPUID 0x0000000d requires both RCX and XCR0, so it can't be
> +	 * cached.
> +	 */
> +	if (lo =3D=3D 0x0000000d)
> +		return ULONG_MAX;
> +
> +	/*
> +	 * Some callers of CPUID don't always set RCX to zero for CPUID
> +	 * functions that don't require RCX, which can result in excessive
> +	 * cached values, so RCX needs to be manually zeroed for use as part
> +	 * of the cache index. Future CPUID values may need RCX, but since
> +	 * they can't be known, they must not be cached.
> +	 */
> +	if (lo > 0x80000020)
> +		return ULONG_MAX;

If the cache is shared across CPUs, do we also need to exclude function 0x1=
 because it contains the LAPIC ID? (Or is the cache per-CPU?)=
