From: Sean Christopherson <sean.j.christopherson@intel.com>
Subject: Re: [PATCH v3 59/75] x86/sev-es: Handle MONITOR/MONITORX Events
Date: Thu, 11 Jun 2020 10:13:05 -0700
Message-ID: <20200611171305.GJ29918@linux.intel.com>
References: <20200428151725.31091-1-joro@8bytes.org>
 <20200428151725.31091-60-joro@8bytes.org>
 <20200520063845.GC17090@linux.intel.com>
 <20200611131045.GE11924@8bytes.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20200611131045.GE11924@8bytes.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Joerg Roedel <joro@8bytes.org>
Cc: x86@kernel.org, hpa@zytor.com, Andy Lutomirski <luto@kernel.org>, Dave Hansen <dave.hansen@linux.intel.com>, Peter Zijlstra <peterz@infradead.org>, Thomas Hellstrom <thellstrom@vmware.com>, Jiri Slaby <jslaby@suse.cz>, Dan Williams <dan.j.williams@intel.com>, Tom Lendacky <thomas.lendacky@amd.com>, Juergen Gross <jgross@suse.com>, Kees Cook <keescook@chromium.org>, David Rientjes <rientjes@google.com>, Cfir Cohen <cfir@google.com>, Erdem Aktas <erdemaktas@google.com>, Masami Hiramatsu <mhiramat@kernel.org>, Mike Stunes <mstunes@vmware.com>, Joerg Roedel <jroedel@suse.de>, linux-kernel@vger.kernel.org, kvm@vger.kernel.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

On Thu, Jun 11, 2020 at 03:10:45PM +0200, Joerg Roedel wrote:
> On Tue, May 19, 2020 at 11:38:45PM -0700, Sean Christopherson wrote:
> > On Tue, Apr 28, 2020 at 05:17:09PM +0200, Joerg Roedel wrote:
> > > +static enum es_result vc_handle_monitor(struct ghcb *ghcb,
> > > +					struct es_em_ctxt *ctxt)
> > > +{
> > > +	phys_addr_t monitor_pa;
> > > +	pgd_t *pgd;
> > > +
> > > +	pgd = __va(read_cr3_pa());
> > > +	monitor_pa = vc_slow_virt_to_phys(ghcb, ctxt->regs->ax);
> > > +
> > > +	ghcb_set_rax(ghcb, monitor_pa);
> > > +	ghcb_set_rcx(ghcb, ctxt->regs->cx);
> > > +	ghcb_set_rdx(ghcb, ctxt->regs->dx);
> > > +
> > > +	return sev_es_ghcb_hv_call(ghcb, ctxt, SVM_EXIT_MONITOR, 0, 0);
> > 
> > Why?  If SVM has the same behavior as VMX, the MONITOR will be disarmed on
> > VM-Enter, i.e. the VMM can't do anything useful for MONITOR/MWAIT.  I
> > assume that's the case given that KVM emulates MONITOR/MWAIT as NOPs on
> > SVM.
> 
> Not sure if it is disarmed on VMRUN, but the MONITOR/MWAIT instructions
> are part of the GHCB spec, so they are implemented here.

Even if MONITOR/MWAIT somehow works across VMRUN I'm not sure it's something
the guest should enable by default as it leaks GPAs to the untrusted host,
with no benefit to the guest except in specific configurations.  Yeah, the
VMM can muck with page tables to trace guest to the some extent, but the
guest shouldn't be unnecessarily volunteering information to the host.

If MONITOR/MWAIT is effectively a NOP then removing this code is a no
brainer.

Can someone from AMD chime in?
