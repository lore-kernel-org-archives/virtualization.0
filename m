From: Andrew Cooper <andrew.cooper3@citrix.com>
Subject: Re: Should SEV-ES #VC use IST? (Re: [PATCH] Allow RDTSC and RDTSCP
 from userspace)
Date: Tue, 23 Jun 2020 16:32:22 +0100
Message-ID: <fe0af2c8-92c8-8d66-e9f3-5a50d64837e5@citrix.com>
References: <CALCETrXGr+o1_bKbnre8cVY14c_76m8pEf3iB_i7h+zfgE5_jA@mail.gmail.com>
 <20200623094519.GF31822@suse.de>
 <20200623104559.GA4817@hirez.programming.kicks-ass.net>
 <20200623111107.GG31822@suse.de>
 <20200623111443.GC4817@hirez.programming.kicks-ass.net>
 <20200623114324.GA14101@suse.de>
 <20200623115014.GE4817@hirez.programming.kicks-ass.net>
 <20200623121237.GC14101@suse.de>
 <20200623130322.GH4817@hirez.programming.kicks-ass.net>
 <20200623144940.GE14101@suse.de>
 <20200623151607.GJ4817@hirez.programming.kicks-ass.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20200623151607.GJ4817@hirez.programming.kicks-ass.net>
Content-Language: en-GB
Sender: linux-kernel-owner@vger.kernel.org
To: Peter Zijlstra <peterz@infradead.org>, Joerg Roedel <jroedel@suse.de>
Cc: Andy Lutomirski <luto@kernel.org>, Joerg Roedel <joro@8bytes.org>, Dave Hansen <dave.hansen@intel.com>, Tom Lendacky <Thomas.Lendacky@amd.com>, Mike Stunes <mstunes@vmware.com>, Dan Williams <dan.j.williams@intel.com>, Dave Hansen <dave.hansen@linux.intel.com>, "H. Peter Anvin" <hpa@zytor.com>, Juergen Gross <JGross@suse.com>, Jiri Slaby <jslaby@suse.cz>, Kees Cook <keescook@chromium.org>, kvm list <kvm@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, Thomas Hellstrom <thellstrom@vmware.com>, Linux Virtualization <virtualization@lists.linux-foundation.org>, X86 ML <x86@kernel.org>, Sean Christopherson <sean.j.christopherson@intel.com>
List-Id: virtualization@lists.linuxfoundation.org

On 23/06/2020 16:16, Peter Zijlstra wrote:
> On Tue, Jun 23, 2020 at 04:49:40PM +0200, Joerg Roedel wrote:
>>> We're talking about the 3rd case where the only reason things 'work' is
>>> because we'll have to panic():
>>>
>>>  - #MC
>> Okay, #MC is special and can only be handled on a best-effort basis, as
>> #MC could happen anytime, also while already executing the #MC handler.
> I think the hardware has a MCE-mask bit somewhere. Flaky though because
> clearing it isn't 'atomic' with IRET, so there's a 'funny' window.

MSR_MCG_STATUS.MCIP, and yes - any #MC before that point will
immediately Shutdown.  Any #MC between that point and IRET will clobber
its IST stack and end up sad.

> It also interacts really bad with the NMI handler. If we get an #MC
> early in the NMI, where we hard-rely on the NMI-mask being set to set-up
> the recursion stack, then the #MC IRET will clear the NMI-mask, and
> we're toast.
>
> Andy has wild and crazy ideas, but I don't think we need more crazy
> here.

Want, certainly not.  Need, maybe :-/
>>>  - #DB with BUS LOCK DEBUG EXCEPTION
>> If I understand the problem correctly, this can be solved by moving off
>> the IST stack to the current task stack in the #DB handler, like I plan
>> to do for #VC, no?
> Hmm, probably. Would take a bit of care, but should be doable.

Andy and I have spent some time considering this.

Having exactly one vector move off IST and onto an in-use task-stack is
doable, I think, so long as it can sort out self-recursion protections.

Having more than one vector do this is very complicated.  You've got to
take care to walk up the list of IST-nesting to see if any interrupted
context is in the middle of trying to copy themselves onto the stack, so
you don't clobber the frame they're in the middle of copying.

~Andrew
