From: Sean Christopherson <sean.j.christopherson@intel.com>
Subject: Re: [PATCH v3 25/75] x86/sev-es: Add support for handling IOIO
 exceptions
Date: Wed, 3 Jun 2020 16:07:16 -0700
Message-ID: <20200603230716.GD25606@linux.intel.com>
References: <20200428151725.31091-1-joro@8bytes.org>
 <20200428151725.31091-26-joro@8bytes.org>
 <20200520062055.GA17090@linux.intel.com>
 <20200603142325.GB23071@8bytes.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20200603142325.GB23071@8bytes.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Joerg Roedel <joro@8bytes.org>
Cc: x86@kernel.org, hpa@zytor.com, Andy Lutomirski <luto@kernel.org>, Dave Hansen <dave.hansen@linux.intel.com>, Peter Zijlstra <peterz@infradead.org>, Thomas Hellstrom <thellstrom@vmware.com>, Jiri Slaby <jslaby@suse.cz>, Dan Williams <dan.j.williams@intel.com>, Tom Lendacky <thomas.lendacky@amd.com>, Juergen Gross <jgross@suse.com>, Kees Cook <keescook@chromium.org>, David Rientjes <rientjes@google.com>, Cfir Cohen <cfir@google.com>, Erdem Aktas <erdemaktas@google.com>, Masami Hiramatsu <mhiramat@kernel.org>, Mike Stunes <mstunes@vmware.com>, Joerg Roedel <jroedel@suse.de>, linux-kernel@vger.kernel.org, kvm@vger.kernel.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

On Wed, Jun 03, 2020 at 04:23:25PM +0200, Joerg Roedel wrote:
> > > +		 */
> > > +		io_bytes   = (exit_info_1 >> 4) & 0x7;
> > > +		ghcb_count = sizeof(ghcb->shared_buffer) / io_bytes;
> > > +
> > > +		op_count    = (exit_info_1 & IOIO_REP) ? regs->cx : 1;
> > > +		exit_info_2 = min(op_count, ghcb_count);
> > > +		exit_bytes  = exit_info_2 * io_bytes;
> > > +
> > > +		es_base = insn_get_seg_base(ctxt->regs, INAT_SEG_REG_ES);
> > > +
> > > +		if (!(exit_info_1 & IOIO_TYPE_IN)) {
> > > +			ret = vc_insn_string_read(ctxt,
> > > +					       (void *)(es_base + regs->si),
> > 
> > SEV(-ES) is 64-bit only, why bother with the es_base charade?
> 
> User-space can also cause IOIO #VC exceptions, and user-space can be
> 32-bit legacy code with segments, so es_base has to be taken into
> account.

Is there actually a use case for this?  Exposing port IO to userspace
doesn't exactly improve security.

Given that i386 ABI requires EFLAGS.DF=0 upon function entry/exit, i.e. is
the de facto default, the DF bug implies this hasn't been tested.  And I
don't see how this could possibly have worked for SEV given that the kernel
unrolls string I/O because the VMM can't emulate string I/O.  Presumably
someone would have complained if they "needed" to run legacy crud.  The
host and guest obviously need major updates, so supporting e.g. DPDK with
legacy virtio seems rather silly.

> > > +					       ghcb->shared_buffer, io_bytes,
> > > +					       exit_info_2, df);
> > 
> > df handling is busted, it's aways non-zero.  Same goes for the SI/DI
> > adjustments below.
> 
> Right, this is fixed now.
> 
> > Batching the memory accesses and I/O accesses separately is technically
> > wrong, e.g. a #DB on a memory access will result in bogus data being shown
> > in the debugger.  In practice it seems unlikely to matter, but I'm curious
> > as to why string I/O is supported in the first place.  I didn't think there
> > was that much string I/O in the kernel?
> 
> True, #DBs won't be correct anymore. Currently debugging is not
> supported in SEV-ES guests anyway, but if it is supported the #DB
> exception would happen in the #VC handler and not on the original
> instruction.

As in, the guest can't debug itself?  Or the host can't debug the guest?
