From: Joerg Roedel <joro@8bytes.org>
Subject: Re: [PATCH v3 51/75] x86/sev-es: Handle MMIO events
Date: Thu, 11 Jun 2020 14:40:08 +0200
Message-ID: <20200611124008.GC11924@8bytes.org>
References: <20200428151725.31091-1-joro@8bytes.org>
 <20200428151725.31091-52-joro@8bytes.org>
 <20200520063202.GB17090@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20200520063202.GB17090@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Sean Christopherson <sean.j.christopherson@intel.com>
Cc: x86@kernel.org, hpa@zytor.com, Andy Lutomirski <luto@kernel.org>, Dave Hansen <dave.hansen@linux.intel.com>, Peter Zijlstra <peterz@infradead.org>, Thomas Hellstrom <thellstrom@vmware.com>, Jiri Slaby <jslaby@suse.cz>, Dan Williams <dan.j.williams@intel.com>, Tom Lendacky <thomas.lendacky@amd.com>, Juergen Gross <jgross@suse.com>, Kees Cook <keescook@chromium.org>, David Rientjes <rientjes@google.com>, Cfir Cohen <cfir@google.com>, Erdem Aktas <erdemaktas@google.com>, Masami Hiramatsu <mhiramat@kernel.org>, Mike Stunes <mstunes@vmware.com>, Joerg Roedel <jroedel@suse.de>, linux-kernel@vger.kernel.org, kvm@vger.kernel.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

On Tue, May 19, 2020 at 11:32:02PM -0700, Sean Christopherson wrote:
> '0' is a valid physical address.  It happens to be reserved in the kernel
> thanks to L1TF, but using '0' as an error code is ugly.  Not to mention
> none of the callers actually check the result.

Right, I changed the function to better handle error cases and added
checks to the call-sites. It looks like below now:

static bool vc_slow_virt_to_phys(struct ghcb *ghcb, struct es_em_ctxt *ctxt,
                                 unsigned long vaddr, phys_addr_t *paddr)
{
        unsigned long va = (unsigned long)vaddr;
        unsigned int level;
        phys_addr_t pa;
        pgd_t *pgd;
        pte_t *pte;

        pgd = pgd_offset(current->active_mm, va);
        pte = lookup_address_in_pgd(pgd, va, &level);
        if (!pte) {
                ctxt->fi.vector     = X86_TRAP_PF;
                ctxt->fi.cr2        = vaddr;
                ctxt->fi.error_code = 0;

                if (user_mode(ctxt->regs))
                        ctxt->fi.error_code |= X86_PF_USER;

                return false;
        }

        pa = (phys_addr_t)pte_pfn(*pte) << PAGE_SHIFT;
        pa |= va & ~page_level_mask(level);

        *paddr = pa;

        return true;
}
