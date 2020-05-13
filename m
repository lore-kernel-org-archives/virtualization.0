From: Joerg Roedel <joro@8bytes.org>
Subject: Re: [PATCH v3 24/75] x86/boot/compressed/64: Unmap GHCB page before
 booting the kernel
Date: Wed, 13 May 2020 13:30:11 +0200
Message-ID: <20200513113011.GG18353@8bytes.org>
References: <20200428151725.31091-1-joro@8bytes.org>
 <20200428151725.31091-25-joro@8bytes.org>
 <20200513111340.GD4025@zn.tnic>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <kvm-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20200513111340.GD4025@zn.tnic>
Sender: kvm-owner@vger.kernel.org
To: Borislav Petkov <bp@alien8.de>
Cc: x86@kernel.org, hpa@zytor.com, Andy Lutomirski <luto@kernel.org>, Dave Hansen <dave.hansen@linux.intel.com>, Peter Zijlstra <peterz@infradead.org>, Thomas Hellstrom <thellstrom@vmware.com>, Jiri Slaby <jslaby@suse.cz>, Dan Williams <dan.j.williams@intel.com>, Tom Lendacky <thomas.lendacky@amd.com>, Juergen Gross <jgross@suse.com>, Kees Cook <keescook@chromium.org>, David Rientjes <rientjes@google.com>, Cfir Cohen <cfir@google.com>, Erdem Aktas <erdemaktas@google.com>, Masami Hiramatsu <mhiramat@kernel.org>, Mike Stunes <mstunes@vmware.com>, Joerg Roedel <jroedel@suse.de>, linux-kernel@vger.kernel.org, kvm@vger.kernel.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

On Wed, May 13, 2020 at 01:13:40PM +0200, Borislav Petkov wrote:
> On Tue, Apr 28, 2020 at 05:16:34PM +0200, Joerg Roedel wrote:
> > @@ -302,9 +313,13 @@ void do_boot_page_fault(struct pt_regs *regs, unsigned long error_code)
> >  	 *	- User faults
> >  	 *	- Reserved bits set
> >  	 */
> > -	if (error_code & (X86_PF_PROT | X86_PF_USER | X86_PF_RSVD)) {
> > +	if (ghcb_fault ||
> > +	    error_code & (X86_PF_PROT | X86_PF_USER | X86_PF_RSVD)) {
> >  		/* Print some information for debugging */
> > -		error_putstr("Unexpected page-fault:");
> > +		if (ghcb_fault)
> > +			error_putstr("Page-fault on GHCB page:");
> > +		else
> > +			error_putstr("Unexpected page-fault:");
> 
> You could carve out the info dumping into a separate function to
> unclutter this if-statement (diff ontop):

Yeah, I had this this way in v2, but changed it upon you request[1] :)


	Joerg

[1] https://lore.kernel.org/lkml/20200402114941.GA9352@zn.tnic/
	
