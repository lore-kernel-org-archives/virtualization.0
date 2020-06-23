From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: Should SEV-ES #VC use IST? (Re: [PATCH] Allow RDTSC and RDTSCP
 from userspace)
Date: Tue, 23 Jun 2020 13:14:43 +0200
Message-ID: <20200623111443.GC4817@hirez.programming.kicks-ass.net>
References: <20200425191032.GK21900@8bytes.org>
 <910AE5B4-4522-4133-99F7-64850181FBF9@amacapital.net>
 <20200425202316.GL21900@8bytes.org>
 <CALCETrW2Y6UFC=zvGbXEYqpsDyBh0DSEM4NQ+L=_pp4aOd6Fuw@mail.gmail.com>
 <CALCETrXGr+o1_bKbnre8cVY14c_76m8pEf3iB_i7h+zfgE5_jA@mail.gmail.com>
 <20200623094519.GF31822@suse.de>
 <20200623104559.GA4817@hirez.programming.kicks-ass.net>
 <20200623111107.GG31822@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20200623111107.GG31822@suse.de>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
 <mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
 <mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>
To: Joerg Roedel <jroedel@suse.de>
Cc: Juergen Gross <JGross@suse.com>, Tom Lendacky <Thomas.Lendacky@amd.com>, Thomas Hellstrom <thellstrom@vmware.com>, X86 ML <x86@kernel.org>, Mike Stunes <mstunes@vmware.com>, Kees Cook <keescook@chromium.org>, kvm list <kvm@vger.kernel.org>, Andrew Cooper <andrew.cooper3@citrix.com>, Joerg Roedel <joro@8bytes.org>, Dave Hansen <dave.hansen@linux.intel.com>, LKML <linux-kernel@vger.kernel.org>, Sean Christopherson <sean.j.christopherson@intel.com>, Linux Virtualization <virtualization@lists.linux-foundation.org>, Dave Hansen <dave.hansen@intel.com>, Andy Lutomirski <luto@kernel.org>, "H. Peter Anvin" <hpa@zytor.com>, Dan Williams <dan.j.williams@intel.com>, Jiri Slaby <jslaby@suse.cz>
List-Id: virtualization@lists.linuxfoundation.org

On Tue, Jun 23, 2020 at 01:11:07PM +0200, Joerg Roedel wrote:
> Hi Peter,
> 
> On Tue, Jun 23, 2020 at 12:45:59PM +0200, Peter Zijlstra wrote:
> > On Tue, Jun 23, 2020 at 11:45:19AM +0200, Joerg Roedel wrote:
> > > Or maybe you have a better idea how to implement this, so I'd like to
> > > hear your opinion first before I spend too many days implementing
> > > something.
> > 
> > OK, excuse my ignorance, but I'm not seeing how that IST shifting
> > nonsense would've helped in the first place.
> > 
> > If I understand correctly the problem is:
> > 
> > 	<#VC>
> > 	  shift IST
> > 	  <NMI>
> > 	    ... does stuff
> > 	    <#VC> # again, safe because the shift
> > 
> > But what happens if you get the NMI before your IST adjustment?
> 
> The v3 patchset implements an unconditional shift of the #VC IST entry
> in the NMI handler, before it can trigger a #VC exception.

Going by that other thread -- where you said that any memory access can
trigger a #VC, there just isn't such a guarantee.

> > Either way around we get to fix this up in NMI (and any other IST
> > exception that can happen while in #VC, hello #MC). And more complexity
> > there is the very last thing we need :-(
> 
> Yes, in whatever way this gets implemented, it needs some fixup in the
> NMI handler. But that can happen in C code, so it does not make the
> assembly more complex, at least.
> 
> > There's no way you can fix up the IDT without getting an NMI first.
> 
> Not sure what you mean by this.

I was talking about the case where #VC would try and fix up its own IST.
