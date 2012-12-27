From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [PATCH v3 02/11] x86/kexec: Add extra pointers to transition page
	table PGD, PUD, PMD and PTE
Date: Wed, 26 Dec 2012 19:33:37 -0800
Message-ID: <083de527-84b0-4450-8e89-055103305afa@email.android.com>
References: <1356574740-6806-1-git-send-email-daniel.kiper@oracle.com>
	<1356574740-6806-2-git-send-email-daniel.kiper@oracle.com>
	<1356574740-6806-3-git-send-email-daniel.kiper@oracle.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1356574740-6806-3-git-send-email-daniel.kiper@oracle.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Daniel Kiper <daniel.kiper@oracle.com>, andrew.cooper3@citrix.com, ebiederm@xmission.com, jbeulich@suse.com, konrad.wilk@oracle.com, maxim.uvarov@oracle.com, mingo@redhat.com, tglx@linutronix.de, vgoyal@redhat.com, x86@kernel.org, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, xen-devel@lists.xensource.com
List-Id: virtualization@lists.linuxfoundation.org

Hmm... this code is being redone at the moment... this might conflict.

Daniel Kiper <daniel.kiper@oracle.com> wrote:

>Some implementations (e.g. Xen PVOPS) could not use part of identity
>page table
>to construct transition page table. It means that they require separate
>PUDs,
>PMDs and PTEs for virtual and physical (identity) mapping. To satisfy
>that
>requirement add extra pointer to PGD, PUD, PMD and PTE and align
>existing code.
>
>Signed-off-by: Daniel Kiper <daniel.kiper@oracle.com>
>---
> arch/x86/include/asm/kexec.h       |   10 +++++++---
> arch/x86/kernel/machine_kexec_64.c |   12 ++++++------
> 2 files changed, 13 insertions(+), 9 deletions(-)
>
>diff --git a/arch/x86/include/asm/kexec.h
>b/arch/x86/include/asm/kexec.h
>index 6080d26..cedd204 100644
>--- a/arch/x86/include/asm/kexec.h
>+++ b/arch/x86/include/asm/kexec.h
>@@ -157,9 +157,13 @@ struct kimage_arch {
> };
> #else
> struct kimage_arch {
>-	pud_t *pud;
>-	pmd_t *pmd;
>-	pte_t *pte;
>+	pgd_t *pgd;
>+	pud_t *pud0;
>+	pud_t *pud1;
>+	pmd_t *pmd0;
>+	pmd_t *pmd1;
>+	pte_t *pte0;
>+	pte_t *pte1;
> };
> #endif
> 
>diff --git a/arch/x86/kernel/machine_kexec_64.c
>b/arch/x86/kernel/machine_kexec_64.c
>index b3ea9db..976e54b 100644
>--- a/arch/x86/kernel/machine_kexec_64.c
>+++ b/arch/x86/kernel/machine_kexec_64.c
>@@ -137,9 +137,9 @@ out:
> 
> static void free_transition_pgtable(struct kimage *image)
> {
>-	free_page((unsigned long)image->arch.pud);
>-	free_page((unsigned long)image->arch.pmd);
>-	free_page((unsigned long)image->arch.pte);
>+	free_page((unsigned long)image->arch.pud0);
>+	free_page((unsigned long)image->arch.pmd0);
>+	free_page((unsigned long)image->arch.pte0);
> }
> 
> static int init_transition_pgtable(struct kimage *image, pgd_t *pgd)
>@@ -157,7 +157,7 @@ static int init_transition_pgtable(struct kimage
>*image, pgd_t *pgd)
> 		pud = (pud_t *)get_zeroed_page(GFP_KERNEL);
> 		if (!pud)
> 			goto err;
>-		image->arch.pud = pud;
>+		image->arch.pud0 = pud;
> 		set_pgd(pgd, __pgd(__pa(pud) | _KERNPG_TABLE));
> 	}
> 	pud = pud_offset(pgd, vaddr);
>@@ -165,7 +165,7 @@ static int init_transition_pgtable(struct kimage
>*image, pgd_t *pgd)
> 		pmd = (pmd_t *)get_zeroed_page(GFP_KERNEL);
> 		if (!pmd)
> 			goto err;
>-		image->arch.pmd = pmd;
>+		image->arch.pmd0 = pmd;
> 		set_pud(pud, __pud(__pa(pmd) | _KERNPG_TABLE));
> 	}
> 	pmd = pmd_offset(pud, vaddr);
>@@ -173,7 +173,7 @@ static int init_transition_pgtable(struct kimage
>*image, pgd_t *pgd)
> 		pte = (pte_t *)get_zeroed_page(GFP_KERNEL);
> 		if (!pte)
> 			goto err;
>-		image->arch.pte = pte;
>+		image->arch.pte0 = pte;
> 		set_pmd(pmd, __pmd(__pa(pte) | _KERNPG_TABLE));
> 	}
> 	pte = pte_offset_kernel(pmd, vaddr);

-- 
Sent from my mobile phone. Please excuse brevity and lack of formatting.
