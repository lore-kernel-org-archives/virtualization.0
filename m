From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: Should SEV-ES #VC use IST? (Re: [PATCH] Allow RDTSC and RDTSCP
 from userspace)
Date: Tue, 23 Jun 2020 12:45:59 +0200
Message-ID: <20200623104559.GA4817@hirez.programming.kicks-ass.net>
References: <20200425191032.GK21900@8bytes.org>
 <910AE5B4-4522-4133-99F7-64850181FBF9@amacapital.net>
 <20200425202316.GL21900@8bytes.org>
 <CALCETrW2Y6UFC=zvGbXEYqpsDyBh0DSEM4NQ+L=_pp4aOd6Fuw@mail.gmail.com>
 <CALCETrXGr+o1_bKbnre8cVY14c_76m8pEf3iB_i7h+zfgE5_jA@mail.gmail.com>
 <20200623094519.GF31822@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20200623094519.GF31822@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Joerg Roedel <jroedel@suse.de>
Cc: Andy Lutomirski <luto@kernel.org>, Joerg Roedel <joro@8bytes.org>, Dave Hansen <dave.hansen@intel.com>, Tom Lendacky <Thomas.Lendacky@amd.com>, Mike Stunes <mstunes@vmware.com>, Dan Williams <dan.j.williams@intel.com>, Dave Hansen <dave.hansen@linux.intel.com>, "H. Peter Anvin" <hpa@zytor.com>, Juergen Gross <JGross@suse.com>, Jiri Slaby <jslaby@suse.cz>, Kees Cook <keescook@chromium.org>, kvm list <kvm@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, Thomas Hellstrom <thellstrom@vmware.com>, Linux Virtualization <virtualization@lists.linux-foundation.org>, X86 ML <x86@kernel.org>, Sean Christopherson <sean.j.christopherson@intel.com>, Andrew Cooper <andrew.cooper3@citrix.com>
List-Id: virtualization@lists.linuxfoundation.org

On Tue, Jun 23, 2020 at 11:45:19AM +0200, Joerg Roedel wrote:
> Hi Andy,
> 
> On Mon, Apr 27, 2020 at 10:37:41AM -0700, Andy Lutomirski wrote:
> > 1. Use IST for #VC and deal with all the mess that entails.
> 
> With the removal of IST shifting I wonder what you would suggest on how
> to best implement an NMI-safe IST handler with nesting support.
> 
> My current plan is to implement an IST handler which switches itself off
> the IST stack as soon as possible, freeing it for re-use.
> 
> The flow would be roughly like this upon entering the handler;
> 
> 	build_pt_regs();
> 
> 	RSP = pt_regs->sp;
> 
> 	if (RSP in VC_IST_stack)
> 		error("unallowed nesting")
> 
> 	if (RSP in current_kernel_stack)
> 		RSP = round_down_to_8(RSP)
> 	else
> 		RSP = current_top_of_stack() // non-ist kernel stack
> 
> 	copy_pt_regs(pt_regs, RSP);
> 	switch_stack_to(RSP);
> 
> To make this NMI safe, the NMI handler needs some logic too. Upon
> entering NMI, it needs to check the return RSP, and if it is in the #VC
> IST stack, it must do the above flow by itself and update the return RSP
> and RIP. It needs to take into account the case when PT_REGS is not
> fully populated on the return side.
> 
> Alternativly the NMI handler could safe/restore the contents of the #VC
> IST stack or just switch to a special #VC-in-NMI IST stack.
> 
> All in all it could get complicated, and imho shift_ist would have been
> simpler, but who am I anyway...
> 
> Or maybe you have a better idea how to implement this, so I'd like to
> hear your opinion first before I spend too many days implementing
> something.

OK, excuse my ignorance, but I'm not seeing how that IST shifting
nonsense would've helped in the first place.

If I understand correctly the problem is:

	<#VC>
	  shift IST
	  <NMI>
	    ... does stuff
	    <#VC> # again, safe because the shift

But what happens if you get the NMI before your IST adjustment?

	<#VC>
	  <NMI>
	    ... does stuff
	    <#VC> # again, happily wrecks your earlier #VC
	  shift IST # whoopsy, too late

Either way around we get to fix this up in NMI (and any other IST
exception that can happen while in #VC, hello #MC). And more complexity
there is the very last thing we need :-(

There's no way you can fix up the IDT without getting an NMI first.

This entire exception model is fundamentally buggered :-/
