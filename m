From: Borislav Petkov <bp@alien8.de>
Subject: Re: Should SEV-ES #VC use IST? (Re: [PATCH] Allow RDTSC and RDTSCP
 from userspace)
Date: Tue, 23 Jun 2020 18:10:10 +0200
Message-ID: <20200623161010.GE32590@zn.tnic>
References: <20200623104559.GA4817@hirez.programming.kicks-ass.net>
 <20200623111107.GG31822@suse.de>
 <20200623111443.GC4817@hirez.programming.kicks-ass.net>
 <20200623114324.GA14101@suse.de>
 <20200623115014.GE4817@hirez.programming.kicks-ass.net>
 <20200623121237.GC14101@suse.de>
 <20200623130322.GH4817@hirez.programming.kicks-ass.net>
 <20200623144940.GE14101@suse.de>
 <20200623151607.GJ4817@hirez.programming.kicks-ass.net>
 <fe0af2c8-92c8-8d66-e9f3-5a50d64837e5@citrix.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <fe0af2c8-92c8-8d66-e9f3-5a50d64837e5@citrix.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Andrew Cooper <andrew.cooper3@citrix.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Joerg Roedel <jroedel@suse.de>, Andy Lutomirski <luto@kernel.org>, Joerg Roedel <joro@8bytes.org>, Dave Hansen <dave.hansen@intel.com>, Tom Lendacky <Thomas.Lendacky@amd.com>, Mike Stunes <mstunes@vmware.com>, Dan Williams <dan.j.williams@intel.com>, Dave Hansen <dave.hansen@linux.intel.com>, "H. Peter Anvin" <hpa@zytor.com>, Juergen Gross <JGross@suse.com>, Jiri Slaby <jslaby@suse.cz>, Kees Cook <keescook@chromium.org>, kvm list <kvm@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, Thomas Hellstrom <thellstrom@vmware.com>, Linux Virtualization <virtualization@lists.linux-foundation.org>, X86 ML <x86@kernel.org>, Sean Christopherson <sean.j.christopherson@intel.com>
List-Id: virtualization@lists.linuxfoundation.org

On Tue, Jun 23, 2020 at 04:32:22PM +0100, Andrew Cooper wrote:
> MSR_MCG_STATUS.MCIP, and yes - any #MC before that point will
> immediately Shutdown.  Any #MC between that point and IRET will clobber
> its IST stack and end up sad.

Well, at some point we should simply accept that we're living a little
on the edge. That is, until we get IRET with a mask of to-reenable
vectors which has #MC, NMI and whatever else vectors. It would be even
better if that mask were configurable.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
