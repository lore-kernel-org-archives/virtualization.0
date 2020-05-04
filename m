From: Joerg Roedel <jroedel@suse.de>
Subject: Re: [PATCH v3 12/75] x86/boot/compressed/64: Switch to __KERNEL_CS
 after GDT is loaded
Date: Mon, 4 May 2020 13:27:06 +0200
Message-ID: <20200504112706.GG8135@suse.de>
References: <20200428151725.31091-1-joro@8bytes.org>
 <20200428151725.31091-13-joro@8bytes.org>
 <20200504104129.GD15046@zn.tnic>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20200504104129.GD15046@zn.tnic>
Sender: linux-kernel-owner@vger.kernel.org
To: Borislav Petkov <bp@alien8.de>
Cc: Joerg Roedel <joro@8bytes.org>, x86@kernel.org, hpa@zytor.com, Andy Lutomirski <luto@kernel.org>, Dave Hansen <dave.hansen@linux.intel.com>, Peter Zijlstra <peterz@infradead.org>, Thomas Hellstrom <thellstrom@vmware.com>, Jiri Slaby <jslaby@suse.cz>, Dan Williams <dan.j.williams@intel.com>, Tom Lendacky <thomas.lendacky@amd.com>, Juergen Gross <jgross@suse.com>, Kees Cook <keescook@chromium.org>, David Rientjes <rientjes@google.com>, Cfir Cohen <cfir@google.com>, Erdem Aktas <erdemaktas@google.com>, Masami Hiramatsu <mhiramat@kernel.org>, Mike Stunes <mstunes@vmware.com>, linux-kernel@vger.kernel.org, kvm@vger.kernel.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

On Mon, May 04, 2020 at 12:41:29PM +0200, Borislav Petkov wrote:
> On Tue, Apr 28, 2020 at 05:16:22PM +0200, Joerg Roedel wrote:
> > +	/* Reload CS so IRET returns to a CS actually in the GDT */
> > +	pushq	$__KERNEL_CS
> > +	leaq	.Lon_kernel_cs(%rip), %rax
> > +	pushq	%rax
> > +	lretq
> > +
> > +.Lon_kernel_cs:
> > +
> >  	/*
> >  	 * paging_prepare() sets up the trampoline and checks if we need to
> >  	 * enable 5-level paging.
> > -- 
> 
> So I'm thinking I should take this one even now on the grounds that
> it sanitizes CS to something known-good than what was there before and
> who knows what set it and loaded the kernel...?
> 
> And that is a good thing in itself.

Right, sure. CS is basically undefined at this point and depends on what
loaded the kernel (EFI, legacy boot code, some container runtime...), so
setting it to something known is definitly good.

Regards,

	Joerg
