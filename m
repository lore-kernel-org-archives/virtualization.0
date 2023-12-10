Received: from terminus.zytor.com (terminus.zytor.com [198.137.202.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE1588829
	for <virtualization@lists.linux.dev>; Sun, 10 Dec 2023 11:49:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zytor.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="mkQYtXpm"
Received: from [127.0.0.1] ([98.35.210.218])
	(authenticated bits=0)
	by mail.zytor.com (8.17.2/8.17.1) with ESMTPSA id 3BAAt0bZ1297998
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NO);
	Sun, 10 Dec 2023 02:55:00 -0800
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.zytor.com 3BAAt0bZ1297998
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
	s=2023111101; t=1702205701;
	bh=hKtmGh1jrH1gZPQncn17Hlwa1+rCcV8nOX/wJY7DxlU=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:From;
	b=mkQYtXpmbQ3exLVv9lPx3DMrz6argRNJOfAnm/J0zjxVdffes+6kp4LvcS/Md7E1v
	 ts+okI+dMjs+4wZn6gxVLAXy+i4r88ym4xI+yTaPK7mA/qyJJ1fYtS4t9nknnuJL1/
	 oUladxpLKB2oE6jIqRMtqKHUmYBdPi0JN6J0klYWwoD8ex1bID2r3IKqCmcfg+sWKd
	 qo9vULC7tN22vlRlDYE5O/aB4h15ypTK4gQIrIH3RyHedOCPHgQVwkyB/QTEj5fVMw
	 bClxpUEGryJrG80n1Nji4aqnztRLCDvYCvv+58bc3wWTD/vyT8NhmXZ+65a7olREni
	 r5WZcUXGX5o3w==
Date: Sun, 10 Dec 2023 02:54:56 -0800
From: "H. Peter Anvin" <hpa@zytor.com>
To: Juergen Gross <jgross@suse.com>, linux-kernel@vger.kernel.org,
        x86@kernel.org, virtualization@lists.linux.dev
CC: Ajay Kaher <akaher@vmware.com>, Alexey Makhalov <amakhalov@vmware.com>,
        VMware PV-Drivers Reviewers <pv-drivers@vmware.com>,
        Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
        Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH v6 1/5] x86/paravirt: introduce ALT_NOT_XEN
User-Agent: K-9 Mail for Android
In-Reply-To: <20231210062138.2417-2-jgross@suse.com>
References: <20231210062138.2417-1-jgross@suse.com> <20231210062138.2417-2-jgross@suse.com>
Message-ID: <BD586C10-CBFB-437F-85DE-A694AC8264AA@zytor.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable

On December 9, 2023 10:21:34 PM PST, Juergen Gross <jgross@suse=2Ecom> wrot=
e:
>Introduce the macro ALT_NOT_XEN as a short form of
>ALT_NOT(X86_FEATURE_XENPV)=2E
>
>Suggested-by: Peter Zijlstra (Intel) <peterz@infradead=2Eorg>
>Signed-off-by: Juergen Gross <jgross@suse=2Ecom>
>---
>V3:
>- split off from next patch
>V5:
>- move patch to the start of the series (Boris Petkov)
>---
> arch/x86/include/asm/paravirt=2Eh       | 42 ++++++++++++---------------
> arch/x86/include/asm/paravirt_types=2Eh |  3 ++
> 2 files changed, 21 insertions(+), 24 deletions(-)
>
>diff --git a/arch/x86/include/asm/paravirt=2Eh b/arch/x86/include/asm/par=
avirt=2Eh
>index 693c61dbdd9c=2E=2Eaa76ac7c806c 100644
>--- a/arch/x86/include/asm/paravirt=2Eh
>+++ b/arch/x86/include/asm/paravirt=2Eh
>@@ -142,8 +142,7 @@ static inline void write_cr0(unsigned long x)
> static __always_inline unsigned long read_cr2(void)
> {
> 	return PVOP_ALT_CALLEE0(unsigned long, mmu=2Eread_cr2,
>-				"mov %%cr2, %%rax;",
>-				ALT_NOT(X86_FEATURE_XENPV));
>+				"mov %%cr2, %%rax;", ALT_NOT_XEN);
> }
>=20
> static __always_inline void write_cr2(unsigned long x)
>@@ -154,13 +153,12 @@ static __always_inline void write_cr2(unsigned long=
 x)
> static inline unsigned long __read_cr3(void)
> {
> 	return PVOP_ALT_CALL0(unsigned long, mmu=2Eread_cr3,
>-			      "mov %%cr3, %%rax;", ALT_NOT(X86_FEATURE_XENPV));
>+			      "mov %%cr3, %%rax;", ALT_NOT_XEN);
> }
>=20
> static inline void write_cr3(unsigned long x)
> {
>-	PVOP_ALT_VCALL1(mmu=2Ewrite_cr3, x,
>-			"mov %%rdi, %%cr3", ALT_NOT(X86_FEATURE_XENPV));
>+	PVOP_ALT_VCALL1(mmu=2Ewrite_cr3, x, "mov %%rdi, %%cr3", ALT_NOT_XEN);
> }
>=20
> static inline void __write_cr4(unsigned long x)
>@@ -182,7 +180,7 @@ extern noinstr void pv_native_wbinvd(void);
>=20
> static __always_inline void wbinvd(void)
> {
>-	PVOP_ALT_VCALL0(cpu=2Ewbinvd, "wbinvd", ALT_NOT(X86_FEATURE_XENPV));
>+	PVOP_ALT_VCALL0(cpu=2Ewbinvd, "wbinvd", ALT_NOT_XEN);
> }
>=20
> static inline u64 paravirt_read_msr(unsigned msr)
>@@ -390,27 +388,25 @@ static inline void paravirt_release_p4d(unsigned lo=
ng pfn)
> static inline pte_t __pte(pteval_t val)
> {
> 	return (pte_t) { PVOP_ALT_CALLEE1(pteval_t, mmu=2Emake_pte, val,
>-					  "mov %%rdi, %%rax",
>-					  ALT_NOT(X86_FEATURE_XENPV)) };
>+					  "mov %%rdi, %%rax", ALT_NOT_XEN) };
> }
>=20
> static inline pteval_t pte_val(pte_t pte)
> {
> 	return PVOP_ALT_CALLEE1(pteval_t, mmu=2Epte_val, pte=2Epte,
>-				"mov %%rdi, %%rax", ALT_NOT(X86_FEATURE_XENPV));
>+				"mov %%rdi, %%rax", ALT_NOT_XEN);
> }
>=20
> static inline pgd_t __pgd(pgdval_t val)
> {
> 	return (pgd_t) { PVOP_ALT_CALLEE1(pgdval_t, mmu=2Emake_pgd, val,
>-					  "mov %%rdi, %%rax",
>-					  ALT_NOT(X86_FEATURE_XENPV)) };
>+					  "mov %%rdi, %%rax", ALT_NOT_XEN) };
> }
>=20
> static inline pgdval_t pgd_val(pgd_t pgd)
> {
> 	return PVOP_ALT_CALLEE1(pgdval_t, mmu=2Epgd_val, pgd=2Epgd,
>-				"mov %%rdi, %%rax", ALT_NOT(X86_FEATURE_XENPV));
>+				"mov %%rdi, %%rax", ALT_NOT_XEN);
> }
>=20
> #define  __HAVE_ARCH_PTEP_MODIFY_PROT_TRANSACTION
>@@ -444,14 +440,13 @@ static inline void set_pmd(pmd_t *pmdp, pmd_t pmd)
> static inline pmd_t __pmd(pmdval_t val)
> {
> 	return (pmd_t) { PVOP_ALT_CALLEE1(pmdval_t, mmu=2Emake_pmd, val,
>-					  "mov %%rdi, %%rax",
>-					  ALT_NOT(X86_FEATURE_XENPV)) };
>+					  "mov %%rdi, %%rax", ALT_NOT_XEN) };
> }
>=20
> static inline pmdval_t pmd_val(pmd_t pmd)
> {
> 	return PVOP_ALT_CALLEE1(pmdval_t, mmu=2Epmd_val, pmd=2Epmd,
>-				"mov %%rdi, %%rax", ALT_NOT(X86_FEATURE_XENPV));
>+				"mov %%rdi, %%rax", ALT_NOT_XEN);
> }
>=20
> static inline void set_pud(pud_t *pudp, pud_t pud)
>@@ -464,7 +459,7 @@ static inline pud_t __pud(pudval_t val)
> 	pudval_t ret;
>=20
> 	ret =3D PVOP_ALT_CALLEE1(pudval_t, mmu=2Emake_pud, val,
>-			       "mov %%rdi, %%rax", ALT_NOT(X86_FEATURE_XENPV));
>+			       "mov %%rdi, %%rax", ALT_NOT_XEN);
>=20
> 	return (pud_t) { ret };
> }
>@@ -472,7 +467,7 @@ static inline pud_t __pud(pudval_t val)
> static inline pudval_t pud_val(pud_t pud)
> {
> 	return PVOP_ALT_CALLEE1(pudval_t, mmu=2Epud_val, pud=2Epud,
>-				"mov %%rdi, %%rax", ALT_NOT(X86_FEATURE_XENPV));
>+				"mov %%rdi, %%rax", ALT_NOT_XEN);
> }
>=20
> static inline void pud_clear(pud_t *pudp)
>@@ -492,8 +487,7 @@ static inline void set_p4d(p4d_t *p4dp, p4d_t p4d)
> static inline p4d_t __p4d(p4dval_t val)
> {
> 	p4dval_t ret =3D PVOP_ALT_CALLEE1(p4dval_t, mmu=2Emake_p4d, val,
>-					"mov %%rdi, %%rax",
>-					ALT_NOT(X86_FEATURE_XENPV));
>+					"mov %%rdi, %%rax", ALT_NOT_XEN);
>=20
> 	return (p4d_t) { ret };
> }
>@@ -501,7 +495,7 @@ static inline p4d_t __p4d(p4dval_t val)
> static inline p4dval_t p4d_val(p4d_t p4d)
> {
> 	return PVOP_ALT_CALLEE1(p4dval_t, mmu=2Ep4d_val, p4d=2Ep4d,
>-				"mov %%rdi, %%rax", ALT_NOT(X86_FEATURE_XENPV));
>+				"mov %%rdi, %%rax", ALT_NOT_XEN);
> }
>=20
> static inline void __set_pgd(pgd_t *pgdp, pgd_t pgd)
>@@ -687,17 +681,17 @@ bool __raw_callee_save___native_vcpu_is_preempted(l=
ong cpu);
> static __always_inline unsigned long arch_local_save_flags(void)
> {
> 	return PVOP_ALT_CALLEE0(unsigned long, irq=2Esave_fl, "pushf; pop %%rax=
;",
>-				ALT_NOT(X86_FEATURE_XENPV));
>+				ALT_NOT_XEN);
> }
>=20
> static __always_inline void arch_local_irq_disable(void)
> {
>-	PVOP_ALT_VCALLEE0(irq=2Eirq_disable, "cli;", ALT_NOT(X86_FEATURE_XENPV)=
);
>+	PVOP_ALT_VCALLEE0(irq=2Eirq_disable, "cli;", ALT_NOT_XEN);
> }
>=20
> static __always_inline void arch_local_irq_enable(void)
> {
>-	PVOP_ALT_VCALLEE0(irq=2Eirq_enable, "sti;", ALT_NOT(X86_FEATURE_XENPV))=
;
>+	PVOP_ALT_VCALLEE0(irq=2Eirq_enable, "sti;", ALT_NOT_XEN);
> }
>=20
> static __always_inline unsigned long arch_local_irq_save(void)
>@@ -769,7 +763,7 @@ void native_pv_lock_init(void) __init;
> =2Eendm
>=20
> #define SAVE_FLAGS	ALTERNATIVE "PARA_IRQ_save_fl;", "pushf; pop %rax;", =
\
>-				    ALT_NOT(X86_FEATURE_XENPV)
>+				    ALT_NOT_XEN
> #endif
> #endif /* CONFIG_PARAVIRT_XXL */
> #endif	/* CONFIG_X86_64 */
>diff --git a/arch/x86/include/asm/paravirt_types=2Eh b/arch/x86/include/a=
sm/paravirt_types=2Eh
>index f4fb2e3ec7b8=2E=2E483e19e5ca7a 100644
>--- a/arch/x86/include/asm/paravirt_types=2Eh
>+++ b/arch/x86/include/asm/paravirt_types=2Eh
>@@ -557,5 +557,8 @@ extern struct paravirt_patch_site __parainstructions[=
],
> 	__parainstructions_end[];
>=20
> #endif	/* __ASSEMBLY__ */
>+
>+#define ALT_NOT_XEN	ALT_NOT(X86_FEATURE_XENPV)
>+
> #endif  /* CONFIG_PARAVIRT */
> #endif	/* _ASM_X86_PARAVIRT_TYPES_H */

X86_FEATURE_NOT_XEN ;)
