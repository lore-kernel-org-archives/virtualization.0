From: Andrew Cooper <andrew.cooper3@citrix.com>
Subject: Re: Should SEV-ES #VC use IST? (Re: [PATCH] Allow RDTSC and RDTSCP
 from userspace)
Date: Tue, 23 Jun 2020 16:39:26 +0100
Message-ID: <56af2f70-a1c6-aa64-006e-23f2f3880887@citrix.com>
References: <20200428075512.GP30814@suse.de>
 <20200623110706.GB4817@hirez.programming.kicks-ass.net>
 <20200623113007.GH31822@suse.de>
 <20200623114818.GD4817@hirez.programming.kicks-ass.net>
 <20200623120433.GB14101@suse.de>
 <20200623125201.GG4817@hirez.programming.kicks-ass.net>
 <20200623134003.GD14101@suse.de>
 <20200623135916.GI4817@hirez.programming.kicks-ass.net>
 <20200623145344.GA117543@hirez.programming.kicks-ass.net>
 <20200623145914.GF14101@suse.de>
 <20200623152326.GL4817@hirez.programming.kicks-ass.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20200623152326.GL4817@hirez.programming.kicks-ass.net>
Content-Language: en-GB
Sender: linux-kernel-owner@vger.kernel.org
To: Peter Zijlstra <peterz@infradead.org>, Joerg Roedel <jroedel@suse.de>
Cc: Andy Lutomirski <luto@kernel.org>, Joerg Roedel <joro@8bytes.org>, Dave Hansen <dave.hansen@intel.com>, Tom Lendacky <Thomas.Lendacky@amd.com>, Mike Stunes <mstunes@vmware.com>, Dan Williams <dan.j.williams@intel.com>, Dave Hansen <dave.hansen@linux.intel.com>, "H. Peter Anvin" <hpa@zytor.com>, Juergen Gross <JGross@suse.com>, Jiri Slaby <jslaby@suse.cz>, Kees Cook <keescook@chromium.org>, kvm list <kvm@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, Thomas Hellstrom <thellstrom@vmware.com>, Linux Virtualization <virtualization@lists.linux-foundation.org>, X86 ML <x86@kernel.org>, Sean Christopherson <sean.j.christopherson@intel.com>
List-Id: virtualization@lists.linuxfoundation.org

On 23/06/2020 16:23, Peter Zijlstra wrote:
> On Tue, Jun 23, 2020 at 04:59:14PM +0200, Joerg Roedel wrote:
>> On Tue, Jun 23, 2020 at 04:53:44PM +0200, Peter Zijlstra wrote:
>>> +noinstr void idtentry_validate_ist(struct pt_regs *regs)
>>> +{
>>> +	if ((regs->sp & ~(EXCEPTION_STKSZ-1)) ==
>>> +	    (_RET_IP_ & ~(EXCEPTION_STKSZ-1)))
>>> +		die("IST stack recursion", regs, 0);
>>> +}
>> Yes, this is a start, it doesn't cover the case where the NMI stack is
>> in-between, so I think you need to walk down regs->sp too.
> That shouldn't be possible with the current code, I think.

NMI; #MC; Anything which IRET but isn't fatal - #DB, or #BP from
patching, #GP from *_safe(), etc; NMI

Sure its a corner case, but did you hear that IST is evil?

~Andrew

P.S. did you also hear that with Rowhammer, userspace has a nonzero
quantity of control over generating #MC, depending on how ECC is
configured on the platform.
