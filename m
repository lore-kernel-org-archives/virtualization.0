From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: Should SEV-ES #VC use IST? (Re: [PATCH] Allow RDTSC and RDTSCP
 from userspace)
Date: Tue, 23 Jun 2020 17:38:44 +0200
Message-ID: <20200623153844.GN4817@hirez.programming.kicks-ass.net>
References: <20200623110706.GB4817@hirez.programming.kicks-ass.net>
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20200623152326.GL4817@hirez.programming.kicks-ass.net>
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

On Tue, Jun 23, 2020 at 05:23:26PM +0200, Peter Zijlstra wrote:
> On Tue, Jun 23, 2020 at 04:59:14PM +0200, Joerg Roedel wrote:
> > On Tue, Jun 23, 2020 at 04:53:44PM +0200, Peter Zijlstra wrote:
> > > +noinstr void idtentry_validate_ist(struct pt_regs *regs)
> > > +{
> > > +	if ((regs->sp & ~(EXCEPTION_STKSZ-1)) ==
> > > +	    (_RET_IP_ & ~(EXCEPTION_STKSZ-1)))
> > > +		die("IST stack recursion", regs, 0);
> > > +}
> > 
> > Yes, this is a start, it doesn't cover the case where the NMI stack is
> > in-between, so I think you need to walk down regs->sp too.
> 
> That shouldn't be possible with the current code, I think.

To clarify, we have: NMI, MCE, DB and DF.

DF (with the exception of ESPFIX) is fatal.
MCE from kernel is fatal (which is what makes the MCE in NMI 'work')
NMI and DB clear DR7, which avoids DB in NMI.

So that leaves: NMI in DB, and that works.
