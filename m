From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: Should SEV-ES #VC use IST? (Re: [PATCH] Allow RDTSC and RDTSCP
 from userspace)
Date: Tue, 23 Jun 2020 14:52:01 +0200
Message-ID: <20200623125201.GG4817@hirez.programming.kicks-ass.net>
References: <20200425191032.GK21900@8bytes.org>
 <910AE5B4-4522-4133-99F7-64850181FBF9@amacapital.net>
 <20200425202316.GL21900@8bytes.org>
 <CALCETrW2Y6UFC=zvGbXEYqpsDyBh0DSEM4NQ+L=_pp4aOd6Fuw@mail.gmail.com>
 <CALCETrXGr+o1_bKbnre8cVY14c_76m8pEf3iB_i7h+zfgE5_jA@mail.gmail.com>
 <20200428075512.GP30814@suse.de>
 <20200623110706.GB4817@hirez.programming.kicks-ass.net>
 <20200623113007.GH31822@suse.de>
 <20200623114818.GD4817@hirez.programming.kicks-ass.net>
 <20200623120433.GB14101@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20200623120433.GB14101@suse.de>
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

On Tue, Jun 23, 2020 at 02:04:33PM +0200, Joerg Roedel wrote:
> On Tue, Jun 23, 2020 at 01:48:18PM +0200, Peter Zijlstra wrote:
> > On Tue, Jun 23, 2020 at 01:30:07PM +0200, Joerg Roedel wrote:
> 
> > But you cannot do a recursion check in #VC, because the NMI can happen
> > on the first instruction of #VC, before we can increment our counter,
> > and then the #VC can happen on NMI because the IST stack is a goner, and
> > we're fscked again (or on a per-cpu variable we touch in our elaborate
> > NMI setup, etc..).
> 
> No, the recursion check is fine, because overwriting an already used IST
> stack doesn't matter (as long as it can be detected) if we are going to
> panic anyway. It doesn't matter because the kernel will not leave the
> currently running handler anymore.

You only have that guarantee when any SNP #VC from kernel is an
automatic panic. But in that case, what's the point of having the
recursion count?

> > I'll keep repeating this, x86_64 exceptions are a trainwreck, and IST in
> > specific is utter crap.
> 
> I agree, but don't forget the most prominent underlying reason for IST:
> The SYSCALL gap. If SYSCALL would switch stacks most of those issues
> would not exist. IST would still be needed because there are no task
> gates in x86-64, but still...

We could all go back to int80 ;-) /me runs like heck
