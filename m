From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: Should SEV-ES #VC use IST? (Re: [PATCH] Allow RDTSC and RDTSCP
 from userspace)
Date: Tue, 23 Jun 2020 15:03:22 +0200
Message-ID: <20200623130322.GH4817@hirez.programming.kicks-ass.net>
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
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20200623121237.GC14101@suse.de>
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

On Tue, Jun 23, 2020 at 02:12:37PM +0200, Joerg Roedel wrote:
> On Tue, Jun 23, 2020 at 01:50:14PM +0200, Peter Zijlstra wrote:
> > If SNP is the sole reason #VC needs to be IST, then I'd strongly urge
> > you to only make it IST if/when you try and make SNP happen, not before.
> 
> It is not the only reason, when ES guests gain debug register support
> then #VC also needs to be IST, because #DB can be promoted into #VC
> then, and as #DB is IST for a reason, #VC needs to be too.

Didn't I read somewhere that that is only so for Rome/Naples but not for
the later chips (Milan) which have #DB pass-through?

> Besides that, I am not a fan of delegating problems I already see coming
> to future-Joerg and future-Peter, but if at all possible deal with them
> now and be safe later.

Well, we could just say no :-) At some point in the very near future
this house of cards is going to implode.

We're talking about the 3rd case where the only reason things 'work' is
because we'll have to panic():

 - #MC
 - #DB with BUS LOCK DEBUG EXCEPTION
 - #VC SNP

(and it ain't a happy accident they're all IST)

Did someone forget to pass the 'ISTs are *EVIL*' memo to the hardware
folks? How come we're getting more and more of them? (/me puts fingers
in ears and goes la-la-la-la in anticipation of Andrew mentioning CET)
