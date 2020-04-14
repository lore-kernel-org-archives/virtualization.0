From: Mike Stunes <mstunes@vmware.com>
Subject: Re: [PATCH 40/70] x86/sev-es: Setup per-cpu GHCBs for the runtime
 handler
Date: Tue, 14 Apr 2020 19:03:44 +0000
Message-ID: <A7DF63B4-6589-4386-9302-6B7F8BE0D9BA@vmware.com>
References: <20200319091407.1481-1-joro@8bytes.org>
 <20200319091407.1481-41-joro@8bytes.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <20200319091407.1481-41-joro@8bytes.org>
Content-Language: en-US
Content-ID: <CCC02F7E87773D41B51FCDF4C0FD1521@namprd05.prod.outlook.com>
Sender: kvm-owner@vger.kernel.org
To: Joerg Roedel <joro@8bytes.org>
Cc: "x86@kernel.org" <x86@kernel.org>, "hpa@zytor.com" <hpa@zytor.com>, Andy Lutomirski <luto@kernel.org>, Dave Hansen <dave.hansen@linux.intel.com>, Peter Zijlstra <peterz@infradead.org>, Thomas Hellstrom <thellstrom@vmware.com>, Jiri Slaby <jslaby@suse.cz>, Dan Williams <dan.j.williams@intel.com>, Tom Lendacky <thomas.lendacky@amd.com>, Juergen Gross <jgross@suse.com>, Kees Cook <keescook@chromium.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>, "virtualization@lists.linux-foundation.org" <virtualization@lists.linux-foundation.org>, Joerg Roedel <jroedel@suse.de>
List-Id: virtualization@lists.linuxfoundation.org

On Mar 19, 2020, at 2:13 AM, Joerg Roedel <joro@8bytes.org> wrote:
>=20
> From: Tom Lendacky <thomas.lendacky@amd.com>
>=20
> The runtime handler needs a GHCB per CPU. Set them up and map them
> unencrypted.
>=20
> Signed-off-by: Tom Lendacky <thomas.lendacky@amd.com>
> Signed-off-by: Joerg Roedel <jroedel@suse.de>
> ---
> arch/x86/include/asm/mem_encrypt.h |  2 ++
> arch/x86/kernel/sev-es.c           | 28 +++++++++++++++++++++++++++-
> arch/x86/kernel/traps.c            |  3 +++
> 3 files changed, 32 insertions(+), 1 deletion(-)
>=20
> diff --git a/arch/x86/kernel/sev-es.c b/arch/x86/kernel/sev-es.c
> index c17980e8db78..4bf5286310a0 100644
> --- a/arch/x86/kernel/sev-es.c
> +++ b/arch/x86/kernel/sev-es.c
> @@ -197,6 +203,26 @@ static bool __init sev_es_setup_ghcb(void)
> 	return true;
> }
>=20
> +void sev_es_init_ghcbs(void)
> +{
> +	int cpu;
> +
> +	if (!sev_es_active())
> +		return;
> +
> +	/* Allocate GHCB pages */
> +	ghcb_page =3D __alloc_percpu(sizeof(struct ghcb), PAGE_SIZE);
> +
> +	/* Initialize per-cpu GHCB pages */
> +	for_each_possible_cpu(cpu) {
> +		struct ghcb *ghcb =3D (struct ghcb *)per_cpu_ptr(ghcb_page, cpu);
> +
> +		set_memory_decrypted((unsigned long)ghcb,
> +				     sizeof(*ghcb) >> PAGE_SHIFT);
> +		memset(ghcb, 0, sizeof(*ghcb));
> +	}
> +}
> +

set_memory_decrypted needs to check the return value. I see it
consistently return ENOMEM. I've traced that back to split_large_page
in arch/x86/mm/pat/set_memory.c.
