From: Borislav Petkov <bp@alien8.de>
Subject: Re: [PATCH v3 64/75] x86/sev-es: Cache CPUID results for improved
 performance
Date: Tue, 26 May 2020 11:19:09 +0200
Message-ID: <20200526091909.GB28228@zn.tnic>
References: <20200428151725.31091-1-joro@8bytes.org>
 <20200428151725.31091-65-joro@8bytes.org>
 <20200520051637.GA16599@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20200520051637.GA16599@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Sean Christopherson <sean.j.christopherson@intel.com>
Cc: Joerg Roedel <joro@8bytes.org>, x86@kernel.org, hpa@zytor.com, Andy Lutomirski <luto@kernel.org>, Dave Hansen <dave.hansen@linux.intel.com>, Peter Zijlstra <peterz@infradead.org>, Thomas Hellstrom <thellstrom@vmware.com>, Jiri Slaby <jslaby@suse.cz>, Dan Williams <dan.j.williams@intel.com>, Tom Lendacky <thomas.lendacky@amd.com>, Juergen Gross <jgross@suse.com>, Kees Cook <keescook@chromium.org>, David Rientjes <rientjes@google.com>, Cfir Cohen <cfir@google.com>, Erdem Aktas <erdemaktas@google.com>, Masami Hiramatsu <mhiramat@kernel.org>, Mike Stunes <mstunes@vmware.com>, Joerg Roedel <jroedel@suse.de>, linux-kernel@vger.kernel.org, kvm@vger.kernel.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

On Tue, May 19, 2020 at 10:16:37PM -0700, Sean Christopherson wrote:
> The whole cache on-demand approach seems like overkill.  The number of CPUID
> leaves that are invoked after boot with any regularity can probably be counted
> on one hand.   IIRC glibc invokes CPUID to gather TLB/cache info, XCR0-based
> features, and one or two other leafs.  A statically sized global array that's
> arbitrarily index a la x86_capability would be just as simple and more
> performant.  It would also allow fancier things like emulating CPUID 0xD in
> the guest if you want to go down that road.

And before we do any of that "caching" or whatnot, I'd like to see
numbers justifying its existence. Because if it is only a couple of
CPUID invocations and the boot delay is immeasurable, then it's not
worth the effort.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
