From: Joerg Roedel <jroedel@suse.de>
Subject: Re: [PATCH v4 45/75] x86/sev-es: Adjust #VC IST Stack on entering
 NMI handler
Date: Wed, 15 Jul 2020 12:26:53 +0200
Message-ID: <20200715102653.GN16200@suse.de>
References: <20200714120917.11253-1-joro@8bytes.org>
 <20200714120917.11253-46-joro@8bytes.org>
 <20200715094702.GF10769@hirez.programming.kicks-ass.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20200715094702.GF10769@hirez.programming.kicks-ass.net>
Sender: linux-kernel-owner@vger.kernel.org
To: Peter Zijlstra <peterz@infradead.org>
Cc: Joerg Roedel <joro@8bytes.org>, x86@kernel.org, hpa@zytor.com, Andy Lutomirski <luto@kernel.org>, Dave Hansen <dave.hansen@linux.intel.com>, Jiri Slaby <jslaby@suse.cz>, Dan Williams <dan.j.williams@intel.com>, Tom Lendacky <thomas.lendacky@amd.com>, Juergen Gross <jgross@suse.com>, Kees Cook <keescook@chromium.org>, David Rientjes <rientjes@google.com>, Cfir Cohen <cfir@google.com>, Erdem Aktas <erdemaktas@google.com>, Masami Hiramatsu <mhiramat@kernel.org>, Mike Stunes <mstunes@vmware.com>, Sean Christopherson <sean.j.christopherson@intel.com>, Martin Radev <martin.b.radev@gmail.com>, linux-kernel@vger.kernel.org, kvm@vger.kernel.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

On Wed, Jul 15, 2020 at 11:47:02AM +0200, Peter Zijlstra wrote:
> On Tue, Jul 14, 2020 at 02:08:47PM +0200, Joerg Roedel wrote:

> DECLARE_STATIC_KEY_FALSE(sev_es_enabled_key);
> 
> static __always_inline void sev_es_foo()
> {
> 	if (static_branch_unlikely(&sev_es_enabled_key))
> 		__sev_es_foo();
> }
> 
> So that normal people will only see an extra NOP?

Yes, that is a good idea, I will use a static key for these cases.

> > +static bool on_vc_stack(unsigned long sp)
> 
> noinstr or __always_inline

Will add __always_inline, thanks.

> > +/*
> > + * This function handles the case when an NMI or an NMI-like exception
> > + * like #DB is raised in the #VC exception handler entry code. In this
> 
> I've yet to find you handle the NMI-like cases..

The comment is not 100% accurate anymore, I will update it. Initially
#DB was an NMI-like case, but I figured that with .text.noinstr and the
way the #VC entry code switches stacks, there is no #DB special handling
necessary anymore.

> > + * case the IST entry for VC must be adjusted, so that any subsequent VC
> > + * exception will not overwrite the stack contents of the interrupted VC
> > + * handler.
> > + *
> > + * The IST entry is adjusted unconditionally so that it can be also be
> > + * unconditionally back-adjusted in sev_es_nmi_exit(). Otherwise a
> > + * nested nmi_exit() call (#VC->NMI->#DB) may back-adjust the IST entry
> > + * too early.
> 
> Is this comment accurate, I cannot find the patch touching
> nmi_enter/exit()?

Right, will update that too. I had the sev-es NMI stack adjustment in
nmi_enter/exit first, but needed to move it out because the possible DR7
access needs the #VC stack already adjusted.

> > + */
> > +void noinstr sev_es_ist_enter(struct pt_regs *regs)
> > +{
> > +	unsigned long old_ist, new_ist;
> > +	unsigned long *p;
> > +
> > +	if (!sev_es_active())
> > +		return;
> > +
> > +	/* Read old IST entry */
> > +	old_ist = __this_cpu_read(cpu_tss_rw.x86_tss.ist[IST_INDEX_VC]);
> > +
> > +	/* Make room on the IST stack */
> > +	if (on_vc_stack(regs->sp))
> > +		new_ist = ALIGN_DOWN(regs->sp, 8) - sizeof(old_ist);
> > +	else
> > +		new_ist = old_ist - sizeof(old_ist);
> > +
> > +	/* Store old IST entry */
> > +	p       = (unsigned long *)new_ist;
> > +	*p      = old_ist;
> > +
> > +	/* Set new IST entry */
> > +	this_cpu_write(cpu_tss_rw.x86_tss.ist[IST_INDEX_VC], new_ist);
> > +}
> > +
> > +void noinstr sev_es_ist_exit(void)
> > +{
> > +	unsigned long ist;
> > +	unsigned long *p;
> > +
> > +	if (!sev_es_active())
> > +		return;
> > +
> > +	/* Read IST entry */
> > +	ist = __this_cpu_read(cpu_tss_rw.x86_tss.ist[IST_INDEX_VC]);
> > +
> > +	if (WARN_ON(ist == __this_cpu_ist_top_va(VC)))
> > +		return;
> > +
> > +	/* Read back old IST entry and write it to the TSS */
> > +	p = (unsigned long *)ist;
> > +	this_cpu_write(cpu_tss_rw.x86_tss.ist[IST_INDEX_VC], *p);
> > +}
> 
> That's pretty disguisting :-(

Yeah, but its needed because ... IST :(
I am open for suggestions on how to make it less disgusting. Or maybe
you like it more if you think of it as a software implementation of what
hardware should actually do to make IST less painful.

Regards,

	Joerg
