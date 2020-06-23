From: Andrew Cooper <andrew.cooper3@citrix.com>
Subject: Re: Should SEV-ES #VC use IST? (Re: [PATCH] Allow RDTSC and RDTSCP
 from userspace)
Date: Tue, 23 Jun 2020 16:22:47 +0100
Message-ID: <9e3f9b2a-505e-dfd7-c936-461227b4033e@citrix.com>
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
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20200623130322.GH4817@hirez.programming.kicks-ass.net>
Content-Language: en-GB
Sender: linux-kernel-owner@vger.kernel.org
To: Peter Zijlstra <peterz@infradead.org>, Joerg Roedel <jroedel@suse.de>
Cc: Andy Lutomirski <luto@kernel.org>, Joerg Roedel <joro@8bytes.org>, Dave Hansen <dave.hansen@intel.com>, Tom Lendacky <Thomas.Lendacky@amd.com>, Mike Stunes <mstunes@vmware.com>, Dan Williams <dan.j.williams@intel.com>, Dave Hansen <dave.hansen@linux.intel.com>, "H. Peter Anvin" <hpa@zytor.com>, Juergen Gross <JGross@suse.com>, Jiri Slaby <jslaby@suse.cz>, Kees Cook <keescook@chromium.org>, kvm list <kvm@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, Thomas Hellstrom <thellstrom@vmware.com>, Linux Virtualization <virtualization@lists.linux-foundation.org>, X86 ML <x86@kernel.org>, Sean Christopherson <sean.j.christopherson@intel.com>
List-Id: virtualization@lists.linuxfoundation.org

On 23/06/2020 14:03, Peter Zijlstra wrote:
> On Tue, Jun 23, 2020 at 02:12:37PM +0200, Joerg Roedel wrote:
>> On Tue, Jun 23, 2020 at 01:50:14PM +0200, Peter Zijlstra wrote:
>>> If SNP is the sole reason #VC needs to be IST, then I'd strongly urge
>>> you to only make it IST if/when you try and make SNP happen, not before.
>> It is not the only reason, when ES guests gain debug register support
>> then #VC also needs to be IST, because #DB can be promoted into #VC
>> then, and as #DB is IST for a reason, #VC needs to be too.
> Didn't I read somewhere that that is only so for Rome/Naples but not for
> the later chips (Milan) which have #DB pass-through?

I don't know about hardware timelines, but some future part can now opt
in to having debug registers as part of the encrypted state, and swapped
by VMExit, which would make debug facilities generally usable, and
supposedly safe to the #DB infinite loop issues, at which point the
hypervisor need not intercept #DB for safety reasons.

Its worth nothing that on current parts, the hypervisor can set up debug
facilities on behalf of the guest (or behind its back) as the DR state
is unencrypted, but that attempting to intercept #DB will redirect to
#VC inside the guest and cause fun. (Also spare a thought for 32bit
kernels which have to cope with userspace singlestepping the SYSENTER
path with every #DB turning into #VC.)

>> Besides that, I am not a fan of delegating problems I already see coming
>> to future-Joerg and future-Peter, but if at all possible deal with them
>> now and be safe later.
> Well, we could just say no :-) At some point in the very near future
> this house of cards is going to implode.

What currently exists is a picture of a house of cards in front of
something which has fallen down.

> Did someone forget to pass the 'ISTs are *EVIL*' memo to the hardware
> folks? How come we're getting more and more of them?

I have tried to get this point across.  Then again - its far easier for
the software folk in the same company as the hardware folk to make this
point.

> (/me puts fingers
> in ears and goes la-la-la-la in anticipation of Andrew mentioning CET)

I wasn't going to bring it up, but seeing as you have - while there are
prohibitively-complicating issues preventing it from working on native,
I don't see any point even considering it for the mess which is #VC, or
the even bigger mess which is #HV.

~Andrew
