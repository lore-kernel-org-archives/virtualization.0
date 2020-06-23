From: Andrew Cooper <andrew.cooper3@citrix.com>
Subject: Re: Should SEV-ES #VC use IST? (Re: [PATCH] Allow RDTSC and RDTSCP
 from userspace)
Date: Tue, 23 Jun 2020 19:56:02 +0100
Message-ID: <7a7c6e7c-8450-3785-035a-197be9268b70@citrix.com>
References: <20200425202316.GL21900@8bytes.org>
 <CALCETrW2Y6UFC=zvGbXEYqpsDyBh0DSEM4NQ+L=_pp4aOd6Fuw@mail.gmail.com>
 <CALCETrXGr+o1_bKbnre8cVY14c_76m8pEf3iB_i7h+zfgE5_jA@mail.gmail.com>
 <20200623094519.GF31822@suse.de>
 <20200623104559.GA4817@hirez.programming.kicks-ass.net>
 <20200623111107.GG31822@suse.de>
 <20200623111443.GC4817@hirez.programming.kicks-ass.net>
 <20200623114324.GA14101@suse.de>
 <20200623115014.GE4817@hirez.programming.kicks-ass.net>
 <20200623121237.GC14101@suse.de>
 <20200623130322.GH4817@hirez.programming.kicks-ass.net>
 <9e3f9b2a-505e-dfd7-c936-461227b4033e@citrix.com>
 <CALCETrWEUXU_BYd5ypF3XC10hSQUJ=XCVz40n3VfcWELS+roTg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CALCETrWEUXU_BYd5ypF3XC10hSQUJ=XCVz40n3VfcWELS+roTg@mail.gmail.com>
Content-Language: en-GB
Sender: linux-kernel-owner@vger.kernel.org
To: Andy Lutomirski <luto@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>, Joerg Roedel <jroedel@suse.de>, Joerg Roedel <joro@8bytes.org>, Dave Hansen <dave.hansen@intel.com>, Tom Lendacky <Thomas.Lendacky@amd.com>, Mike Stunes <mstunes@vmware.com>, Dan Williams <dan.j.williams@intel.com>, Dave Hansen <dave.hansen@linux.intel.com>, "H. Peter Anvin" <hpa@zytor.com>, Juergen Gross <JGross@suse.com>, Jiri Slaby <jslaby@suse.cz>, Kees Cook <keescook@chromium.org>, kvm list <kvm@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, Thomas Hellstrom <thellstrom@vmware.com>, Linux Virtualization <virtualization@lists.linux-foundation.org>, X86 ML <x86@kernel.org>, Sean Christopherson <sean.j.christopherson@intel.com>
List-Id: virtualization@lists.linuxfoundation.org

On 23/06/2020 19:26, Andy Lutomirski wrote:
> On Tue, Jun 23, 2020 at 8:23 AM Andrew Cooper <andrew.cooper3@citrix.com> wrote:
>> On 23/06/2020 14:03, Peter Zijlstra wrote:
>>> On Tue, Jun 23, 2020 at 02:12:37PM +0200, Joerg Roedel wrote:
>>>> On Tue, Jun 23, 2020 at 01:50:14PM +0200, Peter Zijlstra wrote:
>>>>> If SNP is the sole reason #VC needs to be IST, then I'd strongly urge
>>>>> you to only make it IST if/when you try and make SNP happen, not before.
>>>> It is not the only reason, when ES guests gain debug register support
>>>> then #VC also needs to be IST, because #DB can be promoted into #VC
>>>> then, and as #DB is IST for a reason, #VC needs to be too.
>>> Didn't I read somewhere that that is only so for Rome/Naples but not for
>>> the later chips (Milan) which have #DB pass-through?
>> I don't know about hardware timelines, but some future part can now opt
>> in to having debug registers as part of the encrypted state, and swapped
>> by VMExit, which would make debug facilities generally usable, and
>> supposedly safe to the #DB infinite loop issues, at which point the
>> hypervisor need not intercept #DB for safety reasons.
>>
>> Its worth nothing that on current parts, the hypervisor can set up debug
>> facilities on behalf of the guest (or behind its back) as the DR state
>> is unencrypted, but that attempting to intercept #DB will redirect to
>> #VC inside the guest and cause fun. (Also spare a thought for 32bit
>> kernels which have to cope with userspace singlestepping the SYSENTER
>> path with every #DB turning into #VC.)
> What do you mean 32-bit?  64-bit kernels have exactly the same
> problem.  At least the stack is okay, though.

:)

AMD-like CPUs disallow SYSENTER/SYSEXIT in Long Mode, and raise #UD,
even from a compatibility mode segment.

64bit kernels only have this problem on Intel-like CPUs.

(It is a massive shame that between everyone's attempts, there are 0
"fast system call" instructions with sane semantics, but it is several
decades late to fix this problem...)

~Andrew
