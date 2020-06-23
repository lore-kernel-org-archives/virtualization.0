From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: Should SEV-ES #VC use IST? (Re: [PATCH] Allow RDTSC and RDTSCP
 from userspace)
Date: Tue, 23 Jun 2020 17:52:04 +0200
Message-ID: <20200623155204.GO4817@hirez.programming.kicks-ass.net>
References: <20200623113007.GH31822@suse.de>
 <20200623114818.GD4817@hirez.programming.kicks-ass.net>
 <20200623120433.GB14101@suse.de>
 <20200623125201.GG4817@hirez.programming.kicks-ass.net>
 <20200623134003.GD14101@suse.de>
 <20200623135916.GI4817@hirez.programming.kicks-ass.net>
 <20200623145344.GA117543@hirez.programming.kicks-ass.net>
 <20200623145914.GF14101@suse.de>
 <20200623152326.GL4817@hirez.programming.kicks-ass.net>
 <56af2f70-a1c6-aa64-006e-23f2f3880887@citrix.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <56af2f70-a1c6-aa64-006e-23f2f3880887@citrix.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
 <mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
 <mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>
To: Andrew Cooper <andrew.cooper3@citrix.com>
Cc: Juergen Gross <JGross@suse.com>, Tom Lendacky <Thomas.Lendacky@amd.com>, Thomas Hellstrom <thellstrom@vmware.com>, Joerg Roedel <jroedel@suse.de>, Mike Stunes <mstunes@vmware.com>, Kees Cook <keescook@chromium.org>, kvm list <kvm@vger.kernel.org>, Joerg Roedel <joro@8bytes.org>, Dave Hansen <dave.hansen@linux.intel.com>, LKML <linux-kernel@vger.kernel.org>, Sean Christopherson <sean.j.christopherson@intel.com>, Linux Virtualization <virtualization@lists.linux-foundation.org>, Dave Hansen <dave.hansen@intel.com>, Andy Lutomirski <luto@kernel.org>, "H. Peter Anvin" <hpa@zytor.com>, Dan Williams <dan.j.williams@intel.com>, Jiri Slaby <jslaby@suse.cz>, X86 ML <x86@kernel.org>
List-Id: virtualization@lists.linuxfoundation.org

On Tue, Jun 23, 2020 at 04:39:26PM +0100, Andrew Cooper wrote:
> On 23/06/2020 16:23, Peter Zijlstra wrote:
> > On Tue, Jun 23, 2020 at 04:59:14PM +0200, Joerg Roedel wrote:

> >> Yes, this is a start, it doesn't cover the case where the NMI stack is
> >> in-between, so I think you need to walk down regs->sp too.
> > That shouldn't be possible with the current code, I think.
> 
> NMI; #MC; Anything which IRET but isn't fatal - #DB, or #BP from
> patching, #GP from *_safe(), etc; NMI
> 
> Sure its a corner case, but did you hear that IST is evil?

Isn't current #MC unconditionally fatal from kernel? But yes, I was
sorta aware people want that changed.

And yes, NMI can recurse, mostly on #BP and #PF. Like I wrote, its
broken vs #MC.

But Joerg was talking about IST recursion with NMI in the middle,
something like: #DB, NMI, #DB, and not already being fatal. This one in
particular is ruled out by #DB itself clearing DR7 (but NMI would also
do that).

> P.S. did you also hear that with Rowhammer, userspace has a nonzero
> quantity of control over generating #MC, depending on how ECC is
> configured on the platform.

Yes, excellent stuff.
