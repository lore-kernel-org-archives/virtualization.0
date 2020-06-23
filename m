From: Borislav Petkov <bp@alien8.de>
Subject: Re: Should SEV-ES #VC use IST? (Re: [PATCH] Allow RDTSC and RDTSCP
 from userspace)
Date: Tue, 23 Jun 2020 18:13:55 +0200
Message-ID: <20200623161355.GF32590@zn.tnic>
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
Content-Type: text/plain; charset=utf-8
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <56af2f70-a1c6-aa64-006e-23f2f3880887@citrix.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Andrew Cooper <andrew.cooper3@citrix.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Joerg Roedel <jroedel@suse.de>, Andy Lutomirski <luto@kernel.org>, Joerg Roedel <joro@8bytes.org>, Dave Hansen <dave.hansen@intel.com>, Tom Lendacky <Thomas.Lendacky@amd.com>, Mike Stunes <mstunes@vmware.com>, Dan Williams <dan.j.williams@intel.com>, Dave Hansen <dave.hansen@linux.intel.com>, "H. Peter Anvin" <hpa@zytor.com>, Juergen Gross <JGross@suse.com>, Jiri Slaby <jslaby@suse.cz>, Kees Cook <keescook@chromium.org>, kvm list <kvm@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, Thomas Hellstrom <thellstrom@vmware.com>, Linux Virtualization <virtualization@lists.linux-foundation.org>, X86 ML <x86@kernel.org>, Sean Christopherson <sean.j.christopherson@intel.com>
List-Id: virtualization@lists.linuxfoundation.org

On Tue, Jun 23, 2020 at 04:39:26PM +0100, Andrew Cooper wrote:
> P.S. did you also hear that with Rowhammer, userspace has a nonzero
> quantity of control over generating #MC, depending on how ECC is
> configured on the platform.

Where does that #MC point to? Can it control for which address to flip
the bits for, i.e., make the #MC appear it has been generated for an
address in kernel space?

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
