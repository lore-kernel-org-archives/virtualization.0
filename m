From: Joerg Roedel <jroedel@suse.de>
Subject: Re: [PATCH v4 51/75] x86/sev-es: Handle MMIO events
Date: Wed, 22 Jul 2020 10:05:30 +0200
Message-ID: <20200722080530.GH6132@suse.de>
References: <20200714120917.11253-1-joro@8bytes.org>
 <20200714120917.11253-52-joro@8bytes.org>
 <40D5C698-1ED2-4CCE-9C1D-07620A021A6A@vmware.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <40D5C698-1ED2-4CCE-9C1D-07620A021A6A@vmware.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Mike Stunes <mstunes@vmware.com>
Cc: Joerg Roedel <joro@8bytes.org>, "x86@kernel.org" <x86@kernel.org>, Tom Lendacky <thomas.lendacky@amd.com>, "hpa@zytor.com" <hpa@zytor.com>, Andy Lutomirski <luto@kernel.org>, Dave Hansen <dave.hansen@linux.intel.com>, Peter Zijlstra <peterz@infradead.org>, Jiri Slaby <jslaby@suse.cz>, Dan Williams <dan.j.williams@intel.com>, Juergen Gross <jgross@suse.com>, Kees Cook <keescook@chromium.org>, David Rientjes <rientjes@google.com>, Cfir Cohen <cfir@google.com>, Erdem Aktas <erdemaktas@google.com>, Masami Hiramatsu <mhiramat@kernel.org>, Sean Christopherson <sean.j.christopherson@intel.com>, Martin Radev <martin.b.radev@gmail.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>, virtualization@
List-Id: virtualization@lists.linuxfoundation.org

Hmm, I have a theory ...

On Tue, Jul 21, 2020 at 09:01:44PM +0000, Mike Stunes wrote:
> If I remove the call to probe_roms from setup_arch, or remove the calls to romchecksum from probe_roms, this kernel boots normally.
> 
> Please let me know of other tests I should run or data that I can collect. Thanks!

... can you please try the attached diff?

diff --git a/arch/x86/kernel/sev-es.c b/arch/x86/kernel/sev-es.c
index 251d0aabc55a..e1fea7a38019 100644
--- a/arch/x86/kernel/sev-es.c
+++ b/arch/x86/kernel/sev-es.c
@@ -389,7 +389,8 @@ static bool vc_slow_virt_to_phys(struct ghcb *ghcb, struct es_em_ctxt *ctxt,
 	pgd_t *pgd;
 	pte_t *pte;
 
-	pgd = pgd_offset(current->active_mm, va);
+	pgd = __va(read_cr3_pa());
+	pgd = &pgd[pgd_index(va)];
 	pte = lookup_address_in_pgd(pgd, va, &level);
 	if (!pte) {
 		ctxt->fi.vector     = X86_TRAP_PF;
