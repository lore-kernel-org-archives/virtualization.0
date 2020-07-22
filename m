From: Mike Stunes <mstunes@vmware.com>
Subject: Re: [PATCH v4 51/75] x86/sev-es: Handle MMIO events
Date: Wed, 22 Jul 2020 22:53:02 +0000
Message-ID: <7020C1D2-5900-4AD8-ADCD-04A571DF2EA7@vmware.com>
References: <20200714120917.11253-1-joro@8bytes.org>
 <20200714120917.11253-52-joro@8bytes.org>
 <40D5C698-1ED2-4CCE-9C1D-07620A021A6A@vmware.com>
 <20200722080530.GH6132@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20200722080530.GH6132@suse.de>
Content-Language: en-US
Content-ID: <51B15EE8EF8CB4429AD15694F86720A0@namprd05.prod.outlook.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Joerg Roedel <jroedel@suse.de>
Cc: Joerg Roedel <joro@8bytes.org>, "x86@kernel.org" <x86@kernel.org>, Tom Lendacky <thomas.lendacky@amd.com>, "hpa@zytor.com" <hpa@zytor.com>, Andy Lutomirski <luto@kernel.org>, Dave Hansen <dave.hansen@linux.intel.com>, Peter Zijlstra <peterz@infradead.org>, Jiri Slaby <jslaby@suse.cz>, Dan Williams <dan.j.williams@intel.com>, Juergen Gross <jgross@suse.com>, Kees Cook <keescook@chromium.org>, David Rientjes <rientjes@google.com>, Cfir Cohen <cfir@google.com>, Erdem Aktas <erdemaktas@google.com>, Masami Hiramatsu <mhiramat@kernel.org>, Sean Christopherson <sean.j.christopherson@intel.com>, Martin Radev <martin.b.radev@gmail.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>, virtualization@
List-Id: virtualization@lists.linuxfoundation.org



> On Jul 22, 2020, at 1:05 AM, Joerg Roedel <jroedel@suse.de> wrote:
>=20
> Hmm, I have a theory ...
>=20
> On Tue, Jul 21, 2020 at 09:01:44PM +0000, Mike Stunes wrote:
>> If I remove the call to probe_roms from setup_arch, or remove the calls =
to romchecksum from probe_roms, this kernel boots normally.
>>=20
>> Please let me know of other tests I should run or data that I can collec=
t. Thanks!
>=20
> ... can you please try the attached diff?
>=20
> diff --git a/arch/x86/kernel/sev-es.c b/arch/x86/kernel/sev-es.c
> index 251d0aabc55a..e1fea7a38019 100644
> --- a/arch/x86/kernel/sev-es.c
> +++ b/arch/x86/kernel/sev-es.c
> @@ -389,7 +389,8 @@ static bool vc_slow_virt_to_phys(struct ghcb *ghcb, s=
truct es_em_ctxt *ctxt,
> 	pgd_t *pgd;
> 	pte_t *pte;
>=20
> -	pgd =3D pgd_offset(current->active_mm, va);
> +	pgd =3D __va(read_cr3_pa());
> +	pgd =3D &pgd[pgd_index(va)];
> 	pte =3D lookup_address_in_pgd(pgd, va, &level);
> 	if (!pte) {
> 		ctxt->fi.vector     =3D X86_TRAP_PF;

Thanks Joerg! With that change in place, this kernel boots normally. What w=
as the problem?
