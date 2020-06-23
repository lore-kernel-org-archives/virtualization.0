From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: Should SEV-ES #VC use IST? (Re: [PATCH] Allow RDTSC and RDTSCP
 from userspace)
Date: Tue, 23 Jun 2020 17:16:07 +0200
Message-ID: <20200623151607.GJ4817@hirez.programming.kicks-ass.net>
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
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20200623144940.GE14101@suse.de>
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

On Tue, Jun 23, 2020 at 04:49:40PM +0200, Joerg Roedel wrote:
> > We're talking about the 3rd case where the only reason things 'work' is
> > because we'll have to panic():
> > 
> >  - #MC
> 
> Okay, #MC is special and can only be handled on a best-effort basis, as
> #MC could happen anytime, also while already executing the #MC handler.

I think the hardware has a MCE-mask bit somewhere. Flaky though because
clearing it isn't 'atomic' with IRET, so there's a 'funny' window.

It also interacts really bad with the NMI handler. If we get an #MC
early in the NMI, where we hard-rely on the NMI-mask being set to set-up
the recursion stack, then the #MC IRET will clear the NMI-mask, and
we're toast.

Andy has wild and crazy ideas, but I don't think we need more crazy
here.

#VC SNP has a similar problem vs NMI, that needs to die() irrespective
of the #VC IST recursion.

> >  - #DB with BUS LOCK DEBUG EXCEPTION
> 
> If I understand the problem correctly, this can be solved by moving off
> the IST stack to the current task stack in the #DB handler, like I plan
> to do for #VC, no?

Hmm, probably. Would take a bit of care, but should be doable.

> >  - #VC SNP
> 
> This has to panic for other reasons that can't be worked around. It
> boils down to detecting that the HV is doing something fishy and bail
> out to avoid further harm (like in the #MC handler).

Right, but it doesn't take away that IST-any-time vectors are
fundamentally screwy.

Both the MCE and NMI have masks that are, as per the above, differently
funny, but the other ISTs do not. Also, even if they had masks, the
interaction between them is still screwy.

#VC would've been so much better if it would've had a mask bit
somewhere, then at least we could've had the exception entry covered.
Another #VC with the mask set should probably result in #DF or Shutdown,
but that's all water under the bridge I suspect.
