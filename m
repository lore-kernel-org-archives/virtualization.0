From: Joerg Roedel <jroedel@suse.de>
Subject: Re: [PATCH v4 63/75] x86/sev-es: Handle #DB Events
Date: Wed, 15 Jul 2020 11:13:37 +0200
Message-ID: <20200715091337.GI16200@suse.de>
References: <20200714120917.11253-1-joro@8bytes.org>
 <20200714120917.11253-64-joro@8bytes.org>
 <20200715084752.GD10769@hirez.programming.kicks-ass.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20200715084752.GD10769@hirez.programming.kicks-ass.net>
Sender: linux-kernel-owner@vger.kernel.org
To: Peter Zijlstra <peterz@infradead.org>
Cc: Joerg Roedel <joro@8bytes.org>, x86@kernel.org, hpa@zytor.com, Andy Lutomirski <luto@kernel.org>, Dave Hansen <dave.hansen@linux.intel.com>, Jiri Slaby <jslaby@suse.cz>, Dan Williams <dan.j.williams@intel.com>, Tom Lendacky <thomas.lendacky@amd.com>, Juergen Gross <jgross@suse.com>, Kees Cook <keescook@chromium.org>, David Rientjes <rientjes@google.com>, Cfir Cohen <cfir@google.com>, Erdem Aktas <erdemaktas@google.com>, Masami Hiramatsu <mhiramat@kernel.org>, Mike Stunes <mstunes@vmware.com>, Sean Christopherson <sean.j.christopherson@intel.com>, Martin Radev <martin.b.radev@gmail.com>, linux-kernel@vger.kernel.org, kvm@vger.kernel.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

On Wed, Jul 15, 2020 at 10:47:52AM +0200, Peter Zijlstra wrote:
> On Tue, Jul 14, 2020 at 02:09:05PM +0200, Joerg Roedel wrote:
> 
> > @@ -1028,6 +1036,16 @@ DEFINE_IDTENTRY_VC_SAFE_STACK(exc_vmm_communication)
> >  	struct ghcb *ghcb;
> >  
> >  	lockdep_assert_irqs_disabled();
> > +
> > +	/*
> > +	 * #DB is special and needs to be handled outside of the intrumentation_begin()/end().
> > +	 * Otherwise the #VC handler could be raised recursivly.
> > +	 */
> > +	if (error_code == SVM_EXIT_EXCP_BASE + X86_TRAP_DB) {
> > +		vc_handle_trap_db(regs);
> > +		return;
> > +	}
> > +
> >  	instrumentation_begin();
> 
> Wait what?! That makes no sense what so ever.

Then my understanding of intrumentation_begin/end() is wrong, I thought
that the kernel will forbid setting breakpoints before
instrumentation_begin(), which is necessary here because a break-point
in the #VC handler might cause recursive #VC-exceptions when #DB is
intercepted.
Maybe you can elaborate on why this makes no sense?

Regards,

	Joerg
