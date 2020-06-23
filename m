From: Joerg Roedel <jroedel@suse.de>
Subject: Re: Should SEV-ES #VC use IST? (Re: [PATCH] Allow RDTSC and RDTSCP
 from userspace)
Date: Tue, 23 Jun 2020 13:30:07 +0200
Message-ID: <20200623113007.GH31822@suse.de>
References: <20200425191032.GK21900@8bytes.org>
 <910AE5B4-4522-4133-99F7-64850181FBF9@amacapital.net>
 <20200425202316.GL21900@8bytes.org>
 <CALCETrW2Y6UFC=zvGbXEYqpsDyBh0DSEM4NQ+L=_pp4aOd6Fuw@mail.gmail.com>
 <CALCETrXGr+o1_bKbnre8cVY14c_76m8pEf3iB_i7h+zfgE5_jA@mail.gmail.com>
 <20200428075512.GP30814@suse.de>
 <20200623110706.GB4817@hirez.programming.kicks-ass.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20200623110706.GB4817@hirez.programming.kicks-ass.net>
Sender: linux-kernel-owner@vger.kernel.org
To: Peter Zijlstra <peterz@infradead.org>
Cc: Andy Lutomirski <luto@kernel.org>, Joerg Roedel <joro@8bytes.org>, Dave Hansen <dave.hansen@intel.com>, Tom Lendacky <Thomas.Lendacky@amd.com>, Mike Stunes <mstunes@vmware.com>, Dan Williams <dan.j.williams@intel.com>, Dave Hansen <dave.hansen@linux.intel.com>, "H. Peter Anvin" <hpa@zytor.com>, Juergen Gross <JGross@suse.com>, Jiri Slaby <jslaby@suse.cz>, Kees Cook <keescook@chromium.org>, kvm list <kvm@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, Thomas Hellstrom <thellstrom@vmware.com>, Linux Virtualization <virtualization@lists.linux-foundation.org>, X86 ML <x86@kernel.org>, Sean Christopherson <sean.j.christopherson@intel.com>, Andrew Cooper <andrew.cooper3@citrix.com>
List-Id: virtualization@lists.linuxfoundation.org

On Tue, Jun 23, 2020 at 01:07:06PM +0200, Peter Zijlstra wrote:
> On Tue, Apr 28, 2020 at 09:55:12AM +0200, Joerg Roedel wrote:

> So what happens if this #VC triggers on the first access to the #VC
> stack, because the malicious host has craftily mucked with only the #VC
> IST stack page?
> 
> Or on the NMI IST stack, then we get #VC in NMI before the NMI can fix
> you up.
> 
> AFAICT all of that is non-recoverable.

I am not 100% sure, but I think if the #VC stack page is not validated,
the #VC should be promoted to a #DF.

Note that this is an issue only with secure nested paging (SNP), which
is not enabled yet with this patch-set. When it gets enabled a stack
recursion check in the #VC handler is needed which panics the VM. That
also fixes the #VC-in-early-NMI problem.

Regards,

	Joerg
